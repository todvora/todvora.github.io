---
layout: post
title: Ubuntu a RAID
date: '2010-01-14 17:33:06'
tags:
- ubuntu
- raid
- mdadm
- filesystém
- fstab
- ext3
- mdadm.conf
---

Jeden z mnoha návodů na internetu o tom, jak vytořit
v ubuntu softwarový raid


<h2>1) staneme se rootem</h2>

<p><code>sudo -i</code></p>

<h2>2) Vytvoříme raid</h2>

<p><code>mdadm /dev/md0 --create --auto yes -l 0 -n 2 /dev/sdc
/dev/sdd</code></p>

<p><strong>Co to vlastně provádí:</strong></p>

<ul>
	<li><strong>mdadm /dev/md0</strong> – vytváříme raid /dev/md0</li>

	<li><strong>-l</strong> říká že raid bude typu 0 (<a
	href="http://cs.wikipedia.org/wiki/RAID#RAID_0">http://cs.wi­kipedia.org/wi­ki/RAID#RAID_0</a>
	)</li>

	<li><strong>-n</strong> počet zařízení v raidu</li>

	<li><strong>/dev/sdc /dev/sdd</strong> – vytvoříme raid z disků
	/dev/sdc a /dev/sdd (správné identifikátory disků lze zjistit například
	pomocí gparted)</li>
</ul>

<h2>3) Filesystém na raidu</h2>

<p><code>mkfs.ext3 /dev/md0</code> – vytvoříme ext3 filesystém na
našem raidu</p>

<h2>4) Mountování</h2>

<p>Nyní je vytvořený raid třeba někam namountovat, aby se k němu dalo
přistupovat. Ideálně po startu, ve fstab.</p>

<p><code>mkdir /media/raid</code>
<br />vytvoří složku raid, do které budeme mountovat náš raid</p>

<p>Poeditujeme fstab a na konec přidáme řádek</p>

<p><code>nano /etc/fstab</code></p>

<p><code>/dev/md0 /media/raid ext3 defaults 0 0</code></p>

<h3>5) Automatické sestrojení raidu po rebootu</h3>

<p>Příkaz
<br /><code>sudo mdadm --detail --scan</code>
<br />vypíše něco takového :</p>

<p><code>ARRAY /dev/md0 level=raid0 num-devices=2 metadata=00.90
UUID=063b009f:b5015e58:0fa743ad:aa0ca058</code></p>

<p>tento řetězec je třeba přidat na konec souboru
/etc/mdadm/mdad­m.conf</p>

<p><strong>! Tato část se v mnoha návodech na internetu nenachází a
v mém případě se pak raid sám po rebootu nesestrojil a nefungoval
!</strong></p>

<p>Hotovo, rebootneme a raid by měl zůstat funkční, připojený v
/media/raid.</p>

