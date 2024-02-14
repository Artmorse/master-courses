---
title: 20 - APIs
theme: "moon"
separator: ---h---
verticalSeparator: ---v---
---

# JEE et APIs

---h---

# APIs : Quelques généralités

---v---

![>icon](img/icons/question.png)

## API = ???

---v---

## Application Programming Interface

---v---

![>icon](img/icons/question.png)

## Qu'est-ce que c'est ?

---v---

> Une API est un ensemble clairement défini de méthodes permettant à différents composants de communiquer ensemble.

---v---

### ⚠️ Attention ⚠️

Les APIs ne sont pas uniquement dédiées au web !

Vous en utilisez également pour :

* communiquer avec une base de données
* interagir avec le système d'exploitation
* manipuler le hardware
* faire dialoguer des modules logiciels
* ...

---v---

Vous en utilisez déjà !

* Quand vous construisez des applications n-tiers
* Quand vous appelez une dépendance externe
* ...

---v---

![>icon](img/icons/question.png)

## On retrouve quoi dans une API ?

---v---

Tout dépend du type d'API, mais on retrouvera bien souvent :

* Des méthodes
* Des structures de données
* Des formats de messages
* Des protocoles de communication
* Des codes d'erreur / Exception
* Une gestion de la sécurité

---v---

![>icon](img/icons/question.png)

## Des exemples d'API dans le monde Java ?

---v---

* RMI _(**R**emote **M**ethod **I**nvocation)_
* Corba
* EJB Remote _(basés sur RMI en fait)_

note:

RMI : api d'appel d'objet distant, accessible dans une autre JVM que l'objet appelant

---v---

![>icon](img/icons/question.png)

## Un peu plus à la mode ?

---v---

* **SOAP** _(**S**imple **O**bject **A**ccess **P**rotocol)_
* **REST** _(**RE**presentational **S**tate **T**ransfer)_

---h---

# SOAP

---v---

## **S**imple **O**bject **A**ccess **P**rotocol

---v---

![>icon](img/icons/question.png)

## C'est quoi ?

---v---

* Protocole d'échange d'information structurée
* Basé sur XML
* Permet l'invocation de méthodes d'objets distants

---v---

* Contract above HTTP
* M2M Exchange Protocol

note:
Etablissement d'un contrat via le protocole HTTP
Echange machine à machine

---v---

### Structure

* Une **enveloppe** contenant des informations sur le message
* Un **modèle de données** définissant le format du message

---v---

```xml
<?xml version="1.0"?>
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/"
soap:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">
<soap:Header>
  <!-- entête -->
</soap:Header>
<soap:Body>
  <!-- message -->
    <soap:Fault>
    </soap:Fault>
</soap:Body>
</soap:Envelope>
```
<!-- .element: class="stretch" -->

---v---

### Avantages

* Ouvert à différents protocoles de transport
* Indépendant de la plate-forme
* Indépendant du langage
* Extensible
* Définition de contrat de service

note:
Autre protocole de transport : SMTP,...

---v---

### Inconvénients

* Lourdeur des messages XML
* Couplage fort *(contrat de service)*

---v---

![>icon](img/icons/question.png)

## Quel framework ?

---v---

# JAX-WS

#### Java API for Web Services

---v---

https://cxf.apache.org/


*Probablement le plus populaire en Java*

---v---

# Un contrat ?

---v---

# WSDL

### Web Services Description Language

---v---

```xml
<xsd:element name="getBooks">
    <xsd:complexType>
        <xsd:sequence>
            <xsd:choice>
                <xsd:element name="bookId" type="xsd:long"
                    minOccurs="1"></xsd:element>
                <xsd:element name="bookTitle" type="xsd:string"
                    minOccurs="1"></xsd:element>
                <xsd:element name="authorId" type="xsd:long"
                    minOccurs="1"></xsd:element>
                <xsd:element name="authorName" type="xsd:string"
                    minOccurs="1"></xsd:element>
            </xsd:choice>
        </xsd:sequence>
    </xsd:complexType>
</xsd:element>
```

<!-- .element: class="stretch" -->

note:
Exemple d'une partie du wsdl
Description d'un service web

