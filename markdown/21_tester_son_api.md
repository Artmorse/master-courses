---
title: 22 - Tester son API
theme: "moon"
separator: ---h---
verticalSeparator: ---v---
---

# Tester son API

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

---v---

## 🙃 TP 🙃

https://github.com/Artmorse/api-rest-tps/tree/tp02
