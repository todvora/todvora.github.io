---
layout: post
title: ! 'Textpattern: zapomenutý redakční systém?'
date: '2013-01-05 09:13:25'
tags:
- textpattern
- wordpress
- joomla
- drupal
- CMS
- design
---
Znáte Textpattern? Redakční systém z dob, kdy začínal i WordPress. Dodnes se vyvíjí, přestože jej ostatní CMS dávno předběhly. Pojďte se mnou na krátkou prohlídku tohoto redakčního systému. 

<p><img style="float: right; margin: 0 0 10px 10px;" src="/images/259.png" alt="Textpattern logo" width="200" height="57" /></p>
<p>Textpattern je redakční systém postaven na jazyce PHP a MySQL databázi. Největší úspěchy slavil v letech 2005-2007 a v České republice byl značně populární. Poté byl převálcován WordPressem. A také Joomlou, Drupalem a dalšími. Pojďme se podívat, co zajímavého Textpattern dovede, kde jsou jeho silné a slabé stránky a proč pravděpodobně skončil v propadlišti dějin. </p>
<p><img src="/images/251.png" alt="Textpattern - popularita v čase, Google Trends" width="600" height="189" /></p>
<p><em>Obrázek - Jak se měnil zájem o <a href="http://www.google.cz/trends/explore#q=textpattern&cmpt=q">Textpattern - Google trends</a>. Klikněte pro zvětšení</em></p>
<h2>Popularita v ČR</h2>
<p>Největší popularity dosahoval u nás - v ČR. Mnoho českých programátorů se věnovalo psaní pluginů pro tento systém. Velké zásluhy na rozšíření patří i webu <a href="http://textpattern.ivorius.com/">textpattern.ivorius.com</a>. Autorem je Ivo Toman a web <a href="http://web.archive.org/web/20051110002730/http://textpattern.ivorius.com/" target="_blank">provozuje od roku 2005</a>, kdy vznikly i první návody v češtině. Sám jsem se o Textpatternu dozvěděl od <a href="https://twitter.com/pbrada">Přemka Brady</a> v rámci výuky na ZČU-FAV. Od té doby jej pro některé své projekty (včetně tohoto blogu) používám. </p>
<div id="trendsReportTopLocations0" class="trendsReportTopLocations verticalMargin" style="text-align: -webkit-auto; margin-top: 0.4em; margin-right: 0px; margin-bottom: 0px; margin-left: 0px; width: 355px; color: #333333; padding: 0px;"><span style="font-family: arial, sans-serif; font-size: small;">  <img style="margin-left: 10px;" src="/images/252.png" alt="Textpattern - popularita podle zemí. ČR zdaleka převažuje nad ostatními." width="369" height="281" /></span></div>
<h2> </h2>
<h2>Výhody a nevýhody Textpatternu</h2>
<p>Textpattern je velmi lehký redakční systém bez zbytečných složitostí a nastavení. Práce s ním je přímočará - napsat článek a publikovat. V tom je jeho největší síla a zároveň slabina. Od začátku je vytvářen jako nástroj pro bloggery a psavce. Bez zbytečné omáčky a rušivých elementů vede k publikování. Ale v případě, že chcete na Textpatternu vytvořit firemní prezentaci, neobejdete se bez značných zásahů do kódu alespoň základní znalosti programování. <strong>Pro neprogramátora je značně obtížné upravit web ke svému obrazu. </strong></p>
<h3>Výhody</h3>
<ul>
<li>Jednoduchý a čistý kód, již v základní instalaci možnost velmi výrazně upravovat funkcionalitu webu, velmi snadné zásahy do struktury i dat.</li>
<li>Rychlá odezva webu, svižnější než Wordpress.</li>
<li>Možnost snadno spravovat kód šablony, vkládat oddělené bloky, ovlivňovat formy, v jakých budou data vypisována. Programátor se zaraduje z oddělení obsahu a formy.</li>
<li>Velmi jednoduchá úprava kódu webu, ovšem jen pro programátorsky zdatného správce.</li>
<li>Méně známý, takže není cílem spamovacích robotů. S použitím jednoduché captcha nebudete mít komentáře plné spamu tak jako u WP.</li>
</ul>
<p> </p>
<h3>Nevýhody</h3>
<ul>
<li><strong>Zápis textů v <a href="http://en.wikipedia.org/wiki/Textile_(markup_language)">Textile</a></strong> místo WYSIWYG editoru (například <a href="http://www.tinymce.com/">TinyMCE</a>). Takový zápis je neintuitivní a ocení jej snad jen programátor a ještě málokterý. Existují pluginy pro jiné formy zápisu textu, je však nutné je doinstalovat.</li>
<li>Základní šablona není použitelná, snad jen pokud jste minimalista a odmítáte veškerý webdesign. Stejně tak ani administrace není zrovna příjemná na pohled a srovnání s WordPressem nesnese. Ostatně posuďte sami, na konci článku je přiloženo několik screenshotů.</li>
<li>Značně komplikované vytváření statických stránek firemního webu. Tam, kde ve WordPressu naklikáte menu, strukturu i stránky, musíte v Textpatternu značně upravit kód šablon.</li>
<li>Složitá instalace pluginů, nemožnost najít plugin přímo z administrace systému (galerie pluginů). Je nutné dohledat plugin na webu a jeho Base64 zakódovanou reprezentaci (<a href="https://github.com/spiffin/spf_if_eu/blob/master/spf_if_eu.txt">ukázka</a>) vložit do textarey ve správě pluginů.</li>
<li>Žádná jednoduchá cesta, jak instalovat šablony (skiny).</li>
<li>Složitý update na nové verze (stahni, rozbal, uploadni na FTP, spusť update a doufej, že si nic nerozbil).</li>
<li>Velmi nepříjemná administrace obrázků a jejich vkládání do příspěvků.</li>
</ul>
<h2>Budoucnost Textpatternu</h2>
<p>Přesto, že se textpattern dál vyvíjí na <a href="https://code.google.com/p/textpattern/">google code</a> a poslední aktualizace byly provedeny doslova před pár dny, nevěřím, že čekají tento systém světlé zítřky. Zájem o něj už dávno opadl a velikáni jako WordPress, Drupal a Joomla jsou od začátku ve velké převaze.</p>
<p><img src="/images/253.png" alt="Textpattern - porovnání zájmu s ostatními redakčními systémy" width="600" height="188" /></p>
<h2>Doporučil bych jej?</h2>
<p>Pokud jste programátor a/nebo hračička a chcete si zřídit svůj blog postavený na Textpatternu, směle do toho.<strong> V případě, že vytváříte firemní prezentaci pro klienta, není to dobrá volba.</strong> Rozhraní není intuitivní a uživatelsky příjemné tak, jako WordPress. V základu chybí WYSIWYG editor textů i mnoho, jinde běžné, funkcionality potřebné pro firemní prezentaci.</p>
<p>Komunita kolem Textpatternu již téměř nefunguje. <a href="http://textpattern.org/plugins">Pluginy</a> jsou neudržované a nepodporují čerstvá vydání systému. </p>
<h2>Obrázky za tisíc slov</h2>
<p>Živé ukázky administrace i frontendu si můžete prohlédnout na webu <a href="http://www.opensourcecms.com/">opensourcecms.com</a>: <a href="http://www.opensourcecms.com/scripts/details.php?scriptid=88">wordpress</a> a <a href="http://www.opensourcecms.com/scripts/details.php?scriptid=86">textpattern</a>.</p>
<p> </p>
<p><img src="/images/254.png" alt="Textpattern - homepage" width="300" height="195" />   <img src="/images/256.png" alt="Textpattern - admin" width="300" height="195" /></p>
<p><em>Obrázky - základní vzhled Textpattenu a jeho administrace</em></p>
<p> </p>
<p><img src="/images/255.png" alt="WordPress Homepage" width="300" height="195" />    <img src="/images/257.png" alt="WordPress admin" width="300" height="195" /></p>
<p><em>Obrázky - základní vzhled WordPressu a jeho administrace</em></p>
<p> </p>
<p>Už ze snímků základní instalace Textpatternu a WordPressu je jasné, kde se stala chyba. Ať se mi to líbí nebo ne, design prodává a to, co předvádí Textpattern snad ani designem nejde nazvat. Základní instalaci wordpressu můžete klidně hned začít používat, stačí vyměnit obrázek v hlavičce. A skutečně to tak mnoho lidí dělá. Dovedete si představit, že používáte základní design Textpatternu?</p>
<p>Mám rád minimalistické a jednoduché věci. Na Textpatternu je ale jasně vidět, že bez líbivého designu může být věc sebelepší a stejně o ní nebude zájem. Na to my programátoři často zapomínáme. </p>
<p> </p>
<h2>UPDATE: Nová verze</h2>
<p>Jak upozornil v komentářích Jozef Mak, txp zažívá poslední dobou překotný vývoj. Neodolal jsem  a nainstaloval nejnovější verzi na adresu <a href="http://txpdemo.tomas-dvorak.cz/">http://txpdemo.tomas-dvorak.cz/</a> . Jde o verzi 4.5.4. Díky za upozornění. </p>
<p>Je pravda, že se frontend i backend změnil. Defaultní frontend šablona vypadá o kus lépe a je responzivní. Paráda. Backend však až na drobné kosmetické změny vypadá stále stejně a hlavně pořád stejně funguje. </p>
<p>Pořád jen textile (dle mého nepoužitelné), stále stejně neohrabaná práce s obrázky, úprava šablon na úrovni zásahů do html (srovnejte s pohodlnou správou bloků ve WP). Jsem rád, že se textpattern stále vyvíjí dál, bohužel většina z problémů, které vidím, zůstala nezměněna.</p>
<p><img src="/images/261.png" alt="Textpattern - frontend - nová verze" width="300" height="195" />   <img src="/images/262.png" alt="Textpattern - admin - nová verze" width="300" height="195" /></p>
<p> </p>
