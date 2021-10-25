Feature: reqres api test cases

  Background: base url
    Given url base_url

  Scenario: list single user get request
    Given path single_user_path
    When method get
    Then status 200
    Then print response
    And match $ == {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
    And match response == {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
    And match response $ == {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
    And assert responseTime < 4000

  Scenario: list all users get request
    Given path all_user_path
    When method get
    Then status 200
    Then print response
    And match $ == {"page":2,"per_page":6,"total":12,"total_pages":2,"data":[{"id":7,"email":"michael.lawson@reqres.in","first_name":"Michael","last_name":"Lawson","avatar":"https://reqres.in/img/faces/7-image.jpg"},{"id":8,"email":"lindsay.ferguson@reqres.in","first_name":"Lindsay","last_name":"Ferguson","avatar":"https://reqres.in/img/faces/8-image.jpg"},{"id":9,"email":"tobias.funke@reqres.in","first_name":"Tobias","last_name":"Funke","avatar":"https://reqres.in/img/faces/9-image.jpg"},{"id":10,"email":"byron.fields@reqres.in","first_name":"Byron","last_name":"Fields","avatar":"https://reqres.in/img/faces/10-image.jpg"},{"id":11,"email":"george.edwards@reqres.in","first_name":"George","last_name":"Edwards","avatar":"https://reqres.in/img/faces/11-image.jpg"},{"id":12,"email":"rachel.howell@reqres.in","first_name":"Rachel","last_name":"Howell","avatar":"https://reqres.in/img/faces/12-image.jpg"}],"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
    Then print response.data[0]
    And match response.data[0] == {"last_name": "Lawson","id": "#ignore","avatar": "#ignore","first_name": "Michael","email": "michael.lawson@reqres.in"}
    And match response.data[0].first_name != null
    And match response.data[*].id contains [7, 8, 9, 10, 11, 12]
    And match response.data[*].id contains [12, 9, 8, 11, 10, 7]
    And match response.data[*].id contains [7, 9, 8, ]
    And match response.data[*].email contains 'lindsay.ferguson@reqres.in'
    And match response.data[*].first_name contains ['Lindsay', 'Tobias', 'Byron']
    And match response.data[*].id !contains [null, 1]
    And match response.data[*].id !contains 3
    And match response.data[*].id !contains [1, 2, 3]
    And match response.data[*].id contains only [7, 8, 9, 10, 11, 12]
    And match response.data[*].id contains only [12, 9, 8, 11, 10, 7]
    And match response.errors == '#notpresent'
    And def first_name =  $response.data[*].first_name
    And match each first_name == '#string'
    And match each $response.data[*].first_name == '#string'
    And def id_value =  $response.data[*].id
    And match each id_value == "#number"
    And match each $response.data[*].id == '#number'
    And match each $response.data[*].avatar contains 'jpg'

  Scenario: create user using post and external json file
    * def path = '/users'
    * def payload = read('../data/user.json')
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

  Scenario: basic auth test
    * header Authorization = call read('../data/basic-auth.js') { username: 'postman', password: 'password' }
    Given url postman_basic_auth_url
    When method get
    Then print response
    Then print response.authenticated
    And match response.authenticated == true

  Scenario Outline: create user post -data driven test
    * def path = '/users'
    Given path path
    And def payload =
    """
    {
    "name": "<name>",
    "job": "<job>"
    }
    """
    And request payload
    When method post
    Then print response
    And status 201
    And match response == {"createdAt": "#notnull","name": "#string","id": "#notnull","job": "#string"}
    Examples:
      | name   | job |
      | cyril  | qa  |
      | tony   | dev |
      | ferran | ba  |

 Scenario Outline: create user post -data driven test using faker api
    * def test_data = Java.type('examples.data.faker')
    * def fake_name = test_data.fakeName()
    * def fake_job = test_data.fakeJob()
    * def path = '/users'
    Given path path
    And def payload =
    """
    {
    "name": "<name>",
    "job": "<job>"
    }
    """
    And request payload
    When method post
    Then print response
    And status 201
    And match response == {"createdAt": "#notnull","name": "#string","id": "#notnull","job": "#string"}
    And match response == {"createdAt": "#notnull","name":  #(fake_name),"id": "#notnull","job": #(fake_job)}
    Examples:
      | name         | job         |
      | #(fake_name) | #(fake_job) |
      | #(fake_name) | #(fake_job) |
      | #(fake_name) | #(fake_job) |

  Scenario: create user using post , faker api
    * def test_data = Java.type('examples.data.faker')
    * def fake_name = test_data.fakeName()
    * def fake_job = test_data.fakeJob()
    * def path = '/users'
    Given path path
    And request {"name": #(fake_name),"job": #(fake_job)}
    When method post
    Then print response
    And status 201
    And match response.name == fake_name
    And match response.job == fake_job



