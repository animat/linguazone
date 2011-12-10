Feature: Manage classes
	As a subscribing teacher
	In order to control my class pages on LinguaZone.com
	I want to be able to manage all class information
	
	Background:
    Given a state exists with a name of "Pennsylvania"
    And the following subscription plan exists:
      | name    | max teachers | cost |
      | premium | -1           | 500  |
    And the following subscription exists:
      | pin   | subscription plan     |
      | 12345 | name: premium         |
		And the following school exists:
		 | name      | state              |
		 | Northwest | name: Pennsylvania |
    And the following teacher exists:
      | first_name | subscription | school          |
      | Tony       | pin: 12345   | name: Northwest |
	
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
		And I am on the my courses page
		And I have 0 courses
		Then I should see "Create your first class page"
	
	Scenario: I am browsing my classes
		Given I am logged in as a teacher
		And I am on the my courses page
		And the following courses exist:
		 | name             | user             |
		 | Spanish 8        | first_name: Tony |
		 | Prima Lingua 6-1 | first_name: Tony |
		Then I should see "Spanish 8"
		And I should see "Prima Lingua 6-1"