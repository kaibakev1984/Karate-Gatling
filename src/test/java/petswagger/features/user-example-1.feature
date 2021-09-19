Feature: User

  Background: Preconditions
    * def createUserRequestBody = read('classpath:petswagger/request/create-user.json')
    * def createUserResponseBody = read('classpath:petswagger/response/create-user.json')
    * def getUsersByUserNameResponseBody = read('classpath:petswagger/response/get-users-by-username.json')
    * def updateUserRequest = read('classpath:petswagger/request/update-user.json')
    * def deleteUserResponse = read('classpath:petswagger/response/delete-user.json')

  Scenario: Create User
    # --- setting values in request ---
    * set createUserRequestBody.id = environment.userFlow.id
    * set createUserRequestBody.username = environment.userFlow.username
    * set createUserRequestBody.firstName = environment.userFlow.firstName
    * set createUserRequestBody.lastName = environment.userFlow.lastName
    * set createUserRequestBody.email = environment.userFlow.email
    * set createUserRequestBody.password = environment.userFlow.password
    * set createUserRequestBody.phone = environment.userFlow.phone
    * set createUserRequestBody.userStatus = environment.userFlow.userStatus
    Given url apiUrl + "/v2/"
    And path "user"
    And request createUserRequestBody
    When method POST
    Then status 200
    And match response == createUserResponseBody

  Scenario: Get Users By User Name
    # --- setting values in response ---
    * set getUsersByUserNameResponseBody.id = environment.userFlow.id
    * set getUsersByUserNameResponseBody.username = environment.userFlow.username
    * set getUsersByUserNameResponseBody.firstName = environment.userFlow.firstName
    * set getUsersByUserNameResponseBody.lastName = environment.userFlow.lastName
    * set getUsersByUserNameResponseBody.email = environment.userFlow.email
    * set getUsersByUserNameResponseBody.password = environment.userFlow.password
    * set getUsersByUserNameResponseBody.phone = environment.userFlow.phone
    * set getUsersByUserNameResponseBody.userStatus = environment.userFlow.userStatus
    Given url apiUrl + "/v2/"
    And path "user/" + environment.userFlow.username
    When method GET
    Then status 200
    And match response == getUsersByUserNameResponseBody

  Scenario: Update user
    # --- setting values in request ---
    * set updateUserRequest.id = environment.userFlow.newId
    * set updateUserRequest.username = environment.userFlow.newUsername
    * set updateUserRequest.firstName = environment.userFlow.newFirstName
    * set updateUserRequest.lastName = environment.userFlow.newLastName
    * set updateUserRequest.email = environment.userFlow.newEmail
    * set updateUserRequest.password = environment.userFlow.newPassword
    * set updateUserRequest.phone = environment.userFlow.newPhone
    * set updateUserRequest.userStatus = environment.userFlow.newUserStatus
    Given url apiUrl + "/v2/"
    And path "user/Sigma"
    And request updateUserRequest
    When method PUT
    Then status 200
    And match response == createUserResponseBody

  Scenario: Delete User
    # --- setting values in response ---
    * set deleteUserResponse.message = environment.userFlow.newUsername
    Given url apiUrl + "/v2/"
    And path "user/" + environment.userFlow.newUsername
    When method DELETE
    Then status 200
    And match response == deleteUserResponse