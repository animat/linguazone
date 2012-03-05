Feature: Teachers hide resources on their class page
	
	Background:
		Given a teacher exists with a first name of "John"
		And John has 2 games
		And John has 2 word lists
		And John has 2 posts
		And the following course exists:
		 | user             | name       |
		 | first_name: John | Test class |
		And all of John's games, word lists, and posts are showing on the "Test class" page
		And I am logged in as "John"
		And I am on the "Test class" course page
	
	@javascript @wip
	Scenario: Hide a game on the class page
		Then show me the page
		When I follow "Hide from students" within the 2nd game area
		Then I should see 1 available item within the showing games area

	Scenario: Hide a post on the class page

	Scenario: Hide a word list on the class page