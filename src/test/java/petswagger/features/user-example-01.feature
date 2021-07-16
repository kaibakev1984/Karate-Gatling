Feature: User

  Background: Preconditions
    * def version = "v2"
    * def operation = "user"
    * def id = 1
    * def username = "kvasquez"
    * def firstName = "Kevin"
    * def lastName = "Vasquez"
    * def email = "kvasquez@icbc.com.ar"
    * def password = "qwerty"
    * def phone = "011111111"
    * def requestBody = read('../request/user.json')
    * def responseBody = read('../response/user.json')
    * set requestBody[0].id = id
    * set requestBody[0].username = "kvasquez"
    * set requestBody[0].firstName = firstName
    * set requestBody[0].lastName = lastName
    * set requestBody[0].email = email
    * set requestBody[0].password = password
    * set requestBody[0].phone = phone

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

  Scenario: Logs user into the system
    * def login = "login?username=kvasquez&password=qwerty"
    Given url apiUrl + "/" + version + "/"
    And path operation + "/" + login
    When method GET
    Then status 200