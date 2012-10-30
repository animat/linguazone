Feature: Teacher creates custom games

  Background:
    Given a teacher exists with a first name of "John"
    And the following activities exist:
      | name         |
      | Leap Frog    |
      | Garden Grows |
    And the following languages exist:
      | name    |
      | Spanish |
    And I am logged in as "John"


  @wip
  @javascript
  Scenario: Create and Edit a Game
    When I am on the customization page
    And I follow "Spanish"
    And I follow "Customize Leap Frog"
    And I fill in "Student Answer" with "child"
    And I fill in "Your Input" with "nino"
    And I press "Add Question"
    And I fill in "Student Answer" with "car"
    And I fill in "Your Input" with "carro"
    Then show me the page
    And I press "Create Game"
    Then I should see "Game Created"
    When I follow "GAMES"
    Then I should not see "You have not created any games yet"
    And there should be 1 "Leap Frog" Game
    When I follow "Edit"
    Then wait a second
    Then show me the page
    Then I should see the answer "car"

  @wip
  Scenario: Customize a Garden Grows game
    When I am on the customization page
    And I follow "Spanish"
    And I follow "Customize Garden Grows"
    And I fill in "Target word" with "niño"
    And I press "Add Question"
    And I fill in "Target word" with "carro"
    And I press "Create game"
    Then I should see "Game Created"
    When I follow "GAMES"
    Then I should not see "You have not created any games yet"
    And there should be 1 "Garden Grows" Game
