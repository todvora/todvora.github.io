---
layout: post
title: Načítání dat z obchodního rejstříku justice.cz
date: '2013-05-23 09:35:03'
tags:
- justice.cz
- ares
- node.js
- cheerio
- java
---
Pracujete automatizovaně s daty firem? Jméno, IČ, sídlo firmy? Pak určitě znáte API ARESu. Má hodně funkcí a velkou odezvu. Tak velkou, že jsem pro našeptavač musel začít brát data jinde, aby byl použitelný.

<p>API ARESu (Administrativní registr ekonomických subjektů) je pěkně <a href="http://wwwinfo.mfcr.cz/ares/ares.html.cz">dokumentované</a>, má bohaté možnosti a funguje poměrně spolehlivě. Na druhou stranu je tak pomalé, že nad ním našeptavač nepostavíte. A když postavíte, budete čekat a vaše uživatele akorát naštvete. </p>
<p>Rozhodl jsem se tedy data o firmách brát jinde. Konkrétně na webu <a href="https://or.justice.cz/ias/ui/rejstrik-rozsirene">justice.cz</a>. V mém případě mi stačí název firmy, IČ a adresa. Všechny tyto hodnoty justice obsahuje. Web justice bohužel nemá žádné API (hezky se o tom rozepsal <a href="http://blog.aktualne.centrum.cz/blogy/michal-skop.php?itemid=15872">Michal Škop na svém blogu</a>). Co bychom chtěli za <a href="http://aktualne.centrum.cz/ekonomika/podnikani/clanek.phtml?id=736767">80 milionů</a> (cena je za celý systém, web <a href="http://or.justice.cz">or.justice.cz</a> je jen jedna z mnoha částí). Bude tak nutné parsovat HTML výstup.</p>
<p><img src="/images/304.png" alt="Obchodní rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky" width="500" height="106" /></p>
<p>Limity pro přístupy jsou přísně nastaveny jak u <a href="http://wwwinfo.mfcr.cz/ares/ares.html.cz">ARESu</a>, tak u <a href="https://or.justice.cz/ias/ui/podminky">justice.cz</a>. U justice jde o 3000 dotazů denně / 50 za minutu. Není to moc, ale pro nějakou menší aplikaci, kde jde o rychlou odezvu a požadavků není moc to stačí. </p>
<p>Hlavním důvodem pro nevyužití ARESu je tedy jeho velmi pomalá odezva. Tam, kde justice vrací data za desítky milisekund, ARES přemýšlí několik sekund (aktuálně okolo 3s, někdy i půl minuty, zřejmě podle zátěže). </p>
<p> </p>
<p>Srovnejte sami:</p>
<p><strong>ARES</strong>: <a href="http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_std.cgi?czk=utf&amp;max_pocet=10&amp;obchodni_firma=Seznam">http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_std.cgi?czk=utf&amp;max_pocet=10&amp;obchodni_firma=Seznam</a></p>
<p><img src="/images/306.png" alt="Doba odezvy API ARESu" width="500" height="45" /></p>
<p><strong>JUSTICE</strong>: <a href="https://or.justice.cz/ias/ui/rejstrik-dotaz?dotaz=Seznam">https://or.justice.cz/ias/ui/rejstrik-dotaz?dotaz=Seznam</a></p>
<p><img src="/images/305.png" alt="Doba odezvy webu justice.cz" width="500" height="45" /></p>

<div>Napsal jsem si tedy vlastní kód na parsování dat z justice a chtěl bych vám jej poskytnout. Není dokonalý, nejspíš jde napsat lépe, ale o to teď nejde. Funguje dobře a data poskytuje rychle. V našeptavači je to v pohodě použitelné. </div>
<div>
<h2>Node.js implementace parsování webu justice (<a href="https://npmjs.org/package/request">request</a> + <a href="https://npmjs.org/package/cheerio">cheerio</a>)</h2>
<p>Pokud neznáte cheerio, jde o populární serverovou implementaci jQuery. Můžete tak velmi snadno využívat jQuery metody pro práci s DOMem. Více o cheeriu třeba na <a href="https://github.com/MatthewMueller/cheerio">github repozitáři</a>.</p>
<pre>var request = require('request');
var cheerio = require('cheerio');

function getData(companyName, callback) {
    request(&quot;https://or.justice.cz/ias/ui/rejstrik-dotaz?dotaz=&quot; + encodeURIComponent(companyName), function (error, response, body) {
        if (!error &amp;&amp; response.statusCode == 200) {
            var results = [];
            $ = cheerio.load(body);
            $(&quot;.search-results li.result&quot;).each(function (i, elem) {
                var company = {};
                $(elem).find(&quot;th&quot;).each(function (j, cell) {
                    var key = $(cell).text().trim();
                    company[key] = $(cell).next().text().trim();
                });
                results.push(company);
            });
            callback(results);
        } 
    });
}

getData(&quot;Seznam&quot;, function(data) {
    console.log(data);
});</pre>
</div>

