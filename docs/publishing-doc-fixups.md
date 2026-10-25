# Publishing-doc fixups (to apply after the car-computer article work)

Running notes on things found wrong or missing in
`docs/writing-and-publishing-articles.md` while writing the car-computer posts.
Fix these once the article work is done; do not silently edit that doc mid-project.

1. Section 3 (front matter contract) and section 5 (Images) tell authors to use a
   `figure` shortcode:
   `{{< figure src="/images/x.jpg" caption="..." >}}`.
   **The theme has no `figure` shortcode.** It ships `img`
   (`themes/scott/layouts/shortcodes/img.html`), used as
   `{{% img src="images/x.jpg" caption="..." %}}` (note the `%` delimiters, not
   `<`), with optional `class` and `href`. Update both examples to `img`.

2. The doc never mentions diagrams. The theme ships a `mermaid` shortcode
   (`themes/scott/layouts/shortcodes/mermaid.html`) rendered from
   `baseof.html`, used as:

       {{< mermaid >}}
       flowchart TD
         A --> B
       {{< /mermaid >}}

   Fenced ```` ```mermaid ```` blocks are NOT what the site uses. Add a short
   "Diagrams" subsection.

3. `categories` guidance says "usually Software (the site uses a small set)". In
   practice the only value seen in recent posts is `Software`. The car-computer
   posts introduced `Hardware`; either bless a small explicit category list here
   or fold hardware posts into an existing category. Decide and document.

4. Minor: the doc says new posts should use `draft: false`. Fine as the default,
   but note that `buildDrafts = true` lets an in-progress post render locally while
   kept `draft: true` (used for the car-computer drafts).

5. **The doc's `image:` front-matter field does nothing.** Section 3 says to set
   `image:` for the hero/social image. The theme never reads `.Params.image`. It
   reads **`.Params.thumbnail`** for all three uses: the post card thumb
   (`li.html`), the on-page hero band (`summary.html` -> `article.single .thumb`),
   and the `og:image` / `twitter:image` / JSON-LD image
   (`partials/single_meta.html`, `single_json_ld.html`). Consequence: the 31 posts
   that set `image:` have no card or social image (all fall back to
   `images/default.png`). Fix the doc to say `thumbnail:`; optionally add a
   compatible alias. See `themes/scott/layouts/`.
