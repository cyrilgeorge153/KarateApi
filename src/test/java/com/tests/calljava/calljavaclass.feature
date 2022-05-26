Feature: Call a Java Method From Feature File

  Scenario Outline: Verify that a new employee is successfully getting created
    * url 'https://jsonplaceholder.typicode.com/posts'
    * def JavaDemo = Java.type('helpers.jsonbody')
    * def result = JavaDemo.bodyis('<Title>' , '<Body>' , <UserId>)
    #* print result
    Given header Content-Type = 'application/json; charset=UTF-8'
    * request result
    When method post
    Then status 201
    * assert responseTime < 5000
    * match responseType == 'json'
    #* print 'Response is: ', response
    * match response.title == '<Title>'
    * match response.body == '<Body>'
    * match response.userId == '<UserId>'
    Examples:
      |Title|Body|UserId|
      |Java Feature File |Karate Framework|50|
      |Welcome |Karate Framework|10|

