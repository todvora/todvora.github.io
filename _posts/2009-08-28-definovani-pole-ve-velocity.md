---
layout: post
title: Definování pole ve Velocity
date: '2009-08-28 05:58:44'
tags:
- velocity
- apache
- pole
- proměnná
---

Definování proměnné, statického pole, ve velocity a iterace přes jeho
položky.


<p>Velocity je šablonovací nástroj pro Javu. Jeho použití je velmi
intuitivní, má značné možnosti skryptování a pro zkušeného webdesignera
nebo programátora je snadné vykouzlit s ním kdejakou konstrukci.</p>

<p>Domovská stránka projektu Velocity je <a
href="http://velocity.apache.org/">http://veloci­ty.apache.org/</a></p>

<p>Teď již k tématu. Samotná definice proměnné probíhá přes
directivu</p>

<p><code>#set($promenna = "obsah")</code></p>

<p>Kdy byl právě do proměnné s názvem promenna uložen řetězec
„obsah“.</p>

<p>Samotné pole pak do proměné dostaneme takovouto konstrukcí:</p>

<pre class="prettyprint"><code>#set( $array = ["1", "2", "3", "4", "5", "6", "7", "8", "9"])

#foreach( $key in $array )
    $key
#end</code></pre>

<p>Kdy v poli budou uloženy hodnoty od 1 do 9 a cyklus je
následně projde a vypíše.</p>

<h2>Doplnění informací 14.10.2009 :</h2>

<p><strong>Takto vytvořené pole předané jako parametr nějaké metodě Javy
má datový typ ArrayList<String>, nikoli String[] jak bych se
domníval.</strong></p>

