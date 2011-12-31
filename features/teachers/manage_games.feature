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
		And the following course exists:
		 | user             | name       |
		 | first_name: John | Test class |
		And a teacher exists with a first name of "Bob"
		And Bob has a game with a description of "adopt this game"
		And I am logged in as "John"
		And I am on the my games page
	
	Scenario: View all my games
		Then I should see "(14 total)"
	
	Scenario: Search my games by description
		When I fill in "Search for:" with "unique"
		And I press "Search"
		Then I should see "Search results (1 total)"
		And I should see "unique game for searching"
		And I should not see "No games matched your search terms."
		And I should see "Edit" within the first search result row
	
	Scenario: Search my games by game type
		When I select "Leap Frog" from "Customized in..."
		And I press "Search"
		Then I should see "Search results (3 total)"
		And I should see "Edit" within the first search result row
		And I should not see "Show" within the first search result row
		And I should not see "Adopt" within the first search result row
	
	Scenario: Search hidden games on a given class page
		Given John has a hidden game on the "Test class" class page
		When I select "Test class" from "Listed under..."
		And I select "hidden" from "which is..."
		And I press "Search"
		Then I should see "Hidden games in Test class (1 total)"
		And I should see "Show" within the first search result row

	Scenario: Adopt a game
		Given I follow "Adopt a game"
		When I fill in "Search for:" with "adopt this game"
		And I press "Search"
		Then I should see "Adopt" within the first search result row
		And I should not see "Edit" within the first search result row
		
	# TODO: Showing/ hiding the advanced options here is a bit clunky. Not sure how the show/hide link should function; not sure how to test it.
	@javascript @wip
	Scenario: Advanced search options should be hidden at first
		Then "Customized in..." should not be visible
		And "which is..." should not be visible
		And "Search for:" should not be visible
		
	# TODO: Not sure this is properly testing JavaScript visibility either
	@javascript
	Scenario: Advanced search options should be visible when in use
		Given I select "Leap Frog" from "Customized in..."
		And I select "Test class" from "Listed under..."
		And I select "hidden" from "which is..."
		When I press "Search"
		Then I should see "Customized in"
		And I should see "which is..."