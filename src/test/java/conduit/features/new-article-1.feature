Feature: New Article
  Background: Preconditions
    * url apiUrl
    * def requestBody = read('../request/new-article-1.json')
    * def responseBody = read('../response/new-article-1.json')

  Scenario: User Posts New Article
    Given path 'articles'
    And request requestBody
    When method POST
    Then status 200

