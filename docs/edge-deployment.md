# scotttactical.com - edge deployment (frp tunnel through the "hub")

How the live site is exposed to the public internet, and how to deploy / move it.
This documents ONLY the network path (edge + tunnel). The site content/build and
the cluster manifests live elsewhere.

## Architecture (locked 2026-09-22)

```
public -> Route53 (scotttactical.com -> hub public IP)
        -> hub EC2 (already-paid t4g.small): nginx (TLS) + frps
        <- home cluster node00/H5s: frpc dials OUT (zero port forwards at home)
        -> Traefik on the LAN -> scotttactical pod
```

- ALL DNS stays in Route53. scotttactical.com is a normal A record to the hub.
- **nginx** is the public TLS terminator and host multiplexer (it already serves
  hub.kidecon.me on the same box). scotttactical.com is one more server block.
- **frps** (tunnel server) binds loopback only; nginx reverse-proxies
  scotttactical.com -> 127.0.0.1:<vhostHTTPPort>. frps never binds public 80/443.
- **frpc** (home cluster, a k8s Deployment) registers customDomains=[scotttactical.com]
  with hostHeaderRewrite so Traefik routes it.

## Box: the hub (t4g.small, arm64, already-paid RI)

- Public IP + ssh: see the SSH/DNS quick reference in the homelab docs build docs.
  User `solvire`, key-only.
- Ubuntu 26.04 (arm64), nginx owns 80/443, gunicorn(systemd) serves hub.kidecon.me
  on 127.0.0.1:8000. We do NOT disturb that; scotttactical.com is a sibling.
- frps: single Go binary (no runtime), systemd unit, does not use Docker.

## frps install + config on the hub

```bash
# 1. download (arm64), verify, install
cd /tmp
curl -fLO https://github.com/fatedier/frp/releases/download/v0.71.0/frp_0.71.0_linux_arm64.tar.gz
echo "f33c293c275d8fc68c654b6fba8f10b2551d6463d09a9fc9cffb7227eae82266  frp_0.71.0_linux_arm64.tar.gz" | sha256sum -c -
tar xzf frp_0.71.0_linux_arm64.tar.gz
sudo install -m 0755 frp_0.71.0_linux_arm64/frps /usr/local/bin/frps
sudo mkdir -p /etc/frps && sudo install -m 0600 frp_0.71.0_linux_arm64/frps.toml /dev/null || true
```

`/etc/frps/frps.toml` (token from the operator password manager - never commit):

```toml
bindPort = 7000
auth.method = "token"
auth.token = "<FROM_PASSWORD_MANAGER>"
transport.tls.force = true
vhostHTTPPort = 8080            # nginx proxies scotttactical.com -> this loopback here
webServer.addr = "127.0.0.1"    # dashboard loopback only
webServer.port = 7500
webServer.user = "opslayer"
webServer.password = "<FROM_PASSWORD_MANAGER>"
```

systemd unit `/etc/systemd/system/frps.service`:

```ini
[Unit]
Description=frp server (tunnel terminator for public sites)
After=network.target

[Service]
ExecStart=/usr/local/bin/frps -c /etc/frps/frps.toml
Restart=always
RestartSec=5
NoNewPrivileges=true
ProtectSystem=strict
ProtectHome=true

[Install]
WantedBy=multi-user.target
```

Enable + verify listening (AS-BUILT 2026-09-22):

```bash
sudo systemctl daemon-reload
sudo systemctl enable --now frps
sudo ss -ltnp '( sport = :7000 or sport = :8080 or sport = :7500 )'
# observed: 0.0.0.0:7000 (tunnel control), *:8080 (vhost), 127.0.0.1:7500 (dashboard)
```

Note: frp binds vhostHTTPPort (8080) on ALL interfaces (it shares the control-port
bind), not just loopback. Unmatched Host headers return 404 from frps. Optional
hardening: a ufw/nftables rule to accept 8080 only from the nginx local proxy, or
leave it (hub already public on 80/443).

## nginx: add scotttactical.com server block (certbot)

Create `/etc/nginx/sites-available/scotttactical`, symlink into sites-enabled:

```nginx
server {
    server_name scotttactical.com www.scotttactical.com;
    location / {
        proxy_pass http://127.0.0.1:8080;   # -> frps vhost -> tunnel -> home Traefik
        proxy_http_version 1.1;
        proxy_set_header Host $host;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    }
}
```

