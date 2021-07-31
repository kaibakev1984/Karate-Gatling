Feature: Petswagger

  Background: Preconditions
    * def idPet = 1
    * def operation = "pet"
    * def requestBody = read('../request/petswagger-example-1.json')
    * def responseBody = read('../response/petswagger-example-1.json')
    * def dataGenerator = Java.type('utils.DataGenerator')
    * def jsonResult = dataGenerator.getRandomPetValues()
    # --- setting values to request body ---
    * set requestBody.id = idPet
    * set requestBody.name = jsonResult.name
    * set requestBody.category.name = jsonResult.category

  Scenario: Add A New Pet To Store
    Given url petUrl + "/v2/"
    And path operation
    And request requestBody
    When method POST
    Then status 200
    And match response == responseBody

  Scenario: Find Pet By ID
    Given url petUrl + "/v2/"
    And path operation + "/1"
    When method GET
    Then status 200
    And match response == responseBody

  Scenario: Add A Pet And Get By ID
    Given url petUrl + "/v2/"
    And path operation
    And request requestBody
    When method POST
    Then status 200
    And match response == responseBody

    Given url petUrl + "/v2/"
    And path operation + "/1"
    When method GET
    Then status 200
    And match response == responseBody

  Scenario: Delete a Pet
    Given url petUrl + "/v2/"
    And path operation + "/1"
    When method DELETE
    Then status 200

  Scenario: Create And Delete New Pet
    Given url petUrl + "/v2/"
    And path operation
    And request requestBody
    When method POST
    Then status 200
    And match response == responseBody

    Given url petUrl + "/v2/"
    And path operation + "/1"
    When method DELETE
    Then status 200

  Scenario: Update an existing pet
    Given url petUrl + "/v2/"
    And path operation
    And request requestBody
    When method PUT
    Then status 200
    And match response == responseBody