Feature: Verify post API for mySocial

Background:
    # Initialize stuff (if any) goes here
    Given url 'https://jsonplaceholder.typicode.com'

Scenario: Verify post API for mySocial
    Given path 'posts'
    When method get
    Then status 200
    * assert response.length == 100
    * print responseCookies
    * print responseHeaders
    And match response == "#array"
    And match response[0] ==  {"userId": "#number","id": "#number","title": "#string","body": "#string"}
    And match response[*] contains {"userId": 1,"id": 1,"title": "#string","body": "#string"}
    And match each response ==  {"userId": "#number","id": "#number","title": "#string","body": "#string"}

    
# Scenario: Verify post by Uid API for mySocial
#     Given path 'posts'
#     And params userId = 1
#     And headers x-transaction-id = 'abc-1234'
#     When method get
#     Then status 200
#     And assert response.length == 10



Scenario: Verify /post/{postId}/ Works
    Given def postId = 1
    And path 'posts'
    And path postId
    When method get
    Then status 200
    And match response ==
    """
    {
        "userId": "#number",
        "id": "#(postId)",
        "title": "#string",
        "body": "#string"
        }
    """
   
Scenario: Verify the post that can be created 
    Given path 'posts'
    And header Content-Type = 'application/json; charset=UTF-8'
    And request 
    """
        {
        title: 'foo',
        body: 'bar',
        userId: 1,
    }
    """
    When method post
    Then status 201
    And match response == {id: "#number",title: 'foo',body: 'bar',userId: 1}
    

Scenario: Verify update /post/{postId} Works
  Given def postId = 1
  And path 'posts', postId
  And request
  """
  {
    "id": 1,
    "title": "hi",
    "body": "hello",
    "userId": 1
  }
  """
  When method put
  Then status 200
  And match response == { id: 1, title: 'hi', body: 'hello', userId: 1 }

Scenario: Verify delete /post/{postId} Works
  Given def postId = 1
  And path 'posts', postId
  When method delete
  Then status 200
