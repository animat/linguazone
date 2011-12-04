Feature: A new teacher creates a trial account

	Background:
	  Given a teacher exists
	
  Scenario: I do not have any posts and the site points me to create a new post
		Given I am logged in as a teacher
		And I have 0 posts
    When I am on my posts page
		Then I should see "not yet created"
	
	@wip
	Scenario: I browse my posts
		Given I am logged in as a teacher
		And I have 10 posts
		When I am on my posts page
		Then I should see "Sample post"