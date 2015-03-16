---
layout: post
title: Python na nokia 5500 - bt console
date: '2008-04-10 22:21:46'
tags:
- bt console
- nokia
- python
- symbian
---

Návod jak zprovoznit bluetooth konsoli na nokii 5500 a
linux(ubuntu)


<p>Bluetooth console je způsob,jak se vyhnout psaní příkazů na klávesnici
telefonu,a místo toho využít konsoli linuxovou. Pro následující příkazy
uvažujeme toto:</p>

<ul>
	<li>Nainstalovaný PyS60 ( <a
	href="http://opensource.nokia.com/projects/pythonfors60/">ke stažení zde</a>
	)</li>

	<li>připojené bluetooth zařízení k počítači,a nainstalované
	blueZ</li>
</ul>

<p><strong>1) konfigurace minicomu</strong>
<br />Příkazem</p>

<pre><code>minicom -s</code></pre>

<p>spustíme konfiguraci,z menu volíme nastavení sériového portu,
změníme zažízení na /dev/rfcomm0 , zbytek ponecháme a uložíme,
ukončíme</p>

<p><strong>2) Spárování telefonu a počítače</strong>
<br />Příkazy popořadě:</p>

<pre><code>hciconfig reset
hcitool dev
sdptool add --handle=lah --channel=2 SP</code></pre>

<p>Po tomto kroku již linuxová konzole čeká na připojení telefonu,
spustíme tedy python, zvolíme bluetooth konsoli, vyhledáme počítač a
dáme spojit</p>

<p><strong>3) Připojení konsole</strong>
<br />Nyní je již vše připraveno pro propojení konsolí, zbývá poslední
příkaz</p>

<pre><code>rfcomm listen rfcomm0 2 cu -l /dev/rfcomm0</code></pre>

<p>Nyní bychom meli již vidět standartní >>>> prompt pythonu,
můžeme psát příkazy, které se provedou na telefonu a výstup je proveden
do konsole v počítači.</p>

<p>Pro spouštění doporučuji vytvořit si skript, který pokaždé provede
všechny kroky, jen počká na připojení telefonu, jeho obsah by měl
být:</p>

<pre><code>hciconfig reset
hcitool dev
sdptool add --handle=lah --channel=2 SP
rfcomm listen rfcomm0 2 cu -l /dev/rfcomm0</code></pre>

<p>Protože rozhodně neovládám linux na nějaké administrátorské úrovni,
nebude vysvětleno co který příkaz dělá, je zde pouze popsán
postup,který funguje na mých zařízeních.</p>

<p><strong>Zdroje:</strong>
<br /><a
href="http://wiki.opensource.nokia.com/projects/PyS60_Bluetooth_console">Postup
na zprovoznění přímo od nokie</a>
<br /><a
href="http://www.97k.eu/blog/index.php?entry=entry071112-195753">Alternativní
postup</a></p>

<p>Můj způsob je kombinace obou dvou postupů zmíněných v odkazech
výše.</p>

