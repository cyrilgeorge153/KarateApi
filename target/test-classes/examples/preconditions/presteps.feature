@ignore
Feature: pre steps of restful booker api

  Scenario: pre steps
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request {"username" : "admin","password" : "password123"}
    When method post
    Then print response
    Then match $.token == '#present'
    Then match $.token == '#notnull'
    Then match response.token == '#present'
    Then match response.token == '#notnull'
    * def token = response.token
    Given header Content-Type = 'application/json'
    Given header Accept = 'application/json'
    Given url 'https://restful-booker.herokuapp.com/booking'
    And request {"firstname" : "Jim","lastname" : "Brown","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    When method post
    * def booking_id = response.bookingid
