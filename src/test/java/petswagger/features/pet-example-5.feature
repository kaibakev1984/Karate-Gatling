Feature: Petswagger
  Feeder Example

  Background: Preconditions
    * def version = "v2"
    * def operation = "pet"
    * def dataGenerator = Java.type('utils.DataGenerator')
    * def jsonResult = dataGenerator.getRandomArticleValues()
    * def requestBody = read('../request/petswagger-example-1.json')
    * def responseBody = read('../response/petswagger-example-1.json')
<<<<<<< HEAD
    # --- setting values to request body | Using __gatling feeder---
    * def idPet = 1
    * set requestBody.id = idPet
    * set requestBody.name = "Pet " + __gatling.Title
    * set requestBody.category.name = "Category " + __gatling.Description
    * set responseBody.id = idPet
        # --- setting user think time ---
=======
    # --- setting values to request body using gatling feeder ---
    * def idPet = 1
    * set requestBody.id = idPet
    * set requestBody.name = "Pet " + __gatling.Name
    * set requestBody.category.name = "Category " + __gatling.Category
    * set responseBody.id = idPet
    # --- setting user think time ---
>>>>>>> feat_conduit
    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
    * def pause = karate.get('__gatling.pause', sleep)

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