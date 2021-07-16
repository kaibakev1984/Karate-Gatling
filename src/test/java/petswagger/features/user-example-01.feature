Feature: User

  Background: Preconditions
    * def version = "v2"
    * def operation = "user"
    * def requestBody = read('../request/user.json')
    * def responseBody = read('../response/user.json')

  Scenario: Creates list of users with given input array
    Given url apiUrl + "/" + version + "/"
    And path operation + "/createWithList"
    And request requestBody
    When method POST
    Then status 200
    And match response == responseBody

  Scenario: Get user by user name
    Given url apiUrl + "/" + version + "/"
    And path operation + "/kvasquez"
    When method GET
    Then status 200
    #And match response == responseBody

  Scenario: Logs user into the system
    * def login = "login?username=kvasquez&password=qwerty"
    Given url apiUrl + "/" + version + "/"
    And path operation + "/" + login
    When method GET
    Then status 200