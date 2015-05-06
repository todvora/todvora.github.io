---
layout: post
title: MongoDB - Java driver a obnovení přerušeného spojení
date: '2012-06-21 15:02:24'
tags:
- mongodb
- java
- autoConnectRetry
- maxAutoConnectRetryTime
- NoSQL
---
Java driver pro nerelační databázi MongoDB má jako defaultní chování nastaveno neobnovování spojení v případě výpadku. Stačí pak malý výpadek připojení k MongoDB a vaše aplikace zůstane po zbytek běhu bez Monga. Přitom stačí během inicializace překonfigurovat výchozí nastavení.

<p><a href="http://www.mongodb.org/">MongoDB</a> je nerelační databáze (NoSQL), kterou používáme pro ukládání logů a generování statistik webových serverů. Ročně zaznamenáváme desítky milionů logů (bez robotů) a MongoDB je na to ideální. Svým dokumentovým modelem se skvěle hodí na proměnlivou strukturu logů a výkonově stíhá v reálném čase generovat reporty bez nutnosti předpočítávání dat.</p>
<p>Dnes jsem narazil na jednu záludnost. MongoDB driver pro Javu v defaultním nastavení neobnovuje konexi v případě odpojení od serveru. Toto chování lze ovlivnit vhodnou konfigurací MongoOptions při vytváření připojení.</p>
<p>Výchozí hodnoty pro <a href="http://api.mongodb.org/java/2.8.0/com/mongodb/MongoOptions.html">MongoOptions</a> použité při vytváření nového připojení jsou:</p>
<pre class="prettyprint">description=null, 
connectionsPerHost=10, 
threadsAllowedToBlockForConnectionMultiplier=5, 
maxWaitTime=120000, 
connectTimeout=0, 
socketTimeout=0, 
socketKeepAlive=false, 
autoConnectRetry=false, 
maxAutoConnectRetryTime=0, 
slaveOk=false, 
safe=false, 
w=0, 
wtimeout=0, 
fsync=false, 
j=false 
</pre>
<p>Nás zajímají především <strong>autoConnectRetry</strong> a <strong>maxAutoConnectRetryTime</strong>. </p>
<p>Dokumentace k <a href="http://api.mongodb.org/java/2.8.0/com/mongodb/MongoOptions.html#autoConnectRetry">autoConnectRetry</a> říká:</p>
<p style="padding-left: 30px;"><em>If true, the driver will keep trying to connect to the same server in case that the socket cannot be established. There is maximum amount of time to keep retrying, which is 15s by default. This can be useful to avoid some exceptions being thrown when a server is down temporarily by blocking the operations. It also can be useful to smooth the transition to a new master (so that a new master is elected within the retry time). Note that when using this flag: - for a replica set, the driver will trying to connect to the old master for that time, instead of failing over to the new one right away - this does not prevent exception from being thrown in read/write operations on the socket, which must be handled by application Even if this flag is false, the driver already has mechanisms to automatically recreate broken connections and retry the read operations. Default is false.</em></p>
<p><strong>Defaultní hodnota autoConnectRetry je false</strong>, driver se tedy nebude pokoušet o znovupřipojení v případě, že konexi ztratí. To na produkčním serveru rozhodně nepotřebujeme, stačí jen restart démona nebo krátký výpadek spojení a po zbytek běhu aplikace (u nás běžně několik dní do nasazení nové stable verze) není možné do monga zapisovat.</p>
<p>Dokumentace k je <a href="http://api.mongodb.org/java/2.8.0/com/mongodb/MongoOptions.html#maxAutoConnectRetryTime">maxAutoConnectRetryTime</a> je:</p>
<p style="padding-left: 30px;"><em>The maximum amount of time in MS to spend retrying to open connection to the same server. Default is 0, which means to use the default 15s if autoConnectRetry is on.</em> </p>
<p>Nerozumím, proč je defaultní hodnota 0 a znamená 15s (proč není default v milisekundách 15s, aby to bylo zřejmé?), pro naše potřeby je však 15s málo, nastavíme pro jistotu několik minut. To by mělo pokrýt i reboot databázového stroje v případě nutnosti (logy zaznamenáváme asynchronně, mohou se tedy hromadit ve frontě dokud MongoDB opět nenajede).</p>
<p>Inicializace připojení, které je schopno se zotavit z problémů s konexí by pak mohla vypadat například:</p>
<pre class="prettyprint">MongoOptions options = new MongoOptions();
options.setAutoConnectRetry(true);
options.setMaxAutoConnectRetryTime(RECONNECT_TIMEOUT);
MONGO = new Mongo(new ServerAddress(server, port), options);
</pre>
<p> RECONNECT_TIMEOUT je v ms, tedy například 14 * 60 * 1000 pro 14 minut timeoutu.</p>
<p> </p>
<p>Odkazy:</p>
<p><a href="https://github.com/mongodb/mongo-java-driver/downloads">https://github.com/mongodb/mongo-java-driver/downloads</a></p>
<p><a href="http://api.mongodb.org/java/2.8.0/com/mongodb/MongoOptions.html#autoConnectRetry">http://api.mongodb.org/java/2.8.0/com/mongodb/MongoOptions.html#autoConnectRetry</a></p>
