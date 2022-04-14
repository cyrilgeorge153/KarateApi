@ignore
Feature: pre steps of restful booker api

  Scenario: pre steps
    Given url 'https://restful-booker.herokuapp.com/auth'
    And request {"username" : "admin","password" : "password123"}
    When method post
    Then status 200
    * match $.token == '#present'
    * match $.token == '#notnull'
    * match response.token == '#present'
    * match response.token == '#notnull'
    * def token = response.token
    Given header Content-Type = 'application/json'
    And header Accept = 'application/json'
    * url 'https://restful-booker.herokuapp.com/booking'
    * request {"firstname" : "Jim","lastname" : "Brown","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    When method post
    Then def booking_id = response.bookingid
