Feature: User
  Using Feeder in Tests

  Background: Preconditions
    # --- setting user think time ---
    * def sleep = function(ms) { java.lang.Thread.sleep(ms) }
    * def pause = karate.get('__gatling.pause', sleep)

    # --- getting request and response json body ---
    * def createUserRequestBody = read('classpath:petswagger/request/user/create-user.json')
    * def createUserResponseBody = read('classpath:petswagger/response/user/create-user.json')
    * def getUsersByUserNameResponseBody = read('classpath:petswagger/response/user/get-users-by-username.json')
    * def updateUserRequest = read('classpath:petswagger/request/user/update-user.json')
    * def deleteUserResponse = read('classpath:petswagger/response/user/delete-user.json')

    # --- service name ---
    * def service = "user"

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
    And path service
    And request createUserRequestBody
    When method POST
    Then status 200
    And match response == createUserResponseBody
    And match response.code == constants.code
    And match response.type == constants.type

    * pause(2500)
    * header karate-name = "Get New User"
    Given url environment.apiUrl + environment.apiVersion
    And path service,__gatling.Username
    When method GET
    Then status 200
    And match response == getUsersByUserNameResponseBody
    And match response.id == environment.userFlow.id
    And match response.username == __gatling.Username
    And match response.firstName == __gatling.FirstName
    And match response.lastName == __gatling.LastName
    And match response.email == __gatling.Email
    And match response.password == __gatling.Password
    And match response.phone == __gatling.Phone
    And match response.userStatus == environment.userFlow.userStatus

    * pause(2500)
    * header karate-name = "Delete User"
    Given url environment.apiUrl + environment.apiVersion
    And path service,__gatling.Username
    When method DELETE
    Then status 200
    And match response == deleteUserResponse
    And match response.message == __gatling.Username