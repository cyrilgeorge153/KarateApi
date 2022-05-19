@ignore
Feature: Dynamic Scenario Outline

  Background:
    * def kittens = read('classpath:helpers/test.json')
    
  Scenario Outline: cat name : <name>
    * print "<name>"
    
    Examples:
      | kittens |