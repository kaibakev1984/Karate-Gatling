Feature: New Article
  Name Resolver Example: Non-Header karate-name

  Background: Preconditions
    * url apiUrl
    * def articleRequestBody = read('../request/new-article-2.json')
    * def responseBody = read('../response/new-article-2.json')
    * def dataGenerator = Java.type('utils.DataGenerator')
    * def jsonResult = dataGenerator.getRandomArticleValues()
    # --- setting values to article request body ---
    * set articleRequestBody.article.title = "SQUALY3 - " + jsonResult.title
    * set articleRequestBody.article.description = jsonResult.description
    * set articleRequestBody.article.body = jsonResult.body

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