Feature: New Article
  Feeder Example: Header karate-name

  Background: Preconditions
    * url apiUrl
    * def articleRequestBody = read('../request/new-article-2.json')
    * def responseBody = read('../response/new-article-2.json')
    * def dataGenerator = Java.type('utils.DataGenerator')
    * def jsonResult = dataGenerator.getRandomArticleValues()
    # --- setting values to article request body ---
    * set articleRequestBody.article.title = "Karate Gatling - SQUALY3"
    * set articleRequestBody.article.description = "This is a description"
    * set articleRequestBody.article.body = jsonResult.body

  Scenario: User Create And Deletes And Article
    * header karate-name = "Using POST method"
    Given path 'articles'
    And request articleRequestBody
    When method POST
    Then status 200
    * def articleId = response.article.slug

    * header karate-name = "Using GET method"
    Given params { limit: 10, offset: 0}
    And path 'articles'
    When method GET
    Then status 200
    And match response.articles[0].title == articleRequestBody.article.title

    * header karate-name = "Using DELETE method"
    Given path 'articles',articleId
    When method DELETE
    Then status 200