Feature: Teachers control the resources available on their class page

	Background:
		Given a teacher exists with a first name of "John"
		And John has 2 games
		And John has 2 word lists
		And John has 2 posts
		And the following course exists:
		 | user             | name       |
		 | first_name: John | Test class |
		And I am logged in as "John"
		And I am on the "Test class" course page
	
	#TODO @Len: Not sure why I can't update here. Trying to make courses more RESTful...
	Scenario: Update the class code on the page
		When I fill in "Students can register in this class using the class code:" with "code"
		And I press "Update"
		Then I should see "Updated class settings"