<p>Výstupem scriptu pak je:</p>
<pre>[ { 'N&aacute;zev subjektu:': 'Seznam.cz, a.s.',
    'Identifika&#269;n&iacute; &#269;&iacute;slo:': '261&nbsp;68&nbsp;685',
    'Spisov&aacute; zna&#269;ka:': 'B 6493 veden&aacute; u M&#283;stsk&eacute;ho soudu v Praze',
    'Den z&aacute;pisu:': '05.04.2000',
    'S&iacute;dlo:': 'Praha 5 - Sm&iacute;chov, Radlick&aacute; 3294/10, PS&#268;&nbsp;150&nbsp;00' },
  { 'N&aacute;zev subjektu:': 'Seznam.cz datov&aacute; centra, s.r.o.',
    'Identifika&#269;n&iacute; &#269;&iacute;slo:': '016&nbsp;73&nbsp;408',
    'Spisov&aacute; zna&#269;ka:': 'C 209831 veden&aacute; u M&#283;stsk&eacute;ho soudu v Praze',
    'Den z&aacute;pisu:': '15.05.2013',
    'S&iacute;dlo:': 'Radlick&aacute;&nbsp;3294/10, Sm&iacute;chov, 150&nbsp;00 Praha 5' },
  { 'N&aacute;zev subjektu:': 'Sezn&aacute;men&iacute;, s.r.o.',
    'Identifika&#269;n&iacute; &#269;&iacute;slo:': '293&nbsp;87&nbsp;108',
    'Spisov&aacute; zna&#269;ka:': 'C 38117 veden&aacute; u Krajsk&eacute;ho soudu v Ostrav&#283;',
    'Den z&aacute;pisu:': '29.09.2011',
    'S&iacute;dlo:': 'Ostrava - Moravsk&aacute; Ostrava, N&aacute;dra&#382;n&iacute; 3113/128, PS&#268;&nbsp;702&nbsp;00' },
  { 'N&aacute;zev subjektu:': 'Seznam firem s.r.o.',
    'Identifika&#269;n&iacute; &#269;&iacute;slo:': '292&nbsp;82&nbsp;934',
    'Spisov&aacute; zna&#269;ka:': 'C 70854 veden&aacute; u Krajsk&eacute;ho soudu v Brn&#283;',
    'Den z&aacute;pisu:': '10.06.2011',
    'S&iacute;dlo:': 'Brno, P&#345;&iacute;&#269;n&iacute; 118/10, PS&#268;&nbsp;602&nbsp;00' } ]
</pre>
<p> </p>
<h2>Java implementace (<a href="http://nekohtml.sourceforge.net/faq.html">nekoHTML</a> parser)</h2>
<div>Implementace zdaleka nedosahuje lehkosti javascriptu pro node, funguje ale stejně a vrací stejná data. Dalo by se to napsat úsporněji, využít nějaké další knihovny a podobně, to ale není smyslem článku. Ukázka alespoň demonstruje lehkost javascriptu a těžkopádnost javy. I proto je zřejmě node.js tak populární. </div>

<pre>import org.cyberneko.html.parsers.DOMParser;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Justice {

    public static List&lt;Map&lt;String, String&gt;&gt; getFromJusticeCz(String query) throws Exception {
        String url = &quot;https://or.justice.cz/ias/ui/rejstrik-dotaz?dotaz=&quot; + URLEncoder.encode(query, &quot;UTF-8&quot;);
        DOMParser parser = new DOMParser(); //see http://nekohtml.sourceforge.net/faq.html
        InputStream stream = new URL(url).openStream();
        parser.parse(new InputSource(new InputStreamReader(stream, &quot;utf-8&quot;)));
        Document doc = parser.getDocument();
        NodeList tables = doc.getElementsByTagName(&quot;table&quot;);
        List&lt;Map&lt;String, String&gt;&gt; data = new ArrayList&lt;Map&lt;String, String&gt;&gt;();
        for (int i = 0; i &lt; tables.getLength(); i++) {
            Node item = tables.item(i);
            Node cssClass = item.getAttributes().getNamedItem(&quot;class&quot;);
            if (cssClass != null &amp;&amp; cssClass.getNodeValue().contains(&quot;result-details&quot;)) {
                NodeList subnodes = item.getChildNodes();
                for (int j = 0; j &lt; subnodes.getLength(); j++) {
                    Node subnode = subnodes.item(j);
                    if (&quot;TBODY&quot;.equals(subnode.getNodeName())) {
                        Map&lt;String, String&gt; company = new HashMap&lt;String, String&gt;();
                        NodeList companyNodes = subnode.getChildNodes();
                        for (int k = 0; k &lt; companyNodes.getLength(); k++) {
                            String key = null;
                            String value = null;
                            Node row = companyNodes.item(k);
                            NodeList cells = row.getChildNodes();
                            for (int m = 0; m &lt; cells.getLength(); m++) {
                                Node cell = cells.item(m);
                                if (&quot;TH&quot;.equals(cell.getNodeName())) {
                                    key = cell.getTextContent();
                                    key = key.trim();
                                    key = key.substring(0, key.length() - 1);
                                }
                                if (&quot;TD&quot;.equals(cell.getNodeName())) {
                                    value = cell.getTextContent().trim();
                                    company.put(key, value);
                                }
                            }
                        }
                        data.add(company);
                    }
                }
            }
        }
        stream.close();
        return data;
    }

    public static void main(String[] args) throws Exception {
        System.out.println(getFromJusticeCz(&quot;Seznam&quot;));
    }
}

</pre>
<h2>Pro zajímavost</h2>
<p>Nakonec, pro zajímavost, jak se optimalizuje výkon takového API ARESu. Cituji z <a href="http://wwwinfo.mfcr.cz/ares/ares_xml_get.html.cz">dokumentace</a>.</p>
<blockquote>Výstupy jsou uváděny buď v plné verzi, tj. plnými názvy elementů, nebo úsporné ve zkratkách (parametr ver). Implicitně jsou nastaveny u jednotlivých výstupů úsporné verze, protože šetří přenosové linky.</blockquote>
<p>Nikoho už ale nenapadlo vracet data <a href="http://httpd.apache.org/docs/2.2/mod/mod_deflate.html">gzipovaná</a>. To by teprve byla znatelná úspora linky :-)</p>
<p><img src="/images/307.png" alt="Hlavičky ARESu%2C žádný gzip není aktivován" width="500" height="270" /></p>
