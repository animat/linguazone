Feature: Students access their own class page
	
	Background:
		Given a course exists with a name of "Latin 3A"
		And "Latin 3A" has 3 games showing
		And "Latin 3A" has 2 word lists showing
		And "Latin 3A" has 2 audio blog posts showing
	
	@wip
	Scenario: View page that is not password protected
		When I am on the "Latin 3A" course page
		Then I should see "Play games"
		And I should see "Latin 3A"
		And I should see "Study word lists"
	
	Scenario: Play games from page that is not password protected
	