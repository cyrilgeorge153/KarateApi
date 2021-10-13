Feature: Restful booker api testing
  Background: storing booking id and token values in variables
    * call read('classpath:examples/preconditions/presteps.feature')

  Scenario: create booking
    Given header Content-Type = 'application/json'
    Given header Accept = 'application/json'
    Given url 'https://restful-booker.herokuapp.com/booking'
    And request {"firstname" : "Jim","lastname" : "Brown","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    When method post
    And print response
    Then match response  == {"bookingid": #number,"booking": {"firstname": "Jim","lastname": "Brown","totalprice": 111,"depositpaid": true,"bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"additionalneeds": "Breakfast"}}

  Scenario: get booking details
    Given header Accept = 'application/json'
    And url 'https://restful-booker.herokuapp.com/booking'
    And path booking_id
    When method get
    And print response
    Then match response  == {"firstname": "Jim","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "Brown"}

  Scenario: update booking details
    Given header Content-Type = 'application/json'
    Given header Accept = 'application/json'
    And cookie token = token_value
    And url 'https://restful-booker.herokuapp.com/booking'
    And request {"firstname" : "James","lastname" : "Brown","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    And path booking_id
    When method put
    And print response
    Then match response == {"firstname": "James","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "Brown"}