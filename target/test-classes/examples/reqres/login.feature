Feature: swag labs login page ui test cases

  Background:
    * configure driver = { type: 'chrome'}
    Given driver 'https://www.saucedemo.com/'
    And maximize()

  Scenario: swag labs login button display test

    Given waitFor('#login-button')
    And def button_exists = exists('#login-button')
    And print button_exists
    Then match  button_exists == true

  Scenario: swag labs logo display test

    Given waitFor('.login_logo')
    And def button_exists = exists('.login_logo')
    And print button_exists
    Then match  button_exists == true