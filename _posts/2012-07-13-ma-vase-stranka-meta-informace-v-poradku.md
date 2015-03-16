---
layout: post
title: Má vaše stránka meta informace v pořádku?
date: '2012-07-14 11:24:43'
tags:
- meta description
- title
- image_src
- ogp
- opengraph
- facebook
image: /images/120.png
---
Máte na vašich stránkách korektně uvedeny všechny běžně používané meta informace? Tedy titulek, popis a výstižný obrázek, pokud existuje? Informací využívají vyhledavače, sociální sítě, katalogy stránek a je proto dobré nic nepodcenit. Dost možná vám drobná úprava přivede řadu nových čtenářů.

<h2>O co běží?</h2>
<p>V zásadě potřebujeme pro slušně vypadající záznam ve vyhledávání či sociálních sítích při sdílení odkazu tři základní věci:</p>
<ul>
<li>titulek stránky</li>
<li>popisek - krátký popis toho, co na stránce nalezneme</li>
<li>obrázek vystihující článek, pokud takový existuje</li>
</ul>
<p>Tyto tři údaje jdou většinou velmi snadno určit z každé běžné stránky tak jak je, aniž by ji bylo třeba upravovat pro potřeby sdílení. </p>
<p>Jak vypadá ideální stav můžeme vidět při pokusu o sdílení <a href="http://www.lupa.cz/clanky/zakladni-registry-zatim-skoro-nikdo-nepouziva-a-ministerstvo-o-chybach-mlci/">článku</a> z webu <a href="http://www.lupa.cz/">lupa.cz</a>:</p>
<p><img src="http://www.tomas-dvorak.cz/images/120.png" alt="Sdílení článku z lupa.cz na facebooku" width="438" height="386" /></p>
<p>Výsledek vyhledávání na google.com pak zobrazuje ty v podstatě ty samé informace (krom obrázku):</p>
<p><img src="http://www.tomas-dvorak.cz/images/121.png" alt="" width="524" height="262" /></p>
<h2>Titulek - title</h2>
<p>Titulek stránky si každý robot načte z hlavičky (<em><head></em>), elementu <em><title></em>. Titulek stránky je zobrazován i v tabech prohlížeče, výsledcích vyhledávání. autoři stránky by měli mít titulek v pořádku i když neplánují žádné sdílení na sociálních sítích.</p>
<p>Správně má titulek vypadat v kódu takto:</p>
<pre class="prettyprint"><title>Základní registry zatím skoro nikdo nepoužívá a ministerstvo o chybách mlčí - Lupa.cz</title></pre>
<h2>Popisek - meta description</h2>
<p><em>Meta description</em> element má sloužit k vložení krátké informace popisující, co stránka obsahuje. Dříve to byl populární tag pro SEOmágy, pak nastalo období, kdy naopak mágové tvrdili jak je <em>description</em> zcela k ničemu. Dle mého jsme dospěli k rozumnému stavu, description je zobrazeno ve výsledcích hledání a při sdílení v sociálních sítích. Správně má <em>meta description</em> vypadat:</p>
<pre class="prettyprint"><meta name="description" content="Zatímco oficiálně jsou základní registry řádně a dostatečně připraveny, řada měst a obcí upozorňuje své občany na pravý opak. S tím korespondují i statistiky: referenční údaje by ze základních registrů mělo čerpat na 10 tisíc agendových informačních systémů. Zatím jich tak činí jen asi 40." /></pre>
<p>Nemá smysl do description uvádět něco, co na stránce ve skutečnosti není a doufat, že vám to pomůže na první pozice vyhledavačů. Takový podvod bude rychle rozpoznán a i kdyby ne, klamete uživatele a ten nejspíš vaši stránku opustí ihned po vstupu.</p>
<h2>Obrázek</h2>
<p>Pokud vaše stránka neposkytuje žádný relevantní obrázek, buď to vůbec neřešte nebo poskytněte svoje logo. Pokud máte ke každému článku odpovídající obrázek nebo fotku, stojí za to informaci v hlavičce poskytnout. Můžete k tomu využít element link s parametrem rel="image_src". Celý element pak může vypadat:</p>
<pre class="prettyprint"><link rel="image_src" href="http://i.iinfo.cz/images/426/sprava-zakladnich-registru-1.jpg"/></pre>
<p>Co když nebudete mít definován žádný obrázek ke článku ale přesto na stránce nějaký vložený bude? Pak se robot rozhodne jeden vybrat sám (dost často třeba grafický prvek navigace webu), případně poskytne sdílejícímu uživateli možnost vybrat, který obrázek přiložit k příspěvku.</p>
<h2>Opengraph na scéně</h2>
<p><a href="https://developers.facebook.com/docs/opengraph/keyconcepts/">Opengraph</a> je technologie která umožňuje tvůrcům stránek lépe popsat, kam stránka patří, do které kategorie spadá (článek, video, hudba), kdo je autorem, jaký obrázek připojit k textu. </p>
<p>Opengraph může pro potřeby v sociálních sítích nahradit meta informace popsané v článku výše. Ty však mají stále svůj význam pro mnoho dalších webů (vyhledavače, katalogy) i uživatelů (titulek tabu v prohlížeči). </p>
<p>Opengraph daty tak můžeme vhodně doplnit již stávající meta informace. Nejlépe jde zápis dat ukázat na příkladu článku na lupě:</p>
<pre class="prettyprint"><meta property="og:site_name" content="Lupa.cz" />
<meta property="og:type" content="article" />
<meta property="og:image" content="http://i.iinfo.cz/images/426/sprava-zakladnich-registru-1-thumb.jpg" />
<meta property="og:url" content="http://www.lupa.cz/clanky/zakladni-registry-zatim-skoro-nikdo-nepouziva-a-ministerstvo-o-chybach-mlci/" /></pre>
<p>Jak je vidět, v metadatech opengraphu přenášíme název stránky (Lupa.cz), typ stránky(article), cestu k obrázku a url stránky (<a href="http://napoveda.seznam.cz/cz/kanonicke-url.html">kanonická url</a>). Při použití opengraphu je za potřebí doplnit i vhodný namespace:</p>
<pre class="prettyprint"><html xmlns="http://www.w3.org/1999/xhtml" xml:lang="cs" lang="cs" xmlns:og="http://opengraphprotocol.org/schema/"></pre>
<p>Opengraph je preferovaná cesta, jak získává robot facebooku data při pokusu o sdílení stránky. Umí si je však snadno dopočítat i pokud žádná opengraph metadata na stránce nenajde. Detailní popis protokolu opengraph naleznete na webu <a href="http://ogp.me/">http://ogp.me/</a> .</p>
<h2>Testování - jak si web stojí?</h2>
<p>Nakonec to nejdůležitější, jak poznám, že mám vše v pořádku a roboti u mě na webu vidí, co mají? Facebook poskytuje jednoduchý ladící nástroj - vložíte url a ihned vidíte to, co facebook robot. Adresa ladícího nástroje je: <a href="http://developers.facebook.com/tools/debug">http://developers.facebook.com/tools/debug</a></p>
<p>Pokud Vás zajímá, jak si stojí mockrát zmíněná stránka lupy - prohlédněte si její <a href="http://developers.facebook.com/tools/debug/og/object?q=http%3A%2F%2Fwww.lupa.cz%2Fclanky%2Fzakladni-registry-zatim-skoro-nikdo-nepouziva-a-ministerstvo-o-chybach-mlci%2F">kompletní report</a>.</p>
<p> <img src="http://www.tomas-dvorak.cz/images/122t.png" alt="" width="300" height="400" /></p>
<h2>Poděkování</h2>
<p>Poděkování patří <a href="http://www.lupa.cz/">lupě</a> za vzorné zpracování metadat u svých článků. Sám nemám na svých webech informace tak dopodrobna zpracované, proto jsem v příkladech využil článek <a href="http://www.lupa.cz/">lupy</a>.</p>
<p> </p>
