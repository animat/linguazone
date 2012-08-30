Feature: A teacher can manage which students are registered in a given course
	
	Background:
		Given a teacher exists with a first name of "John"
		And a school exists with a name of "LZAcademy"
		And John has a course at that school named "Sample Latin"
		And there are 10 students enrolled in "Sample Latin"
		And I am logged in as "John"
		And I am on the "Sample Latin" class page
	
	Scenario: View all students registered in a course
		When I follow "10 students enrolled"
		Then I should see "Sample Latin class list"
		And I should see 10 "Remove from class" links

	@javascript
	Scenario: Remove a student from a course
		Given I follow "10 students enrolled"
		When I follow "Remove from class" and click OK within the 2nd student listing
		Then I should see "That student has been removed"
		And I should see 9 "Remove from class" links