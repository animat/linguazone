Feature: Teacher is prompted to upgrade
  Background:
    Given a school exists with a name of "Northwest"
    Given the following subscription plan exists:
      | name    | max teachers | cost |
      | premium | 5            | 100  |
      | normal  | 5            | 100  |
      | premium | 22           | 200  |
      | premium | -1           | 500  |
    And the following subscription exists:
      | pin   | subscription plan     |
      | 12345 | name: premium         |
      | 54321 | name: normal          |
      | 66666 | max teachers: -1      |
    And the following teacher exists:
      | subscription | school          |
      | pin: 12345   | name: Northwest |
      | pin: 54321   | name: Normal    |
      | pin: 66666   | name: Ultimate  |
    And a game exists with a getting started of "true"
    And a state exists with a name of "Pennsylvania"

  Scenario: See upgrade options for premium plans
    Given I am on the pricing page
    And I fill in "pin" with "12345"
    And I press "Proceed"
    When I fill in my account details
    And I press "Create account and get started!"
    And I am on the teachers page
    Then I should see "Premium subscription for up to 22 teachers"
    Then I should see "Premium subscription for unlimited teachers"

  Scenario: See upgrade options for normal plans
    Given I am on the pricing page
    And I fill in "pin" with "54321"
    And I press "Proceed"
    When I fill in my account details
    And I press "Create account and get started!"
    And I am on the teachers page
    Then I should see "Premium subscription for up to 5 teachers"
    Then I should see "Premium subscription for up to 22 teachers"
    Then I should see "Premium subscription for unlimited teachers"

  Scenario: See message when no upgrades exist
    Given I am on the pricing page
    And I fill in "pin" with "66666"
    And I press "Proceed"
    When I fill in my account details
    And I press "Create account and get started!"
    And I am on the teachers page
    Then I should see "No upgrades are available for your account."
