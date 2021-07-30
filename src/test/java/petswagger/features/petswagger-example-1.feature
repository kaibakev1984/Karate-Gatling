Feature: Petswagger

  Background: Preconditions
    * def version = "v2"
    * def operation = "pet"
    * def requestBody = read('../request/petswagger-example-1.json')
    * def responseBody = read('../response/petswagger-example-1.json')
    * def idPet = 1
    * set requestBody.id = idPet
    * set responseBody.id = idPet

  Scenario: Add a new pet to the store
    Given url petUrl + "/" + version + "/"
    And path operation
    And request requestBody
    When method POST
    Then status 200
    And match response == responseBody

  Scenario: Find pet by ID
    Given url petUrl + "/" + version + "/"
    And path operation + "/1"
    When method GET
    Then status 200
    And match response == responseBody

  Scenario: Add A Pet And Get By ID
    Given url petUrl + "/" + version + "/"
    And path operation
    And request requestBody
    When method POST
    Then status 200
    And match response == responseBody

    Given url petUrl + "/" + version + "/"
    And path operation + "/1"
    When method GET
    Then status 200
    And match response == responseBody

  Scenario: Update an existing pet
    Given url petUrl + "/" + version + "/"
    And path operation
    And request requestBody
    When method PUT
    Then status 200
    And match response == responseBody