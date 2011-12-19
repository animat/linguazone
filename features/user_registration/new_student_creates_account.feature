Feature: New student creates account

	Background:
	  Given the following student exists:
	    | email             | password  |
	    | tony@sopranos.com | badabing  |

	
	Scenario: Successfully create a new student account
		When I am on the new student page
		And I fill in "Your first name:" with "Carmella"
		And I fill in "Your last name:" with "Soprano"
		And I fill in "Email address or username:" with "carmella@sopranos.com"
		And I fill in "Create a LinguaZone password:" with "ediefalco"
		And I press "Create account"
		Then I should be on the students page
		And I should see "Overview"
		And I should see "Register in a new class"
	
	@wip
	Scenario: Fail to create a new student account with duplicate username
		When I am on the new student page
		And I fill in "Your first name:" with "Tony"
		And I fill in "Your last name:" with "Soprano"
		And I fill in "Email address or username:" with "tony@sopranos.com"
		And I fill in "Create a LinguaZone password:" with "new-lz-password"
		And I press "Create account"
		Then I should see "already"
		And I should be on the new student page
	
	# TODO @Len: Any tips on how to migrate to OAuth so that I can have users sign up with their Google Accounts?