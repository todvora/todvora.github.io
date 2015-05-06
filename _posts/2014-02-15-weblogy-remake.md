---
layout: post
title: Weblogy remake
date: '2014-02-15 23:15:52'
tags:
- rss
- weblogy
- github
- javascript
---
Mám rád weblogy.cz. Super myšlenka provozovat agregátor českých IT a marketing webů. Ale uživatelské rozhraní mi nevyhovuje. Proto jsem vytvořil alternativní. 

<h2><span>Proč vytvářet alternativní rozhraní?</span></h2>
<ul>
<li>Nechcete koukat na reklamy, twitter stream, kalendář, upoutávky na ostatní projekty iinfa.</li>
<li>Šetříte svůj drahocený FUP (alternativa je 12-25x úspornější, viz níže).</li>
<li>Prohlížíte si weblogy na mobilu a chybí vám responzivní verze.</li>
<li>Chcete mít svůj vlastní design stránky.</li>
</ul>
<div>Demo / běžící aplikaci si můžete prohlédnout na <a href="http://todvora.github.io/wblg">http://todvora.github.io/wblg</a></div>
<h2>Kde vzít data</h2>
<p><a href="http://www.weblogy.cz/">Weblogy</a> poskytují svůj <a href="http://www.weblogy.cz/export/rss/">RSS feed</a>, vzniklý agregací všech těch <a href="http://www.weblogy.cz/zdroje/">skvělých českých blogů</a>. Není tak třeba vytvářet a udržovat vlastní seznamy RSS kanálů, stačí zpracovávat tento agregovaný feed.</p>
<h2>Žádný backend + žádný hosting = žádné problémy</h2>
<p>Bylo by snadné napsat krátký PHP skript, který načte RSS feed a vygeneruje stránku s náhledy článků. Jenže pak přijdou ty problémy. Kde vzít hosting (ideálně zdarma), aby dovedl spouštět PHP skripty. Jak zálohovat, kde verzovat, jak nasadit update? Kterak se o svou práci podělit s dalšími?</p>
<p>Asi bude snazší od začátku celou věc postavit jinak. Když nebude třeba PHP, ale jen JavaScript na frontendu, nemusím mít plnohodnotný hosting. Stačí takový, který umí statické stránky. A náhodou jeden takový zdarma poskytují zrovna <a href="http://pages.github.com/">GitHub pages</a>. S GitHubem přichází další výhody automaticky - verzování a zálohování, deploy gitem, dostupnost, možnost sdílet kód, snadné forkování.</p>
<h2>Google Feed API</h2>
<p>Jenže bez backendu nemůžeme načítat RSS feed přímo ve stránce JavaScriptem. Brání nám v tom <a href="http://en.wikipedia.org/wiki/Same-origin_policy">Same Origin Policy</a>. Můžeme ale využít <a href="https://developers.google.com/feed/">Feed API</a> od Google, které problém řeší (obchází) a umožňuje načíst RSS JavaScriptem v prohlížeči. Nepotřebujeme žádný backend, paráda.</p>
<h2>Dáváme věci dohromady</h2>
<p>Máme tedy vyřešeno, jak RSS feed načíst. Víme, kde hostovat. Zbývá vytvořit jednoduchou HTML stránku, přidat pár řádek JavaScriptu a nastylovat. Odpustíme si zbytečnosti jako jQuery, responzivní framework (Bootstrap/Foundation) a grafiku. Cílem je minimalistická varianta RSS čtečky.</p>
<p>Když pak zdrojáky commitneme do větve 'gh-pages', GitHub nám poskytne běžící aplikaci na adrese <a href="http://todvora.github.io/wblg">http://todvora.github.io/wblg</a></p>
<p>Vešké zdroje čtečky jsou na githubu <a href="https://github.com/todvora/wblg">https://github.com/todvora/wblg</a>, kde si ji můžete prohlédnout, forknout a upravit k obrazu svému.</p>
<h2>Kolik toho FUPu ušetřím?</h2>
<p>Originální <strong>weblogy.cz na první načtení udělají 49 requestů, přenesou 800KB</strong>. Moje minimalistická verze udělá 8 requestů a přenese 66KB. První načtení je zhruba 12x úspornější na data. Další načtení jsou ještě lepší. Originál weblogy.cz jsou na 407KB a moje varianta na 16KB, tedy zhruba 25x úspornější. Na mobilu s velmi špatným a limitovaným připojením zásadní rozdíl. Navíc jednoduchá stránka nezabere tolik paměti telefonu a je responzivní - lépe se používá.</p>
<h2>Je libo vlastní variantu?</h2>
<p>Líbí se vám nápad? Klidně používejte mou stránku <a href="http://todvora.github.io/wblg">http://todvora.github.io/wblg</a>. Pak ale budete odkázáni na vzhled a chování, které vyhovuje mě. A co je dobré pro mě nemusí být super pro vás.</p>
<p>Jsme ale na GitHubu, tak toho využijme. Stačí, když si tenhle projekt <a href="https://github.com/todvora/wblg/fork">forknete﻿</a>. V tu chvíli máte bez práce vlastní běžící instanci dostupnou na vasejmeno.github.io/wblg. Tu si můžete měnit k vašim představám. Jen provedete úpravu a commitnete. Nic víc není třeba.</p>
<p> </p>
