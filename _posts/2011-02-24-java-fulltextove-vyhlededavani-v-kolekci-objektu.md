---
layout: post
title: ! 'Java: Fulltextové vyhlededávání v kolekci objektů'
date: '2011-02-24 18:52:35'
tags:
- reflection
- reflexe
- vyhledávání
- java
- atribut
- proměnná
---

Jednoduchý návod, jak prohledat kolekci objektů a vyhledat v ní
objekty, kde nějaká proměnná objektu obsahuje hledaný výraz.
Prohledávání využívá reflexi, je tedy obecné a neřeší typ
vyhledávaných objektů


<p>V následujícím příkladu je řešen v celku triviální
požadavek, najít v kolekci objektů takový, který alespoň nějakou
proměnnou třídy odpovídá vyhledávanému výrazu. Využijeme reflexi,
která nám umožní přistoupit programově ke každé z proměnných
objektů, získat její hodnotu. Hodnotu pak porovnáme s vyhledávaným
výrazem a v případě že obsahuje hledaný výraz, objekt je
akceptován. kód je bohatě komentován, další vysvětlování postrádá
smysl.</p>

<pre class="prettyprint"><code>package com.ivitera.examples;

import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Priklad pro vyhledavani objektu na zaklade hodnot promennych tridy,
 * vyuzivana  reflexe, z kazde promenne tridy se ziska stringova reprezentace
 * a ta se porovnava s vyhledavanym vyrazem
 */
public class SearchReflection {
    public static void main(String[] args) {

        // Vytvorim pole vzorovych dat, ve kterych budu vyhledavat
        List<User> users = new ArrayList<User>();
        users.add(new User("Tomáš Dvořák", "lorem@ipsum.com", "Nová 3, Brno"));
        users.add(new User("Tomáš Dvořák", "dolor@ipsum.com", "Nová 3, Praha 1"));
        users.add(new User("Petr Dvořák", "foo@bar.com", "Krátká, Plzeň"));
        users.add(new User("Jan Novák", "foo@bar.com", "Nová 3, Praha 1"));

        // v prvni ukazce budu vyhledavat podle prijmeni
        System.out.println("Vyhledavani podle retezce 'Dvořák'");
        System.out.println("-----");
        List<User> result = find(User.class, users, "Dvořák");
        for (User found : result) {
            System.out.println(found.toString());
        }
        System.out.println("");

        // v druhe ukazce budu vyhledavat podle adresy
        System.out.println("Vyhledavani podle retezce 'brno'");
        System.out.println("-----");
        List<User> result2 = find(User.class, users, "brno");
        for (User found : result2) {
            System.out.println(found.toString());
        }
        System.out.println("");
    }

    /**
     * @param clazz trida objektu, ktere budu vyhledavat. je ji nutne definovat
     * takto, protoze metoda je genericka a umoznuje podstrcit seznam libovolnych
     * objektu a nevedel bych, jaka maji definovana pole
     * @param allObjects seznam objektu, ve kterych budu vyhledavat
     * @param query vyhledavaci dotaz
     * @param <T> typ objektu, ktere prochazim pri prohledavani
     * @return seznam objektu, ktere prosly vyhledavacim kriteriem
     */
    private static <T> List<T> find(Class<T> clazz, Collection<T> allObjects,
                                    String query) {
        // vytahnu z tridy vsechny definovane promenne
        Field[] declaredFields = clazz.getDeclaredFields();
        List<T> acceptedObjects = new ArrayList<T>();
        // budu prochazet vsechny objekty
        for (T object : allObjects) {
            // a v kazdem objektu vsechny promenne tridy tohoto objektu
            for (Field field : declaredFields) {
                // pokud narazim na kterekoli, ktere objekt akceptuje, dal
                // nehledam a cely objekt je povazovan za akceptovany
                if (isFieldAccepted(field, object, query)) {
                    acceptedObjects.add(object);
                    break;
                }
            }
        }
        return acceptedObjects;
    }

    /**
     * @param field pole tridy, definovana promenna
     * @param object objekt urceny k prohledani
     * @param query fulltextovy dotaz pro nalezeni objektu
     * @param <T> typ objektu
     * @return {code true} pokud ma nejake pole textovou hodnotu obsahujici
     * hledany vyraz
     */
    private static <T> boolean isFieldAccepted(Field field, T object,
                                               String query) {

        try {
            // pole si zpristupnim pro cteni, pokud je private, vyhodilo by to
            // v tomto miste vyjimku
            field.setAccessible(true);
            // vytahnu hodnotu pro tento konkretni objekt
            Object value = field.get(object);

            if (value == null) {
                return false;
            }
            String stringValue = String.valueOf(value);

            if (stringValue.isEmpty()) {
                return false;
            }

            if (stringValue.toLowerCase().contains(query.toLowerCase())) {
                return true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    private static class User {
        private String name;
        private String email;
        private String address;

        private User(String name, String email, String address) {
            this.name = name;
            this.email = email;
            this.address = address;
        }

        @Override
        public String toString() {
            return name + ", " + email + ", " + address;
        }
    }
}</code></pre>

<p><strong>Ukázka výstupu</strong></p>

<pre><code>Vyhledavani podle retezce 'Dvořák'
-----
Tomáš Dvořák, lorem@ipsum.com, Nová 3, Brno
Tomáš Dvořák, dolor@ipsum.com, Nová 3, Praha 1
Petr Dvořák, foo@bar.com, Krátká, Plzeň

Vyhledavani podle retezce 'brno'
-----
Tomáš Dvořák, lorem@ipsum.com, Nová 3, Brno</code></pre>

