@ignore
Feature: generate oauth 2.o token and reuse it in creating profile

  Background: oauth2.0 token
    Given url 'https://login.salesforce.com/services/oauth2'

    * path 'token'
    * form field grant_type = 'password'
    * form field username = 'apptest@katzion.com'
    * form field password = 'Ganesh@18'
    * form field client_id = '3MVG9fe4g9fhX0E58aNIy03f0wE8LKYfhIVnt1P2lh1eXPIesU.oNmSdI_6CnKaM7S8dLgmwsm5TRxqjvfOl3'
    * form field client_secret = '98E209043DE1BD69CBE2FF78724FF5BD12888AE257DBA1E79E08EDDEF75E5B17'
    * method post
    * status 200
    * print response
    * def accessToken = response.access_token
    Then print 'access token is:'+accessToken

Scenario: create profile
    * def payload = read('profile.json')

#    Given url 'https://login.salesforce.com/services/oauth2'
#
#    * path 'token'
#    * form field grant_type = 'password'
#    * form field username = 'apptest@katzion.com'
#    * form field password = 'Ganesh@18'
#    * form field client_id = '3MVG9fe4g9fhX0E58aNIy03f0wE8LKYfhIVnt1P2lh1eXPIesU.oNmSdI_6CnKaM7S8dLgmwsm5TRxqjvfOl3'
#    * form field client_secret = '98E209043DE1BD69CBE2FF78724FF5BD12888AE257DBA1E79E08EDDEF75E5B17'
#    * method post
#    * status 200
#    * print response
#    * def accessToken = response.access_token
#     Then print 'access token is:'+accessToken

    Given url 'https://katzapptest.my.salesforce.com/services/data/v51.0/sobjects/katzion__Matchscore_Profile__c'
    And header Authorization = 'Bearer ' + accessToken
    And request payload
    When method post
    Then print response

