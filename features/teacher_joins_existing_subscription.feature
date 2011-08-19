Feature: Join an existing subscription
  Background:
    Given a school exists with a name of "Northwest"
    Given a subscription exists with a pin of "12345"
    And the following teacher exists:
      | subscription |
      | pin: 12345   |
    And a game exists with a getting started of "true"
    And a state exists with a name of "Pennsylvania"

  Scenario: Join an existing subscription
    Given I am on the pricing page
    And I fill in "pin" with "12345"
    And I press "Proceed"
    When I fill in my account details
    And I press "Create account and get started!"
    Then I should see "Let's get started!"

  Scenario: Fill in incorrect pin
    Given I am on the pricing page
    And I fill in "pin" with "312345"
    And I press "Proceed"
    Then I should see "Sorry"
    And I should be on the pricing page
 
 


