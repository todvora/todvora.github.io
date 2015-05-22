---
layout: post
title: Flyspray na windows 2003
date: '2010-01-31 10:35:01'
tags:
- flyspray
- bug-tracking
- php
- virtualbox
- windows 2003
- debian
- apache
- php
---

Jednoduchý návod, jak rozeběhnout na windows 2003 serveru bug-tracker
systém flyspray za pomoci virtualboxu a v něm virtualizovaného
debianu.


<p><strong>1. Cíl</strong>
<br />Cílem mého snažení bylo rozeběhnout na vnitřní síti společnosti
flyspray ( <a href="http://flyspray.org/">http://flyspray.org/</a> ), což
je nástroj pro hlášení chyb. Zde bude použit jako systém pro zadávání
úkolů a sledování jejich plnění. Něco o bug tracking systémech je
k přečtení například na <a
href="http://cs.wikipedia.org/wiki/Bug_tracking_system">wikipedii</a></p>

<p><strong>2. Návrh</strong>
<br />K dispozici je server s windows 2003, který zajištuje dns
služby a sdílí internet. Na něj nainstalujeme virtualbox, ve kterém trvale
poběži debian, protože potřebujeme PHP a mySQL pro flyspray, a rozhodně to
bude spolehlivější a jednodušší než nutit php běžet na windows.</p>

<p><strong>3. Ke stažení</strong>
<br />budeme potřebovat tyto věci :
<br />Virtualbox – <a
href="http://www.virtualbox.org/wiki/Downloads">http://www.virtualbox.org/wiki/Downloads</a>
– pro windows
<br />Image debian cd – <a
href="http://debian.org/distrib/netinst#smallcd">http://debian.org/distrib/netinst#smallcd</a>
<br />flyspray už pak stáhneme přímo z debianu</p>

<p><strong>4. Instalace virtualboxu</strong>
<br />Instalace je typicky windowsova – proste další další další
:)</p>

<p><strong>5. Vytvoření virtuálního systému</strong>
<br />Klikneme na „nový“ – další
<br />Zvolte název virtuálního stroje, pomocí něj bude možné později
ovládat stroj z příkazové řádky
<br />Vyberete „Operating system“ → „linux“ a
„version“ → debian
<br />Zvolte velikost operační paměti – 256MB by mělo spolehlivě
stačit
<br />Dále je třeba vytvořit soubor který bude představovat disk
virtuálního stroje. Zvolte nový a zadejte lokaci do které se uloží, typ
dynamický, velikost ponechte klidně nabízených 8GB, samotný disk je
„nafukovací“, roste se spotřebovaným místem na disku
virtuálního stroje. Ponechte zaškrtlé boot harddisk a dejte dokončit. Tím
je vytvořen nový virtuální systém.
<br />Ještě musíme doladit drobnosti. Připojit image debianu
k mechanice. Nastavení – CD/DVD – připojit CD/DVD mechaniku
– soubor ISO – vyberte iso image a potvďte. Nyní by již mělo
být připraveno všechno pro instalaci operačního systému.</p>

<p><strong>6. Instalace debianu</strong></p>

<ul>
	<li>spustíme virtuální stroj, ten nabootuje z CD (námi připojený
	image).</li>

	<li>zvolíme jako jazyk češtinu</li>

	<li>disk necháme automaticky nakonfigurovat debianem</li>

	<li>všechny partišny na jeden oddíl</li>

	<li>typ instalace bude standartní + webserver</li>

	<li>vše ostatní necháme standartní</li>
</ul>

<p><strong>7. Konfigurace debianu</strong>
<br />Nejprve je třeba debian nastavit tak, aby byl viditelný ve vnitřní
síti. Nastavíme mu pevnou ip. To provedeme v /etc/networking/interfaces
<br />Jak na to :
<br />přihlašte se jako root a do terminálu zadejte
<br /><code>nano /etc/network/interfaces</code></p>

<p>po vaší úpravě by měl soubor vypadat nějak takhle :</p>

<pre><code>auto lo eth0
iface lo inet loopback

auto eth0
iface eth0 inet static
address 192.168.1.2
netmask 255.255.255.0
network 192.168.1.0
broadcast 192.168.1.255
gateway 192.168.1.1</code></pre>

<p>kde 192.168.1.1 je náš windows server, 192.168.1.2 bude ip
flyspray virtuálního pc.</p>

<p>Nyní vypneme virtuální počítač a je třeba upravit síťování ve
virtualboxu. V nastaveních flyspray stroje najděte síť a zvolte
„host interface“, dole z dropdown seznamu pak vyberte síťovou
kartu která je připojena do lan, ne k modemu či routeru.</p>

<p>Nyní by již po opětovném startu měl jít počítač pingnout
z vnitřní sítě. Jeho ip bude 192.168.1.2</p>

<p><strong>8. konfigurace flyspraye</strong>
<br />Přihlásíme se do systému jako root
<br />Nejprve musíme stahnout zip s instancí flyspraye.
<br />Nejsnáze asi takto :
<br /><code>wget http://flyspray.org/flyspray-0.9.9.5.1.zip</code>
<br />Pak jej rozbalit, snadno to jde programem unp, píšeme tedy
<br /><code>apt-get install unp</code></p>

<p>Příprava adresáře a zkopírování zipu
<br /><code>mkdir /var/www/flyspraymv /root/flyspray-0.9.9.5.1.zip
/var/www/flyspray/</code></p>

<p>a samotné rozbalení
<br /><code>cd /var/www/flysprayunp flyspray-0.9.9.5.1.ziprm
flyspray-0.9.9.5.1.zip</code></p>

<p>Následuje instalace nezbytných balíčků :
<br /><code>apt-get install apache2 mysql-server debconf libapache2-mod-php5
libphp-adodb php5-mysql ucf wwwconfig-common graphviz php5-cli</code></p>

<p>Některé již v systému možná jsou, závísí to na konfiguraci
která byla navolená při instalaci systému, ale to nevadí.</p>

<p>Reloadneme apache
<br /><code>/etc/init.d/apache2 restart</code></p>

<p>Musíme umožnit přístup do mysql databáze:</p>

<pre><code># mysql -u root -p
  > CREATE DATABASE flyspray DEFAULT CHARACTER
SET utf8 COLLATE utf8_unicode_ci;
  > GRANT SELECT,INSERT,UPDATE,DELETE,CREATE,DROP,
INDEX,ALTER,CREATE TEMPORARY TABLES ON flyspray.*
TO flysprayuser@localhost IDENTIFIED BY 'yourpassword';
  > quit
  # mysqladmin -u root -p reload</code></pre>

<p>Nezapoměňte zkontrolovat, zda jsou složky <strong>attachments</strong> a
<strong>cache</strong> zapisovatelné.</p>

<p>Po restartu apache by již měl být flyspray dostupný na
<br /><a
href="http://192.168.1.2/flyspray/setup/">http://192.168.1.2/flyspray/setup/</a></p>

<p>Následujte pokyny na obrazovce, jde o vyplnění konfiguračních
údajů, jako je přístup do databáze a podobně.</p>

<p>Po instalaci nezapomeňte odstranit složku <strong>setup</strong></p>

