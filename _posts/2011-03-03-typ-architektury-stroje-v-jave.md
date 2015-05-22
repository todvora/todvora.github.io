---
layout: post
title: Typ architektury stroje v javě
date: '2011-03-03 13:17:09'
tags:
- java
- architektura
- 64bit
- 32bit
---

Jak poznat, zda stroj běží na 32bit nebo 64bit architektuře
v javě.


<p>V zásadě by se takové rozlišování nemělo používat, ale pokud
už vyloženě potřebujeme využívat nějaké konkrétní binární
ovladače/knihovny/software, občas je nutné vědět, která architektura
stojí pod JVM.</p>

<pre><code>package com.ivitera.examples;

public class ArchitectureDetection {
    public static void main(String[] args) {
        // http://www.oracle.com/technetwork/java/hotspotfaq-138619.html#64bit_detection
        //
        //There's no public API that allows you to distinguish between 32 and 64-bit
        // operation.  Think of 64-bit as just another platform in the write once,
        // run anywhere tradition.  However, if you'd like to write code which is
        // platform specific (shame on you),
        // the system property sun.arch.data.model has the value "32", "64", or "unknown".
        String architecture = System.getProperty("sun.arch.data.model");
        System.out.println("Current architecture: " + architecture);
    }
}</code></pre>

<p><strong>Výstup:</strong></p>

<pre><code>Current architecture: 32</code></pre>

<hr />

<p>Inspirováno FAQ: <a
href="http://www.oracle.com/technetwork/java/hotspotfaq-138619.html#64bit_detection">http://www.oracle.com/technetwork/java/hotspotfaq-138619.html#64bit_detection</a></p>

