---
layout: post
title: Java i18n taglibs a databázový backend
date: '2008-01-31 09:03:42'
tags:
- i18n
- taglibs
- jsp
- databáze
- backend
---

Jednoduchý návod, jak používat i18n taglibs spolu s ukládáním
překladů v databázové tabulce a nikoli v .properties souborech.


<p>Před nějakou dobou jsem sháněl na internetu návod jak sprovoznit
překládání stránek jsp pomocí i18n(zkratka anglického
Internationali­zation) taglibu tak,že se překlady budou nacházet
v databázi,a ne v .properties souboru, tak jak je to standartně.</p>

<p>Nevýhodou těchto souborů je jejich špatná editovatelnost (špatně
dostupné při editaci přes internet), nutnost převádění na ascii
kódování, nezaznamenávání výrazů, které jsou použity na stránkých
ale nejsou přeloženy…</p>

<p>Oproti tomu výhody ukládání slovníku jsou zřejmé, snadné vytvoření
editačního rozhraní, při chybějícím překladu se prostě slovo zanese do
databáze a čeká na přeložení, všechny překlady na jediném místě,ne
v několika souborech.</p>

<p>Problém je to, že pokud chceme jako backend používat databázi,je třeba
provést několik kroků:</p>

<ol>
	<li>vytvoření vhodné tabulky v databázi</li>

	<li>Vytvoření třídy Dictionary, která se stará a práci s databází,
	generuje HashMapu s překladem do daného jazyka,a vkládá slovo do
	databáze,pokud v ní nebylo nalezeno</li>

	<li>Vytvoření třídy mujResource rozšiřující třídu
	java.util.Resou­rceBundle</li>

	<li>Nastavení jsp stránek tak, aby používaly náš resourceBundle</li>

	<li>Zbytek je standartní a stejný, tak jako při použití .properties
	souborů</li>

	<li>Přepínání jazyků proměnnou v session</li>
</ol>

<p><strong>1) Tabulka Translate v databázi</strong>
<br />Vzhledem k tomu, že překladový klíč musí být unikátní,
ideální je použít ho i jako primary key v tabulce, zajistí se tak
jeho unikátnost, stejně tak jako optimalizace při vyhledávání
v tabulce podle klíče překladu
<br />Struktura tabulky by pak mohla být</p>

<table>
	<tr>
		<td>- varchar(50) -</td>

		<td>– text -</td>

		<td>– text -</td>

		<td>– text -</td>
	</tr>

	<tr>
		<td>– key -</td>

		<td>– cs -</td>

		<td>– en -</td>

		<td>– de -</td>
	</tr>
</table>

<p>tedy pro každý jazyk bude jeden sloupec v tabulce</p>

<p><strong>2) Třída Dictionary</strong>
<br />Má na starosti práci se samotnou databází a generování hashMapy
slovník.</p>

<pre class="prettyprint"><code>import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

public class Dictionary {

    String machine;
    String db;
    String user;
    String pass;
    String dbUri;
    HashMap slovnik;
    String lang;
    public final String not_found = "NOT TRANSLATED";

    public Dictionary(String lang) {

        slovnik = new HashMap();
        this.machine = "localhost";
        this.db = "databaze";
        this.user = "uzivatel";
        this.pass = "heslo";
        this.dbUri = "jdbc:postgresql://" + machine + "/" + db +
"?user=" + user + "&password=" + pass +
"&characterEncoding=utf-8";
        this.lang = lang;
        Load();
    }

