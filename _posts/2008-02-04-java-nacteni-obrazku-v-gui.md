---
layout: post
title: Java - načtení obrázku v GUI
date: '2008-02-04 08:35:20'
tags:
- java
- gui
- jPanel
- img
- bufferedImage
---

Vykreslení obrázku v grafickém uživatelském rozhraní
v komponentě JScrollPane


<p>Načtení obrázku do rámce v grafickém rozhranní není tak úplně
triviální, jak by se mohlo zdát. Problém je, že komponentě nejde říct
přímo, jaký obrázek vykreslit. Musí se napsat třída implementující
JPanel, vytvořena její instance a přidána jako obsah do nějakého
kontejneru, třeba ScrollPane. Takže kroky sou následující:</p>

<ol>
	<li>Vytvořit třídu pro vykreslení, rozšiřující JPanel</li>

	<li>Vytvořit referenci na soubor obrázku</li>

	<li>Načíst obrázek do paměti</li>

	<li>Vytvořit instanci naší třídy</li>

	<li>Přiřadit ji do ScrollPane</li>
</ol>

<p><strong>1) Třída rozšiřující JPanel</strong></p>

<pre><code>import java.awt.Graphics;
import java.awt.Image;
import javax.swing.JPanel;

public class KresliciPanel extends JPanel
{
  Image img;

  public KresliciPanel (Image img)
  { this.img = img; }

  public void paintComponent (Graphics g) {
   super.paintComponent (g);
   int imgX =0;// obrazek ma rozmer stejny jako ramec
   int imgY =0;// vlozime ho tedy do rohu

   //vykreslime
   g.drawImage (img, imgX, imgY, this);
  }

}</code></pre>

<p>Z kódu je vidět, že třída je opravdu jednoduchá, jak jen to
jde.</p>

<p><strong>2) Reference na soubor</strong></p>

<pre><code>File f = new File("obrazek.jpg");</code></pre>

<p><strong>3) Načíst obrázek do paměti</strong></p>

<p>Vytvoříme instanci BufferedImage a pomocí třídy ImageIO ji naplníme
obrázkem.</p>

<pre><code>BufferedImage bimage = ImageIO.read(f);</code></pre>

<p><strong>4) Instance naší třídy</strong>
<br />Ve třídě gui, nejlépe v metodě volané při nějaké akci,
třeba kliknutí na tlačítko, vytvoříme objekt naší třídy</p>

<pre><code>KresliciPanel kp = new KresliciPanel(bimage.getScaledInstance(
JScrollPane.getWidth(), JScrollPane.getHeight(),
Image.SCALE_SMOOTH));</code></pre>

<p>Kde bimage je náš obrázek v paměti, getScaledInstance() vytvoří
náhled velký stejně jako je náš zobrazovací panel,a Image.SCALE_SMOOTH je
metoda transformace obrázku při zmenšování.</p>

<p><strong>5) Zobrazení obrázku v panelu</strong>
<br />Poslední krok, nutný pro vykreslení obrázku v GUI je jeho
přiřazení do JscrollPane. Kód je jednoduchý</p>

<pre><code>JScrollPane.add(kp);</code></pre>

<p>Po tomto kroku by již měl být obrázek zobrazen, pokud nenastal problém
například s referencí na soubor.</p>

<p>Možná by bylo dobré ještě podotknout kde se veme ten JScrollPane,
prostě ho v návrhu rozložení grafiky přetáhneme z panelu
komponent na místo kam chceme,a upravíme mu rozměry.</p>

<p><strong>Závěr</strong>
<br />Věřím že existuje mnoho lepších praktik, ale když jsem hledal
jakoukoli jednoduchou funkční, zabralo to dost času. Tento návod snad
poradí do začátku, jak na to.</p>

