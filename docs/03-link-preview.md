# 03 - Link preview on Messenger, WhatsApp and LinkedIn

Goal: when someone shares the link, a card appears with an image, a title and a description.

## How it works

Social apps read the Open Graph tags in the `<head>` of the page:

```html
<meta property="og:title" content="Nubrivo Tech - Azure and Microsoft 365">
<meta property="og:description" content="Secure, well-governed Microsoft cloud for small and mid-sized organizations.">
<meta property="og:image" content="https://www.example.com/og-image.jpg">
<meta property="og:image:width" content="1200">
<meta property="og:image:height" content="630">
<meta property="og:url" content="https://www.example.com/">
<meta name="twitter:card" content="summary_large_image">
```

Rules:

- `og:image` must be an absolute URL (with `https://`), not a relative path.
- Image size: 1200 x 630 px, JPEG, under 1 MB.
- `robots.txt` must not block the site, or the preview bots cannot read the page. To keep a demo out of search engines, use `<meta name="robots" content="noindex, nofollow">` in the page instead.

## Check before sharing

1. Deploy the site.
2. Open the [Sharing Debugger](https://developers.facebook.com/tools/debug/), paste the URL, then select **Scrape Again**.
3. The image, title and description must appear. A warning about a missing `fb:app_id` can be ignored.

## The preview does not appear in Messenger

- Messenger caches previews. If the link was shared before the tags existed, add a parameter to force a new preview: `https://www.example.com/?v=2`.
- Messenger does not always show a preview, especially for recent domains. When it matters, send the image as a photo first, then the link.
