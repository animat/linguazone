Feature: Manage classes
	As a subscribing teacher
	In order to control my class pages on LinguaZone.com
	I want to be able to manage all class information
	
	Background:
	  Given a teacher exists
	
	@wip
	Scenario: Create a new class
		Given I am logged in as a teacher
		And I am on the my courses page
		When I follow "new class"
		And I fill in "Class name" with "Latin 3A"
		And I press "Create"
		Then I should see "successfully"