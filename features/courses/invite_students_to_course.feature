Feature: Teacher can invite students to register in a given course
	
	Background:
		Given a teacher exists with a first name of "Sarah"
		And a school exists with a name of "LZAcademy"
		And Sarah has a course at that school named "Sample Latin"
		And I am logged in as "Sarah"
		And I am on the "Sample Latin" course registrations page
	
	Scenario: Teacher invites a single student to join a course
		Given I follow "Invite students"
		When I fill in "Enter student email addresses here:" with "student@example.com"
		And I press "Send email invitations"
		Then "student@example.com" should receive an email with subject /Join Sample Latin on LinguaZone.com/
		And I should see "Email invitation (1 total) successfully sent"
	
	Scenario: Teacher invites multiple students to join a course
		Given I follow "Invite students"
		When I fill in "Enter student email addresses here:" with "student@example.com, student2@example.com, student3@example.com"
		And I press "Send email invitations"
		Then "student@example.com" should receive an email with subject /Join Sample Latin on LinguaZone.com/
		And "student2@example.com" should receive an email with subject /Join Sample Latin on LinguaZone.com/
		And "student3@example.com" should receive an email with subject /Join Sample Latin on LinguaZone.com/
		And I should see "Email invitations (3 total) successfully sent"
		
	Scenario: Student follows a link in an email to create an account and register in a class page
		Given I follow "Invite students"
		When I fill in "Enter student email addresses here:" with "student@example.com"
		And I press "Send email invitation"
		And I have logged out
		Then "student@example.com" should have an email
		When they open the email with subject "Join Sample Latin on LinguaZone.com"
		And they follow "Click here to register and get started" in the email
		Then I should see "Please login or create an account below to access your class page"
		And I follow "Create a username & password"
		And I fill in "Your first name:" with "Sample"
		And I fill in "Your last name:" with "Student"
		And the "Your email address:" field should contain "student@example.com"
		And I fill in "Create a LinguaZone password:" with "pass123"
		And I press "Create account"
		Then I should see "Sample Latin"
		And I should see "taught by Sarah"
		And I should see "You have successfully registered your new account in this class"