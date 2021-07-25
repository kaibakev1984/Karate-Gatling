Feature: New Article
  User Think Time

  Background: Preconditions
    * url apiUrl
    * def articleRequestBody = read('../request/new-article-2.json')
    * def responseBody = read('../response/new-article-2.json')
    * def dataGenerator = Java.type('utils.DataGenerator')
    * def jsonResult = dataGenerator.getRandomArticleValues()
    # --- setting values to article request body ---
    * set articleRequestBody.article.title = jsonResult.title
    * set articleRequestBody.article.description = jsonResult.description
    * set articleRequestBody.article.body = jsonResult.body
    # --- setting user think time
    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
    * def pause = karate.get('__gatling.pause', sleep)

  Scenario: User Create And Deletes And Article
    Given path 'articles'
    And request articleRequestBody
    When method POST
    Then status 200
    * def articleId = response.article.slug
    * header karate-name = 'Setting pause of 5 seconds'
    * pause(5000)

    Given path 'articles',articleId
    When method DELETE
    Then status 200