---v---

### Développer un client

---v---

```shell
wsdl2java -p com.mycompany.greeting Greeting.wsdl
```

---v---

http://cxf.apache.org/docs/wsdl-to-java.html

> wsdl2java - takes a WSDL document and generates fully annotated Java code from which to implement a service.

---v---

```xml
<plugin>
    <groupId>org.apache.cxf</groupId>
    <artifactId>cxf-codegen-plugin</artifactId>
    <version>${cxf.version}</version>
    <executions>
        <execution>
            <id>generate-sources</id>
            <phase>generate-sources</phase>
            <configuration>
                <sourceRoot>${project.build.directory}/generated/cxf</sourceRoot>
                <wsdlOptions>
                    <wsdlOption>
                        <wsdl>${basedir}/src/main/resources/myService.wsdl</wsdl>
                    </wsdlOption>
                </wsdlOptions>
            </configuration>
            <goals>
                <goal>wsdl2java</goal>
            </goals>
        </execution>
    </executions>
</plugin>
```

<!-- .element: class="stretch" -->

---v---

http://cxf.apache.org/docs/maven-cxf-codegen-plugin-wsdl-to-java.html

---v---

```java
JaxWsProxyFactoryBean factory = new JaxWsProxyFactoryBean();
factory.setServiceClass(HelloWorld.class);
factory.setAddress("http://localhost:9000/helloWorld");
HelloWorld client = (HelloWorld) factory.create();
String reply = client.sayHi("HI");
System.out.println("Server said: " + reply);
```

---v---

### Développer un service

---v---

Plusieurs façons d'aborder le développement :

* Code Java puis génération de WSDL
* Ecriture du WSDL puis génération du code Java
* Ecriture de XML puis génération du WSDL et Java

---v---

```java
@javax.jws.WebService(
  serviceName = "BookService",
  wsdlLocation = "...",
  endpointInterface = "ili.BookService")
public class BookServiceImpl implements BookService {
    ...
}
```

---v---

- `@WebMethod`
- `@WebParam`
- `@WebResult`

---v---

![>icon](img/icons/tip.png)

## ⬇️ Conclusion ⬇️

---v---

* Largement utilisé dans les architectures SOA (*Architecture orientée services*)
* Permet la définition de contrat d'interfaces
* Difficile pour les humains
* Lourdeur du XML
* Couplage fort !

note:
SOA: Architecture orientée services

---v---

Bref, on va pas faire de TP.

---v---

De rien.

---h---

# REST

---v---

## **RE**presentational **S**tate **T**ransfer

---v---

![>icon](img/icons/question.png)

### C'est quoi ?

---v---

C'est un **style d'architecture**.

note:
basé sur des principes

---v---

### D'où ça vient? 🏺

---v---

### Roy Fielding

![>h](img/20/roy_fielding.jpg)

https://fr.wikipedia.org/wiki/Roy_Fielding

---v---

> Roy Fielding a défini REST en 2000 dans sa thèse de doctorat Architectural Styles and the Design of Network-based Software Architectures à l'université de Californie à Irvine. Il y a développé le style d'architecture REST en parallèle du protocole HTTP 1.1 de 1996 à 1999, basé sur le modèle existant de HTTP 1.0 de 1996.

