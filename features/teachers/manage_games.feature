Feature: Teacher manages customized games

	Background:
	  Given a teacher exists
		And that teacher has 200 games
		And there are 3 games which are the "Leap Frog" activity
		And there is 1 game with the description "Unique game for tests"
		And I am logged in as that teacher
		And I am on that teacher's games page
	
	Scenario: View all my games
		When I am on my games page
		Then I should see "(200 total)"
	
	Scenario: Search my games
		When I follow "Search my games"
		And I fill in "description" with "Unique"
		And I press "Search"
		Then I should see "1 game"
		And I should see "Unique game for tests"