Feature: Teacher creates custom games

  Background:
    Given a teacher exists with a first name of "John"
    And the following activities exist:
      | name         | game type       | node_options |
      | Leap Frog    | OneToOne        | { "question": { "prompt": "The question a student sees", "types": ["text", "image"], "count": 1  }, "response": { "prompt": "The response image", "types": ["image"], "count": 5  }} |
      | Garden Grows | TargetWord      | { "question": { "prompt": "The question a student sees", "types": ["text"], "count": 1  } } |
      | Quiz Show    | MultipleAnswer  | { "question": { "prompt": "The question a student sees", "types": [ "text", "image" ], "count": 1 }, "response": { "prompt": "The response image", "types": [ "image" ], "count": 5 } } |
      | Downfall     | DoubleWordMatch | { "question": { "prompt": "The question a student sees", "types": [ "text", "image" ], "count": 1 }, "response": { "prompt": "The response image", "types": [ "image" ], "count": 5 } } |

    And the following languages exist:
      | name    |
      | Spanish |
    And I am logged in as "John"

  @customizer
  @javascript
  Scenario: Create and Edit a Game
    When I am on the customization page
    And I follow "Spanish"
    And I follow "Leap Frog"
    Then wait a second
    And I enter "niño" for node 1 for "question"
    And I enter "boy" for node 1 for "response"
    And I add another node
    And I enter "carro" for node 2 for "question"
    And I enter "car" for node 2 for "response"
    And I press "Next step"
    And I press "Create Game"
    Then I should see "Game Created"
    When I follow "GAMES"
    Then I should not see "You have not created any games yet"
    And there should be 1 "Leap Frog" Game
    When I follow "Edit"
    Then wait a second
    Then I should see the answer "car"


  # TODO: test multiple answers
  @customizer
  @javascript
  @wip
  Scenario: Customize Quiz Show"
    Then wait a second
    And I fill in word list 1 with "car,goat,cow"
    And I move to the next step for node 1
    Then wait a second
    And I enter "carro" for node 1 for "question"
    And I select "car" for node 1 for "response"
    And I enter "carro" for node 1 for "question"
    And I add another node
    And I fill in word list 2 with "bird,goat,cow"
    And I enter "vaca" for node 2 for "question"
    And I select "cow" for node 2 for "response"
    And I enter "vaca" for node 2 for "question"
    And I press "create-game"
    And I should not see "not have"
    Then wait a second
    And my game has been created
