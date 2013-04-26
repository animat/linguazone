Feature: Teacher creates custom games

  Background:
    Given a teacher exists with a first name of "John"
    And the following activities exist:
      | name         | game type  | node_options |
      | Leap Frog    | OneToOne   | { "question": { "prompt": "The question a student sees", "types": ["text", "image"], "count": 1  }, "response": { "prompt": "The response image", "types": ["image"], "count": 5  }} |
      | Garden Grows | TargetWord | { "question": { "prompt": "The question a student sees", "types": ["text"], "count": 1  } } |
    And the following languages exist:
      | name    |
      | Spanish |
    And I am logged in as "John"


  @customizer
  @javascript
  Scenario: Create and Edit a Game
    When I am on the customization page
    And I follow "Spanish"
    And I follow "Customize Leap Frog"
    Then wait a second
    And I enter "niño" for node 1 for "question"
    And I enter "boy" for node 1 for "response"
    And I add another node
    And I enter "carro" for node 2 for "question"
    And I enter "car" for node 2 for "response"
    And I press "Create Game"
    Then I should see "Game Created"
    When I follow "GAMES"
    Then I should not see "You have not created any games yet"
    And there should be 1 "Leap Frog" Game
    When I follow "Edit"
    Then wait a second
    Then show me the page
    Then I should see the answer "car"


  # TODO: test multiple answers
  @customizer
  @javascript
  Scenario: Customize a Garden Grows game
    When I am on the customization page
    And I follow "Spanish"
    And I follow "Customize Garden Grows"
    And I enter "niño" for node 1 for "question"
    And I add another node
    And I enter "carro" for node 2 for "question"
    And I press "create-game"
    And I should not see "not have"
    When I follow "GAMES"
    Then I should not see "You have not created any games yet"
    And there should be 1 "Garden Grows" Game
