---
layout: post
title: Děravá iŽabka
date: '2013-05-16 21:38:58'
tags:
- sql injection
- bezpečnost
---
Tak ukázkové SQL injection, jako je na webu iŽabka, už jsem dlouho neviděl. A co hůř, ani po týdnu od hlášení chyby emailem není opraveno nic. Nezbývá, než věc zveřejnit, ukázat si, co dělají špatně a trochu se z toho poučit.

<p><em>Ahoj, já jsem Tomáš a mám takovou úchylku. Pokaždé, když vidím na webu vyhledávací políčko, zadávám do něj divné věci. Většinou stačí málo. Uvozovky, apostrof nebo dvojkombinace ">. A podle toho, co na mě vypadne, si o vás často myslím něco ošklivého.</em></p>
<p><em>Nejsem ale takovej zmetek a dám vám o chybě vědět. Na twitteru, na emailu, kde zrovna jste. Většinou reagujete pěkně, poděkujete a chybu rychle opravíte. Občas hrajete mrtvého brouka, neodpovíte, nic neopravíte. A mě pak nezbývá, než chybu zveřejnit, udělat vám ostudu a pobavit odbornou veřejnost.</em></p>
<p>A proto se dnes pojďme zasmát na účet webu iŽabka.cz. <a href="/images/303.png">Je to týden, co jsem je upozorňoval na SQL injection</a> a žádná reakce, ani oprava. Ukážu vám, co udělali špatně a čemu se máte vyvarovat, pokud nemám příště psát o vašem webu.</p>
<p>Na stránce <a href="http://www.izabka.cz/">http://www.izabka.cz</a> najdeme vyhledávací pole, do něj vepíšeme několik znaků, přidáme apostrof a stiskneme ENTER. </p>
<p>Výsledek bude vypadat zhruba takhle: <a href="http://www.izabka.cz/cs/component/search/?searchword=whisky%20grant's&ordering=newest&searchphrase=exact">http://www.izabka.cz/cs/component/search/?searchword=whisky%20grant's&ordering=newest&searchphrase=exact</a></p>
<p><img src="/images/302.png" alt="iŽabka SQL injection" width="522" height="250" /></p>
<p> </p>
<p>Na co to koukáme? Tím apostrofem jsme rozbili syntaxi SQL dotazu. Část, která vyhledává přítomnost fráze v textu - LIKE, jsme naším apostrofem ukončili tak, že je celý dotaz neplatný. To je neklamná známka toho, že se vhodnou formulací vyhledávací fráze dá dotaz upravit vlastním představám.</p>
<p>Celou věc maximálně zjednodušuje ten chybový výpis s kompletním SQL dotazem. Nemusíte odhadovat, co že se to stalo a jak zhruba skládají dotaz do databáze. Máte to tu vypsané černé na bílém. </p>
<p><strong>Tady následuje právní vsuvka.</strong> Pokud vás teď napadlo, že by bylo fajn formulovat vyhledávací dotaz tak, aby začal vracet úplně jiná, nečekaná data, nezapomeňte, v trestním zákoníku existuje<a href="http://business.center.cz/business/pravo/zakony/trestni-zakonik/cast2h5.aspx#par230"> <strong>Zákon č. 40/2009 Sb., § 230, Neoprávněný přístup k počítačovému systému a nosiči informací</strong></a>.</p>
<p>Když začnete skládat dotazy a dolovat data z databáze iŽabky, s velkou pravděpodobností jednáte protiprávně. Proto vám nebudu ukazovat, jak by se dalo postupovat. Nerad bych ten zákon porušil. Já pouze hledal, zda něco nepíšou o mé oblíbené whisky ;)</p>
<p>Chtěl bych ale naznačit, co by případný útočník mohl získat a proč se ti zlí hackeři o takové útoky pokouší. Firmu pak může úspěšný útok stát nemalé peníze.</p>
<ul>
<li>Je možné editovat text stránek. Někdo by mohl na naší úvodní stránce napsat, že jste zbankrotovali. Nebo změnili typ obchodu na sexshop. Co to udělá s vašimi zákazníky?</li>
<li>Pokud jsou v databázi uloženy uživatelské účty, nejspíš se povede získat login a heslo některého uživatele. </li>
<li>Na stránkách je funkce "<a href="http://www.izabka.cz/cs/akcni-letak-emailem">akční leták emailem</a>". To znamená, že jsou nejspíš v databázi uloženy údaje zákazníků, kteří mají o leták zájem. Potrava pro spammery, konkurenci. Pokud se taková databáze dostane ven, bude mít provozovatel webu na krku ÚOOÚ a pře o to, zda dostatečně chrání údaje svých zákazníků. Nechrání.</li>
<li>Je možné na stránky podstrčit libovolný vlastní kód, třeba přesměrování na svou síť provozoven.</li>
<li>A mnoho dalšího. Cokoliv si dovedete představit, že na webu lze udělat. Útočník může získat plný přístup ke všemu.</li>
</ul>
<p> </p>
<h3>Zopakujme si tedy, jak to dělat dobře, ať se podobným průserům vyvarujete:</h3>
<ul>
<li>Nechť vaši programátoři píšou bezpečný kód. SQL injection je známá, snadno odhalitelná chyba, o které se mluví už celou věčnost. Zeptejte se, co o SQL injection ví a jak se jí brání.</li>
<li>Testujte, zda web nevrací, co nemá. Jak jsem psal v úvodu, stačí několik jednoduchých znaků na úvodní otestování a odhalení největších problémů. Uvozovka, apostrof a podobně.</li>
<li>Koukejte do Google Analytics. Všímejte si, jaké dotazy lidi pokládají. Když odhalíte divné dotazy, ozkoušejte, co dělají. Máte je zaznamenány, neignorujte tu informaci.</li>
<li>Monitorujte nějak zmínky na internetu. Podobnou informaci někdo často někde utrousí a vy o ní vůbec nevíte. Pro začátek stačí třeba Google Alerts a monitorovat název domény. Jak na to jsem psal už dříve, v článku <a href="/posts/monitoring-medii-na-vlastni-pest-google-alerts">Monitoring médií na vlastní pěst - Google Alerts</a>.</li>
<li>Zeptejte se tvůrce webu, zda je na produkčním webu vypnutý výpis chyb. Neprozrazujte, co není nutné. Stačí napsat, že nastala chyba.</li>
<li>Když už vám někdo pošle zprávu o tom, že máte na webu zranitelnost, poděkujte a opravte tu chybu. Posílá vám to proto, že chce poradit. Kdyby chtěl škodit, proč by vám o tom dával vědět?</li>
<li>Nakonec, pokud ignorujete všechno zmíněné, nedivte se.</li>
</ul>
<p>Nepodceňujte bezpečnost webů. Stránky umí naprogramovat kdejaký student po pár hodinách učení se. O bezpečnosti ví ale málokdo. Během psaní článku nebyla zraněna žádná žabka ani jiný živý tvor. Utrpí snad jen ego programátorů, co web iŽabka slepili.</p>
