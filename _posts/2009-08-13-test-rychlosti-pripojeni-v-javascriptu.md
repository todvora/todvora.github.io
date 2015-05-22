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

<pre><code>&lt;script type=&quot;text/javascript&quot;&gt;

var SpeedTest = function() {};

SpeedTest.prototype = {
  imgUrl: &quot;/images/23.png&quot;    // Where the image is located at
  ,size: 199642                // bytes
  ,run: function( options ) {

    if( options &amp;&amp; options.onStart )
      options.onStart();

    var imgUrl = this.imgUrl + &quot;?r=&quot; + Math.random();
    this.startTime = (new Date()).getTime() ;

    var testImage = new Image();
    var me = this;
    testImage.onload = function() {
      me.endTime = (new Date()).getTime();
      me.runTime = me.endTime - me.startTime;

      if( options &amp;&amp; options.onEnd )
        options.onEnd( me.getResults() );
    };
    testImage.src = imgUrl;
  }

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

 var st = new SpeedTest();
 st.run({
    onStart: function() {
       document.getElementById(&quot;speedTest&quot;).innerHTML = &quot;zacal vypocet...&quot;;
   }
   ,onEnd: function(speed) {
document.getElementById(&quot;speedTest&quot;).innerHTML = Math.round(speed.Kbps) + ' Kbps';
   }
 });
&lt;/script&gt;
</code></pre>

<p>Takto definovaná funkce a její spouštěč se sama postará
o spuštění a prezentaci výsledků, v námi uvedeném případě
obojí zapisuje do elementu s id „speedtest“. Proto by bylo
vhodné javaSctript vložit do stránky s následující strukturou :</p>

<pre><code>&lt;html&gt;
 &lt;head&gt;
  &lt;title&gt;Speed Check&lt;/title&gt;
 &lt;/head&gt;
 &lt;body&gt;
  &lt;h3&gt; Speed check &lt;/h3&gt;
  &lt;br&gt;
Speed : &lt;span id=&quot;speedTest&quot;&gt;&lt;/span&gt;
&lt;/body&gt;
&lt;/html&gt;
</code></pre>

<p>Nezbývá než si celý kód ozkoušet a případně prohlédnout zdrojový
kód na stránce <a href="/examples/speedcheck/speedcheck.html">SpeedTest</a></p>

<p>Za kompletní návod děkuji autorovi článku : <a
href="http://alexle.net/archives/257">http://alexle.net/archives/257</a></p>

