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
	
	@javascript
	Scenario: Show a hidden game
		Given I should see 0 "Hide from students" links for games
		And I follow "add a game"
		And I follow "Show a hidden game"
		When I follow "Show" within the first search result row
		Then I should see 1 "Show" link
		And I follow "Go to Test class class page"
		And I hover over the course item teacher controls
		And I should see 1 "Hide from students" link within the available games area

	@javascript
	Scenario: Show a hidden post
		Given I should see 0 "Hide from students" links for posts
		And I follow "add a post"
		And I follow "Show a hidden post"
		When I follow "Show" within the first search result row
		Then I should see 1 "Show" link
		And I follow "Go to Test class class page"
		And I hover over the course item teacher controls
		And I should see 1 "Hide from students" link within the available posts area

	@javascript
	Scenario: Show a hidden word list
		Given I should see 0 "Hide from students" links for word_lists
		And I follow "add a list"
		And I follow "Show a hidden word list"
		When I follow "Show" within the first search result row
		Then I should see 1 "Show" link
		And I follow "Go to Test class class page"
		And I hover over the course item teacher controls
		And I should see 1 "Hide from students" link within the available word lists area