Feature: Modify request on the fly

Background:
    Given url 'https://jsonplaceholder.typicode.com'
    And def rqst = {"title": "#(title)", "body": "#(body)", "userId": #(userId)}

Scenario Outline: embedded expression -1
    Given path 'posts'
    And header Content-Type = 'application/json; charset=UTF-8'
    And request rqst
    When method post
    Then status 201
    And match response == {id: "#number",title: <title>,body: <body>,userId: <userId>}
    
Examples:
    | userId! | title | body |
    | 1      | post1 | body1 |
    | 2      | post2 | body2 |