- source _[wikipedia]_(https://fr.wikipedia.org/wiki/Representational_state_transfer)

---v---

![>icon](img/icons/question.png)

### Restful applications ?

---v---

C'est un terme utilisé pour une application qui respecte le style d'architecture REST.

---v---

![>icon](img/icons/question.png)

### C'est quoi un style d'architecture ?

---v---

Un ensemble de contraintes et de directives menant au design d'une application et guidant une partie de ses choix techniques.

note: 
- contraintes: RFC (Request For Comments)
- directives: le pluriel dans les URLs

---v---

### REST vs. SOAP

* SOAP & REST :
  * Indépendant de la technologie
  * Repose sur un protocole HTTP
* SOAP :
  * Repose sur XML
  * Contrat fort
  * Difficile pour les humains
* REST :
  * Repose ne definit pas de format precis (HTML, XML, CSV, **JSON** ...)
  * Pas de contrat fort
  * Tests faciles !

note:

en pratique on utilise principalement JSON (pour ses divers avantages) pour REST

---v---

### Le choix dépend de vos besoins.

note:

SOAP=très normé et structuré, assure la sécurité, cohérence, atomicité des transactions
assure fiabilité des transactions
REST=plus souple et plus léger à mettre en place et à utiliser

---v---

## Architecture Orientée Ressources

---v---

Dans un système hypermedia, une ressource est **tout ce qui peut être référencé par un lien**.

note: 
- Hypermedia, an extension of the term hypertext, is a nonlinear medium of information that includes graphics, audio, video, plain text and hyperlinks
- HTTP: Hypertext Transfer Protocol

---v---

## ⚠️ Attention ⚠️

---v---

Il est important de distinguer une ressource de sa valeur !

---v---

Un exemple ?

* Le *dernier article d'un journal* est une ressource
* Sa valeur diffère selon le temps
* La sémantique de la ressource elle, ne devra pas changer

note: sémantique:
- une ressource sur laquelle je veux agir
- une action (GET, POST, ...)

---v---

Une ressource est identifiée par un **identificateur de ressource**.

---v---

![>icon](img/icons/question.png)

## Quel identificateur avec REST ?

---v---

# URI

_**U**niform **R**esource **I**dentifier_

_more info [here](https://fr.wikipedia.org/wiki/Uniform_Resource_Identifier)_

note:
- nom + adresse d'une resource
- A Uniform Resource Identifier (URI) is a unique sequence of characters that identifies a logical or physical resource used by web technologies
- A Uniform Resource Locator (URL), colloquially termed as a web address, is a reference to a web resource that specifies its location on a computer network and a mechanism for retrieving it. A URL is a specific type of Uniform Resource Identifier (URI)
- A URL provides the location of the resource. A URI identifies the resource by name at the specified location or URL

---v---

Les composants de l'architecture manipulent les ressources en transférant des représentations de ces ressources.

*(HTML, XML, CSV, **JSON**...)*

---v---

## Une interface simple et uniforme

---h---

## **Protocole + Représentation**

- HTTP + HTML
- HTTP + XML
- HTTP + CSV
- HTTP + **JSON** 👀
- HTTP + ...

---h---

![>icon](img/icons/focus.png)

## Représentation des ressources

# JSON

_**J**ava**S**cript **O**bject **N**otation_

https://www.json.org/json-en.html

---v---

```json
{
  "name": "pikachu",
  "order": 35,
  "species": {
    "name": "pikachu",
    "url": "https://pokeapi.co/api/v2/pokemon-species/25/"
  }
}
```

note: pas spécifiquement de `header` comme en `SOAP` mais le format est libre

---v---

### JSON est ~40% plus léger que XML

---v---

### JSON & Jakarta EE ?

#### JSON-P

> JSON Processing (JSON-P) is a Java API to process (for e.g. parse, generate, transform and query) JSON messages. It produces and consumes JSON text in a streaming fashion (similar to StAX API for XML) and allows to build a Java object model for JSON text using API classes (similar to DOM API for XML).

- source _https://javaee.github.io/jsonp/_
- spec _https://javaee.github.io/jsonb-spec/_

---v---

### JSON-P Object Model calls

```java
public static void main(String[] args) {
   // Create Json and serialize
   JsonObject json = Json.createObjectBuilder()
     .add("name", "Falco")
     .add("age", BigDecimal.valueOf(3))
     .add("biteable", Boolean.FALSE).build();
   String result = json.toString();
     
   System.out.println(result);
 }
```

---v---

### JSON-P Streaming API calls

```java
public static void main(String[] args) {
    // Parse back
    final String result = "{\"name\":\"Falco\",\"age\":3,\"bitable\":false}";
    final JsonParser parser = Json.createParser(new StringReader(result));
    String key = null;
    String value = null;
    while (parser.hasNext()) {
        final Event event = parser.next();
        switch (event) {
        case KEY_NAME:
            key = parser.getString();
            System.out.println(key);
            break;
        case VALUE_STRING:
            value = parser.getString();
            System.out.println(value);
            break;
        }
    }
    parser.close();
}
```

<!-- .element: class="stretch" -->

---v---

![>icon](img/icons/tip.png)

### Un framework pour JSON ?

---v---

## Jackson, par exemple

> Jackson has been known as "the Java JSON library" or "the best JSON parser for Java". Or simply as "JSON for Java".

- source _[github](https://github.com/FasterXML/jackson)_

note:

Librairie pour parser du json ou transformer des objets Java en JSON.

---h---


![>icon](img/icons/focus.png)

## Protocole de communication

# HTTP

_**H**yper**T**ext **T**ransfer **P**rotocol_

https://developer.mozilla.org/en-US/docs/Web/HTTP/Overview

---v---

![>icon](img/icons/question.png)

## Pourquoi HTTP?

---v---

1. URL Complexity
2. HTTP Verbs
3. HTTP Error Codes

---h---

### 1. URL Complexity ?

---v---

`http://exemple.org/maMethode?p1=v1&p2=v2`

---v---

![>icon](img/icons/warning.png)

## Architecture Orientée Ressource !

---v---

![>icon](img/icons/question.png)

## De quoi avons-nous besoin ?

---v---

- une sémantique (description de l’interaction)
- un verbe HTTP (GET, PUT, POST, DELETE, …)
- une ressource : URI + sémantique
- des en-têtes de requête (contrôle)
- un corps de requête
- des en-tête de réponse
- un corps de réponse
- des codes erreurs éventuels

---v---

### Exemple

* Récupérer un article :
  * `JAVA` : `getArticle`
  * Ressource : `GET /articles/123`
* Supprimer un article :
  * `JAVA` : `deleteArticle`
  * Ressource : `DELETE /articles/123`

---v---

### Notez la différence:

* 2 méthodes
* Mais 1 seule ressource
* Avec 2 verbes

---v---

### ⚠️ Attention ⚠️

Les ressources ne correspondent pas forcément à vos objets métiers, mais à tout ce qui peut être identifiable par une URI.

Cela peut être des concepts abstraits.

note:
la méteo du jour

---h---

### 2. HTTP Verbs

---v---

![>icon](img/icons/question.png)

## Vous les connaissez ?

---v---

* `GET`: Récupère la représentation d'une ressource spécifiée
* `POST`: Soumet une entité à la ressource spécifiée
* `PUT`: Remplace toutes les représentations courantes de la ressource spécifiée par le _payload_ de la requête
* `DELETE`: Supprime la ressource spécifiée

note:

CRUD: **C**reate **R**ead **U**pdate **D**elete
payload: ce qui transporte notre body (contenu)

---v---

### ⚠️ Attention ⚠️

* Les requêtes `GET` doivent seulement **récupérer** des données !
* Les requêtes `POST` cause souvent un changement d'état côté serveur
* Les requêtes `PUT` sont souvent résumées à *mettre à jour*, alors qu'elles visent en fait à modifier une **ressource identifiée**

note: Notamment pour `GET` qui peut être un gros problème de sécurité

---v---

### PUT vs. POST

On pourrait résumer à :

* Vous connaissez l'identifiant de la ressource ?
  * `PUT`
* Vous ne connaissez pas l'identifiant de la ressource ?
  * `POST`
* Si l'identifiant unique est généré par la base de données par exemple
  * `POST`.

---v---

Le protocole HTTP en defini d'autres mais ils ne sont pas utilisé dans REST.

* `HEAD`
* `PATCH`
* `CONNECT`
* `OPTIONS`
* `TRACE`

---v---

https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods

---h---

### 3. HTTP Error Codes

---v---

![>icon](img/icons/question.png)

## Vous les connaissez ?

---v---

# 200

### [OK](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/200)

note:

Retourne l'entité

---v---

# 201

### [Created](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/201)

note:
Retourne l'entite créée
Elle doit avoir été créé avant l'envoi de la reponse sinon c'est un 202 : accepted

---v---

# 204

### [No Content](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/204)

---v---

# 301

### [Moved Permanently](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/301)

note:
exemple: proxy, mailing...

---v---

# 400

### [Bad Request](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/400)

note: The server cannot or will not process the request due to something that is perceived to be a client error (e.g., malformed request syntax, invalid request message framing, or deceptive request routing).

---v---

# 403

### [Forbidden](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/403)

---v---

# 404

### [Not Found](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/404)

---v---

# 409

### [Conflict](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/409)

### 🤔 [GitHub](https://docs.github.com/en/rest/branches/branches?apiVersion=2022-11-28#merge-a-branch)

note: The HTTP 409 Conflict response status code indicates a request conflict with the current state of the target resource.

---v---

# 418

### [I'm a teapot](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/418)

---v---

# 422

### [Unprocessable Entity](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/422)

### 🤔 [GitHub](https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28#delete-a-file)

note: The request was well-formed but was unable to be followed due to semantic errors.

---v---

# 501

### [Not Implemented](https://developer.mozilla.org/en-US/docs/Web/HTTP/Status/501)

---v---

## Récapitulatif

- **1XX** - Messages techniques
- **2XX** - Succès
- **3XX** - Redirection
- **4XX** - Requête invalide envoyée par le client
- **5XX** - Problème serveur

---v---

https://developer.mozilla.org/en-US/docs/Web/HTTP/Status

---h---

# Quelques bonnes pratiques

---v---

### Utilisez le pluriel

- Préférez : `/users/bob`
- Plutôt que : `/user/bob`

Rappelez vous que dans `URL`, `R` correspond à `Resource` et `L` à `Locator`. Une URL doit donc clairement identifier une ressource.

---v---

Si une ressource `R1` est contenue dans `R2`, l'URL devrait être `R2/{id de R2}/R1/{id de R1}`.

Par exemple :

- `users` : tous les utilisateurs
- `users/bob` : l'utilisateur bob
- `users/bob/friends` : les amis de bob

---v---

### Les retours

- Si vous ne retournez rien, utilisez `204 NO CONTENT` et pas `200 OK`
- Si vous retournez quelque chose, utilisez `200 OK`
- Si vous déclenchez un process asynchrone, utilisez `202 ACCEPTED`

---v---

### Les erreurs

En cas d'erreur :

- Si une erreur est survenue a cause des information donnees par le client, utilisez `400 BAD REQUEST`
- Si un probleme est survenue cote serveur, utilisez `500 INTERNAL SERVER ERROR`
- Si vous développez un ransomware, utilisez `402 PAYMENT REQUIRED`
- Si le problème concerne l'état d'un objet, utilisez `409 CONFLICT`

Bien entendu, ça ne remplace pas les cas identifiés type `Unauthorized`, `Not Found`...

---v---

### Les ressources

Une URL doit identifier clairement une ressource.

`/users/bob` : bob doit être l'identifiant unique vers l'utilisateur correspondant.

Pour créer une ressource, faites un POST ou un PUT sur l'URL correspondante. Pas de POST sur des URLs type `/users/create` ou `/users/new`...

---v---

Pour récupérer une ressource:

- Faites : `GET /users/bob`
- Et non pas : `GET /users?id=bob`

Pour récupérer un ensemble de ressources, utilisez le même path sans identifiant:

- Faites : `GET /users`
- Et non pas : `GET /users/all`

---v---

Pour mettre a jour:

- Faites : `PUT /users/bob`
- Et non pas : `POST /users/bob`

---v---

Et pour supprimer ?

- Faites : `DELETE /users/bob`
- Et non pas : `GET /users/bob/delete`

---h---

# What's next?

![>h whats next](https://media1.giphy.com/media/lPY5d1vUYBreWtF1I0/giphy.gif?cid=ecf05e47z07qnje9y5wmv28mtnh7wpchby5926gyhnojx0tw&ep=v1_gifs_search&rid=giphy.gif&ct=g)

---v---

## More... 👀

- https://www.youtube.com/watch?v=vyHpbR6jScI
- https://www.youtube.com/watch?v=7qqzqse1hgc

---v---

## 🙃 TP 🙃

[TP01](https://github.com/Artmorse/api-rest-tps/tree/tp01)
