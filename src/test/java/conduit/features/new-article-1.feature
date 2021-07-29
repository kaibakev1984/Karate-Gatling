Feature: New Article

  Background: Preconditions
    * url apiUrl
    * def articleRequestBody = read('../request/new-article-1.json')
    * def responseBody = read('../response/new-article-1.json')
    * def dataGenerator = Java.type('utils.DataGenerator')
    * def jsonResult = dataGenerator.getRandomArticleValues()
    # --- setting values to article request body ---
    * set articleRequestBody.article.title = "SQUALY3 - " + jsonResult.title
    * set articleRequestBody.article.description = jsonResult.description
    * set articleRequestBody.article.body = "It's the content of this article"

  Scenario: User Creates New Article
    Given path 'articles'
    And request articleRequestBody
    When method POST
    Then status 200
    And match response.article.title == articleRequestBody.article.title
    And match response.article.description == articleRequestBody.article.description
    And match response.article.body == articleRequestBody.article.body