---
layout: post
title: postgreSQL - jak získat názvy sloupců tabulky
date: '2008-02-13 17:59:45'
tags:
- postgresql
- java
- databáze
- select
---

Jednoduchý způsob zjištění a zpracování názvů sloupců tabulky


<p>Občas se hodí znát názvy sloupců tabulky, nejčastěji pro další
použití a zpracování dat z databáze. Jednoduchou možností jak to
zařídít je tento sql dotaz:</p>

<pre><code>"SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns WHERE
TABLE_NAME = 'nazev_tabulky'&quot;;</code></pre>

<p>a celý kód pro zpracování tohoto dotazu:</p>

<pre><code>Class.forName(&quot;org.postgresql.Driver&quot;);
String dbUri = &quot;jdbc:postgresql://&quot; + &quot;localhost&quot; + &quot;/&quot;
                                + &quot;databaze&quot; + &quot;?user=&quot; + &quot;uzivatel&quot;
                                +&quot;&amp;password=&quot; + &quot;heslo&quot; +
                                 &quot;&amp;characterEncoding=cp1250&quot;;
 Connection con = DriverManager.getConnection(dbUri);
Statement s = con.createStatement();
String sql = &quot;SELECT COLUMN_NAME FROM
                     INFORMATION_SCHEMA.Columns WHERE
                     TABLE_NAME = 'nazev_tabulky'&quot;;
              ResultSet rs = s.executeQuery(sql);
              while (rs.next()) {
                System.out.println(rs.getString(1));
       }
rs.close();
s.close();
 con.close();</code></pre>

