Feature: Teacher creates custom games

  Background:
    Given a teacher exists with a first name of "John"
    And the following activities exist:
      | name      |
      | Leap Frog |
    And the following languages exist:
      | name    |
      | Spanish |
    And I am logged in as "John"

  @wip
  Scenario: Customize a game
    When I am on the customization page
    Then show me the page
    And I follow "Spanish"
    And I follow "Leap Frog"
    Then show me the page
