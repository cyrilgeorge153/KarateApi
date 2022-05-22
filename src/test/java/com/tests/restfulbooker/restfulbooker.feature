Feature: Restful booker api testing

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
    And url restful_booker_base_url
    And request {"firstname" : "Tom","lastname" : "Mathew","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    When method post
    Then status 200
    * match response  == {"bookingid": "#number","booking": {"firstname": "Tom","lastname": "Mathew","totalprice": 111,"depositpaid": true,"bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"additionalneeds": "Breakfast"}}

  Scenario: update booking details
    Given header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And cookie token = token
    And url restful_booker_base_url
    And request {"firstname" : "James","lastname" : "George","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    And path booking_id
    When method put
    Then status 200
    * match response == {"firstname": "James","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "George"}

  Scenario: update booking details using accessing variables of another feature file
    Given header Content-Type = 'application/json'
    And header Accept = 'application/json'
    And cookie token = token
    And url restful_booker_base_url
    And request {"firstname" : "James","lastname" : "George","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    And path booking_id
    When method put
    Then status 200
    * match response == {"firstname": "James","additionalneeds": "Breakfast","bookingdates": {"checkin": "2018-01-01","checkout": "2019-01-01"},"totalprice": 111,"depositpaid": true,"lastname": "George"}
