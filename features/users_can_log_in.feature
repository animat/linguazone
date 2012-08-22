Feature: An existing student and teacher can log in

	Background:
	  Given the following student exists:
	    | email             | password  |
	    | tony@sopranos.com | badabing  |
		Given a teacher exists


	Scenario: Login with existing student account
	  Given I go to the student login page
	  And I fill in "Your email address (or LinguaZone username):" with "tony@sopranos.com"
	  And I fill in "Password:" with "badabing"
	  And I press "Login"
	  Then I should see "Overview"

	Scenario: Login with existing teacher account
	  Given I go to the teacher login page
	  And I fill in "Email address:" with "test@example.com"
	  And I fill in "Password:" with "test"
	  And I press "Login"
	  Then I should see "Overview"