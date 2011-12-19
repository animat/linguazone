Feature: Teacher manages posts for audio blogs

	Background:
	  Given a teacher exists with a first name of "John"
		And "John" has 10 posts
		And "John" has a post with a description of "This is a unique post for searching"
		And I am logged in as "John"
		And I am on the my posts page
	
  Scenario: I do not have any posts and the site points me to create a new post
		Given I have 0 posts
    When I am on the my posts page
		Then I should see "create your first post"
	
	Scenario: I browse my posts
		When I am on my posts page
		Then I should see "Sample post"