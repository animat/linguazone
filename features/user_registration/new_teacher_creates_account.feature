Feature: A new teacher creates a trial account
	
  Background:
    Given a subscription plan exists with a name of "trial"
    And a game exists with a getting started of "true"
    And a state exists with a name of "Pennsylvania"

  Scenario: Sign up for a new plan with a new school
    Given I am on the new trial page
    When I enter "Northwest" as my school
    And I fill in my school's address
    Then I should see "Lastly, create your account"
    When I fill in my account details
    And I press "Create trial and get started!"
    Then I should see "Let's get started!"
	
  Scenario: Sign up for a new plan with an existing school
    Given a school exists with a name of "Northwest"
    And I am on the new trial page
    When I enter "Northwest" as my school
    And I fill in my account details
    And I press "Create trial and get started!"
    Then I should see "Let's get started!"

  Scenario: Sign up for a plan with a new school
    Given I am on the pricing page
    And I press "Sign up"
    When I enter "Northwest" as my school
    And I fill in my school's address
    Then I should see "Lastly, create your account"
    When I fill in my account details
    And I press "Create trial and get started!"
    Then I should see "Let's get started!"
	
  Scenario: Sign up for a plan with an existing school
    Given a school exists with a name of "Northwest"
    Given I am on the pricing page
    And I follow "SIGN UP NOW"
    When I enter "Northwest" as my school
    And I fill in my account details
    And I press "Create trial and get started!"
    Then I should see "Let's get started!"