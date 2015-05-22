---
layout: post
title: Poznámky ze školení SEO pro webmastery od h1
date: '2013-03-27 08:35:42'
tags:
- SEO
- školení
- h1
- webdesign
---
Před pár dny jsem se účastnil SEO školení v h1. Chtěl jsem si ověřit, že to, co znám, je správně a neutíká mi nic podstatného. Jste si jisti, že máte technologickou stránku webu zcela v pořádku?

<h2>On page faktory</h2>
<p>Váš web je to jediné, co máte plně pod kontrolou. Neovlivníte zcela, kdo a jak na vás odkazuje. Jak si o vás lidé povídají na sociálních sítích. Ale můžete co nejvíce usnadnit indexování vlastního webu, upravit navigaci, nadpisy, metaznačky. Odstranit duplicity, doplnit sitemapu. On page faktory prý dělají jen 15% z hodnocení webu, ale jsou jedinou věcí, kterou můžete ze 100% ovlivnit. Udělejte tak maximum pro optimální nastavení svého webu.</p>
<h2>Duplicity</h2>
<p>Duplicitní stránky jsou zlo, které se nám často nevědomky děje na našem webu. V ideálním případě by neměly být indexovány žádné dvě stránky, které mají stejný obsah. Taková duplicitní stránka vznikne třeba tím, že stejný výpis seřadíte podle jiného kritéria. Nebo neošetříte stránkování s hodnotou 1. Na mém webu existují minimálně tři ty samé stránky s různým URL:</p>
<ul>
<li>Úvodka - <a href="http://www.tomas-dvorak.cz/">http://www.tomas-dvorak.cz/</a></li>
<li>Výpis všech článků - <a href="http://www.tomas-dvorak.cz/clanky">http://www.tomas-dvorak.cz/clanky</a></li>
<li>Stránkování s hodnotou 1 - <a href="http://www.tomas-dvorak.cz/clanky?pg=1">http://www.tomas-dvorak.cz/clanky?pg=1</a></li>
</ul>
<p>Takové stránky by měly být přesměrovány na jednu jedinou variantu. Ideálně pomocí <a href="http://cs.wikipedia.org/wiki/Stavov%C3%A9_k%C3%B3dy_HTTP">HTTP stavového kódu</a> 301 (přesunuto trvale). </p>
<p>Další chybu jsem odhalil, když jsem si procházel můj web přes operátor <a href="https://www.google.cz/search?q=site%3Atomas-dvorak.cz">'site:tomas-dvorak.cz'</a> ve vyhledávání googlu. Robot googlu si naindexoval zhruba 10000 totožných stránek. Měnil parametr pro stránkování a stále zvyšoval jeho hodnotu. Tento web má celkem 12 stránek. To znamená, že tisíce url obsahovaly ten samý prázdný výpis. Vracely ale HTTP kód 200 (vše v pořádku) a pro robota tedy nebyl důvod myslet si, že je něco špatně.</p>
<p>Nespoléhejte na to, že google bude procházet jen adresy, na které vede nějaký odkaz. Podle toho, co jsem viděl, si hodnoty parametrů upravuje a zkouší je měnit. Projděte si seznam stránek, které u vás google naindexoval a ověřte, že nekouká, kam nemá. </p>
<p>Vodítkem také může být stav indexu z <a href="http://www.google.com/webmasters/tools/?hl=cs">webmaster tools</a>. Pokud začne najednou index nevysvětlitelně bobtnat, je třeba hledat příčinu. Web který obsahuje necelých 200 článků by neměl mít naindexováno 11 000 stránek.</p>
<p><img src="/images/282.png" alt="Nástroje pro webmastery - stav indexu" width="400" height="260" /></p>
<p> </p>
<h2>Seznam vs. Google</h2>
<p>V našem malém rybníku na poli vyhledávání kralují dva vyhledavače. Seznam a Google. Žádný z nich není výrazně dominantní a každý má svou cílovou skupinu.</p>
<p><strong>Seznam</strong> používají méně technicky zdatní uživatelé. Často ti, kteří nechtějí o angličtině ani slyšet a výsledky na doméně .com nebo .org je stejně nezajímají. Typickým uživatelem seznamu jsou starší lidé, maminky na mateřské a podobně. </p>
<p><strong>Google</strong> oproti tomu používají mladší generace, technicky zdatnější uživatelé. Ti, kteří proplouvají sociálními sítěmi, cizí jazyky jim nedělají problém. Nechtějí se omezovat jen na české stránky.</p>
<p>Ke každému z vyhledavačů tak patří jiná demografická skupina a je třeba to mít na paměti. Pokud provozujete eshop s počítačovými díly, pravděpodobně vás víc zajímají uživatele googlu. Můžete tak víc sil zaměřit na metatagy, inzerovat v AdWords a podobně. </p>
<h2>Robots.txt</h2>
<p>Souborem robots.txt umístěném v kořenovém adresáři webu (v mém případě <a href="http://www.tomas-dvorak.cz/robots.txt">http://www.tomas-dvorak.cz/robots.txt</a>) můžeme ovlivnit, jaké stránky budou roboti indexovat a jaké naopak ne. Pozor na to, že tento soubor kontrolují jen slušní roboti. Přesto, že zakážete indexaci určité části stránek, můžou se i nadále vyskytovat ve výsledcích hledání. </p>
<p>Příkladem může být třeba <a href="https://www.google.cz/search?q=site:klaboseni.cz&amp;num=20&amp;hl=cs&amp;safe=off&amp;filter=0&amp;biw=1920&amp;bih=944">výpis stránek webu klaboseni.cz</a>. V <a href="http://www.klaboseni.cz/robots.txt">robots.txt</a> mají zakázáno indexování celého webu a přesto  google zná a vypisuje téměř 200 000 stránek ve výsledcích hledání.</p>
<p><img src="/images/283.png" alt="Klaboseni.cz - procházení zakázáno pomocí robots.txt, přesto jsou ve výsledcích hledání" width="400" height="231" /></p>
<p>Proč je tomu tak, je vysvětleno v <a href="https://support.google.com/webmasters/bin/answer.py?hl=cs&amp;answer=156449">nápovědě pro webmastery</a>. Ve zkratce - na stránky je odkazováno odjinud a proto jsou zaindexovány.</p>
<h2>Rychlost načítání webu</h2>
<p>Rychlost odezvy webu je jedno z hodnotících kritérií webu. Ve firmě h1 prý dodržují zásadu, že by se měla stránka načíst do 4 sekund. Mě to přijde poněkud hodně, i když záleží, co se měří. Pokud jsou to 4s se vším všudy, včetně designu, obrázků, videí a scriptů, pak je to celkem pěkný čas. </p>
<p>Představu, jak rychle se načítá stránka, můžete získat třeba ve webmaster tools. Tam se ukazuje nejspíš jen čas načtení samotné HTML stránky (bez grafiky, scriptů a pod) tak, jak to trvá google botovi.</p>
<p><img src="/images/284.png" alt="Čas načtení stránky tomas-dvorak.cz ve webmaster tools" width="400" height="158" /> </p>
<p>Detailní představu o tom, co a jak dlouho se na vašem webu načítá, může poskytnout třeba nástroj <a href="http://tools.pingdom.com/">Pingdom Tools</a>. Měří nejen stránku, ale i všechny její součásti. Umí do detailu rozepsat jednotlivé požadavky na server, zjistit, kde jsou problémy. Pingdom tools dovedou otestovat i cachování, poradit, jak vylepšit výkon.</p>
<p><img src="/images/285.png" alt="Pingdom tools - výkon webu" width="400" height="144" /></p>
<p>Obdobnou službu provozuje google pod názvem <a href="https://developers.google.com/speed/pagespeed/insights">PageSpeed Insights</a>. Informace jsou velmi detailní včetně návodů, jak problémy řešit. V mém případě jsem zjistil, že se musím více zaměřit na cachování v prohlížeči a mohu optimalizovat (bezztrátová komprese) některé obrázky. Služba navíc umí zobrazit i doporučení pro mobilní/responzivní verzi webu, kde jsou požadavky a problémy mírně odlišné.</p>
<p> <img src="/images/287.png" alt="PageSpeed Insights — Google Developers.png" width="400" height="242" /></p>
<p>Obdobná data, jako pingdom, můžete získat i pomocí vývojářských rozšíření v prohížečích. Ve firefoxu jde o <a href="http://getfirebug.com/">Firebug</a>, v <a href="https://developers.google.com/chrome-developer-tools/?hl=cs">Chrome developer tools</a>. </p>
<p>Před pár dny jsem narazil na pěkný seznam doporučení a optimalizačních technik pro web - <a href="http://browserdiet.com/">browserdiet.com</a>. </p>
<h2>Všechny stránky webu</h2>
<p>Čas od času je dobré podívat se, jaké stránky a s jakými daty vidí roboti vyhledavačů. Nejjednoduší cesta je již zmíněný operátor <em>site:nazev_domeny.tld<strong> </strong></em>﻿- u mě tedy <em>site:tomas-dvorak.cz</em>﻿. Tento operátor funguje jak pro seznam, tak pro google. Můžete tak zjistit počet stran, obsah titulků a popisků, tvar URL. U google pak můžeme ověřit i metadata stránky. </p>
<p>Důkladnější analýza vyžaduje detailnější informace o maximu stránek na webu. <a href="http://home.snafu.de/tilman/xenulink.html">Xenu</a> je program pro průchod celým webem. Začne na domovské stránce a sleduje všechny odkazy z ní. Totéž provádí pro stránky odkazované z úvodky a tak pořád dokola, dokud existují další stránky. Sleduje titulek, popis stránky, dobu stažení, počet odkazů na stránku a ze stránky, HTTP stavový kód a mnoho dalších informací. Také ukazuje odkazy na neexistující stránky. Získáte tak kompletní obraz vašeho webu se všemi podstatnými daty pro analýzu.</p>
<p>Data z Xenu jsou exportovatelná do CSV, můžeme je tedy třídit a filtrovat v Excelu nebo Calcu z Open Office. </p>
<p>Xenu je napsán pro Windows (.exe). Bez problémů běží pod emulatorem Wine na Linuxech, a měl by fungovat i pod emulátorem na Macu.</p>
<p><img src="/images/286.png" alt="Xenu - průchod webem a analýza dat" width="400" height="314" /></p>
<h2>Jazykové mutace webu</h2>
<p>Pokud  vytváříte novou jazykovou verzi webu, je v zásadě několik typických možností, na jakou adresu ji posadit. Kdybych vytvářel německou verzi tohoto webu, rozhodoval bych se mezi</p>
<ul>
<li>tomas-dvorak.de</li>
<li>de.tomas-dvorak.cz</li>
<li>tomas-dvorak.cz/de</li>
</ul>
<p>Všechny dávají smysl a jsou běžně používané pro takové účely. Ale jen tomas-dvorak.cz/de využije to, co původní doména tomas-dvorak.cz buduje už roky. Zpětné odkazy, ranky, síla mateřské domény dovede jazykovou mutaci popohnat kupředu.</p>
<p> </p>
<h2>SEO texty</h2>
<p>Byl jsem zvědav, zda se školení dotkne i často zmiňovaných a dle mého nesmyslných optimalizací webu ku prospěchu SEO. Napadají mě třeba tyto záležitosti kolem klíčových slov:</p>
<ul>
<li>Co nejvíc klíčových slov v URL</li>
<li>Důsledná struktura nadpisů od h1 do h6, vždy naplněna těmi správnými výrazy pro vyhledavače</li>
<li>Ideální husota klíčového slova ve stránce</li>
</ul>
<p>A lektor potvrzoval, v co jsem doufal. Dělejme stránky pro lidi a ne pro vyhledavače. URL ať je hezká a jednoduchá na zapamatování, nikoliv SEO optimalizovaná. Nadpisy používejte tak, aby vyznačovaly logický tok textu. A běda vám, pokud text prošpikujete klíčovými slovy tak, že se nedá vůbec číst. Doporučuji pěkný <a href="http://www.lukaspitra.cz/ach-ty-seo-texty/">článek o SEO textech</a>.</p>
<h2>Strukturovaná data</h2>
<p>Strukturovaná data, mikroformáty, rich snippets. Způsob, jak trochu vylepšit výpis svého webu na vyhledávací stránce googlu, pomoct robotovi pochopit, co na stránce vidí. Mikroformáty u nás používají třeba online kuchařky. Výpis výsledků hledání pak může vypadat třeba takhle:</p>
<p><img src="/images/288.png" alt="Mikrodata v podobě receptu" width="400" height="182" /></p>
<p>Google podporuje strukturované úryvky pro tyto typy dat: recenze, lidé, produkty, firmy a organizace, recepty, události, hudba. Bližší popis je dostupný v <a href="https://support.google.com/webmasters/bin/answer.py?hl=cs&amp;answer=99170">nápovědě pro webmastery</a>, testovat můžete v <a href="http://www.google.com/webmasters/tools/richsnippets">nástroji na testování strukturovaných dat</a>. </p>
<p>Pro svůj web jsem nedávno implementoval <a href="http://www.google.com/insidesearch/features/authorship/index.html">Google Authorship</a>. Jde o propojení profilu na Google plus s mým blogem. Cílem je, aby se u nalezených stránek z mého webu zobrazila fotka, jméno autora a odkaz na profil, případně další články. Takhle pak vypadá záznam v hledání:</p>
<p><img src="/images/289.png" alt="Google authorship" width="400" height="86" /></p>
<p>Pokud budete implementovat některé mikroformáty, vždy myslete na to, že to děláte pro lidi. Jde o to nalákat člověka ke kliknutí na odkaz v hledání, nejde o optimalizaci pro vyhledače.</p>
<h2>Ke školení a lektorovi</h2>
<p>Na školení jsem jel především proto, abych si ověřil, že mi neuniká nic důležitého. Že nedělám nějakou zásadní chybu a neradím lidem nesmysly. </p>
<p>To se mi v zásadě potvrdilo. Lektor <a href="http://www.h1.cz/o-nas/nas-tym/lektori/pavel-ungr/">Pavel Ungr</a> měl k optimalizacím postoj, který mě mile překvapil. Dělat věci jednoduše, kvalitně a hlavně pro uživatele a ne pro roboty. V tom duchu se neslo celé školení. Dělat web srozumitelný, snadno průchozí a logicky strukturovaný. Žádná magie a šamanské tipy. Na můj vkus by mohlo být školení víc technické a nezabývat se úplnými základy. Přece jen, co je robots.txt a sitemapa vím už řadu let. </p>
<p>Pokud s webdesignem začínáte a pojmy z mého článku vám moc neříkají, školení si nenechte ujít. Jestli jste ale ostřílený webař a znáte vše, o čem jsem se tu zmínil, školení vám pravděpodobně nepřinese nové zásadní znalosti. Můžete si ale udělat celkový obraz o oblasti, zeptat se na své problémy a ověřit si, že vám neuteklo něco podstatného.</p>
<p>Tip na závěr: sledujte <a href="https://twitter.com/necodymiconer">twitter účet Pavla Ungra</a>, denně publikuje tipy, odkazy na články a nástroje z oblasti SEO a webů. </p>
<p>Díky za fajn školení.</p>
