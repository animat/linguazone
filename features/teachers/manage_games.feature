Feature: Teacher manages customized games
	
	Background:
	  Given a teacher exists with a first name of "John"
		And the following activities exist:
		 | name        |
		 | Leap Frog   |
		 | Mantis      |
		 | Cliffhanger |
		And "John" has 10 games
		And "John" has 3 games which are the "Leap Frog" activity
		And a game exists with a description of "Unique game for tests"
		And I am logged in as "John"
		And I am on the my games page
	
	@wip
	Scenario: View all my games
		Then I should see "(14 total)"
	
	
	Scenario: Search my games
		When I press "View all my games"
		Then show me the page
		When I follow "Search my games"
		And I fill in "description" with "Unique"
		And I press "Search"
		Then I should see "1 game"
		And I should see "Unique game for tests"