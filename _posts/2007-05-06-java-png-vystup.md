---
layout: post
title: JAVA - PNG výstup
date: '2007-05-06 16:30:45'
tags:
- java
- png
- výstup
- bufferedimage
---

Jak v paměti vytvořit obrázek a pak ho uložit na disk


<p>Když jsem naposledy řešil jak z programu v Javě udělat výstup
do grafického formátu <a href="http://cs.wikipedia.org/wiki/PNG">PNG</a>
strávil jsem relativně dlouhý čas hledáním nějakých informací,
o které se teď chci podělit:</p>

<p><strong>BufferedImage bimage = new BufferedImage(width, height,
BufferedImage.TYPE_INT_RGB); //vytvoreni obrazku s danou sirkou a
vyskou</strong>
<br /><strong>Graphics g;</strong>
<br /><strong>g=bimage.getGraphics();</strong>
<br /><strong>Graphics2D g2d = bimage.createGraphics();</strong>
<br /><strong>g2d.setColor(Color.RED); //nastaveni barvy kresleni</strong>
<br /><strong>g2d.drawRect(x,y,vyska,sirka); //kresleni
obdelniku</strong></p>

<p>objekt g2d obsahuje spoustu metod pro kreslení nebo přizpůsobování
obrázku, jako je kreslení geometrických tvarů,barev…</p>

<p>nakonec obrázek uložíme na disk:</p>

<p><strong>ImageIO.write(bimage, „png“, new
File(„vystup.png“));</strong></p>

<p>Možná by bylo dobré ještě uvést seznam importů co jsou třeba
k chodu programu</p>

<p><strong>import java.awt.Color;</strong>
<br /><strong>import java.awt.Graphics;</strong>
<br /><strong>import java.awt.Graphics2D;</strong>
<br /><strong>import java.awt.image.BufferedImage;</strong>
<br /><strong>import java.io.*;</strong>
<br /><strong>import javax.imageio.ImageIO;</strong></p>

