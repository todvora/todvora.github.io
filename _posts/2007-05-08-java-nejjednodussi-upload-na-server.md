---
layout: post
title: Java - nejjednodušší upload na server
date: '2007-05-08 14:10:03'
tags:
- java
- upload
- html
- jsp
---

Jednoduchý příklad jak pomocí HTML formuláře a JSP stránky uploadovat
soubor na server a uložit ho tam


<p>HTML formulář, stránka která umožní vybrat který soubor odeslat,</p>

<pre><code>&lt;form action=&quot;upload.jsp&quot; method=&quot;post&quot;
enctype=&quot;multipart/form-data&quot;&gt;
&lt;input name=&quot;soubor&quot; type=&quot;file&quot; /&gt;
&lt;input type=&quot;submit&quot; value=&quot;ulozit&quot;  /&gt;
&lt;/form&gt;</code></pre>

<hr />

<p>A nyní obsah JSP stránky:</p>

<div></div>

<pre><code>&lt;%@ page import=&quot;java.io.*&quot; %&gt;

&lt;%
String contentType = request.getContentType();
System.out.println(&quot;Content type is :: &quot; +contentType);
if ((contentType != null) &amp;&amp; (contentType.indexOf(&quot;multipart/form-data&quot;) &gt;= 0)) {
DataInputStream in = new DataInputStream(request.getInputStream());
int formDataLength = request.getContentLength();

byte dataBytes[] = new byte[formDataLength];
int byteRead = 0;
int totalBytesRead = 0;
while (totalBytesRead &lt; formDataLength) {
byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
totalBytesRead += byteRead;
}
String cesta=&quot;webapps/ROOT/img/banners/&quot;;
String file = new String(dataBytes);
String saveFile = file.substring(file.indexOf(&quot;filename=\&quot;&quot;) + 10);
saveFile = saveFile.substring(0, saveFile.indexOf(&quot;\n&quot;));
saveFile = saveFile.substring(saveFile.lastIndexOf(&quot;\\&quot;) + 1,saveFile.indexOf(&quot;\&quot;&quot;));

//out.print(dataBytes);

int lastIndex = contentType.lastIndexOf(&quot;=&quot;);
String boundary = contentType.substring(lastIndex + 1,contentType.length());
//out.println(boundary);
int pos;
pos = file.indexOf(&quot;filename=\&quot;&quot;);

pos = file.indexOf(&quot;\n&quot;, pos) + 1;

pos = file.indexOf(&quot;\n&quot;, pos) + 1;

pos = file.indexOf(&quot;\n&quot;, pos) + 1;


int boundaryLocation = file.indexOf(boundary, pos) - 4;
int startPos = ((file.substring(0, pos)).getBytes()).length;
int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

FileOutputStream fileOut = new FileOutputStream(cesta+saveFile);


//fileOut.write(dataBytes);
fileOut.write(dataBytes, startPos, (endPos - startPos));
fileOut.flush();
fileOut.close();

out.println(&quot;File saved as &quot; +saveFile);

}
%&gt;</code></pre>

<hr />

<p>Nazev souboru si jsp stánka nastaví sama,cesta je dána v proměnné
cesta.
<br />Jenodušší to ani snad být nemuže</p>

<p>Návod nalezen na <a
href="http://forums.codecharge.com/posts.php?post_id=44078">tomto fóru</a></p>

