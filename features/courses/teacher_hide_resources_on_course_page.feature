Feature: Teachers hide resources on their class page
	
	Background:
		Given a teacher exists with a first name of "John"
		And John has 3 games
		And John has 3 word lists
		And John has 3 posts
		And the following course exists:
		 | user             | name       |
		 | first_name: John | Test class |
		And all of John's games, word lists, and posts are showing on the "Test class" page
		And I am logged in as "John"
		And I am on the "Test class" course page
	
	@javascript
	Scenario: Hide a game on the class page
		Given I hover over the course item teacher controls
		Then wait a second
		Then I should see 3 "Hide from students" links for games
		And I follow "Hide from students" within the 2nd game controls area
		Then I should see 2 "Hide from students" links for games

	@javascript
	Scenario: Hide a post on the class page
		Given I hover over the course item teacher controls
		Then wait a second
		Then I should see 3 "Hide from students" links for posts
		And I follow "Hide from students" within the 1st post controls area
		Then I should see 2 "Hide from students" links for posts
	
	@javascript
	Scenario: Hide a word list on the class page
		Given I hover over the course item teacher controls
		Then wait a second
		Then I should see 3 "Hide from students" links for word_lists
		And I follow "Hide from students" within the 1st word_list controls area
		Then I should see 2 "Hide from students" links for word_lists
