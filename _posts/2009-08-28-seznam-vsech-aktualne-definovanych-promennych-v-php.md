---
layout: post
title: Seznam všech aktuálně definovaných proměnných v PHP
date: '2009-08-28 05:43:18'
tags:
- php
- proměnná
---
Někdy se pro ladící účely hodí mít vypsaný seznam všech proměných, které jsou v současné chvíli dostupné. PHP na to má jeden velmi jednoduchý příkaz.

<p>Začneme hned zdrojovým kódem (z manuálových stránek PHP) :</p>
<pre><code><?php $b = array(1,1,2,3,5,8); $arr = get_defined_vars(); // print $b print_r($arr["b"]); // print all the available keys for the arrays of variables print_r(array_keys(get_defined_vars())); ?></code></pre>
<p>kde výstup bude podobný tomuto:</p>
<pre><code>Array ( [0] => 1 [1] => 1 [2] => 2 [3] => 3 [4] => 5 [5] => 8 ) array(4) { [0]=> string(4) "html" [1]=> string(5) "prefs" [2]=> string(1) "b" [3]=> string(3) "arr" }</code></pre>
<p>Nejprve se vypsalo celé pole b a následně klíče v mapě všech proměných. To, že se nevypíše celá (docela obrovská) struktura všech proměných, je zajištěno právě funkcí array_keys().</p>
<p>Pokud by výpis vypadal jen takto : </p>
<pre>print_r(get_defined_vars());</pre>
<p>výstup by vypsal i hodnoty jednotlivých proměných, nějak takhle (pouze malá část pole):</p>
<pre><code>Array ( [prefs_id] => 1 [sitename] => Tomáš Dvořák [siteurl] => www.tomas-dvorak.cz [site_slogan] => programování a webdesign [language] => cs-cz [url_mode] => 1 [timeoffset] => 0 [comments_on_default] => 1 [comments_default_invite] => Komentář</code></pre>
<p>Jak s takovými daty naložit už je na Vás.</p>
