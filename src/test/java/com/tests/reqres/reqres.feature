Feature: Reqres api test cases

  Background: base url
    * url base_url
    #* def validateResponse = read('classpath:helpers/common_assertions.js')
    * callonce read('classpath:helpers/common_assertions.feature')

  Scenario: list single user get request
  Given path single_user_path
  When method get
  Then status 200
  * match $ == {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
  * match response == {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
  * match response $ == {"data":{"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"},"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
  * match response.data.id == 2
  * match $.data.id == 2
  #complex fuzzy matcher
  * match response.data.id == '#? _ == 2'
  * validateResponse()
  
  Scenario: list all users get request
  Given path all_users_path
  And param page = 2
  When method get
  Then status 200
  * match $ == {"page":2,"per_page":6,"total":12,"total_pages":2,"data":[{"id":7,"email":"michael.lawson@reqres.in","first_name":"Michael","last_name":"Lawson","avatar":"https://reqres.in/img/faces/7-image.jpg"},{"id":8,"email":"lindsay.ferguson@reqres.in","first_name":"Lindsay","last_name":"Ferguson","avatar":"https://reqres.in/img/faces/8-image.jpg"},{"id":9,"email":"tobias.funke@reqres.in","first_name":"Tobias","last_name":"Funke","avatar":"https://reqres.in/img/faces/9-image.jpg"},{"id":10,"email":"byron.fields@reqres.in","first_name":"Byron","last_name":"Fields","avatar":"https://reqres.in/img/faces/10-image.jpg"},{"id":11,"email":"george.edwards@reqres.in","first_name":"George","last_name":"Edwards","avatar":"https://reqres.in/img/faces/11-image.jpg"},{"id":12,"email":"rachel.howell@reqres.in","first_name":"Rachel","last_name":"Howell","avatar":"https://reqres.in/img/faces/12-image.jpg"}],"support":{"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}}
  * match response.data[0] == {"last_name": "Lawson","id": "#ignore","avatar": "#ignore","first_name": "Michael","email": "michael.lawson@reqres.in"}
  * match response.data[0].first_name != null
  * match response.data[*].id contains [7, 8, 9, 10, 11, 12]
  * match response.data[*].id contains [12, 9, 8, 11, 10, 7]
  * match response.data[*].id contains [7, 9, 8, ]
  * match response.data[*].email contains 'lindsay.ferguson@reqres.in'
  * match response.data[*].first_name contains ['Lindsay', 'Tobias', 'Byron']
  * match response.data[*].id !contains [null, 1]
  * match response.data[*].id !contains 3
  * match response.data[*].id !contains [1, 2, 3]
  * match response.data[*].id contains only [7, 8, 9, 10, 11, 12]
  * match response.data[*].id contains only [12, 9, 8, 11, 10, 7]
  * match response.errors == '#notpresent'
  * def first_name =  $response.data[*].first_name
  * match each first_name == '#string'
  * match each $response.data[*].first_name == '#string'
  * def id_value =  $response.data[*].id
  * match each id_value == "#number"
  * match each $response.data[*].id == '#number'
  * match each $response.data[*].avatar contains 'jpg'
  * validateResponse()
  
  Scenario: create user using post and external json file
  * def payload = read('classpath:helpers/user.json')
  Given path all_users_path
  And request payload
  When method post
  Then status 201
  * match response.name == "morpheus"
  * match response.job == "leader"
  * validateResponse()
  
  Scenario: create user using post and inline json payload
  Given path all_users_path
  And request {"name": "morpheus","job": "leader"}
  When method post
  Then status 201
  * match response.name == "morpheus"
  * match response.job == "leader"
  * validateResponse()
  
  Scenario: update user using put and inline json payload
  Given path all_users_path
  And request {"name": "morpheus","job": "zion resident"}
  When method put
  Then status 200
  * match response.name == "morpheus"
  * match response.job == "zion resident"
  * validateResponse()
  
  Scenario: update user using patch and inline json payload
  Given path all_users_path
  And request {"name": "morpheus","job": "tester"}
  When method patch
  Then status 200
  * match response.name == "morpheus"
  * match $.job == "tester"
  * validateResponse()
  
  Scenario: update user using put and passing payload as a variable
  * def payload = {"name": "morpheus","job": "zion resident"}
  Given path all_users_path
  And request payload
  When method put
  Then status 200
  * match response.name == "morpheus"
  * match response.job == "zion resident"
  * validateResponse()
  
  Scenario: delete user using delete http method
  Given path single_user_path
  When method delete
  Then status 204
  
  Scenario: basic auth test
  * header Authorization = call read('classpath:helpers/basic-auth.js') { username: 'postman', password: 'password' }
  Given url postman_basic_auth_url
  When method get
  Then status 200
  * match response.authenticated == true
  * validateResponse()
  
  Scenario Outline: create user post -data driven test using payload <name> and <job>
  Given path all_users_path
  And def payload =
  """
  {
  "name": "<name>",
  "job": "<job>"
  }
  """
  And request payload
  When method post
  Then status 201
  * match response == {"createdAt": "#notnull","name": "#string","id": "#notnull","job": "#string"}
  * validateResponse()
  Examples:
  | name   | job |
  | cyril  | qa  |
  | tony   | dev |
  | ferran | ba  |
  
  Scenario Outline: create user post data driven test using faker api
  * def test_data = Java.type('helpers.faker')
  * def fake_name = test_data.fakeName()
  * def fake_job = test_data.fakeJob()
  Given path all_users_path
  And def payload =
  """
  {
  "name": "<name>",
  "job": "<job>"
  }
  """
  And request payload
  When method post
  Then status 201
  * match response == {"createdAt": "#notnull","name": "#string","id": "#notnull","job": "#string"}
  * match response == {"createdAt": "#notnull","name":  "#(fake_name)","id": "#notnull","job": "#(fake_job)"}
  * match response.name == name 
  * match response.job == job
  * validateResponse() 
  Examples:
  | name         | job         |
  | #(fake_name) | #(fake_job) |
  | #(fake_name) | #(fake_job) |
  | #(fake_name) | #(fake_job) |
  
  Scenario: create user using post method and faker api
  * def test_data = Java.type('helpers.faker')
  * def fake_name = test_data.fakeName()
  * def fake_job = test_data.fakeJob()
  Given path all_users_path
  And request {"name": '#(fake_name)',"job": '#(fake_job)'}
  When method post
  Then status 201
  * match response.name == fake_name
  * match response.job == fake_job
  * validateResponse()
  
  Scenario: list single user get request json schema test
  Given path single_user_path
  When method get
  Then status 200
  * match response == '#object'
  * def jsonSchemaExpected =
  """
  {
  "data": {
  "id": '#number',
  "email": "#string",
  "first_name": "#string",
  "last_name": "#string",
  "avatar": "#string"
  },
  "support": {
  "url": "#string",
  "text": "#string"
  }
  }
  """
  * match response == jsonSchemaExpected
  * validateResponse()
  
  Scenario Outline: create user post -data driven test using payload from csv
  Given path all_users_path
  And def payload =
  """
  {
  "name": "<name>",
  "job": "<job>"
  }
  """
  And request payload
  When method post
  Then status 201
  * match response == {"createdAt": "#notnull","name": "#string","id": "#notnull","job": "#string"}
  * match response == {"createdAt": "#notnull","name": "#(response.name)","id": "#notnull","job": "#(response.job)"}
  * validateResponse()
  Examples:
  | read('classpath:helpers/test_data.csv') |
  
  Scenario Outline: create user post -data driven test using payload from json
  Given path all_users_path
  And def payload =
  """
  {
  "name": "<name>",
  "job": "<job>"
  }
  """
  And request payload
  When method post
  Then status 201
  * match $ == {"createdAt": "#notnull","name": "#string","id": "#notnull","job": "#string"}
  * match $ == {"createdAt": "#notnull","name": "#(response.name)","id": "#notnull","job": "#(response.job)"}
  * validateResponse()
  Examples:
  | read('classpath:helpers/test_data.json') |
  
  Scenario Outline: register user post -data driven test of negative scenarios
    Given path 'register'
    And request { email: '#(email)', password: '#(password)' }
    When method post
    Then status 400
    * match response == errorResponse
    * validateResponse()
    Examples: 
      | read('classpath:helpers/user_registration.json') |
