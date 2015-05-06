---
layout: post
title: Požadavky při vývoji malých webů a aplikací
date: '2012-10-12 20:09:29'
tags:
- KISS
- vývoj webu
- framework
- PHP
- git
- hosting
- java
- javascript
- nosql
- software
---
Co by měl chtít zadavatel po tvůrci jednoduchého webu nebo webové aplikace? Programátoři často trvají na virtuálních serverech, jazycích o kterých jste nikdy neslyšeli a různých složitostech. Když někdo chce jednoduchou věc, nenuťte mu k webu i správu serverů, framework co jste si sami napsali a databázi, kterou nikdo nezná. Dělejte jednoduché věci jednoduše.

<p>Přestavte si, že máte nápad na web. Jednoduchou mapovou aplikaci, databázi čehosi, katalog. Nechcete nic okázalého ani komplikovaného. Nemá smysl v začátcích začít budouvat infrastrukturu pro desítky tisíc návštěvníků denně, když nevíte, jestli se to ujme. A potřebujete najít člověka, který web naprogramuje, rozpohybuje. Pokusil jsem se formulovat několik myšlenek, které bych předal onomu programátorovi dřív, než dojde na jakoukoliv práci.</p>
<h1>Prostředí</h1>
<p>Na malé věci by měl by stačit běžný hosting. Nevidím důvod řešit si vlastní virtuální stroj a natlačit se tak do správy serveru, dokud to není nezbytně nutné. Navíc je to úspora nákladů, zvlášť když už nějaký multihosting je použit pro další projekty. Výhodou je outsourcing updatu, zálohování, mailserveru, databáze. To jsou rozhodně věci, které bych nechtěl řešit a nechal na hostingu samotném. </p>
<h1>Hotový software - opensource</h1>
<p>Jde použít něco, co už napsali jiní a dali k dispozici(zdarma)? Výborně, nepotřebujete vlastně ani programátora, spíš člověka co to dovede nainstalovat, nakonfigurovat, nalámat do šablony grafiku. Podívejte se, jestli vaše požadavky na web nedokáže splnit třeba <a href="http://cs.wordpress.org/">WordPress</a>, <a href="http://www.opencart.com/">OpenCart</a>, <a href="http://www.mediawiki.org/wiki/MediaWiki">MediaWiki</a> nebo jiný opensource. Základní funkcionalitu dovedete rozšířit tisíci pluginy a připadně si necháte napsat plugin na míru. O update zbytku softwaru se za vás postarají jiní.</p>
<h1 dir="ltr">Jazyk</h1>
<p>Pokud si nevystačíte s hotovým opensource, nezbývá než se pustit do programování. Programovací jazyk by měl být <a href="http://www.php.net/">PHP</a>. Není sice nejproduktivnější, ale vývoj je levnější, běží to všude, není náročný na zdroje a existuje bezpočet různých knihoven a doplňků. Vývojář v PHP vás vyjde levněji, snáz jej nahradíte a pokud máte aspoň nějaké základy programování, pak snad i dovedete sledovat, co že to programuje a jak.</p>
<p>PHP už ale nějakou dobu není cool. A proto se vás budou snažit vývojáři přesvědčit, že Ruby, Python nebo Java je ten správný jazyk. Vy ale chcete jednouchou webovou stránku, na to bylo PHP stvořeno. Nekomplikujte si život do budoucna.Schválně se podívejte na jobsy, kolik je <a href="http://www.jobs.cz/search/?section=positions&srch%5Bq%5D=PHP">nabídek pro PHP vývojáře</a> a kolik pro <a href="http://www.jobs.cz/search/?section=positions&srch%5Bq%5D=Ruby">Ruby</a>. Koho myslíte, že seženete pro pozdější úpravy snázeji? Reči o tom, jak je PHP nevýkonné a nedostatečné neberte v potaz. Na PHP běží wikipedie, facebook, yahoo, flickr, digg a pod. Zdá se, že s drobnými úpravami dovede utáhnout zátěž zhruba miliardy uživatelů. Myslíte, že to bude stačit? </p>
<h1 dir="ltr">Framework</h1>
<p>Ideálně aplikaci postavit nad běžným frameworkem pro PHP. <a href="http://nette.org/cs/">Nette</a> je takovým českým standardem a rozumnou volbou. Ale žádný z PHP frameworků vyjmenovaných <a href="http://cs.wikipedia.org/wiki/Framework">zde</a> není krok mimo. Pokud bude mít programátor zkušenosti s jiným, není problém. Nenechte si vnutit nějaký systém, co si vývojář napsal sám na koleni. Nenajdete nikoho, kdo to po něm převezme a dovede udržovat a rozvíjet. Nebo vás to vyjde pekelně draze. Frameworky programátora svazují a nutí mu nějaké konvence, standardy. Jedině dobře pro vás.</p>
<h1 dir="ltr">Databáze</h1>
<p>Doporučuji <a href="http://www.mysql.com/">MySQL</a>. Není to žádný hit, ale opět je na každém hostingu, není záludná, všude je k ní webové rohraní + importy/exporty a zálohování. Dat nebude snad ze začátku tolik, aby bylo třeba řešit výkon. Cool jsou <a href="http://en.wikipedia.org/wiki/Nosql">NoSQL</a> databáze. Ale jen v případě, že přesně víte proč a jak je použít. Jinak se pouštíte do neprobádaných (a často záludných) vod.</p>
<h1 dir="ltr">JavaScript</h1>
<p>Jako JavaScriptový framework bych určitě volil <a href="http://jquery.com/">jQuery</a>. Je to v podstatě standard posledních let. Mraky rozšíření, pluginy pro UI, testovaný na masách uživatelů. Natahnout ho z <a href="https://developers.google.com/speed/libraries/devguide#jquery">Googlí CDN</a> ať nevytěžuje vlastní hosting. Umí s ním každej webař, práce je jednoduchá a pochopitelná.</p>
<h1 dir="ltr">Verzování</h1>
<p>Bezpodmínečně nutné je veškeré změny kódu průběžně zaznamenávat v nějakém verzovacím nástroji dostupném online. Pro kontrolu, pro možnost vrátit se k předchozí funkční verzi, sledování historie. Nejspíš by nemusel být kód vidět bez přihlášení, aby nebylo možné zkopírovat celý projekt na pár kliknutí. Sám využívám free <a href="http://www.projectlocker.com/">http://www.projectlocker.com/</a> a SVN. Pokud existuje lepší varianta, není problém. Jestli verzovat v <a href="http://cs.wikipedia.org/wiki/Git">GITu</a>, <a href="http://cs.wikipedia.org/wiki/Apache_Subversion">SVN</a> nebo <a href="http://en.wikipedia.org/wiki/Mercurial">Hg</a> je skoro, pořadí zde ovlivňuje moje preference. Pokud nemáte problém s tím, že vaše zdrojáky bude moct číst kdokoliv, zvolte <a href="https://github.com/">github</a>, <a href="http://code.google.com/intl/cs/">google code</a> nebo <a href="https://bitbucket.org/">bitbucket</a>. </p>
<h1 dir="ltr">Deploy</h1>
<p>Na hostingu nebude asi možný řešit deploy vytažením změn z verzování(není to běžné ale hostingy to postupně začínají nabízet). Nevadí, stačí nějakej FTP upload. Změny a vývoj nejspíš může probíhat naživo venku, stejně na to z kraje nikdo cizí nepoleze. Případně omezit přístup na sadu IP adres a ostatním vracet nějakou “Zde pro vás připravujeme...” statickou stránku. Nepůjde debug PHP, ale na to jsou PHP vývojáři zvyklí a <em>echo</em> s <em>var_dump</em> jim stačí :-) Není to super, ale vy chcete jednoduché a rychlé řešení. Ne bezproblémový deploy pro stránku, kam nikdo z kraje nezabloudí.</p>
<h1>KISS</h1>
<p>KISS je zkratka ze slov Keep It Simple, Stupid. Jedná se o jednoduchý návrhový vzor, kdy se tvůrce snaží věc držet maximálně jednoduchou a minimaistickou. Taková věc je pak snadno dlouhodobě udržitelná. Detailní popis KISS si přečtete třeba na <a href="http://cs.wikipedia.org/wiki/KISS">Wikipedii</a>. Není KISS přesně to, co hledáte?</p>
<h1>Závěrem</h1>
<p>Tuším, že každý vývojář mě s takovýma radama bude hnát k čertu. Ale jde o to předem stanovit nějaké rozumné meze programátorovi, který to bude implementovat. A pokud chcete jednouchou věc, nenechte si ji hned z kraje zkomplikovat a prodražit. <strong>Programátoři mají rádi komplikovaná, složitá a náročná řešení.</strong> Tedy přesný opak toho, co hledá každý zadavatel projektu. To říkám jako vývojář, co má rád javu, složitý deploy, virtualizované servery, nerelační databáze a všechny novinky z IT. </p>
<p>Žádná z rad pro vás nemusí vůbec platit, pokud víte co děláte. Software není neměnný, v budoucnu bude možné svá rozhodnutí změnit. Vybrat jinou databázi, dokonce celou věc přepsat do jiného jazyka, když to bude nutné. Neházejte si ale klacky pod nohy hned z kraje, když to není třeba.</p>
<p><strong>Máte opačné zkušenosti? Podělte se prosím v komentářích. Rád se přiučím a svůj názor(i tenhle článek) klidně změním.</strong></p>
