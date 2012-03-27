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
	
	Scenario: Fail to create a new student account with duplicate username
		When I am on the new student page
		And I fill in "Your first name:" with "Tony"
		And I fill in "Your last name:" with "Soprano"
		And I fill in "Email address or username:" with "tony@sopranos.com"
		And I fill in "Create a LinguaZone password:" with "new-lz-password"
		And I press "Create account"
		Then I should see "That username or email address is already in the database"
	
	# TODO @Len [later]: Any tips on how to use OAuth so that I can have users sign up with their Google Accounts?
	#				Also, sometimes students report having bizarre login problems. No idea how to troubleshoot these issues.
	#				The site used to use one service, then switched to Authlogic. Feeling like I'm in an in between state. Not sure how to move forward.
	#		Related: could you help me consolidate duplicate student accounts?