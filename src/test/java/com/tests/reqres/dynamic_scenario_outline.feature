@ignore
Feature: Dynamic Scenario Outline

  Background:
    * def kittens = read('classpath:com/tests/test.json')
    
  Scenario Outline: cat name : <name>
    * print "<name>"
    
    Examples:
      | kittens |