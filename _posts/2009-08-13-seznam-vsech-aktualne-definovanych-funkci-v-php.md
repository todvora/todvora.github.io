---
layout: post
title: Seznam všech aktuálně definovaných funkcí v PHP
date: '2009-08-13 08:39:06'
tags:
- php
- metoda
- proměnná
- textpattern
- výstup
---

Jak pomocí PHP snadno zjistit, jaké funkce jsou v aktuálním
okamžiku dostupné


<p>Funkce <code>get_defined_functions();</code> umožnuje vypsat přehled
definovaných funkcí v aktuálním bloku PHP kódu. Můžeme tak
například zjistit, jaké všechny funkce je možné použít při vytváření
pluginu do Textpatternu. Pro lepší čitelnost doporučuji vypsat návratovou
hodnotu fukce pomocí metody <code>print_r($arr);</code> . Celý kód pak bude
vypadat nějak takto :</p>

<pre><code>$arr = get_defined_functions();
print_r($arr);</code></pre>

<p>A výsledkem bude výpis obdobný tomuto:</p>

<p>Array
<br />(
<br />[internal] => Array
<br />(
<br />[0] => zend_version
<br />[1] => func_num_args
<br />[2] => func_get_arg
<br />[3] => func_get_args
<br />[4] => strlen
<br />[5] => strcmp
<br />[6] => strncmp
<br />...
<br />[750] => bcscale
<br />[751] => bccomp
<br />)</p>

<p>[user] => Array
<br />(
<br />[0] => myrow
<br />)</p>

<p>)</p>

<p>Ale vzhledem k tomu že se jedná o PHP, bude mít spíše
obrovské množství funkcí :)</p>

<p>Více na <a
href="http://cz2.php.net/get_defined_functions">http://cz2.php­.net/get_defi­ned_functions</a></p>

