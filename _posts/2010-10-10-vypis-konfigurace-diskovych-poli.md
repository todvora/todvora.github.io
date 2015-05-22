---
layout: post
title: Výpis konfigurace diskových polí
date: '2010-10-10 16:32:10'
tags:
- filesystém
- debian
- fstab
- linux
- mdadm
---

Jak zjistit, které disky jsou obsaženy v kterých polích a
konfiguraci těchto polí


<p>cat /proc/mdstat</p>

<p>Personalities : [raid10] [raid1] [linear] [multipath] [raid0] [raid6] [raid5]
[raid4]
<br />md1 : active raid1 sdb1[1] sda1[0]
<br />146480512 blocks [4/2] [UU__]</p>

<p>md3 : active raid10 sdd[3] sdc[1] sdb3[2] sda3[0]
<br />142576640 blocks 64K chunks 2 near-copies [4/4] [UUUU]</p>

<p>md2 : active raid10 sdb2[2] sda2[0]
<br />19534848 blocks 64K chunks 2 near-copies [4/2] [U_U_]</p>

<p>unused devices: &lt;none&gt;</p>

