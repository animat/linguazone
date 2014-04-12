Feature: Students access their own class page and use the course items
	
	Background:
		Given a course exists with a name of "Latin 3A"
		And "Latin 3A" has 3 games showing
		And "Latin 3A" has 2 word lists showing
		And "Latin 3A" has 2 audio blog posts showing
	
	Scenario: View a class page that is not password protected
		When I am on the "Latin 3A" course page
		Then I should see "Play games"
		And I should see "Latin 3A"
		And I should see "Study word lists"
	
	Scenario: Play games from page that is password protected
		Given the course "Latin 3A" has a code of "test-code"
		When I am on the "Latin 3A" course page
		Then I should see "Please login before accessing"
	
	Scenario: Visit an audio blog post from the course page
		Given I am on the "Latin 3A" course page
		When I follow the 1st link within the 1st post area
		Then I should see "You must login to participate in this audio blog."

	Scenario: Play a game from the course page
		Given I am on the "Latin 3A" course page
		When I follow the 1st link within the 1st game area
		Then show me the page
		Then I should see "Play Mantis"
		
	Scenario Outline: Use all of the features of a word list
		Given I am on the "Latin 3A" course page
		When I follow the <num> link within the 1st word list area
		Then I should see <header>
		Examples:
		 | num | header                  |
		 | 1st | "Browse your word list" |
		 | 2nd | "Print your list"  |
		 | 3rd | "Study your word list"  |
		 | 4th | "Catch the words"       |