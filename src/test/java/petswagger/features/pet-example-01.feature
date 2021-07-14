Feature: Pet

  Background: Preconditions
    #* def apiUrl = "https://petstore.swagger.io/"
    * def version = "v2"
    * def operation = "pet"
    * def requestBody = read('../request/pet.json')
    * def responseBody = read('../response/pet.json')
    * def idPet = 1
    * set requestBody.id = idPet
    * set responseBody.id = idPet

  Scenario: Add a new pet to the store
    Given url apiUrl + "/" + version + "/"
    And path operation
    And request requestBody
    When method POST
    Then status 200
    And match response == responseBody

  Scenario: Find pet by ID
    Given url apiUrl + "/" + version + "/"
    And path operation + "/1"
    When method GET
    Then status 200
    And match response == responseBody

  Scenario: Update an existing pet
    Given url apiUrl + "/" + version + "/"
    And path operation
    And request requestBody
    When method PUT
    Then status 200
    And match response == responseBody