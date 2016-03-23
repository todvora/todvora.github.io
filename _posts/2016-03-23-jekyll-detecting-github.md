---
layout: post
title: "Jekyll: detect Github build"
date:   2016-03-05 15:34:01
tags:
  - jekyll
  - github
  - liquid
image: /images/jekyll-logo.png
---

Do you host your Jekyll generated site on Github and need to distinguish between Github and other environments, where the site has been built?

Github exposes [repository metadata](https://help.github.com/articles/repository-metadata-on-github-pages/) inside Jekyll's configuration under ```site.github``` namespace. This can be used to render some interesting data like repository name, organisation members, releases, contributors or repositories:

```liquid
{% raw %}{% for repository in site.github.public_repositories %}
  * [{{ repository.name }}]({{ repository.html_url }})
{% endfor %}{% endraw %}
```

Or you can use it to detect Github powered build and modify your templates accordingly:

```liquid
{% raw %}{% if site.github %}
    <p>Hosted on Github Pages, for free.</p>
{% endif %}{% endraw %}
```

### Instruct search engines to ignore github build

I am hosting this blog myself on my hosting while keeping [github page](https://todvora.github.io) as an online backup. In this case is needed to tell search engines, which site should be ignored. To do so, my [robots.txt](https://github.com/todvora/todvora.github.io/blob/master/robots.txt) looks like:

```liquid
{% raw %}{% if site.github %}
User-agent: *
Disallow: /
{% else %}
User-agent: *
Allow: /
{% endif %}{% endraw %}
```

And in HTML header of the layout:

```liquid
{% raw %}{% if site.github %}
    <meta name="robots" content="noindex, nofollow">
{% endif %}{% endraw %}
```

The self-hosted page (build by travis-ci) is fully accessible and indexable. The github page should be ingored and not indexed by search engines.
