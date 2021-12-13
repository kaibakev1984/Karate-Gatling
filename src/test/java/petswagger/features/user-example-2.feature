Feature: User
  Request Flow Using Pauses

  Background: Preconditions
    # --- setting user think time ---
    * def sleep = function(ms){ java.lang.Thread.sleep(ms) }
    * def pause = karate.get('__gatling.pause', sleep)
    # --- getting request and response json body ---
    * def createUserRequestBody = read('classpath:petswagger/request/user/create-user.json')
    * def createUserResponseBody = read('classpath:petswagger/response/user/create-user.json')
    * def getUsersByUserNameResponseBody = read('classpath:petswagger/response/user/get-users-by-username.json')
    * def updateUserRequest = read('classpath:petswagger/request/user/update-user.json')
    * def deleteUserResponse = read('classpath:petswagger/response/user/delete-user.json')
    * def service = "user"

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
    And path service
    And request createUserRequestBody
    When method POST
    Then status 200
    And match response == createUserResponseBody
    And match response.code == constants.code
    And match response.type == constants.type
    And match response.message == environment.userFlow.expectedId

    # --- setting pause ---
    * pause(5000)

    # --- setting values in response ---
    Given url environment.apiUrl + environment.apiVersion
    And path service,environment.userFlow.username
    When method GET
    Then status 200
    And match response == getUsersByUserNameResponseBody
    And match response.id == environment.userFlow.id
    And match response.username == environment.userFlow.username
    And match response.firstName == environment.userFlow.firstName
    And match response.lastName == environment.userFlow.lastName
    And match response.email == environment.userFlow.email
    And match response.password == environment.userFlow.password
    And match response.phone == environment.userFlow.phone
    And match response.userStatus == environment.userFlow.userStatus

    # --- setting pause ---
    * pause(5000)

    # --- setting values in response ---
    * set deleteUserResponse.message = environment.userFlow.username
    Given url environment.apiUrl + environment.apiVersion
    And path service,environment.userFlow.username
    When method DELETE
    Then status 200
    And match response == deleteUserResponse