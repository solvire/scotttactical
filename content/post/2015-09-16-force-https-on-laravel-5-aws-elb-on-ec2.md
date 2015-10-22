---
title: Force HTTPS on Laravel 5 behind AWS ELB on EC2
author: SScott
date: 2015-09-16
url: /force-https-on-laravel-5-aws-elb-on-ec2/
categories:
  - DevOps
---
# Laravel 5 - Enforcing HTTPS

[<img src="http://scotttactical.com/wp-content/uploads/2015/09/Laravel-5-300x180.png" alt="Laravel 5" width="300" height="180" class="alignnone size-medium wp-image-195" />][1]

I've used a lot of frameworks. <a href="http://laravel.com/" title="Laravel 5" target="_blank">Laravel</a> is great.

## Dealing with a load balancer

Most of us are on a scaled service and most of us need HTTPS. It is much easier to put the SSL certificate on the load balancer and then proxy the request over port 80 to the actual server. It saves on CPU processes as well since the decryption work doesn't have to be performed on the slave boxes. 

If you do not handle the redirect properly and just look for port 443 then you will get yourself into a **redirection loop**. That is annoying because if you don't test under an SSL you will deploy to production and then have to tell you boss why you're loopy. Amazon is kind of a pain for this.

## AWS ELB Proxy Headers

Make sure you know what the request looks like to the accepting server. 

This header is going to be passed over:
  
`HTTP_X_FORWARDED_PROTO`

The problem with just looking for this and accepting your solution based on this is that header can be forged trivially. You need to make sure you are only acknowledging that header from trusted sources. 

## Setting the Redirect

I went ahead and installed <a href="https://github.com/fideloper/TrustedProxy" title="Laravel Trusted Proxies" target="_blank">Laravel Trusted Proxies</a> from <a href="https://github.com/fideloper" title="Chris Fideo" target="_blank">Chris Fideo</a>. 

Follow his instructions. It's pretty straight forward. Here is what my \`config/trustedproxy.php\` looks like. 

<pre class="brush: php; title: ; notranslate" title="">'proxies' =&gt; [
    '172.31.0.0/16',
],
</pre>

I knew after looking at my logs where my health checks were coming from:\`ELB-HealthChecker/1.0\`
  
I figured if I just allow everything in that B block that I should be okay. 

Also set the proper header to look for.
  
NOTE: I lost a couple hours trying to figure out why it wouldn't match. Read the docblock above it. It strips HTTP_  <img src="http://scotttactical.com/wp-includes/images/smilies/frownie.png" alt=":(" class="wp-smiley" style="height: 1em; max-height: 1em;" />

<pre class="brush: php; title: ; notranslate" title="">'headers' =&gt; [
        \Illuminate\Http\Request::HEADER_CLIENT_IP    =&gt; 'X_FORWARDED_FOR',
        \Illuminate\Http\Request::HEADER_CLIENT_HOST  =&gt; 'FORWARDED_HOST',
        \Illuminate\Http\Request::HEADER_CLIENT_PROTO =&gt; 'X_FORWARDED_PROTO',
        \Illuminate\Http\Request::HEADER_CLIENT_PORT  =&gt; 'X_FORWARDED_PORT',
    ]
</pre>

## Add to Laravel Middleware

I created Secure.php and added it to app/Http/Middleware
  
Thanks to the work from <a href="https://gist.github.com/nblackburn/a66e8e93561e277996aa" title="nblackburn" target="_blank">@nblackburn</a>. That was highly appreciated. 

What was weird about my environment is I was getting in a redirection loop because it would prepend \`public/\` on the front of my uri. I'm running multiple environments so I didn't have the luxury of pointing my root to that directory. I had to strip that off the front. 

<pre class="brush: php; title: ; notranslate" title="">class Secure implements Middleware
{
    public function handle($request, Closure $next)
    {
        if (! $request-&gt;secure() && app()-&gt;environment('production')) {
            
            // this is a really ugly hack but it kept looping and prepnding public 
            return redirect()-&gt;secure(preg_replace('%/public%', '', $request-&gt;getRequestUri()));
        }
        
        return $next($request);
    }
}
</pre>

Add it to your global middleware if you want it to run for all requests.
  
Open up: app/Http/Kernel.php

I added 

<pre class="brush: php; title: ; notranslate" title="">protected $middleware = [
	    ...		
		// trust the proxies from aws 
		'Fideloper\Proxy\TrustProxies',
		// then force it secure (if production)
		'LeadFerret\Http\Middleware\Secure',
	];
</pre>

Now there are no more redirect loop hells.

 [1]: http://scotttactical.com/wp-content/uploads/2015/09/Laravel-5.png