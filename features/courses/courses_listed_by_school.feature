Feature: Customizable list of courses offered at a given school
	
	Background:
		Given a school exists with a name of "LZAcademy"
		And a teacher exists with a first name of "John"
		And "John" has a course at "LZAcademy" named "Latin 1"
		And "John" has a course at "LZAcademy" named "Latin 2"
		And "John" has a course at "LZAcademy" named "Latin 3"
		And a teacher exists with a first name of "Bob"
		And "Bob" has a course at "LZAcademy" named "French 1"
		And "Bob" has a course at "LZAcademy" named "French 2"
		And "Bob" has a course at "LZAcademy" named "French 3"
		And I am logged in as "John"
		And I am on the my courses page
	
	# TODO: Is it possible (or necessary) to test this?
	Scenario: Reorder the list of classes
		Given I follow "Click here to reorganize the list of classes at your school."
		#Then show me the page
		
	Scenario: Cancel the reordering of classes
		Given I follow "Click here to reorganize the list of classes at your school."
		#Then I should see