    private void Load() {
        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUri);
            Statement s = con.createStatement();
            String sql = "SELECT key, " + lang + " FROM \"Translate\"";
            ResultSet rs = s.executeQuery(sql);
            while (rs.next()) {
                slovnik.put((String) rs.getString("key"), (String) rs.getString(lang));
            }
            rs.close();
            s.close();
            con.close();
        } catch (Exception e) {
            System.out.println("Load:"+e.toString());
        }
    }

    public HashMap getDictionary() {
        return this.slovnik;
    }

    public boolean isKeyInDB(String key){
        int pocet=0;
          try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUri);
            Statement s = con.createStatement();
            String sql = "SELECT COUNT(*) FROM \"Translate\" WHERE key='"+key+"'";
            ResultSet rs = s.executeQuery(sql);
            rs.next();
            pocet=rs.getInt("count");
            rs.close();
            s.close();
            con.close();
        } catch (Exception e) {
            System.out.println("isKeyInDB:"+e.toString());
        }
        if(pocet>0){
            return true;
        }else{
            return false;
        }
    }

    private ArrayList existingLanguages() {
        ArrayList languages=new ArrayList();
        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUri);
            Statement s = con.createStatement();
            String sql = "SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.Columns
 WHERE TABLE_NAME = 'Translate'";
            ResultSet rs = s.executeQuery(sql);
            rs.next();
            while (rs.next()) {
                languages.add((String) rs.getString(1));
            }
            rs.close();
            s.close();
            con.close();
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return languages;
    }

    public void putKey(String key) {
        if(!isKeyInDB(key)){
        try {
            Class.forName("org.postgresql.Driver");
            Connection con = DriverManager.getConnection(dbUri);
            Statement s = con.createStatement();
            String sql="INSERT INTO \"Translate\" (key) VALUES('"+key+"')";
            boolean rs = s.execute(sql);
            s.close();
            con.close();
        } catch (Exception e) {
            System.out.println("putKey:"+e.toString());
        }
      }
    }
}</code></pre>

<p>Takže popořádku, v konstruktoru vytvoříme spojení přes jdbc
s databází ( v příkladu postgreSQL). Nastavíme jazyk překladu,a
do hashMapy pomocí metody <em>Load()</em> načteme slovník ve tvaru
klíč-překlad. Pro pořádek, hashMapa neumožnuje duplicitní klíče, což
odpovídá našemu záměru vyhnout se duplicitám i v databázi).</p>

<p>Metoda <em>getDictionary()</em> vrátí hashMapu se slovníkem, tuto metodu
používá resourceBundle pro získání slovníku.</p>

<p>Metoda <em>isKeyInDB()</em> ověřuje,zda je klíč v databázi již
obsažen. Uvažujme následující situaci, v databázi máme slovo, které
má překlad v češtině,ale v angličtině dosud přeloženo nebylo,
Tedy resourceBundle ho nenajde ve slovníku, a pokusí se ho vložit do
databáze, protože si myslí že jej neobsahuje. Pokud ale slovo existuje,jen
ne v daném jazyce, databáze bude hlásit chybu,že daný klíč již
existuje, a není tedy možné ho vložit. Proto nejprve otestujeme zda již
klíč není obsažen, byť v jiném jazyce.</p>

<p>Metoda <em>existingLangu­ages()</em> vrací arrayList jazyků, které
jsou evidovány v databázi.</p>

<p>Poslední metodou je <em>putKey()</em> která je volána v případě
nenalezení klíče ve slovníku. Nejprve otestuje zda slovo není jen
nepřeloženo do daného jazyka, ale databáze již příslušný řádek
obsahuje, jinak ho vytvoří.</p>

<p>Třída slovník tedy nemá přímou návaznost na nternacionalizaci, je
pouze služební třídou pro pokračování.</p>

<p><strong>3) Vlastní resourceBundle</strong>
<br />Tato třída je velmi jednoduchá, pouze získá slovník od třídy
<em>Dictionary</em>, zjistí zda obsahuje slovník hledaný klíč, pokud ano,
vrátí ho jako String, jinak se pokusí uložit ho do databáze, a vrátí
konstantu značící, že text není přeložen.</p>

<pre class="prettyprint"><code>import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;

public class mujResource extends java.util.ResourceBundle{

    HashMap slovnik;
    String slovo="";
    Dictionary d;

    public mujResource() {
        d= new Dictionary("en");
        slovnik=d.getDictionary();

    }

    @Override
    protected Object handleGetObject(String key) {

        this.slovo=(String) this.slovnik.get(key);
        if(slovo!=null)
            return slovo;
        else{
            d.putKey(key);
            return d.not_found;
        }
    }

