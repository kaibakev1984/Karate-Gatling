Feature: User
  Request Flow Using Pauses

  Background: Preconditions
    # --- setting user think time ---
    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
    * def pause = karate.get('__gatling.pause', sleep)
    # --- getting request and response json body ---
    * def createUserRequestBody = read('classpath:petswagger/request/create-user.json')
    * def createUserResponseBody = read('classpath:petswagger/response/create-user.json')
    * def getUsersByUserNameResponseBody = read('classpath:petswagger/response/get-users-by-username.json')
    * def updateUserRequest = read('classpath:petswagger/request/update-user.json')
    * def deleteUserResponse = read('classpath:petswagger/response/delete-user.json')

  Scenario: Create And Delete User
    # --- setting values in request ---
    * set createUserRequestBody.id = environment.userFlow.id
    * set createUserRequestBody.username = environment.userFlow.username
    * set createUserRequestBody.firstName = environment.userFlow.firstName
    * set createUserRequestBody.lastName = environment.userFlow.lastName
    * set createUserRequestBody.email = environment.userFlow.email
    * set createUserRequestBody.password = environment.userFlow.password
    * set createUserRequestBody.phone = environment.userFlow.phone
    * set createUserRequestBody.userStatus = environment.userFlow.userStatus
    Given url environment.apiUrl + environment.apiVersion
    And path "user"
    And request createUserRequestBody
    When method POST
    Then status 200
    And match response == createUserResponseBody

    # --- setting pause ---
    * pause(5000)

    # --- setting values in response ---
    * set getUsersByUserNameResponseBody.id = environment.userFlow.id
    * set getUsersByUserNameResponseBody.username = environment.userFlow.username
    * set getUsersByUserNameResponseBody.firstName = environment.userFlow.firstName
    * set getUsersByUserNameResponseBody.lastName = environment.userFlow.lastName
    * set getUsersByUserNameResponseBody.email = environment.userFlow.email
    * set getUsersByUserNameResponseBody.password = environment.userFlow.password
    * set getUsersByUserNameResponseBody.phone = environment.userFlow.phone
    * set getUsersByUserNameResponseBody.userStatus = environment.userFlow.userStatus
    Given url environment.apiUrl + environment.apiVersion
    And path "user",environment.userFlow.username
    When method GET
    Then status 200
    And match response == getUsersByUserNameResponseBody

    # --- setting pause ---
    * pause(5000)

    # --- setting values in response ---
    * set deleteUserResponse.message = environment.userFlow.username
    Given url environment.apiUrl + environment.apiVersion
    And path "user",environment.userFlow.username
    When method DELETE
    Then status 200
    And match response == deleteUserResponse