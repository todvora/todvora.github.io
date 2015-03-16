---
layout: post
title: ! 'Smarty: null v šabloně'
date: '2010-03-02 15:19:13'
tags:
- php
- smarty
---

Jak ve smarty poznat, že proměnná je null.


<p>Velmi často se před vypisováním hodí vědět, jestli proměnná, kterou
mám zrovna v plánu vypsat je NULL. Provést se to dá velmi
jednoduše:</p>

<pre class="prettyprint"><code>{if $paging->getFirst()}
    {* mám první stránku stránkování *}
{else}
    {* metoda getFirst() vrátila NULL *}
{/if}</code></pre>

<p><code>$paging</code> je samozřejmě objekt, nad kterým lze metodu getFirst
zavolat a semtam nevrací NULL :)</p>

