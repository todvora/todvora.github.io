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
<p><img src="http://www.tomas-dvorak.cz/images/304t.png" alt="Obchodní rejstřík a Sbírka listin - Ministerstvo spravedlnosti České republiky" width="500" height="106" /></p>
<p>Limity pro přístupy jsou přísně nastaveny jak u <a href="http://wwwinfo.mfcr.cz/ares/ares.html.cz">ARESu</a>, tak u <a href="https://or.justice.cz/ias/ui/podminky">justice.cz</a>. U justice jde o 3000 dotazů denně / 50 za minutu. Není to moc, ale pro nějakou menší aplikaci, kde jde o rychlou odezvu a požadavků není moc to stačí. </p>
<p>Hlavním důvodem pro nevyužití ARESu je tedy jeho velmi pomalá odezva. Tam, kde justice vrací data za desítky milisekund, ARES přemýšlí několik sekund (aktuálně okolo 3s, někdy i půl minuty, zřejmě podle zátěže). </p>
<p> </p>
<p>Srovnejte sami:</p>
<p><strong>ARES</strong>: <a href="http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_std.cgi?czk=utf&max_pocet=10&obchodni_firma=Seznam">http://wwwinfo.mfcr.cz/cgi-bin/ares/darv_std.cgi?czk=utf&max_pocet=10&obchodni_firma=Seznam</a></p>
<p><img src="http://www.tomas-dvorak.cz/images/306t.png" alt="Doba odezvy API ARESu" width="500" height="45" /></p>
<p><strong>JUSTICE</strong>: <a href="https://or.justice.cz/ias/ui/rejstrik-dotaz?dotaz=Seznam">https://or.justice.cz/ias/ui/rejstrik-dotaz?dotaz=Seznam</a></p>
<p><img src="http://www.tomas-dvorak.cz/images/305t.png" alt="Doba odezvy webu justice.cz" width="500" height="45" /></p>
<div> </div>
<div>Napsal jsem si tedy vlastní kód na parsování dat z justice a chtěl bych vám jej poskytnout. Není dokonalý, nejspíš jde napsat lépe, ale o to teď nejde. Funguje dobře a data poskytuje rychle. V našeptavači je to v pohodě použitelné. </div>
<div>
<h2>Node.js implementace parsování webu justice (<a href="https://npmjs.org/package/request">request</a> + <a href="https://npmjs.org/package/cheerio">cheerio</a>)</h2>
<p>Pokud neznáte cheerio, jde o populární serverovou implementaci jQuery. Můžete tak velmi snadno využívat jQuery metody pro práci s DOMem. Více o cheeriu třeba na <a href="https://github.com/MatthewMueller/cheerio">github repozitáři</a>.</p>
<pre class="prettyprint">var request = require('request');
var cheerio = require('cheerio');

function getData(companyName, callback) {
    request("https://or.justice.cz/ias/ui/rejstrik-dotaz?dotaz=" + encodeURIComponent(companyName), function (error, response, body) {
        if (!error && response.statusCode == 200) {
            var results = [];
            $ = cheerio.load(body);
            $(".search-results li.result").each(function (i, elem) {
                var company = {};
                $(elem).find("th").each(function (j, cell) {
                    var key = $(cell).text().trim();
                    company[key] = $(cell).next().text().trim();
                });
                results.push(company);
            });
            callback(results);
        } 
    });
}

getData("Seznam", function(data) {
    console.log(data);
});</pre>
</div>
<div> </div>
<p>Výstupem scriptu pak je:</p>
<pre class="prettyprint">[ { 'Název subjektu:': 'Seznam.cz, a.s.',
    'Identifikační číslo:': '261 68 685',
    'Spisová značka:': 'B 6493 vedená u Městského soudu v Praze',
    'Den zápisu:': '05.04.2000',
    'Sídlo:': 'Praha 5 - Smíchov, Radlická 3294/10, PSČ 150 00' },
  { 'Název subjektu:': 'Seznam.cz datová centra, s.r.o.',
    'Identifikační číslo:': '016 73 408',
    'Spisová značka:': 'C 209831 vedená u Městského soudu v Praze',
    'Den zápisu:': '15.05.2013',
    'Sídlo:': 'Radlická 3294/10, Smíchov, 150 00 Praha 5' },
  { 'Název subjektu:': 'Seznámení, s.r.o.',
    'Identifikační číslo:': '293 87 108',
    'Spisová značka:': 'C 38117 vedená u Krajského soudu v Ostravě',
    'Den zápisu:': '29.09.2011',
    'Sídlo:': 'Ostrava - Moravská Ostrava, Nádražní 3113/128, PSČ 702 00' },
  { 'Název subjektu:': 'Seznam firem s.r.o.',
    'Identifikační číslo:': '292 82 934',
    'Spisová značka:': 'C 70854 vedená u Krajského soudu v Brně',
    'Den zápisu:': '10.06.2011',
    'Sídlo:': 'Brno, Příční 118/10, PSČ 602 00' } ]
