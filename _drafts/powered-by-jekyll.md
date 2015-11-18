---
layout: post
title: Powered by Jekyll
date:   2015-11-17 09:50:16
categories:
  - webdesign
  - html
  - javascript
---

## Motivation

## Convert from Textpattern to Jekyll


## Tests
- Travis

## Assets caching
```
{% capture cssPath %}/css/main.css?v={{site.time | date_to_xmlschema}}{% endcapture %}
<link rel="stylesheet" href="{{cssPath  | prepend: site.baseurl }}">
```

```
<script src="/js/new_search.js?v={{site.time | date_to_xmlschema}}" async></script>
```

## Hosting and deploy
http://scurker.com/automated-deploys-with-travis/

## Fulltext search

## Comments
