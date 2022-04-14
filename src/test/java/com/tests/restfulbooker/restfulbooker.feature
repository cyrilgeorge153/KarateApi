Feature: Restful booker api testing
  Background: storing booking id value in variable
    * callonce read('classpath:com/tests/preconditions/presteps_booking_id.feature')

  Scenario: get booking details
    Given header Accept = 'application/json'
    And url restful_booker_base_url
    And path booking_id
    When method get
    And print response
    Then match response  == {"firstname": "#ignore","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "#ignore"}

  Scenario: create booking
    Given header Content-Type = 'application/json'
    Given header Accept = 'application/json'
    Given url restful_booker_base_url
    And request {"firstname" : "Tom","lastname" : "Mathew","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    When method post
    And print response
    Then match response  == {"bookingid": #number,"booking": {"firstname": "Tom","lastname": "Mathew","totalprice": 111,"depositpaid": true,"bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"additionalneeds": "Breakfast"}}

  Scenario: update booking details
    Given header Content-Type = 'application/json'
    Given header Accept = 'application/json'
    And cookie token = token
    And url restful_booker_base_url
    And request {"firstname" : "James","lastname" : "George","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    And path booking_id
    When method put
    And print response
    Then match response == {"firstname": "James","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "George"}

