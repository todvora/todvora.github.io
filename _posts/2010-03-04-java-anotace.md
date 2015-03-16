---
layout: post
title: Java anotace
date: '2010-03-04 13:41:54'
tags:
- atribut
- databáze
- java
- reflection
- software
- anotace
---

V tomto článku bych chtěl nastínit, co jsou to java anotace,
k čemu jsou dobré a jak s nimi pracovat. Také se zlehka podíváme
na obsah balíku java.lang.anno­tation


<p>Anotace je v javě zápis, jak přiřadit nějakému elementu (třída,
metoda, proměnná) jakýsi příznak, metadata, informaci mimo běžný kód.
Na první pohled se zdá vysvětlení dost kostrbaté, Pojďme si tedy hned
ukázat něco, co smysl dává.</p>

<h2>Základy anotací</h2>

<p>Jedna z běžně používaných anotací je například
<strong>@Deprecated</strong></p>

<pre class="prettyprint"><code>public
class Thread implements Runnable {
...
@Deprecated
    public final void stop() {
  synchronized (this) {
...</code></pre>

<p>Ukázka z třídy Thread. Povšimněte si zápisu @Deprecated nad
metodou stop(). Ta nám říká, že metoda stop je z nějakého důvodu
nedoporučovaná, a v budoucnu nebude pravděpodobně podporována.
V JavaDoc komentáři se většinou pak najde vysvětlení, proč tomu tak
je, a jak danou funkčnost vyřešit jinak.</p>

<p>Další z používaných anotací standardně obsažených v javě
je <strong>@Transient</strong>, značící, že proměnná nebude ukládána
při serializaci.</p>

<p>Ukázali jsme si tedy základní zápis anotace bez parametru
<strong>@NázevAnotace</strong>. Takové anotace si můžeme bez problémů
napsat sami.</p>

<p>Definice takové jednoduché bezparametrické anotace by mohla vypadat
například takto:</p>

<pre class="prettyprint"><code>import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;
import java.lang.annotation.ElementType;

@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
public @interface NeedsRootPermissions {
}</code></pre>

<p>Co vlastně jednotlivé řádky znamenají :
<br /><strong>@Retention(Re­tentionPolicy­.RUNTIME)</strong> –
anotace, která říká, že vaše nově vytvořená anotace bude dostupná za
běhu.
<br /><strong>@Target(Elemen­tType.TYPE)</strong> – anotace, která
říká, že anotace jde použít nad třídou, rozhraním nebo enumem.</p>

<p><strong>public @interface NeedsRootPermis­sions</strong> –
samotná definice anotace, veřejná anotace (@interface) se jménem
NeedsRootPermis­sions</p>

<p>Taková anotace se teď dá velmi snadno připojit ke kterékoli
třídě.</p>

<p>Představme si, že vyvíjíme aplikaci, kde jsou uživatelé a také
superuživatelé. Přístup k některým třídám chceme omezit jen na
superuživatele.</p>

<pre class="prettyprint"><code>@NeedsRootPermissions
public class CreateUser extends AbstractProcess {
...</code></pre>

<p>Anotací jsme označili naší vlastní třídy CreateUser. Na první pohled
je vidět, že třída dává smysl pouze pokud máte nastavena práva
superuživatele (nemá nic společného s operačním systémem, je to jen
příznak ve vaší aplikaci). A jen na vás je, jak s takovou
anotací naložíte. Možná že Vám bude stačit jen jako dokumentační
anotace pro potřeby vývoje. Ale java nabízí slušné api. Anotaci tak nad
třídou můžeme zjistit například:</p>

<pre class="prettyprint"><code>Class<?> clazz = this.getClass();
if (clazz != null) {
    NeedsRootPermissions annotation = clazz
               .getAnnotation(NeedsRootPermissions.class);
    if (annotation != null) {
        checkAccess();
        ....</code></pre>

<p>Co tedy provádíme:
<br />vezmeme aktuální třídu (this.getClass()), a nad ní se pokusíme
získat anotaci námi požadovaného typu NeedsRootPermission
(clazz.getAnno­tation(NeedsRo­otPermissions­.class)). Pokud se
vše povede a anotace neni rovna null, víme, že anotace je nad současnou
třídou clazz přítomna. Ještě máme k dispozici metodu
isAnnotationPre­sent(NeedsRoot­Permissions.clas­s), která nám
poví jen zda je anotace přítomna. Ta by byla užitečná v předchozím
případě. Ovšem to, že získáme objekt anotace záhy velmi oceníme</p>

<p>To je nejzákladnější použití anotací. Teď se podíváme na něco
lepšího, na anotace nesoucí námi dané hodnoty.</p>

<h2>Anotace s hodnotami</h2>

<p>Definice anotace, tentokrát z webového světa by mohla vypadat
například takto:</p>

<pre class="prettyprint"><code>@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Inherited
/**
 * Trida bude vracet chybovy stav uvedeny ve {@code value}.
 */
public @interface ErrorPage {
    int value();
}</code></pre>

<p>Taaak, co se změnilo. Přibyla definice metody value(). Ta říká, že
anotace bude vyžadovat jeden parametr typu int. Použití pak může vypadat
takto:</p>

<pre class="prettyprint"><code>@ErrorPage(404)
public class EcErrorPage extends AbstractScreen {</code></pre>

<p>Zápis je volitelně možný ještě způsobem který popíšeme
o maličko pozdeji, tedy @ErrorPage(value = 404), kde specifikujeme, které
metodě předáváme hodnotu. Pro jednohodnotové anotace se ale v zásadě
vždy používá metoda value() a možnost vynechat přiřazení, tedy
@ErrorPage(404).</p>

<p>Pokud chceme v anotaci přiřadit více hodnot, pak definice vypadá
nějak takto</p>

<pre class="prettyprint"><code>@Retention(RetentionPolicy.RUNTIME)
@Target(ElementType.TYPE)
@Inherited
public @interface Author {
    String name();
    String email();
}</code></pre>

<p>a její použití v pak bude @Author(name = „Tomas Dvorak“,
email=„todvora­@gmail.com“)</p>

<pre class="prettyprint"><code>Class<?> clazz = this.getClass();
if (clazz != null) {
    Author annotation = clazz.getAnnotation(Author.class);
    if (annotation != null) {
        String name = annotation.name();
        String email = annotation.email();
        setOnErrorContact(name, email);
        ....</code></pre>

<h2>Defaultní hodnoty</h2>

<p>Defaultní hodnota anotaci se dá nastavit při jejím definování</p>

<pre class="prettyprint"><code>public @interface Author {
    String name() default "unknown developer";
    String email() default "unknown@mydomain.com;
}</code></pre>

<p>a při použití anotace je pak možné hodnoty, které mají default
nastaveno vynechat. Například
@Author(email=„tod­vora@gmail.com“).</p>

<h2>Anotace pro anotace</h2>

<p>K anotacím se nezbytně váže několik dalších standardních
anotací. Jsou to</p>

<ul>
	<li>@Retention</li>

	<li>@Target</li>

	<li>@Inherited</li>
</ul>

<p>Nejjednodušší, @Inherited, říká, že každá třída, která je
potomkem náší anotací označené třídy bude mít takovou anotaci
přiřazenu automaticky též.
<br />@Retention – k retention se váže enum RetentionPolicy. Jeho
možné hodnoty jsou</p>

<ul>
	<li>SOURCE</li>

	<li>CLASS</li>

	<li>RUNTIME</li>
</ul>

<p>a vyjadřují možnost přístupu k anotaci. První, SOURCE, označuje
anotace, které jsou dostupné jen v kódu, po přeložení již nikoli.
Poslední, RUNTIME, značí anotace dostupné reflexí za běhu, to je
chování, které využíváme v celém příkladu.</p>

<p>@Target se váže k enumu ElementType, který má hodnoty</p>

<ul>
	<li>TYPE</li>

	<li>FIELD</li>

	<li>METHOD</li>

	<li>PARAMETER</li>

	<li>CONSTRUCTOR</li>

	<li>LOCAL_VARIABLE</li>

	<li>ANNOTATION_TYPE</li>

	<li>PACKAGE</li>
</ul>

<p>a vyjadřují, k čemu je možné anotaci připojit.</p>

<h2>Proč to všechno</h2>

<p>Důvodů se nabízí několik. V kódu to vypadá lépe. Lépe se
k tomu přistupuje. Nabízí se možnost vytvořit rozhraní a to
implementovat tam, kde bychom použili anotaci. Ale implementace jsou otravné,
dlouhé, nepřehledné. Přístup k nim taky není nijak super, přece jen
if(myClass instanceof MyInterface)… vypadá hůř než getAnnotation()
metoda. Anotace se dají využít nejen za běhu, ale i při překladu,
například k automatickému generování čehosi. Jsou dostupné nad
všemi myslitelnými typy v javě. Není potřeba nic programovat, funguje
to vše samo. Spoustu dalších použití vás určitě napadne. Jako jedno
z nejobvyklejších je objektově relační mapování, kde nad
konkrétními proměnnými říkáme anotací, který sloupec z databáze
se na ní má mapovat. Deprecation zná asi také každý.</p>

<p>Závěrem se dá říci, že anotace jsou mocnou zbraní od javy 1.5.</p>

