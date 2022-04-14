Feature: Call a Java Method From Feature File

  Scenario Outline: Verify that a new employee is successfully getting created
    Given url 'https://jsonplaceholder.typicode.com/posts'
    * def JavaDemo = Java.type('com.tests.data.jsonbody')
    * def result = JavaDemo.bodyis('<Title>' , '<Body>' , <UserId>)
    And print result
    And header Content-Type = 'application/json; charset=UTF-8'
    And request result
    And method post
    Then status 201
    And assert responseTime < 3000
    And match responseType == 'json'
    And print 'Response is: ', response
    Then match response.title == '<Title>'
    Then match response.body == '<Body>'
    Then match response.userId == '<UserId>'
    Examples:
      |Title|Body|UserId|
      |Java Feature File |Karate Framework|50|
      |Welcome |Karate Framework|10|

