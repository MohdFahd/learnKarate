Feature: Verify post API for mySocial

Background:
    Given url 'https://jsonplaceholder.typicode.com'

Scenario Outline: Verify /posts/<postId> works
    Given path 'posts'
    And path <postId>
    When method get
    Then status 200
    And match response ==
    """
    {
        "userId": "#number",
        "id": <postId>,
        "title": "#string",
        "body": "#string"
    }
    """

Examples:
    | postId |
    | 1      |
    | 2      |


Scenario Outline: Verify the post <userId> that can be created 
    Given path 'posts'
    And header Content-Type = 'application/json; charset=UTF-8'
    And request 
    """
        {
        title: <title>,
        body: <body>,
        userId: <userId>,
    }
    """
    When method post
    Then status 201
    And match response == {id: "#number",title: <title>,body: <body>,userId: <userId>}
    
Examples:
    | read('postData.json') |
