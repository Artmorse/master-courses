---
title: 22 - Tester son API
theme: "moon"
separator: ---h---
verticalSeparator: ---v---
---

# Tester son API

---h---

## Manuellement 🤢

---v---

### avec cURL

`curl -X GET "http://localhost:8080/app/api/user/list" -H  "accept: application/json"`

note: attention à certains navigateurs/extensions qui peuvent forcer le https

---v---

### ou avec Postman

⬇️

https://www.getpostman.com/

Vous pouvez importer votre spec OpenAPI: _https://learning.postman.com/docs/designing-and-developing-your-api/importing-an-api/_.

---v---

### ou avec Insomnia

⬇️

https://insomnia.rest/

Vous pouvez importer votre spec OpenAPI: _https://docs.insomnia.rest/insomnia/import-export-data_.

---v---

### ou avec IntelliJ Ultimate

⬇️

https://www.jetbrains.com/help/idea/http-client-in-product-code-editor.html

---v---

### ou avec pleins d'autres outils...

---h---

## Automatiquement

---v---

Comme lorsqu'on écrit du code, il est important d'écrire des tests automatiques.

---v---

On utilise des frameworks pour se faciliter l'écriture des tests.

---v---

### Rest-assured

http://rest-assured.io/

```java
@Test
public void gpathJSONAndHamcrestMatcher() 
        throws Exception {
         expect()
        .body("lotto.lottoId", 
                equalTo(5))
        .when().get("/lotto");
}

@Test
public void gpathAssertionWithHamcrestMatcherAndJSONReturnsArray() 
        throws Exception {
        expect()
        .body("lotto.winners.winnerId", 
                hasItems(23, 54))
        .when()
        .get("/lotto");
}
```

---v---

### Feign

https://github.com/OpenFeign/feign

```java
public interface GitHub {

  @RequestLine("GET /repos/{owner}/{repo}/contributors")
  List<Contributor> getContributors(
          @Param("owner") String owner, 
          @Param("repo") String repository
  );
}

GitHub github = Feign.builder()
  .decoder(new GsonDecoder())
  .target(GitHub.class, "https://api.github.com");
```

---v---

### Retrofit

https://github.com/square/retrofit

```java
public interface GitHub {
  @GET("/repos/{owner}/{repo}/contributors")
  Call<List<Contributor>> contributors(
      @Path("owner") String owner,
      @Path("repo") String repo);
}

Retrofit retrofit = new Retrofit.Builder()
        .baseUrl(API_URL)
        .addConverterFactory(GsonConverterFactory.create())
.build();
```

---v---

## Robot Framework

https://robotframework.org/

---h---

# What's next?

![>h whats next](https://media1.giphy.com/media/lPY5d1vUYBreWtF1I0/giphy.gif?cid=ecf05e47z07qnje9y5wmv28mtnh7wpchby5926gyhnojx0tw&ep=v1_gifs_search&rid=giphy.gif&ct=g)

---v---

## 🙃 TP 🙃

https://github.com/Artmorse/api-rest-tps/tree/tp02
