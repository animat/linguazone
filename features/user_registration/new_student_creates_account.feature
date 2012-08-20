Feature: New student creates account

	Background:
	  Given the following student exists:
	    | email             | password  |
	    | tony@sopranos.com | badabing  |
		Given a school exists with a name of "LZAcademy"
		And a teacher has a course at that school named "Latin 2"
	@wip
	Scenario: Successfully create a new student account
		When I am on the new student page
		And I fill in "Your first name:" with "Carmella"
		And I fill in "Your last name:" with "Soprano"
		And I fill in "Your email address:" with "carmella@sopranos.com"
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
		And I fill in "Your email address:" with "tony@sopranos.com"
		And I fill in "Create a LinguaZone password:" with "new-lz-password"
		And I press "Create account"
		Then I should see "That username or email address is already in the database"
	
	Scenario: Fail to create a new student account when omitting a password
		When I am on the new student page
		And I fill in "Your first name:" with "Carmella"
		And I fill in "Your last name:" with "Soprano"
		And I fill in "Your email address:" with "carmella@sopranos.com"
		And I press "Create account"
		Then I should see "Password can't be blank"
	
	@wip @javascript
	Scenario: Create a new student with a username instead of an email address
		When I am on the new student page
		And I fill in "Your first name:" with "Luca"
		And I fill in "Your last name:" with "Brazzi"
		And I follow "click here" within "#email_hint"
		And I fill in "Create a new username to use LinguaZone:" with "fishZZZ123"
		And I fill in "Create a LinguaZone password:" with "tmp-password"
		And I press "Create account"
		Then I should see "Overview"
		And I should see "Register in a new class"
	
	#TODO: Could not complete this test...
	@javascript
	Scenario: Register in a password protected class page
		Given I am logged in as a student
		When I follow "Register in a new class"
		And I fill in "Your school's name:" with "LZAcademy"
		And I press "Check the database"
		And I choose "Latin 2 taught by Joe Teacher"
		And I press "Continue registration"
		And I wait until "Continue registration" is not visible
		Then show me the page
		#Then I should see "Please enter the Latin 2 class code"
		
		And I fill in "Please enter the Latin 2 class code:" with "banana"
		#And I press "Register"
		
		
	# TODO @Len [later]: Any tips on how to use OAuth so that I can have users sign up with their Google Accounts?
	#				Also, sometimes students report having bizarre login problems. No idea how to troubleshoot these issues.
	#				The site used to use one service, then switched to Authlogic. Feeling like I'm in an in between state. Not sure how to move forward.
	#		Related: could you help me consolidate duplicate student accounts?