Feature: New student creates account

	Background:
	  Given the following student exists:
	    | email             | password  |
	    | tony@sopranos.com | badabing  |
		Given a school exists with a name of "LZAcademy"
		And a teacher has a course at that school named "Latin 2"
		And a teacher has a password-protected course at that school named "Secret Latin" with a code of "tmp_code"
	
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
	
	Scenario: Fail to create a new student account with duplicate username
		When I am on the new student page
		And I fill in "Your first name:" with "Tony"
		And I fill in "Your last name:" with "Soprano"
		And I fill in "Your email address:" with "tony@sopranos.com"
		And I fill in "Create a LinguaZone password:" with "new-lz-password"
		And I press "Create account"
		Then I should see "That username or email address (tony@sopranos.com) is already in the database"
	
	@javascript
	Scenario: Register in a password protected class page
	Scenario: Fail to create a new student account when omitting a password
		When I am on the new student page
		And I fill in "Your first name:" with "Carmella"
		And I fill in "Your last name:" with "Soprano"
		And I fill in "Your email address:" with "carmella@sopranos.com"
		And I press "Create account"
		Then I should see "Password can't be blank"
	
	@javascript
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
	
	@javascript
	Scenario: Navigate to a school, then course, then class page -- then register as a new student -- then direct back to class page
		Given I am on the "LZAcademy" school page
		And I follow "Secret Latin taught by Joe Teacher"
		And I follow "Create a username & password"
		When I fill in "Your first name:" with "Meadow"
		And I fill in "Your last name:" with "Soprano"
		And I fill in "Your email address:" with "m34d0w@sopranos.com"
		And I fill in "Create a LinguaZone password:" with "mdw"
		And I press "Create account"
		Then I should see "Please enter the Secret Latin class code:"
	
	@javascript
	Scenario: Register in a class page that is password protected
		Given I am logged in as a student
		When I follow "Register in a new class"
		And I fill in "Your school's name:" with "LZAcademy"
		And I press "Check the database"
		And I choose "Secret Latin taught by Joe Teacher"
		And I press "Continue registration"
		Then I should see "Please enter the Secret Latin class code"
		And I fill in "code" with "fake-code"
		And I press "Register"
		And I should see "That code was incorrect"
		And I fill in "code" with "tmp_code"
		And I press "Register"
		And I should see "You are all set!"

	@javascript
	Scenario: Register in a class page that is NOT password protected
		Given I am logged in as a student
		When I follow "Register in a new class"
		And I fill in "Your school's name:" with "LZAcademy"
		And I press "Check the database"
		And I choose "Latin 2 taught by Joe Teacher"
		And I press "Continue registration" within "#select_course"
		Then I should see "You are all set!"
