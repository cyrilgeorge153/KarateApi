Feature: swag labs home page ui test cases
  Background:
    * configure driver = { type: 'chrome'}
    Given driver 'https://www.saucedemo.com/'
    And maximize()
    And waitFor('#user-name')
    And input('[id=user-name]', 'standard_user')
    And waitFor('#password')
    And input('[id=password]', 'secret_sauce')
    And waitFor('#login-button')
    And click('input[id=login-button]')
    * delay(5000)

  Scenario: swag labs home page products heading test
    Given waitFor('.title')
    When def button_exists = exists('.title')
    Then match button_exists == true
    And def heading_text = text('.title')
    And print heading_text
    And match text('.title') == 'Products'

  Scenario: swag labs home page load test
    Given waitFor('.title')
    When def button_exists = exists('.shopping_cart_link')
    And print button_exists
    Then match button_exists == true
