Feature: A teacher can view all of the activities a student has logged on their class page

	Background:
		Given a teacher exists with a first name of "Sarah"
		And a school exists with a name of "LZAcademy"
		And Sarah has a course at that school named "Sample Latin"
		And Sarah has 3 games
		And Sarah has 2 word lists
		And Sarah has 4 posts
		And all of Sarah's games, word lists, and posts are showing on the "Sample Latin" page
		And there is 1 student enrolled in "Sample Latin"
		And I am logged in as "Sarah"
		And I am on the "Sample Latin" course registrations page
		
	Scenario: View a student who has no activities logged
		When I follow "John Smith"
		Then I should see "No activities have yet been recorded"
	@wip	
	Scenario: View a student who has played games, studied word lists, and recorded audio comments
		Given "John Smith" has recorded 3 high scores in "Sample Latin"
		And "John Smith" has created 1 comment on a post in "Sample Latin"
		And "John Smith" has studied 2 word lists in "Sample Latin"
		When I follow "John Smith"
		Then I should see 6 feed items listed within the activity stream