Feature: A teacher can view all of the activities a student has logged on their class page

	Background:
		Given a teacher exists with a first name of "Sarah"
		And a school exists with a name of "LZAcademy"
		And Sarah has a course at that school named "Sample Latin"
		And Sarah has 3 games
		And Sarah has 2 word lists
		And Sarah has 4 posts
		And all of Sarah's games, word lists, and posts are showing on the "Sample Latin" page
		And a student exists with a first name of "Bob"
		And "Bob" is enrolled in "Sample Latin"
		And I am logged in as "Sarah"
		And I am on the "Sample Latin" course registrations page
	
	Scenario: View a student who has no activities logged
		When I follow "Bob Smith"
		Then I should see "No activities have yet been recorded"
	
	Scenario: View a student who has played games, studied word lists, and recorded audio comments
		Given "Bob" has recorded 3 high scores in "Sample Latin"
		And "Bob" has created 1 comment on a post in "Sample Latin"
		And "Bob" has studied 2 word lists in "Sample Latin"
		When I follow "Bob Smith"
		Then I should see 6 feed items listed within the activity stream
	
	Scenario: View a full class's activity stream
		Given a student exists with a first name of "Tommy"
		And "Tommy" is enrolled in "Sample Latin"
		And "Tommy" has created 1 comment on a post in "Sample Latin"
		And "Tommy" has recorded 2 high scores in "Sample Latin"
		And "Bob" has recorded 3 high scores in "Sample Latin"
		And "Bob" has created 1 comment on a post in "Sample Latin"
		And "Bob" has studied 2 word lists in "Sample Latin"
		When I am on the "Sample Latin" course feed items page
		Then I should see 9 feed items listed within the activity stream