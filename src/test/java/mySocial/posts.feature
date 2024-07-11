Feature: Verify post API for mySocial

Background:
    * url 'https://reqres.in/api'
    * header Accept = 'application/json'

Scenario: Verify page by Uid API for task
    Given path 'users'
    And param page = 1
    When method get
    Then status 200
    And print response
    And match response.page == 1
    And match response.data[0].first_name != null
    And assert response.data.length == 6
    And match response.data[0] contains { id: "#number", email: "#string", first_name: "#string", last_name: "#string", avatar: "#string" }