    @Override
    public Enumeration<String> getKeys() {
        throw new UnsupportedOperationException("Not supported yet.");
    }

}</code></pre>

<p>Zde nastává v zásadě nejvetší komplikace. Pro každý jazyk je
třeba vytvořit jednu takovou třídu, s volbou jazyka. třída
mujResource bude použita,v případě že se pokoušíme načíst řeč,
pro kterou překlad není nastaven, nebo pokud nelze použít jiný
vhodnější. Třída pro češtinu by se tedy měla jmenovat mujResource_cs,
pro angličtinu mujResource_en, pro němčinu mujResource_de, a podobně. Tyto
třídy je vytvoříme prostým skopírováním původní, a přejmenováním,
spolu s nahrazením jazyka v řádku
<br /><code>d= new Dictionary("en")</code>;
<br />kde „en“ nahradíme jazykem podle jména třídy.</p>

<p><strong>4) Nastavení JSP stránek</strong></p>

<p>Na začátek stránky vložíme kód:</p>

<pre class="prettyprint"><code><i18n:bundle baseName="translation.mujResource"
             localeRef="userLocale"
             scope="request"
             changeResponseLocale="true"

                         /></code></pre>

<p>Kde v atribudu baseName je cesta k dané standartní třídě
slovníku, v mém případě v balíčku translation</p>

<p>Pro kompletnost si uvedeme i jak si na stránce vyžádat překlad:</p>

<pre class="prettyprint"><code><i18n:message key="informace" /></code></pre>

<p>Pro běh tohoto taglibu je třeba ještě nastavit v web.xml cestu
k tld souboru</p>

<pre class="prettyprint"><code><taglib>
    <taglib-uri>http://jakarta.apache.org/taglibs/i18n-1.0</taglib-uri>
    <taglib-location>/WEB-INF/taglibs-i18n.tld</taglib-location>
  </taglib></code></pre>

<p>a ve složce lib mít uložen jar soubor <em>taglibs-i18n.jar</em></p>

<p><strong>6) Volba jazyků v aplikaci</strong>
<br />Jedna z možností je vytvořit servlet, který bude do session
ukládat proměnnou s názvem userLocale a její hodnotou dané locale,
např:</p>

<pre class="prettyprint"><code>session.setAttribute("userLocale",new Locale("cs","CZ"));</code></pre>

<p>Úryvek ze servletu:</p>

<pre class="prettyprint"><code>public void doGet(HttpServletRequest request,
           HttpServletResponse response)
           throws ServletException, IOException {
       request.setCharacterEncoding("UTF-8");
       response.setCharacterEncoding("UTF-8");

       HttpSession session = request.getSession();

      String lang = request.getParameter("language");
 if ( "en".equals(lang) )
   {
   session.setAttribute("userLocale",Locale.ENGLISH);
   }</code></pre>

<p><strong>Závěr</strong></p>

<p>Po provdedení těchto několika kroků bude možné překlady uchovávat
v databázi, při nově překládané stráce se všechny klíče uloží
samy do databáze, a není již nijak komplikované vytvořit editační
rozhraní pro doplnění překladů ke klíčum. Důležité je podotknout, že
proměnná slovnik se vytváří při prvním vyžádání, a do restartu
servlet kontejneru se nemění. To znamená dvě veci: zátěž na databázi
negenerujeme během celého spuštění aplikace,ale jen při prvním, a do
restartu kontejneru se nově přeložené fráze nikde neprojeví. Proto po
přeložení vetší části klíčů nezapoměnte provést restart.</p>

<p>Třídy zde uvedené jistě nejsou optimalizované a ošetřené tak,jak by
měly být, ale základní funkčnost splňují, Každý si tak může
následně doplnit třídy dle libosti.</p>

<p>Jakékoli dotazy rád zodpovím,ať již na emailu <a
href="mailto:data_4@seznam.cz">data_4 (at) sez­nam.cz</a>
nebo v komentářím pod článkem.</p>

