Feature: Teacher manages customized games
	
	Background:
	  Given a teacher exists with a first name of "John"
		And the following activities exist:
		 | name        |
		 | Leap Frog   |
		 | Mantis      |
		 | Cliffhanger |
		And John has 10 games
		And John has 3 games which are the "Leap Frog" activity
		And John has a game with a description of "This is a unique game for searching"
		And I am logged in as "John"
		And I am on the my games page
	
	Scenario: View all my games
		Then I should see "(14 total)"
	
	Scenario: Search my games
		When I fill in "Search for:" with "unique"
		And I press "Search"
		Then I should see "1 game"
		And I should see "unique game for searching"