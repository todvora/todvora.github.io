---
layout: post
title: Smarty foreach
date: '2008-04-22 20:43:44'
tags:
- smarty
- foreach
- php
- template
---

Smarty a foreach, způsob jak odlišit první a poslední iteraci


<p>Způsob jak donutit smarty vypisovat v cyklu třeba toto:</p>

<p>prvni | druhy | treti</p>

<p>Kde za třetí už není oddělovací čára. Jde tedy o to,jak
u posledního( nebo prvního) prvku vykonat něco jiného než
u ostatních.</p>

<p>Řešení je snadné, cyklus pojmenujeme( tag name) a pak jen testujeme,
jestli jeho iterace je poslední(první) a vykonáme co je třeba.</p>

<pre><code>{foreach name=foo from=$array}
{if $smarty.foreach.foo.first} První iterace {/if}

Jakýkoli výpis v každé obrátce cyklu

{if $smarty.foreach.foo.last}  Poslední iterace {/if}
{/foreach}</code></pre>

<p>A k příkladu z úvodu:</p>

<pre><code>{foreach name=foo from=$array item=polozka}

{$polozka}

{if !$smarty.foreach.foo.last}  | {/if}
{/foreach}</code></pre>

<p>Tedy pokaždé vypíše obsah buňky pole,a pokud není poslední, vypíše
i oddělovač.</p>

