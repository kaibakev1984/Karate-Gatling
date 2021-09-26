Feature: User
  Using Feeder in Tests

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
    * set createUserRequestBody.username = __gatling.Username
    * set createUserRequestBody.firstName = __gatling.FirstName
    * set createUserRequestBody.lastName = __gatling.LastName
    * set createUserRequestBody.email = __gatling.Email
    * set createUserRequestBody.password = __gatling.Password
    * set createUserRequestBody.phone = __gatling.Phone
    * set createUserRequestBody.userStatus = environment.userFlow.userStatus
    Given url environment.apiUrl + environment.apiVersion
    And path "user"
    And request createUserRequestBody
    When method POST
    Then status 200
    And match response == createUserResponseBody

    * header karate-name = "Get New User"
    # --- setting values in response ---
    * set getUsersByUserNameResponseBody.id = environment.userFlow.id
    * set getUsersByUserNameResponseBody.username = __gatling.Username
    * set getUsersByUserNameResponseBody.firstName = __gatling.FirstName
    * set getUsersByUserNameResponseBody.lastName = __gatling.LastName
    * set getUsersByUserNameResponseBody.email = __gatling.Email
    * set getUsersByUserNameResponseBody.password = __gatling.Password
    * set getUsersByUserNameResponseBody.phone = __gatling.Phone
    * set getUsersByUserNameResponseBody.userStatus = environment.userFlow.userStatus
    Given url environment.apiUrl + environment.apiVersion
    And path "user",__gatling.Username
    When method GET
    Then status 200
    And match response == getUsersByUserNameResponseBody

    * header karate-name = "Delete User"
    # --- setting values in response ---
    * set deleteUserResponse.message = __gatling.Username
    Given url environment.apiUrl + environment.apiVersion
    And path "user",__gatling.Username
    When method DELETE
    Then status 200
    And match response == deleteUserResponse