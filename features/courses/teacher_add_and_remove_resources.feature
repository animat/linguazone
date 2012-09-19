Feature: Teachers control the resources available on their class page

	Background:
		Given a teacher exists with a first name of "John"
		And John has 2 games
		And John has 2 word lists
		And John has 2 posts
		And the following course exists:
		 | user             | name       |
		 | first_name: John | Latin test |
		And all of John's games, word lists, and posts are showing on the "Latin test" page
		And I am logged in as "John"
		And I am on the "Latin test" course page
	
	Scenario: Update the class code on the page
		Given the course "Latin test" has a code of ""
		When I check "login_required"
		And I fill in "code" with "example"
		And I press "Update"
		Then I should see "Updated class settings"
		And the "Latin test" class page should require students to login
		
	@javascript
	Scenario: Disable login required on a class page
		Given the course "Latin test" has a code of "rana"
		And I am on the "Latin test" course page
		When I uncheck "login_required"
		And I press "Update"
		Then I should see "Updated class settings"
		And the "Latin test" class page should not require students to login
		And the "login_required" checkbox should not be checked
	
	Scenario: Do not allow teacher to require login with no class code
		Given I check "login_required"
		And I fill in "code" with ""
		And I press "Update"
		Then I should see "Please enter a class code in order to password-protect this class page."
		And I should not see "Updated class settings"
		And the "Latin test" class page should not require students to login
	
	Scenario: Edit a game from the course page
		When I follow "Edit this game" within the 1st game area
		Then I should see "Edit your LinguaZone game"
	
	Scenario: Edit a word list from the course page
		When I follow "Edit this word list" within the 1st word list area
		Then I should see "Edit your LinguaZone word list"
	
	Scenario: Edit a post from the course page
		When I follow "Edit this post" within the 1st post area
		Then I should see "Editing post"
	
	Scenario: View stats on a game from the course page
		When I follow "View stats" within the 1st game area
		Then I should see "No students in Latin test have played this game yet."
	
	Scenario: View stats on a word list from the course page
		When I follow "View stats" within the 1st word list area
		Then I should see "No students in Latin test have studied this word list yet."
	
	Scenario: Teacher should not be able to view stats on a post from a course page
		Then I should not see "View stats" within the 1st post area
		
	Scenario: Create a new game from the class page
		When I follow "add a game" within the game header section
		And I follow "Create a new game"
		Then I should see "Select a language for your new game"
	
	Scenario: Create a new word list from the class page
		When I follow "add a list" within the word_list header section
		And I follow "Create a new word list"
		Then I should see "Select a language for your new word list"
	
	Scenario: Create a new post from the class page
		When I follow "add a post" within the post header section
		And I follow "Create a post"
		Then I should see "Enter a title for your post"