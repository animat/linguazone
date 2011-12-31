Feature: Join an existing subscription
  Background:
    Given a school exists with a name of "Northwest"
    Given the following subscription plan exists:
      | name    | max teachers | cost |
      | premium | 2            | 100  |
      | normal  | 2            | 100  |
      | premium | 22           | 200  |
      | premium | -1           | 200  |
    And the following subscription exists:
      | pin   | subscription plan |
      | 12345 | name: premium     |
      | 54321 | name: normal      |
    And the following teacher exists:
      | subscription | school          |
      | pin: 12345   | name: Northwest |
      | pin: 54321   | name: Normal    |
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

