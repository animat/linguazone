Feature: Teacher can invite students to register in a given course
	
	Background:
		Given a teacher exists with a first name of "Sarah"
		And a school exists with a name of "LZAcademy"
		And Sarah has a course at that school named "Sample Latin"
		And I am logged in as "Sarah"
		And I am on the "Sample Latin" course registrations page
	
	@wip
	Scenario: Teacher invites a single student to join a course
		Given I follow "Invite students"
		When I fill in "Enter student email addresses here:" with "student@example.com"
		#Then "student@example.com" should receive an email with subject /Join Sample Latin on LinguaZone.com/
		Then "student@example.com" should receive an email
		And I should see "Email invitation (1 total) successfully sent"
		
	Scenario: Teacher invites multiple students to join a course