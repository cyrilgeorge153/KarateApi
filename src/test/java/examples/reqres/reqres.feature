Feature: reqres api test cases

  Background: base url
    Given url 'https://reqres.in/api'

  Scenario: single user get request
    Given path '/users/2'
    When method get
    Then status 200
    Then print response
    And match $ == {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}

  Scenario: list users get request
    Given path '/users?page=2'
    When method get
    Then status 200
    Then print response
    And match $ == {"page":2,"per_page":6,"total":12,"total_pages":2,"data":[{"id":7,"email":"michael.lawson@reqres.in","first_name":"Michael","last_name":"Lawson","avatar":"https://reqres.in/img/faces/7-image.jpg"},{"id":8,"email":"lindsay.ferguson@reqres.in","first_name":"Lindsay","last_name":"Ferguson","avatar":"https://reqres.in/img/faces/8-image.jpg"},{"id":9,"email":"tobias.funke@reqres.in","first_name":"Tobias","last_name":"Funke","avatar":"https://reqres.in/img/faces/9-image.jpg"},{"id":10,"email":"byron.fields@reqres.in","first_name":"Byron","last_name":"Fields","avatar":"https://reqres.in/img/faces/10-image.jpg"},{"id":11,"email":"george.edwards@reqres.in","first_name":"George","last_name":"Edwards","avatar":"https://reqres.in/img/faces/11-image.jpg"},{"id":12,"email":"rachel.howell@reqres.in","first_name":"Rachel","last_name":"Howell","avatar":"https://reqres.in/img/faces/12-image.jpg"}],"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}


  Scenario: create user using post and external json file
    * def path = '/users'
    * def payload = read('user.json')
    Given path path
    And request payload
    When method post
    Then print response
    And status 201
    And match response.name == "morpheus"
    And match response.job == "leader"

  Scenario: create user using post and inline json payload
    * def path = '/users'
    Given path path
    And request {"name": "morpheus","job": "leader"}
    When method post
    Then print response
    And status 201
    And match response.name == "morpheus"
    And match response.job == "leader"


  Scenario: update user using put and inline json payload
    * def path = '/users'
    Given path path
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then print response
    And status 200
    And match response.name == "morpheus"
    And match response.job == "zion resident"

  Scenario: update user using patch and inline json payload
    * def path = '/users'
    Given path path
    And request {"name": "morpheus","job": "zion resident"}
    When method put
    Then print response
    And status 200
    And match response.name == "morpheus"
    And match response.job == "zion resident"

  Scenario: update user using patch and passing payload as a variable
    * def path = '/users'
    * def payload = {"name": "morpheus","job": "zion resident"}
    Given path path
    And request payload
    When method put
    Then print response
    And status 200
    And match response.name == "morpheus"
    And match response.job == "zion resident"


  Scenario: delete user using delete http method
    * def path = '/users/2'
    Given path path
    When method delete
    Then print response
    And status 204

