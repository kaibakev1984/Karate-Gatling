Feature: Pet

  Background: Preconditions
    * def createPetRequestBody = read('../request/create-pet.json')
    * def createPetResponseBody = read('../response/create-pet.json')
    * def getPetByIdResponseBody = read('../response/get-pet-by-id.json')
    # * def deletePetByIdResponse = read()

  Scenario: Create Pet
      # --- setting values in request json body ---
    * set createPetRequestBody.id = environment.petFlow.id
    * set createPetRequestBody.category.id = environment.petFlow.categoryId
    * set createPetRequestBody.category.name = environment.petFlow.categoryName
    * set createPetRequestBody.name = environment.petFlow.name
    * set createPetRequestBody.status = environment.petFlow.status
      # --- setting values in response json body ---

    Given url environment.apiUrl + environment.apiVersion
    And path "pet"
    And request createPetRequestBody
    When method POST
    Then status 200
    And match response == createPetResponseBody
    And match response.id == environment.petFlow.id
    And match response.category.id == environment.petFlow.categoryId
    And match response.category.name == environment.petFlow.categoryName
    And match response.name == environment.petFlow.name
    And match response.status == environment.petFlow.status

    Scenario: Get Pet By Id
      Given url environment.apiUrl + environment.apiVersion
      And path "pet", environment.petFlow.id
      When method GET
      Then status 200
      And match response == getPetByIdResponseBody
      And match response.id == environment.petFlow.id
      And match response.category.id == environment.petFlow.categoryId
      And match response.category.name == environment.petFlow.categoryName
      And match response.name == environment.petFlow.name
      And match response.status == environment.petFlow.status

      Scenario: Delete Pet By Id
        Given url environment.apiUrl + environment.apiVersion
        And path "user", environment.petFlow.id
        When method DELETE
        Then status 200