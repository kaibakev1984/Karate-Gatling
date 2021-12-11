Feature: User

  Background: Preconditions
    * def service = 'user'
    * def createUserRequestBody = read('classpath:petswagger/request/user/create-user.json')
    * def createUserResponseBody = read('classpath:petswagger/response/user/create-user.json')
    * def getUsersByUserNameResponseBody = read('classpath:petswagger/response/user/get-users-by-username.json')
    * def updateUserRequest = read('classpath:petswagger/request/user/update-user.json')
    * def deleteUserResponse = read('classpath:petswagger/response/user/delete-user.json')

  Scenario: Create User
    # --- setting values in request json body ---
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
    And match response.code == environment.userFlow.code
    And match response.type == environment.userFlow.type
    And match response.message == environment.userFlow.expectedId

  Scenario: Get Users By User Name
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

  Scenario: Update user
    # --- setting values in request json body ---
    * set updateUserRequest.id = environment.userFlow.newId
    * set updateUserRequest.username = environment.userFlow.newUsername
    * set updateUserRequest.firstName = environment.userFlow.newFirstName
    * set updateUserRequest.lastName = environment.userFlow.newLastName
    * set updateUserRequest.email = environment.userFlow.newEmail
    * set updateUserRequest.password = environment.userFlow.newPassword
    * set updateUserRequest.phone = environment.userFlow.newPhone
    * set updateUserRequest.userStatus = environment.userFlow.newUserStatus

    Given url environment.apiUrl + environment.apiVersion
    And path service,environment.userFlow.username
    And request updateUserRequest
    When method PUT
    Then status 200
    And match response == createUserResponseBody
    And match response.code == 200
    And match response.type == "unknown"
    And match response.message == environment.userFlow.newExpectedId

  Scenario: Delete User
    # --- setting values in response ---
    * set deleteUserResponse.message = environment.userFlow.newUsername
    Given url environment.apiUrl + environment.apiVersion
    And path service,environment.userFlow.newUsername
    When method DELETE
    Then status 200
    And match response == deleteUserResponse
    And match response.code == environment.userFlow.code
    And match response.type == environment.userFlow.type
    And match response.message == environment.userFlow.newUsername
