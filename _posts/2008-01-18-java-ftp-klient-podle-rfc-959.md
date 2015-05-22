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
<br />CWP – změna pracovního adresáře
<br />DELE – vymazání souboru
<br
/>HELP – seznam příkazů kterým server rozumí
<br
/>LIST – seznam souborů a složek v pracovním adresáři
<br />MKD – vytvoření složky
<br />PASV – přepnutí na pasivní režim
<br />PWD – výpis názvu aktuálního
pracovního adresáře
<br />QUIT – ukončení komunikace
<br />RETR – přenesení souboru na klienta
<br />RMD – smazání prázdného adresáře
<br />STOR – přenesení souboru na server
<br />TYPE – přepnutí komunikace mezi binární
a ascii</p>

<p>Odkaz ke stažení semestrální práce:
<br /><a href="/downloads/FTPclient.zip">FTPclient.zip</a></p>

