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
  @javascript
  Scenario: Customize a game
    When I am on the customization page
    And I follow "Spanish"
    And I follow "Customize Game"
    And I fill in "Your Input" with "niño"
    And I fill in "Student Answer" with "child"
    And I press "Add Question"
    And I fill in "Your Input" with "carro"
    And I fill in "Student Answer" with "car"
    And I press "Create Game"
    Then I should see "Game Created"
    And there should be 1 "Leap Frog" Game
    Then there should be a template for "Leap Frog" Game