</pre>
<p> </p>
<h2>Java implementace (<a href="http://nekohtml.sourceforge.net/faq.html">nekoHTML</a> parser)</h2>
<div>Implementace zdaleka nedosahuje lehkosti javascriptu pro node, funguje ale stejně a vrací stejná data. Dalo by se to napsat úsporněji, využít nějaké další knihovny a podobně, to ale není smyslem článku. Ukázka alespoň demonstruje lehkost javascriptu a těžkopádnost javy. I proto je zřejmě node.js tak populární. </div>
<div> </div>
<pre class="prettyprint">import org.cyberneko.html.parsers.DOMParser;
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

    public static List<Map<String, String>> getFromJusticeCz(String query) throws Exception {
        String url = "https://or.justice.cz/ias/ui/rejstrik-dotaz?dotaz=" + URLEncoder.encode(query, "UTF-8");
        DOMParser parser = new DOMParser(); //see http://nekohtml.sourceforge.net/faq.html
        InputStream stream = new URL(url).openStream();
        parser.parse(new InputSource(new InputStreamReader(stream, "utf-8")));
        Document doc = parser.getDocument();
        NodeList tables = doc.getElementsByTagName("table");
        List<Map<String, String>> data = new ArrayList<Map<String, String>>();
        for (int i = 0; i < tables.getLength(); i++) {
            Node item = tables.item(i);
            Node cssClass = item.getAttributes().getNamedItem("class");
            if (cssClass != null && cssClass.getNodeValue().contains("result-details")) {
                NodeList subnodes = item.getChildNodes();
                for (int j = 0; j < subnodes.getLength(); j++) {
                    Node subnode = subnodes.item(j);
                    if ("TBODY".equals(subnode.getNodeName())) {
                        Map<String, String> company = new HashMap<String, String>();
                        NodeList companyNodes = subnode.getChildNodes();
                        for (int k = 0; k < companyNodes.getLength(); k++) {
                            String key = null;
                            String value = null;
                            Node row = companyNodes.item(k);
                            NodeList cells = row.getChildNodes();
                            for (int m = 0; m < cells.getLength(); m++) {
                                Node cell = cells.item(m);
                                if ("TH".equals(cell.getNodeName())) {
                                    key = cell.getTextContent();
                                    key = key.trim();
                                    key = key.substring(0, key.length() - 1);
                                }
                                if ("TD".equals(cell.getNodeName())) {
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
        System.out.println(getFromJusticeCz("Seznam"));
    }
}

</pre>
<h2>Pro zajímavost</h2>
<p>Nakonec, pro zajímavost, jak se optimalizuje výkon takového API ARESu. Cituji z <a href="http://wwwinfo.mfcr.cz/ares/ares_xml_get.html.cz">dokumentace</a>.</p>
<blockquote>Výstupy jsou uváděny buď v plné verzi, tj. plnými názvy elementů, nebo úsporné ve zkratkách (parametr ver). Implicitně jsou nastaveny u jednotlivých výstupů úsporné verze, protože šetří přenosové linky.</blockquote>
<p>Nikoho už ale nenapadlo vracet data <a href="http://httpd.apache.org/docs/2.2/mod/mod_deflate.html">gzipovaná</a>. To by teprve byla znatelná úspora linky :-)</p>
<p><img src="http://www.tomas-dvorak.cz/images/307t.png" alt="Hlavičky ARESu%2C žádný gzip není aktivován" width="500" height="270" /></p>
