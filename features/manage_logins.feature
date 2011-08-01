Feature: Manage logins
  In order to allow teachers access to the site
  As a teacher
  I want to login
  
  Scenario: Login successfully
    Given I am on the teacher login page
		And the following user:
			| email | "test@example.com" |
			| password | "test" |
    When I fill in "Email" with "test@example.com"
		And I fill in "Password" with "test"
		And I press "Login"
		Then I should see "My account"
