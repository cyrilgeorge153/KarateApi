Feature: Restful booker api testing

  Background: storing booking id value in variable
  #* callonce read('classpath:com/tests/preconditions/presteps.feature')
  
  Scenario: get booking details
    Given header Accept = 'application/json'
    And url restful_booker_base_url
    And path booking_id
    When method get
    Then status 200
    * match response  == {"firstname": "#ignore","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "#ignore"}

  Scenario: create booking
    Given header Content-Type = 'application/json'
    And header Accept = 'application/json'
    * url restful_booker_base_url
    * request {"firstname" : "Tom","lastname" : "Mathew","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    When method post
    Then status 200
    * match response  == {"bookingid": "#number","booking": {"firstname": "Tom","lastname": "Mathew","totalprice": 111,"depositpaid": true,"bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"additionalneeds": "Breakfast"}}

  Scenario: update booking details
    Given header Content-Type = 'application/json'
    And header Accept = 'application/json'
    * cookie token = token
    * url restful_booker_base_url
    * request {"firstname" : "James","lastname" : "George","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    * path booking_id
    When method put
    Then status 200
    * match response == {"firstname": "James","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "George"}

  Scenario: update booking details using accessing variables of another feature file
    * def presStep = call read('classpath:com/tests/preconditions/presteps.feature')
    Given header Content-Type = 'application/json'
    And header Accept = 'application/json'
    * cookie token = presStep.token
    * url restful_booker_base_url
    * request {"firstname" : "James","lastname" : "George","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    * path presStep.booking_id
    When method put
    Then status 200
    * match response == {"firstname": "James","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "George"}
