---
layout: post
title: Assembler
date: '2007-05-08 09:02:54'
tags:
- assembler
---

V zadaném řetězci program určí počty slov se stejnou délkou.
Počty uloží do paměti v desítkové soustavě.


<p><strong>zadání:</strong> V zadaném řetězci program určí počty
slov se stejnou délkou. Počty uloží do paměti v desítkové
soustavě.
<br /><strong>rozbor:</strong> Vzhledem k tomu,že procesor H8S od
renesas,pro který má být úloha realizována,má pouze 7 24bitových
registrů, je třeba vymyslet jak s nimi naložit. Rozložil jsem je
takto:</p>

<ul>
	<li>Zásobník není třeba, registr ER7 si nechám na pomocné proměnné</li>

	<li>registry ER1-ER5 použiji k ukládání počtu slov délky
	1,2,..,9,10 a více</li>

	<li>registr R6L použiji pro uchování příznaku,zda je již konec řetězce a
	program má připočíst poslední slovo a skončit.</li>
</ul>

<p><strong>zde je samotný kód programu:</strong></p>

<p>.h8300s</p>

<p>.data ; začátek datové sekce
<br />TEXT: .asciz „q q q q q q q q q q Qqq qq QQ QQQQ“
<br />VAR1: .space 1
<br />VAR2: .space 1
<br />VAR3: .space 1
<br />VAR4: .space 1
<br />VAR5: .space 1
<br />VAR6: .space 1
<br />VAR7: .space 1
<br />VAR8: .space 1
<br />VAR9: .space 1
<br />VAR10: .space 1
<br />.text ; začátek kódové sekce
<br />.global _start ; _start je globální návěští</p>

<p>_start:
<br />MOV.L #TEXT, ER0 ;presunu odkaz na zacatek textu
<br />xor.l ER7,ER7 ;vymazu registru pro ukladani poctu..
<br />xor.l ER1,ER1
<br />xor.l ER2,ER2
<br />xor.l ER3,ER3
<br />xor.l ER4,ER4
<br />xor.l ER5,ER5
<br />xor.l ER6,ER6
<br />smycka: MOV.B @ER0, R7H ;nactu prvni znak
<br />CMP.B #0, R7H ;kdyz je to znak konce textu
<br />BEQ FINALIZE
<br />CMP.B #' ', R7H ;kdyz je to znak mezery
<br />BEQ ULOZ ;tak je cas ulozit to
<br />add.b #1,R7L ;pridame jednicku k pocitadlu</p>

<p>INC.L #1, ER0 ;posuneme ukazatel ER0 na dalsi znak
<br />BRA smycka</p>

<p>ULOZ: CMP.B #1, R7L
<br />BEQ JEDNA
<br />CMP.B #2, R7L
<br />BEQ DVA
<br />CMP.B #3, R7L
<br />BEQ TRI
<br />CMP.B #4, R7L
<br />BEQ CTYRI
<br />CMP.B #5, R7L
<br />BEQ PET
<br />CMP.B #6, R7L
<br />BEQ SEST
<br />CMP.B #7, R7L
<br />BEQ SEDM
<br />CMP.B #8, R7L
<br />BEQ OSM
<br />CMP.B #9, R7L
<br />BEQ DEVET
<br />CMP.B #9, R7L
<br />BHI VIC
<br />BRA KON</p>

<p>JEDNA: add.b #1,R1L
<br />bra REINI
<br />DVA: add.b #1,R1H
<br />bra REINI
<br />TRI: add.b #1,R2L
<br />bra REINI
<br />CTYRI: add.b #1,R2H
<br />bra REINI
<br />PET: add.b #1,R3L
<br />bra REINI
<br />SEST: add.b #1,R3H
<br />bra REINI
<br />SEDM: add.b #1,R4L
<br />bra REINI
<br />OSM: add.b #1,R4H
<br />bra REINI
<br />DEVET: add.b #1,R5L
<br />bra REINI
<br />VIC: add.b #1,R5H
<br />bra REINI</p>

<p>REINI: CMP.B #1, R6L
<br />BEQ COPYTOMEM
<br />xor.b R7L,R7L
<br />INC.L #1, ER0
<br />bra smycka</p>

<p>FINALIZE: mov.b #1,R6L
<br />bra ULOZ</p>

<p>COPYTOMEM:
<br />mov.b R1L,@VAR1
<br />mov.b R1H,@VAR2
<br />mov.b R2L,@VAR3
<br />mov.b R2H,@VAR4
<br />mov.b R3L,@VAR5
<br />mov.b R3H,@VAR6
<br />mov.b R4L,@VAR7
<br />mov.b R4H,@VAR8
<br />mov.b R5L,@VAR9
<br />mov.b R5H,@VAR10
<br />bra KON</p>

<p>KON: bra KON ; nekonečná smyčka na konci
<br />.end</p>

