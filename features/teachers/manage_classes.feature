Feature: Manage classes
	As a subscribing teacher
	In order to control my class pages on LinguaZone.com
	I want to be able to manage all class information
	
	Background:
    Given a teacher exists with a first name of "Tony"
	
	Scenario: Create a new class
		Given I am logged in as a teacher
		And I am on the my courses page
		When I follow "new class"
		And I fill in "Class name" with "Latin 3A"
		And I press "Create"
		Then I should see "Latin 3A"
		And I should see "taught by"
		And I should see "This is your new class page"
	
	Scenario: I am browsing my classes but I have not made any yet
		Given I am logged in as a teacher
		And I have 0 courses
		And I am on the my courses page
		Then I should see "You have not created any class pages yet."
	
	Scenario: I am browsing my classes
		Given I am logged in as a teacher
		And the following courses exist:
		 | name             | user             |
		 | Spanish 8        | first_name: Tony |
		 | Prima Lingua 6-1 | first_name: Tony |
		And I am on the my courses page
		Then I should see "Spanish 8"
		And I should see "Prima Lingua 6-1"
		And I should not see "Latin 3A"
	
	Scenario: Rename a class
		Given I am logged in as a teacher
		And the following course exists:
		 | name      | user             |
		 | Spanish 8 | first_name: Tony |
		And I am on the my courses page
		When I follow "Edit"
		And I fill in "Class name" with "French 8"
		And I press "Update"
		Then I should see "Your class has been updated"
		And I should be on the my courses page
		And I should see "French 8"
	
	Scenario: Delete a class
		Given I am logged in as a teacher
		And the following course exists:
		 | name      | user             |
		 | Spanish 8 | first_name: Tony |
		And I am on the my courses page
		When I follow "Delete"
		Then I should see "Spanish 8 has been deleted"
		And I should be on the my courses page
	
	
	Scenario: Archive a class
		Given I am logged in as a teacher
		And the following course exists:
  	 | name      | user             |
		 | Spanish 8 | first_name: Tony |
	  And I am on the my courses page
	When I follow "Edit"
	And I check "Archive this class"
	And I press "Update this class"
	Then I should be on the my courses page
	And I should see "Your class has been updated"
	And "Spanish 8" should be archived