---
layout: post
title: java FTP klient podle RFC 959
date: '2008-01-18 11:48:24'
tags:
- java
- ftp
- rfc 959
- client
---

FTP klient napsaný v javě, odpovídá RFC 959


<p>V níže odkazovaném zip archívu se nachází zdrojové
i binární kódy, včetně dokumentace k programu. Program
komunikuje se serverem přes sockety, odesílá textové přikazy. Zadání
semestrální práce znělo:</p>

<p><strong>FTP klient</strong>.Prostudujte odpovídající RFC dokumenty a
navrhněte minimální množinu podporovaných operací protokolu FTP.
Realizujte funkce klienta. Součástí práce bude i otestování
funkčnosti programu s existujícím serverem. Soustřeďte se na
problematiku bezpečného připojení.</p>

<p>Funkce které klient implementuje:</p>

<p>CDUP – návrat o složku výše
<br />CWP – změna pra­covního adresá­ře
<br />DELE – vymazá­ní souboru
<br
/>HELP – seznam pří­kazů kterým ser­ver rozumí
<br
/>LIST – seznam sou­borů a složek v pra­covním adresá­ři
<br />MKD – vytvoře­ní složky
<br />PASV – přepnu­tí na pasivní režim
<br />PWD – výpis náz­vu aktuálního
pracovního a­dresáře
<br />QUIT – ukonče­ní komunikace
<br />RETR – přenese­ní souboru na klienta
<br />RMD – smazání prázdného adre­sáře
<br />STOR – přenese­ní souboru na server
<br />TYPE – přepnu­tí komunikace mezi binární
a ascii</p>

<p>Odkaz ke stažení semestrální práce:
<br /><a href="/downloads/FTPclient.zip">FTPclient.zip</a></p>

