Feature: An existing student and teacher can log in

	Background:
	  Given the following student exists:
	    | email             | password  |
	    | tony@sopranos.com | badabing  |
		Given a teacher exists


	Scenario: Login with existing student account
	  Given I go to the student login page
	  And I fill in "Username or email address:" with "tony@sopranos.com"
	  And I fill in "Password:" with "badabing"
	  And I press "Login"
	  Then I should see "Overview"

	Scenario: Login with existing teacher account
	  Given I go to the teacher login page
	  And I fill in "Email address:" with "test@example.com"
	  And I fill in "Password:" with "test"
	  And I press "Login"
	  Then I should see "Overview"
	

# TODO:	
# 	Scenario Outline: Login as an existing parent
# 	  Given 1 parent
# 	  When I go to the parent sign in page
# 	  And I fill in "Email" with <email>
# 	  And I fill in "Password" with <password>
# 	  And I press "Sign in"
# 	  Then I should see <feedback>
#
# 	  Examples:
# 	    | email | password | feedback |
#       | "parent@example.com" | "password" | "Signed in successfully" |
#       | "parent@example.com" | "fail"     | "Invalid"                |