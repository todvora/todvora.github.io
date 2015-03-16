---
layout: post
title: Test rychlosti připojení v JavaScriptu (javascript speed test)
date: '2009-08-17 15:33:52'
tags:
- html
- img
- javascript
- speedtest
---

Při provozování složitější aplikace je často nutné zjistit, jaké
má schopnosti klientský prohlížeč a jaké je jeho připojení do světa.
V tomto článku rozebereme postup, jak zjistit jeho rychlost stahování
dat.


<p>Občas je při vývoji internetových aplikací potřeba znát, jakou
rychlostí je k Vám připojen klient, který aplikaci používá. Vše co
bude potřeba, je jeden obrázek uložený na serveru, a kousek JavaSriptového
kódu. Nepotřebujeme žádné frameworky, knihovny, nic takového.</p>

<p>Idea je taková, že měření provedeme v následovně : stopneme čas,
začneme nahrávat obrázek a v okamžiku kdy nahrávání skončí,
změříme čas podruhé. Ze zjištěného času a známé velikosti obrázku
vypočteme přenosovou rychlost.</p>

<pre><code><script type="text/javascript">
// vytvoreni nove funkce
var SpeedTest = function() {};

// jeji navrzeni
SpeedTest.prototype = {
  imgUrl: "/images/23.png"    // umisteni obrazku
  ,size: 199642                // a jeho velikost v bitech
  ,run: function( options ) {

    if( options && options.onStart )
      options.onStart();

// nahodne cislo, aby se zamezilo cachovani
    var imgUrl = this.imgUrl + "?r=" + Math.random();

// prvni stopnuti casu
    this.startTime = (new Date()).getTime() ;

    var testImage = new Image();
    var me = this;
    testImage.onload = function() {
// druhe stopnuti casu, po nahrani obrazku
      me.endTime = (new Date()).getTime();
      me.runTime = me.endTime - me.startTime;

      if( options && options.onEnd )
        options.onEnd( me.getResults() );
    };
    testImage.src = imgUrl;
  }

// vypocet rychlosti
  ,getResults: function() {
    if( !this.runTime )
      return null;

    return {
      runTime: this.runTime
      ,Kbps: ( this.size * 8 / 1024 / ( this.runTime / 1000 ) )
      ,KBps: ( this.size / 1024 / ( this.runTime / 1000 ) )
    };
  }
}

// samotne vytvoreni testovani
 var st = new SpeedTest();
// spusteni
 st.run({
// co provest na zacatku
    onStart: function() {
       document.getElementById("speedTest").innerHTML = "zacal vypocet...";
   }
// co provest nakonci
   ,onEnd: function(speed) {
document.getElementById("speedTest").innerHTML = Math.round(speed.Kbps) + ' Kbps';
   }
 });
</script></code></pre>

<p>Takto definovaná funkce a její spouštěč se sama postará
o spuštění a prezentaci výsledků, v námi uvedeném případě
obojí zapisuje do elementu s id „speedtest“. Proto by bylo
vhodné javaSctript vložit do stránky s následující strukturou :</p>

<pre><code><html>
 <head>
  <title>Speed Check</title>
 </head>
 <body>
  <h3> Speed check </h3>
  <br>
Speed : <span id="speedTest"></span>
</body>
</html></code></pre>

<p>Nezbývá než si celý kód ozkoušet a případně prohlédnout zdrojový
kód na stránce <a href="/speedtest">SpeedTest</a></p>

<p>Za kompletní návod děkuji autorovi článku : <a
href="http://alexle.net/archives/257">http://alexle­.net/archives/257</a></p>

