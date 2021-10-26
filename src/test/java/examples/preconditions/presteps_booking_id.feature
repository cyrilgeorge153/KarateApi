@ignore
Feature: pre steps of restful booker booking id

  Scenario: pre steps booking id
    Given header Content-Type = 'application/json'
    Given header Accept = 'application/json'
    Given url 'https://restful-booker.herokuapp.com/booking'
    And request {"firstname" : "Jim","lastname" : "Brown","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    When method post
    * def booking_id = response.bookingid