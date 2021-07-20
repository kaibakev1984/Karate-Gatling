Feature: New Article

  Background: Preconditions
    * url apiUrl
    * def articleRequestBody = read('../request/new-article-1.json')
    * def responseBody = read('../response/new-article-1.json')
    * def dataGenerator = Java.type('utils.DataGenerator')
    * def jsonResult = dataGenerator.getRandomArticleValues()
    # --- setting values to article request body ---
    * set articleRequestBody.article.title = "Karate Gatling - SQUALY3"
    * set articleRequestBody.article.description = "It's a karate-gatling presentation"
    * set articleRequestBody.article.body = "It's the content of this article"

  Scenario: User Creates New Article
    Given path 'articles'
    And request articleRequestBody
    When method POST
    Then status 200
    And match response.article.title == articleRequestBody.article.title
    And match response.article.description == articleRequestBody.article.description
    And match response.article.body == articleRequestBody.article.body

  Scenario: User Create And Deletes And Article
    Given path 'articles'
    And request articleRequestBody
    When method POST
    Then status 200
    * def articleId = response.article.slug

    Given params { limit: 10, offset: 0}
    And path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title == articleRequestBody.article.title

    Given path 'articles',articleId
    When method DELETE
    Then status 200

    Given params { limit: 10, offset: 0 }
    And path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title != articleRequestBody.article.title