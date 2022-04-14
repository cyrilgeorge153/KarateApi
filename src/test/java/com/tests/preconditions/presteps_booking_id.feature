@ignore
Feature: pre steps of restful booker booking id

  Scenario: pre steps booking id
    Given header Content-Type = 'application/json'
    And header Accept = 'application/json'
    * url 'https://restful-booker.herokuapp.com/booking'
    * request {"firstname" : "Jim","lastname" : "Brown","totalprice" : 111,"depositpaid" : true,"bookingdates" : {"checkin" : "2018-01-01","checkout" : "2019-01-01"},"additionalneeds" : "Breakfast"}
    When method post
    Then def booking_id = response.bookingid