```bash
sudo ln -sf /etc/nginx/sites-available/scotttactical /etc/nginx/sites-enabled/scotttactical
# automatic cert (same path used for hub.kidecon.me). Needs DNS already on the hub.
sudo certbot --nginx -d scotttactical.com -d www.scotttactical.com
sudo nginx -t && sudo systemctl reload nginx
```

AS-BUILT (2026-09-22): before certbot, the scotttactical server block had NO
`listen` and NO cert, so 443 traffic fell to the hub.kidecon.me default server
(the only 443 block) and served hub content. `certbot --nginx` grafts the
`listen 443 ssl` + cert lines + HTTP->HTTPS redirect into sites-available/scotttactical,
same shape as hub.kidecon.me. Cert issued: Let's Encrypt, CN scotttactical.com,
expires 2026-12-21, auto-renewal configured.

## Route53

Point scotttactical.com (and www) A record at the hub's public IP, TTL 60 for
rollback. Old serving EC2 record preserved until the tunnel is proven stable a day.

## frpc (home cluster) - AS-BUILT 2026-09-22 (opslayer-managed)

frpc runs as a k8s Deployment in the home cluster, applied and reconciled by
**opslayer** (not hand-edited). The opslayer `tunnel` module renders the frpc
ConfigMap (with `{{ .Envs.FRP_TOKEN }}` templating), a token Secret named
`frpc-token`, and the `frpc` Deployment (image `ghcr.io/solvire/frpc:0.71.0`),
then `kubectl apply`s them - token never in git, no SSH.

The one command that creates/updates the route:

```bash
opslayer --json network tunnel-upsert scotttactical.com \
  traefik.kube-system.svc.cluster.local \
  --domain scotttactical.com --domain www.scotttactical.com \
  --rewrite-host scotttactical.dtac.io
```

- `traefik.kube-system.svc.cluster.local` = the backend frpc dials (cluster-local,
  so it floats across node00/H5s).
- `--rewrite-host scotttactical.dtac.io` = Host rewrite so Traefik routes to the
  site ingress (Traefik routes that host, not scotttactical.com directly).
- Env keys: `OPSLAYER_TUNNEL_PROVIDER=frp`, `OPSLAYER_FRP_SERVER=44.242.82.136`,
  `OPSLAYER_FRP_PORT=7000`, `OPSLAYER_FRP_TOKEN=<shared>`.
- Related verbs: `opslayer network tunnel-status|tunnel-list|tunnel-delete|tunnel-verify`
  (read-only ones are safe; delete removes the whole frpc app).

Rendered frpc.toml (for reference):

```toml
serverAddr = "44.242.82.136"
serverPort = 7000
auth.method = "token"
auth.token = "{{ .Envs.FRP_TOKEN }}"
[[proxies]]
name = "scotttactical.com"
type = "http"
localIP = "traefik.kube-system.svc.cluster.local"
localPort = 80
customDomains = ["scotttactical.com", "www.scotttactical.com"]
hostHeaderRewrite = "scotttactical.dtac.io"
transport.useEncryption = true
```

## AWS security group - REQUIRED (do not forget on a new box)

The hub's EC2 security group must allow **inbound TCP 7000** (frp control) to the
world (or the home egress), in addition to 80/443/22. Without it, frpc dials
44.242.82.136:7000 and **i/o timeout** -> CrashLoopBackOff, even though
80/443/22 work. Verified 2026-09-22: adding the 7000 SG rule made the pod connect.

## Verify

From a public (non-LAN) vantage:

```bash
curl -sI https://scotttactical.com/
dig +short scotttactical.com A
# expected: 200; generator Hugo 0.166.0 (current cluster content) - verified 2026-09-22
```

## Rollback (one sentence)

> Undo = stop frpc at home (opslayer network tunnel-delete scotttactical.com), stop
> frps on the hub, and repoint scotttactical.com back to the old EC2 A-record
> (preserved); nginx server block + certbot cert can stay or be removed, both harmless.

## View: admin / status

- `opslayer network tunnel-status` - frpc deployment state
- frps dashboard: the loopback frps webServer (127.0.0.1:7500) or Prometheus metrics on the hub.