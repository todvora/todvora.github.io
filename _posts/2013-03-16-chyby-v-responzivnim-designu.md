---
layout: post
title: Chyby v responzivním designu
date: '2013-03-23 21:41:08'
tags:
- responzivní design
- mobile
- emulátor
---
Responsivní design je hit poslední doby. Denně se ale setkávám se stránkami, které sice jsou responzivní, ale nevhodným zásahem celý efekt rozbijí a stránka pak na mobilu vypadá špatně. Několik častých chyb jsem nasnímal, popsal a doporučil řešení.

<h2>Facebookový bloček</h2>
<p>Facebook nesmí chybět na žádné stránce, která je moderní a sociální. Často však do hezké responzivní šablony někdo bloček zasadí tak nevhodně, že celou responzivnost zničí. Několik ukázek takového problému jsem našel například na webech <a href="http://kinohled.cz/">kinohled.cz</a> nebo <a href="http://blog.mefistofeles.cz/">blog.mefistofeles.cz</a>. U kinohledu končí běžná stránka tam, kde je v polovině obrázku vidět změna pozadí. Bloček je ale nastaven tak nešikovně, že stránku rozšíří na dvojnásobek. U <a href="http://blog.mefistofeles.cz/">blog.mefistofeles.cz</a> se sice vejde do stránky, ale vytéká z designu.</p>
<p><img src="/images/274.png" alt="Kinohled - přetékající FB bloček" width="250" height="417" /> <img src="/images/275.png" alt="Blog.mefistofeles.cz - přetékající facebookový bloček" width="250" height="417" /></p>
<p> </p>
<p>Ve zdrojovém kódu kinohledu vidím například bloček vložený takovýmto zápisem:</p>
<pre class="prettyprint"><iframe id="facebook" src="//www.facebook.com/plugins/likebox.php?href=https%3A%2F%2Fwww.facebook.com%2Fkinohled&amp;<strong>width=600</strong>&amp;height=258&amp;show_faces=true&amp;colorscheme=dark&amp;stream=false&amp;border_color=%232C2C36&amp;header=false&amp;appId=408953665859714" scrolling="no" frameborder="0" style="border:none; overflow:hidden; <strong>width:600px;</strong> height:258px;" allowtransparency="true"></iframe></pre>
<p class="prettyprint">Řešením je donutit facebookový bloček, aby nebyla šířka nastavena fixně. Záleží vždy na konkrétním případu a implementaci, ale začal bych CSS pravidly jako:</p>
<pre class="prettyprint">max-width: 100% !important;</pre>
<p class="prettyprint">Pak je nutné zkoušet a zkoušet. Několik nástrojů, které práci usnadní vyjmenovávám na konci článku v odstavci <em>Nástroje, které vám pomohou</em>.</p>
<h2>Minimální šířka prvků</h2>
<p>Vždy, když přidáte na web nový prvek, je dobré zkontrolovat, jak že to vypadá na mobilu. <a href="http://www.zdrojak.cz/">Zdroják</a>, postavený na wordpressu, má v horní části stránky vloženu admin lištu.</p>
<pre class="prettyprint"><div id="wpadminbar" class="" role="navigation">...vynecháno...</div></pre>
<p class="prettyprint"><img src="/images/276.png" alt="Zdroják.cz - lišta v hlavičce rozhodí responsivní design" width="250" height="417" /></p>
<p class="prettyprint">Klasický design končí na zlomu pozadí, lišta však vynutí širkokou stránku bez ohledu na váš display. Chyba je v tom, že pomocí CSS této liště nastavují minimální šířku na 600px. Taková lišta se na menší telefony v portrét modu nemuže vejít. Ve stylech je uveden zápis:</p>
<pre class="prettyprint">#wpadminbar {width: 100%; <strong>min-width: 600px;</strong> }</pre>
<h2>Obsah až pod přehybem</h2>
<p>Kdysi, v době menších monitorů, se řešilo, aby se obsah webu vešel co nejlépe nad přehyb (fold) monitoru. Tedy aby byl obsah vidět bez nutnosti scrollování. Teď nastává ten samý problém u mobilů. Bylo by fajn, aby alespoň nadpis a část textu byla viditelná hned, bez scrollování. Zdroják to má tak na doraz, <a href="http://www.itefektivne.cz/">itefektivně.cz</a> má nadpis na mém telefonu (800x480px) až pod přehybem. Oba snímky jsou z detailu článku.</p>
<p><img src="/images/277.png" alt="Zdroják - text začíná až pod přehybem" width="250" height="417" /> <img src="/images/278.png" alt="itefektivne - text začíná až za přehybem" width="250" height="417" /></p>
<p>Pokud chcete otestovat, kolik se toho vejde na display bez scrollování, můžete použít třeba <a href="http://browsersize.googlelabs.com/">tento nástroj z googlelabs</a>. Změnou velikosti okna můžete simulovat mobilní rozlišení. Obsah nad přehybem by snad měl být také <a href="http://seo-sem.robertnemec.com/google-obsah-fold/">lépe hodnocen pro vyhledávání</a>.</p>
<p>Je na zvážení každého designera, co vše by mělo v hlavičce na mobilním zobrazení být, a jestli je to tam opravdu nutné. U zdrojáku je velké pole pro hledání, které jsem nikdy nepoužil. Překáží mi ale při čtení každého článku.</p>
<h2>Příliš velký padding stránky</h2>
<p>Pro responsivní weby používá mnoho vývojářů framework Bootstrap. Ten má v základním nastavení na můj vkus zbytečně velké odsazení obsahu a na menších displayích to vypadá, že na obsah už skoro žádné místo nezbývá. První ukázka pochází z <a href="http://blog.mefistofeles.cz/">blog.mefistofeles.cz</a> a sejmuta byla telefonem Sony Xperia Tipo (display 320x480px). Padding stránky je nastaven zleva i zprava na 25px, dalších 20px zleva i zprava vezme padding samotného obsahu. Při poměrně běžném rozlišení 320x480px tedy padding ukousne celých 28% šířky displaye. Řešením by bylo buď jej snížit na mnohem nižší čísla nebo nastavovat relativně k šířce displaye. Druhá ukázka je z mého webu, kdy jsem stejné výchozí hodnoty snížil na 10px z každé strany padding textu a 5px padding stránky. Celkem tedy jen 1/3 původních hodnot. Zároveň jsem zmenšil velikost nadpisu, aby nevycházelo jedno slovo na řádek. Dává to tak víc prostoru samotnému textu.</p>
<p><img src="/images/279.png" alt="Příliš velký padding stránky" width="250" height="375" /> <img src="/images/280.png" alt="ukázka paddingu" width="250" height="375" /></p>
<h2>Zbytečně moc dat a scriptů</h2>
<p>Pokud máte pod každým článkem umístěno několik sociálních tlačítek (facebook, twitter, g+, linkedIn) a pro každé používáte doporučovaný způsob vložení, nutíte tak prohlížeč stahovat mnoho dat navíc. Pro zmíněná čtyři tlačítka to může být 400KB dat a 22 requestů. Pokud vám to také přijde hodně, přečtěte si můj článek <a href="/posts/jak-delat-tlacitka-pro-socialni-site-lepe">Jak dělat tlačítka pro sociální sítě lépe</a>. Jde to i bez externích zdrojů a hromady dat navíc.</p>
<h2>Nástroje, které vám pomohou</h2>
<p><strong>Window resizery</strong> jsou rozšíření do prohlížeče, která umožní změnit velikost okna a tím simulovat menší display.</p>
<ul>
<li><a href="https://chrome.google.com/webstore/detail/window-resizer/kkelicaakdanhinjdeammmilcgefonfh/related">Chrome plugin</a></li>
<li><a href="https://addons.mozilla.org/cs/firefox/addon/firesizer/">Firefox plugin</a></li>
</ul>
<p> </p>
<p><strong>Emulátory mobilních prohlížečů </strong>﻿vám umožní zobrazit si stránku tak, jak by vypadala na mobilu. Opera mini je dostupná jako java applet ve webové stránce, opera mobile se instaluje do počítače a dovoluje spouštět prohlížeč v konfiguraci jednoho z mnoha běžných telefonů. Při startu aplikace si vybíráte, jaký telefon emulovat.</p>
<ul>
<li><a href="http://www.opera.com/developer/opera-mini-simulator">Opera mini simulator</a></li>
<li><a href="http://www.opera.com/developer/mobile-emulator">Opera mobile emulator</a></li>
</ul>
<div><img src="/images/281.png" alt="Opera mini - online verze mobilního prohlížeče" width="250" height="372" /></div>

<p><strong>Vývojářské nástroje</strong>, jako jsou <a href="http://getfirebug.com/">firebug ve firefoxu</a>, <a href="http://www.opera.com/dragonfly/">dragonfly v opeře</a> nebo <a href="https://developers.google.com/chrome-developer-tools/?hl=cs">developer tools v chrome</a>, pomohou odhalit, kde se bere padding a margin, jak je který prvek zarovnán. Zároveň umožňují ihned hodnoty měnit a testovat. Nemusíte tak dokola upravovat soubor se styly a přenačítat stránku. Vždy je ale lepší otestovat web na reálných zařízeních. Zjistíte tak, jak se stránka používá, jak reaguje na dotek a posun.</p>
<h2>Závěrem</h2>
