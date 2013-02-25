Feature: Students can add comments and get feedback

	Background:
		Given a school exists with a name of "LZAcademy"
		And a teacher exists with a first name of "Sarah"
		And "Sarah" has a course at "LZAcademy" named "Sample class"
		And Sarah has 1 post
		And all of Sarah's games, word lists, and posts are showing on the "Sample class" page
		And the following student exists:
		  | first_name | last_name | email           |
		  | Bob        | Jones     | bob@example.com |
		And "Bob" is enrolled in "Sample class"
	
	Scenario: A student should be able to leave a comment on an audio blog post
		Given I am logged in as the student "Bob"
		And I am on the "Sample class" class page
		And I follow the 1st link within the 1st post area
		And I fill in "Your comment:" with "Sample comment goes here"
		And I press "Submit"
		And I should see "Your comment has been created"
		And I should see "Sample comment goes here" within "#comments"
	
	@javascript
	Scenario: A teacher should be able to add a note to a comment
		Given I am logged in as the student "Bob"
		And I am on the "Sample class" class page
		And I follow the 1st link within the 1st post area
		And I fill in "Your comment:" with "Sample comment goes here"
		And I press "Submit"
		And I have logged out
		And I am logged in as "Sarah"
		When I go to the "Sample class" class page
		And I follow the 1st link within the 1st post area
		When I hover over the comment teacher controls
		And I fill in "comment_1_teacher_note_text_area" with "Example feedback on the comment"
		And I press "Add note"
		And the 1st comment should have a note that says "Example feedback on the comment"
		
	@javascript
	Scenario: A teacher should be able to rate a comment
		Given Bob has left a comment on Sarah's 1st post
		And I am logged in as "Sarah"
		And I go to the "Sample class" class page
		And I follow the 1st link within the 1st post area
		When I hover over the comment teacher controls
		And I follow "3-stars"
		Then there should be a rating of 3 within the 1st comment area