Feature: User
  Using Name Resolver in Report

  Background: Preconditions
    # --- getting request and response json body ---
    * def createUserRequestBody = read('classpath:petswagger/request/create-user.json')
    * def createUserResponseBody = read('classpath:petswagger/response/create-user.json')
    * def getUsersByUserNameResponseBody = read('classpath:petswagger/response/get-users-by-username.json')
    * def updateUserRequest = read('classpath:petswagger/request/update-user.json')
    * def deleteUserResponse = read('classpath:petswagger/response/delete-user.json')

  Scenario: Create And Delete User
    * header karate-name = "Create a New User"
    # --- setting values in request ---
    * set createUserRequestBody.id = environment.userFlow.id
    * set createUserRequestBody.username = environment.userFlow.username
    * set createUserRequestBody.firstName = environment.userFlow.firstName
    * set createUserRequestBody.lastName = environment.userFlow.lastName
    * set createUserRequestBody.email = environment.userFlow.email
    * set createUserRequestBody.password = environment.userFlow.password
    * set createUserRequestBody.phone = environment.userFlow.phone
    * set createUserRequestBody.userStatus = environment.userFlow.userStatus
    Given url apiUrl + apiVersion
    And path "user"
    And request createUserRequestBody
    When method POST
    Then status 200
    And match response == createUserResponseBody

    * header karate-name = "Get New User"
    # --- setting values in response ---
    * set getUsersByUserNameResponseBody.id = environment.userFlow.id
    * set getUsersByUserNameResponseBody.username = environment.userFlow.username
    * set getUsersByUserNameResponseBody.firstName = environment.userFlow.firstName
    * set getUsersByUserNameResponseBody.lastName = environment.userFlow.lastName
    * set getUsersByUserNameResponseBody.email = environment.userFlow.email
    * set getUsersByUserNameResponseBody.password = environment.userFlow.password
    * set getUsersByUserNameResponseBody.phone = environment.userFlow.phone
    * set getUsersByUserNameResponseBody.userStatus = environment.userFlow.userStatus
    Given url apiUrl + apiVersion
    And path "user",environment.userFlow.username
    When method GET
    Then status 200
    And match response == getUsersByUserNameResponseBody

    * header karate-name = "Delete User"
    # --- setting values in response ---
    * set deleteUserResponse.message = environment.userFlow.username
    Given url apiUrl + apiVersion
    And path "user",environment.userFlow.username
    When method DELETE
    Then status 200
    And match response == deleteUserResponse