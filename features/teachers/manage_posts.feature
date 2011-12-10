Feature: Teacher manages posts for audio blogs

	Background:
	  Given a teacher exists
	
  Scenario: I do not have any posts and the site points me to create a new post
		Given I am logged in as a teacher
		And I have 0 posts
    When I am on the my posts page
		Then I should see "not yet created"
	
	Scenario: I browse my posts
		Given I am logged in as a teacher
		And I have 10 posts
		When I am on my posts page
		Then I should see "Sample post"