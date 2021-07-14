Feature: Pet

  Background: Preconditions
    * def version = "v2"
    * def operation = "order"
    * def idOrder = 1
    * def requestBody = read('../request/order.json')
    * def responseBody = read('../response/order.json')
    * set requestBody.id = idOrder
    * set responseBody.id = idOrder

  Scenario: Place an order for a pet
    Given url apiUrl + "/" + version + "/store/"
    And path operation
    And request requestBody
    When method POST
    Then status 200
    And match response == responseBody

  Scenario: Find purchase order by ID
    Given url apiUrl + "/" + version + "/store/"
    And path operation + "/1"
    When method GET
    Then status 200
    And match response == responseBody

  Scenario:  Delete purchase order by ID
    Given url apiUrl + "/" + version + "/store/"
    And path operation + "/1"
    When method DELETE
    Then status 200

    * print "Check deleted order by ID ---"
    Given url apiUrl + "/" + version + "/store"
    And path operation + "/1"
    When method GET
    Then status 404
