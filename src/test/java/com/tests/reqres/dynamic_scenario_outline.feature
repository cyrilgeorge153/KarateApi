#@ignore
Feature: Dynamic Scenario Outline

  #Background:not applicable for 1.3.0 version
  #* def kittens = read('classpath:helpers/test.json')not applicable for 1.3.0 version
  @setup
  Scenario: 
   * def kittens = read('classpath:helpers/test.json')

  Scenario Outline: cat name : <name>
    * print "<name>"

    Examples: 
      | karate.setup().kittens |
     # | kittens | not applicable for 1.3.0 version
