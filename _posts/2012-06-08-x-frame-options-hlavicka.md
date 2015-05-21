---
layout: post
title: X-FRAME-OPTIONS hlavička
date: '2012-06-09 07:55:16'
tags:
- X-FRAME-OPTIONS
- http
- PHP
- apache
- nginx
- javascript
- framekiller
- clickjacking
---
X-FRAME-OPTIONS HTTP hlavička funguje jako prostředek, jak může server sdělit prohlížeči svou představu o chování stránky vložené v rámu (frame, iframe). Server tak může ovlivnit, zda jím vytvořená stránka smí být vložena všude, jen z jiných stránek téhož serveru nebo nikdy nikam.

<p>Hlavička <strong>X-FRAME-OPTIONS</strong> funguje především jako ochrana proti <a href="http://cs.wikipedia.org/wiki/Clickjacking">clickjackingu</a> (legitimní stránka je natažena ve framu a překryta průhledným obsahem, při kliknutí na místo, kde je v legitimní stránce nějaký prvek je vykonáno kliknutí v záškodnickém průhledném rámu), můžeme jí využít ale i pokud si nepřejeme stránky zobrazovat jinde vložené ve rámu (třeba obalené cizím webem, reklamou a podobně). Proti clickjackingu se využívá například i javascript, který detekuje, že je stránka zobrazena ve framu a dovede provést redirect tak, aby se z rámu vymanila do horního, rodičovského okna. JavaScript ale není zcela spolehlivá metoda. </p>
<p>Hlavička <strong>X-FRAME-OPTIONS</strong> může mít dvě hodnoty:</p>
<ul>
<li><strong>SAMEORIGIN</strong> - je povoleno zobrazovat stránku v rámu na vlastním webu</li>
<li><strong>DENY</strong> - stránka nikdy nesmí být zobrazena v rámu</li>
</ul>

<div>Podpora je v nových prohlížečích v pořádku:</div>

<div>Internet Explorer: 8.0</div>
<div>Firefox: (Gecko)3.6.9 (1.9.2.9)</div>
<div>Opera: 10.50</div>
<div>Safari: 4.0</div>
<div>Chrome: 4.1.249.1042</div>

<div>Zdroj: <a href="https://developer.mozilla.org/en/The_X-FRAME-OPTIONS_response_header">developer.mozilla.org</a></div>


<div>V PHP můžete hlavičku nastavit voláním funkce <a href="http://php.net/manual/en/function.header.php">header</a>, například:</div>

<pre class="prettyprint">header('X-Frame-Options: DENY'); </pre>
<div>nebo:</div>
<pre class="prettyprint">header('X-Frame-Options: SAMEORIGIN');</pre>
<p>V Apachi v konfiguraci virtualhosta pak stačí:</p>
<pre class="prettyprint">Header set X-Frame-Options SAMEORIGIN</pre>
<p>Nginx by měl akceptovat konfiguraci:</p>
<pre class="prettyprint">add_header X-Frame-Options SAMEORIGIN;</pre>
<p>Pozor! Než hlavičku nastavíte, zvažte zda neposkytujete některému jinému webu svůj obsah v podobě stránky připravené pro vložení do iframu. Typicky se tak vkládá reklamní bloček s nabídkou volných pracovních pozic a pod. V takovém případě by se na stránkách Vašeho partnera začala zobrazovat chybová zpráva obdobná té v obrázcích níže.</p>
<p>V chromiu se mi místo zakázaného rámce zobrazí pouze prázdné místo, opera zobrazí srozumitelnou hlášku o nemožnosti rám načíst s prolinkem na originální stránku. Internet Explorer 9 zobrazí také srozumitelnou chybovou hlášku.</p>
<p><img src="/images/100.png" alt="Informace prohlížeče opera o zakázaném zobrazení iframu" width="404" height="239" /></p>
<p>(Obrázek 1: informace o nemožnosti zobrazit stránku v iframu, opera 11.64)</p>
<p><img src="/images/101.png" alt="informace o nemožnosti zobrazit stránku v iframu, Internet Explorer 9" width="400" height="240" /></p>
<p>(Obrázek 2: informace o nemožnosti zobrazit stránku v iframu, Internet Explorer 9)</p>
<p> </p>
<p>Pokud nemáte možnost manipulovat s HTTP hlavičkami a přesto byste rádi dosáhli podobné funkcionality, využijte JavaScript. Kód, který to řeší se běžně označuje jako <strong>Framekiller</strong>. Jeho nejjednodušší implementace může vypadat nějak takto:</p>
<pre class="prettyprint"><script type="text/javascript">
  if(top != self) top.location.replace(location);
</script></pre>
<p>Framekiller jde ale eliminovat a navíc vyžaduje podporu JavaScriptu na klientu.</p>
<p>Více různých implementací framekilleru a detailní popis naleznete na <a href="http://en.wikipedia.org/wiki/Framekiller">wikipedia stránce framekiller</a>.</p>
