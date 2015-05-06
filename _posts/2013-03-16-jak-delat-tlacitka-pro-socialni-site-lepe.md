---
layout: post
title: Jak dělat tlačítka pro sociální sítě lépe
date: '2013-03-16 20:07:35'
tags:
- facebook
- linkedin
- twitter
- google
---
Také máte pod článkem několik tlačítek (pluginů) pro sociální sítě? Umožnit snadno sdílet článek a ukázat, kolik lidí už tak učinilo. Víte, že taková tlačítka dovedou přenést klidně stovky KB dat a načítat se 10 sekund?  Přečtěte si, jak je vytvořit lépe a jednoduše.

<h2>Kde je problém?</h2>
<p>Vytvořil jsem jednoduchou ukázkovou stránku,do které jsem vložil běžná tlačítka pro sdílení na sociálních sítích. Stránka je k vidění tady: <a href="http://www.tomas-dvorak.cz/examples/sharebuttons.html">test sociálních tlačítek</a>. Až odkaz rozkliknete, sledujte jak dlouho se tlačítka zobrazují.</p>
<p>Ve stránce není vloženo nic, než sdílecí tlačítka a čtyři odstavečky pro uvození konkrétní sítě a pod tím hned tlačítko. Žádný obsah, styly, nic dalšího. Přesto má stránka přímo obludné rozměry a parametry. Posuďte sami:</p>
<ul>
<li><strong>22 requestů</strong> na různé URL</li>
<li><strong>392,3KB</strong> přenesených dat</li>
<li><span class="netTotalTimeLabel netSummaryLabel ">5.24s (onload: 6.31s) načítání stránky (subjektivní, záleží na připojení a počítači)</span></li>
</ul>
<p>Když necháte svého čtenáře takovou zrůdnost stahovat na mobilu, při špatném připojení a s obvyklým FUP, moc vám nepoděkuje. Stránka se mu bude načítat dlouho, vytěžovat síť a zdržovat samotné vykreslení stránky. Dost možná samotná tlačítka přenesou více dat, než vaše stránka s obsahem.</p>
<p>Jasně, část z požadavků a dat zůstane nacachována v prohlížeči a nenačítá se vždy, při prvním přístupu ale ano. Krom toho, veškeré přístupy na váš web zpřístupňujete oněm sociálním sítím. Dovedou tak trackovat jak známé, tak neznámé uživatele. </p>
<div>Pokud znáte a používáte Firebug nebo jeho obdoby v jiných prohlížečích, ověřte si sami, co taková <a href="http://www.tomas-dvorak.cz/examples/sharebuttons.html">stránka</a> všechno dělá a jak dlouho ji to trvá. </div>
<p>Aby toho nebylo málo, tlačítka i po načtení stránky dále komunikují se svou domovskou stránkou a stahují tak další a další KB dat. Stačí na prvek najet myší a ihned vyšle další požadavky a stahuje nová data. Nejaktivnější je v tomto směru prvek pro Google+. Při najetí myší nad každé ze čtyř tlačítek se vykoná celkem dalších 13 požadavků a stáhne 80,4KB dat.</p>
<p>Tlačítka jsem vygeneroval vždy v developer sekci té které sítě, tedy:</p>
<ul>
<li>LinkedIn: <a href="http://developer.linkedin.com/plugins/share-plugin-generator">http://developer.linkedin.com/plugins/share-plugin-generator</a></li>
<li>Twitter: <a href="https://twitter.com/about/resources/buttons">https://twitter.com/about/resources/buttons</a></li>
<li>Facebook: <a href="https://developers.facebook.com/docs/reference/plugins/like/">https://developers.facebook.com/docs/reference/plugins/like/</a></li>
<li>Google plus: <a href="https://developers.google.com/+/web/share/">https://developers.google.com/+/web/share/</a> </li>
</ul>
<h2>Externí služby - AddThis</h2>
<p>Možná znáte službu <a href="http://www.addthis.com/">AddThis</a>, která umožňuje sociální tlačítka spravovat jednotně. V podstatě si vyberete design, služby a ona vám vygeneruje kód na míru pro vložení do stránky. Může to být lepší, než vkládat tlačítka po jednom? Vytvořil jsem <a href="http://www.tomas-dvorak.cz/examples/sharebuttons-addthis.html">testovací stránku</a> pro tlačítka vložená přes AddThis. Načítá se (zdánlivě) jen jeden soubor - ten z webu addthis.com.</p>
<p>Tady jsou hodnoty:</p>
<ul>
<li><strong>28 requestů</strong> na různé URL</li>
<li><strong>378,8KB</strong> přenesených dat</li>
<li><span class="netTotalTimeLabel netSummaryLabel ">5.78s načítání stránky (subjektivní, záleží na připojení a počítači)</span></li>
</ul>
<div>Nejen, že neuspoříte žádná data, ale stránka udělá ještě o 6 dalších requestů navíc. Krom toho jsou tlačítka kompletně blokována addBlockem. Jako bonus poskytujete svá data nejen sociálním sítím, ale i addthis.com službě (viz <a href="http://www.addthis.com/tos">podmínky služby</a>). To rozhodně není cesta, jak odlehčit uživateli. </div>
<h2>Jak to dělat lépe?</h2>
<p>Vždyť je to jen tlačítko, obrázek. Musí být lepší způsob, jak umožnit uživatelům sdílet a neprudit je přitom takovou záplavou požadavků a dat. Opravdu potřebujete, aby v bublině vedle tlačítka svítilo, kolik lidí už kliknulo? </p>
<p>Netahejte žádné scripty a externí data. Pro každou síť si připravte obrázek/ikonku/text, nastavte jej jako odkaz a ten nasměrujte na správnou URL. Načteno bude v mžiku, nebudete umožňovat špehování uživatelů a především - <strong>nebudete zatěžovat uživatele</strong>.</p>
<p>Každá z běžných sociálních sítí má nějakou URL, na kterou jde poslat v parametrech adresu, popis nebo text a umožnit tak sdílet vaši stránku. Takovou url dovedete do tlačítka zanést ať už v okamžiku vykreslení stránky pomocí redakčního systému nebo programovacího jazyka, nebo až po načtení například pomocí vlastního jednoduchého JavaScriptu. Pokud si na to netroufáte, zeptejte se svého webmastera a ukažte mu tuto stránku. Bude vědět, jak na to.</p>
<p>Provozovatelé sociálních sítí to nepovažují za preferovanou cestu sdílení. Přicházejí tak o mnoho cených dat, která jim tak (nevědomky) poskytujete. Pro běžné sítě jsem tedy připravil popis, jak na to.</p>
<h3 class="prettyprint">Twitter URL pro sdílení</h3>
<p>Detailní popis je ve <a href="https://dev.twitter.com/docs/tweet-button">vývojářské dokumentaci</a> na twitteru.Nejjednodušší zápis URL pro sdílení na twitteru může být:</p>
<pre class="prettyprint">http://twitter.com/share?url=<strong>{articleUrl}</strong>&text=<strong>{articleTitle}</strong></pre>
<p>Proměnné <strong>{articleUrl} </strong>a<strong> </strong><strong>{articleTitle} </strong>nahraďte za konkrétní hodnoty pro vaši stránku(pro každý článek).<strong> </strong>Hodnoty by měly být URL encodovány (jak na to viz dokumentace pro <a href="http://php.net/manual/en/function.urlencode.php">PHP</a>, <a href="http://www.w3schools.com/jsref/jsref_encodeuricomponent.asp">JavaScript</a>, <a href="http://docs.oracle.com/javase/6/docs/api/java/net/URLEncoder.html">Javu</a>). Další možné parametry jsou například {via}, {related} nebo {hashtags}. Kompletní seznam a návod najdete v již zmíněné <a href="https://dev.twitter.com/docs/tweet-button">dokumentaci</a>.</p>
<h3>Facebook URL pro sdílení</h3>
<p>U facebooku se mi nepovedlo dohledat přímou dokumentaci ke konstrukci URL pro sdílení. Nějaká dokumentace je <a href="https://developers.facebook.com/docs/plugins/">zde</a>, ale samotná adresa tam popsána není.</p>
<p>Adresa pro sdílení na facebooku je jednodušší, než u jiných služeb. Stačí předat cílovou stránku a Facebook si sám načte potřebné <a href="http://www.tomas-dvorak.cz/clanky/ma-vase-stranka-meta-informace-v-poradku">metainformace</a> (titulek, text, obrázek). Je tak dobré mít svůj web dobře upravený pro čtení facebook robotem. Jak na to jsem psal již dříve v článku <a href="http://www.tomas-dvorak.cz/clanky/ma-vase-stranka-meta-informace-v-poradku">Má vaše stránka meta informace v pořádku?</a></p>
<p>Adresa má následující formát:</p>
<pre class="prettyprint">http://www.facebook.com/sharer.php?u=<strong>{articleUrl}</strong></pre>
<p>ArticleUrl by mělo být opět encodováno.</p>
<h3>Google+ URL pro sdílení</h3>
<p>I Google+ poskytuje jednoduchou adresu pro sdílení článku. Moc se tím nechlubí a raději by, abyste si na web nacpali jeho tlačítko, <a href="https://developers.google.com/+/web/share/#sharelink">dokumentaci</a> však poskytuje.</p>
<p>Zápis URL je obdobný Facebooku, tedy:</p>
<pre class="prettyprint">https://plus.google.com/share?url=<strong>{</strong><strong>articleUrl</strong><strong>}</strong></pre>
<h3 style="white-space: normal;">LinkedIn URL pro sdílení</h3>
<p style="white-space: normal;">Detailní popis konstrukce URL je popsán v <a href="https://developer.linkedin.com/documents/share-linkedin">dokumentaci</a>. Tvar je takový:</p>
<pre class="prettyprint">http://www.linkedin.com/shareArticle?mini=true&url=<strong>{articleUrl}</strong>&title=<strong>{articleTitle}</strong>&summary=<strong>{articleSummary}</strong>&source=<strong>{articleSource}</strong> </pre>
<p style="white-space: normal;">Parametry musí být URL encodované a nejsou všechny povinné (měl by stačit odkaz na článek, zbytek si dovede linkedin donačíst sám z <a href="http://www.tomas-dvorak.cz/clanky/ma-vase-stranka-meta-informace-v-poradku">metadat</a>).</p>
<h2 class="prettyprint"><strong>Co tím získám?</strong></h2>
<ul>
<li>Významně nižsí objem dat přenášených při načtení stránky (ocení hlavně mobilní uživatelé).</li>
<li>Velmi rychlé načítání tlačítek.</li>
<li>Nižší potřebný výkon pro zobrazení stránky (prohlížeč nebude 10s chroupat, než tlačítka vykreslí).</li>
<li>Získáte plnou kontrolu nad svým webem (sámi si určíte, jak bude sdílecí prvek vypadat).</li>
<li>Znemožníte sledování vašich čtenářů sociálními sítěmi.</li>
<li>Budete mít jednotný vzhled a funkce tlačítek.</li>
<li>Tlačítka vám nebude blokovat AdBlock (plugin pro skrytí reklamy na webu)</li>
</ul>
<p>Zároveň ale přijdete o vždy aktuální obrázek tlačítka a taky o bublinu s počtem kliknutí. Počet kliknutí ale může naopak odvádět od úmyslu sdílet článek. Někdo nechce sdílet první, jiný nechce být pětistý v řadě.</p>
<h2>Ozkoušejte si</h2>
<p>Pokud si chcete zkusit, jak to funguje, klikněte prosím na některé ze sociálních tlačítek pod tímto článkem. Otestujete, že opravdu fungují a pokud sdílení potvrdíte, zároveň tak budete šířit osvětu a tipy svým přátelům. Děkuji vám :-) </p>
<p>Protože nejsem znalcem sociálních sítí a jejich funkcí, dost možná jsem přehlédl nebo zapomněl něco podstatného. Pak napište prosím svou připomínku nebo tip do komentářů.</p>
