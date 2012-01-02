Feature: Teachers show hidden resources on their class page
	
	Background:
		Given a teacher exists with a first name of "John"
		And John has 2 games
		And John has 2 word lists
		And John has 2 posts
		And the following course exists:
		 | user             | name       |
		 | first_name: John | Test class |
		And all of John's games, word lists, and posts are hidden on the "Test class" page
		And I am logged in as "John"
		And I am on the "Test class" course page
	
	Scenario: Verify all games can be hidden at first
		Then I should see 0 available games
	
	Scenario: Show a hidden game
		When I follow "add a game"
		And I follow "Show a hidden game"
		And I follow "Show" within the first search result row
		Then I should see "This game has been added to your account"
	