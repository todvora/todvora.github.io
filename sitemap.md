---
layout: page
title: Sitemap
permalink: /sitemap/
---

<div class="home">
    <ul>
        {% for post in site.posts %}
        <li>
            <a href="{{ post.url | prepend: site.baseurl }}">{{ post.title }}</a> <span class="post-meta">{{ post.date | date: "%b %-d, %Y" }}</span>
        </li>
        {% endfor %}
    </ul>
</div>
