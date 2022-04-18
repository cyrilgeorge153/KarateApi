@ignore
Feature: Dynamic Scenario Outline

  Background:
    * def kittens = read('../data/test.json')
    
  Scenario Outline: cat name : <name>
    * print "<name>"
    
    Examples:
      | kittens |