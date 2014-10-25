Feature: Search Qwinix Technologies on Google search


  Background:
    Given I have opened google
      When I see the search page

  Scenario Outline: Users can perform search on Google
    Given I have opened google search I should be able to search for "<search>"
      Then  I should see the results page

  Examples:
  | search     |
  | Qwinix Technologies  |
 