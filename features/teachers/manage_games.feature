Feature: Teacher manages customized games
	
	# @Len: Do you think we could build this piece together so that I can carry on solo?
	Background:
	  Given a teacher exists with a first_name of "John"
		And "John" has 10 games
		And "John" has 3 games which are the "Leap Frog" activity
		And the following activities exist:
		 | name        |
		 | Leap Frog   |
		 | Mantis      |
		 | Cliffhanger |
		And there is 1 game with the description "Unique game for tests"
		And I am logged in as "John"
		And I am on "John"'s my games page
	
	Scenario: View all my games
		When I am on my games page
		Then I should see "(200 total)"
	
	@wip
	Scenario: Search my games
		When I follow "Search my games"
		And I fill in "description" with "Unique"
		And I press "Search"
		Then I should see "1 game"
		And I should see "Unique game for tests"