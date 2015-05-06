---
layout: post
title: Otevřená data, ukradená auta
date: '2013-12-06 02:13:30'
tags:
- API
- apiary
- policeapi.cz
---
Jak a proč policie uzavírá a znepřístupňuje svá data, brání se vyhledavačům a proč jsem vytvořil neoficiální API k databázi odcizených vozidel.

<p>Několik let se motám kolem databáze odcizených vozidel. Téměř čtyři roky provozuji web <a href="http://www.odcizena-vozidla.cz" target="_blank">odcizena-vozidla.cz</a>. Do roku 2011 jsem využíval <a href="http://www.odcizena-vozidla.cz/images/policie-screenshoty/xml_api_old.png" target="_blank">dostupné API od Policie ČR</a>. Mohl jsem se dotazovat pro SPZ nebo VIN, mohl jsem si stáhnout denní přehled všech ukradených aut. Na konci roku 2011 se však policie rozhodla, že už žádná data nebude dále poskytovat.</p>
<p>Zrušila exporty, zrušila API a <a href="http://www.policie.cz/clanek/nova-databaze-patrani-po-vozidlech.aspx" target="_blank">s velkou slávou představila</a> <a href="http://aplikace.policie.cz/patrani-vozidla/" target="_blank">vyhledávací formulář</a> na svých stránkách. Jako jedinou možnou cestu, jak data o ukradeném vozidle zjistit. To jsou otevřená data podle policie. Přitom do té doby existující <a href="http://www.odcizena-vozidla.cz/images/policie-screenshoty/xml_api_old.png" target="_blank">API vypadalo velmi slušně a užitečně</a>. </p>
<p>Pátral jsem, proč to. <a href="http://www.odcizena-vozidla.cz/ukonceni-importu-policie" target="_blank">Bylo mi řečeno</a>, že nikdo API ani exporty nepotřebuje, když má aktuální data u nich ve formuláři na stránce. K čemu by mohlo být API zřejmě vůbec neměli tušení. Přebíráním a zveřejňováním dat se prý akorát vystavuji postihům a nemám to dělat.</p>
<p>Samotná policejní data jsou neindexovaná a zcela nepřístupná vyhledavačům (<meta name="robots" content="noindex, follow" />). Neexistuje žádná stránka, odkud by se vyhledavače odrazily, žádný seznam všech, nic než vyhledávací políčko. A za ním stránky s příznakem zákazu indexace. Nikdy tak nenajdete informaci o ukradeném autě na googlu či seznamu. </p>
<h2>Komu tím prospějou?</h2>
<p>Policie si ulehčí práci a přihrajou nějaký peníze i firmám, který za pár stovek vystaví certifikát, že vozidlo s tím a tím VIN není evidováno jako odcizené. Proč při pravidelné technické kontrole a při každé změně majitele zapisují na STK stav tachometru a spoustu údajů o vozidle, když se tato data nedají nikde získat zpět? Nebo opět jen za tučný poplatek?</p>
<h2>Jak  z toho ven?<span style="font-size: 10px;"> </span></h2>
<p>Pro potřeby webu <a href="http://www.odcizena-vozidla.cz">odcizena-vozidla.cz</a> jsem si vytvořil <a href="http://www.policeapi.cz/" target="_blank">vlastní API</a> nad policejním webem. Prostě data otevírám za policii. Když se je snaží uzavírat a znepřístupňovat, není jiná cesta.</p>
<p><strong>Tak vznikl projekt <a href="http://www.policeapi.cz/">policeapi.cz</a>. API zpracovává vyhledávací formulář a následné stránky na oficiálním policejním webu a výsledky vrací ve formátu XML nebo JSON. </strong></p>
<p>API poskytuji veřejně. Doufám, že se jej chytne někdo další a zaintegruje do svých systémů. Autobazar (ověření VIN auta k prodeji), parkovací domy, mobilní aplikace pro ověření vozidla, kdokoliv, kdo pracuje s SPZ nebo VIN. </p>
<p>API je dokumentováno na <a href="http://www.apiary.io/">Apiary</a> - <a href="http://docs.odcizenavozidla.apiary.io/">http://docs.odcizenavozidla.apiary.io/</a>.  Rád jej upravím a doplním, když pošlete návrhy, co by mohlo být lépe. Ukázky použití, demo a další informace na podpůrném webu <a href="http://www.policeapi.cz">www.policeapi.cz</a>. </p>
<p>Nápady, komentáře, připomínky? Rád si je poslechnu. Ať už zde v komentářích, nebo na e-mailu todvora@gmail.com. </p>
