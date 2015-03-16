---
layout: post
title: Jazyk C - linux - system("pause");
date: '2008-03-04 10:01:43'
tags:
- jazyk C
---

Náhrada system(„pause“) v linuxech za cyklus
s podmínkou


<p>Ve školních příkladech se často na konci metody main nachází
volání</p>

<pre><code>system("pause");</code></pre>

<p>což způsobí zastavení běhu programu a umožní užívateli přečíst si
co program vytiskl do konzole, a čeká na stisk klávesy.</p>

<p>Ale protože funkce system je vázaná na operační systém, v linuxech
toto fungovat nebude. Stejnou funkci však vykoná tento jednoduchý cyklus:</p>

<pre><code>while(getchar()!='\n')
;</code></pre>

<p>A nejlépe bude funkce vidět na celém příkladu:</p>

<pre><code>#include <stdio.h>
#include <stdlib.h>

int main(int argc, char *argv[]){
    printf("%s\n","ahoj");
    pause();
    return 0;
}

pause(){
    printf("%s","\n");
    printf("%s","stisknete klavesu ENTER");
    while(getchar()!='\n')
        ;
}</code></pre>

<p>Kde cyklus přesuneme do funkce pause, která vypíše hlášku a bude čekat
na stisk Enteru. tím docílíme v podstatě stejné funkčnosti</p>

