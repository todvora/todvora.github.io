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

<pre class="prettyprint"><code><form action="upload.jsp" method="post"
enctype="multipart/form-data">
<input name="soubor" type="file" />
<input type="submit" value="ulozit"  />
</form></code></pre>

<hr />

<p>A nyní obsah JSP stránky:</p>

<div></div>

<pre class="prettyprint"><code><%@ page import="java.io.*" %>

<%
String contentType = request.getContentType();
System.out.println("Content type is :: " +contentType);
if ((contentType != null) && (contentType.indexOf("multipart/form-data") >= 0)) {
DataInputStream in = new DataInputStream(request.getInputStream());
int formDataLength = request.getContentLength();

byte dataBytes[] = new byte[formDataLength];
int byteRead = 0;
int totalBytesRead = 0;
while (totalBytesRead < formDataLength) {
byteRead = in.read(dataBytes, totalBytesRead, formDataLength);
totalBytesRead += byteRead;
}
String cesta="webapps/ROOT/img/banners/";
String file = new String(dataBytes);
String saveFile = file.substring(file.indexOf("filename=\"") + 10);
saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,saveFile.indexOf("\""));

//out.print(dataBytes);

int lastIndex = contentType.lastIndexOf("=");
String boundary = contentType.substring(lastIndex + 1,contentType.length());
//out.println(boundary);
int pos;
pos = file.indexOf("filename=\"");

pos = file.indexOf("\n", pos) + 1;

pos = file.indexOf("\n", pos) + 1;

pos = file.indexOf("\n", pos) + 1;


int boundaryLocation = file.indexOf(boundary, pos) - 4;
int startPos = ((file.substring(0, pos)).getBytes()).length;
int endPos = ((file.substring(0, boundaryLocation)).getBytes()).length;

FileOutputStream fileOut = new FileOutputStream(cesta+saveFile);


//fileOut.write(dataBytes);
fileOut.write(dataBytes, startPos, (endPos - startPos));
fileOut.flush();
fileOut.close();

out.println("File saved as " +saveFile);

}
%></code></pre>

<hr />

<p>Nazev souboru si jsp stánka nastaví sama,cesta je dána v proměnné
cesta.
<br />Jenodušší to ani snad být nemuže</p>

<p>Návod nalezen na <a
href="http://forums.codecharge.com/posts.php?post_id=44078">tomto fóru</a></p>

