Feature: Teacher manages posts for audio blogs

	Background:
	  Given a teacher exists with a first name of "John"
		And John has 10 posts
		And John has a post with a description of "This is a unique post for searching"
		And I am logged in as "John"
	
  Scenario: I do not have any posts and the site points me to create a new post
		Given I have 0 posts
    When I am on the my posts page
		Then I should see "create your first one"
	
	Scenario: I browse my posts
		When I am on the my posts page
		Then I should see "Sample post"

	# TODO @Len: Not sure why I can't test basic subscription access in this way. 
	#					The controller should block me out. Should I use a before_filter?
	Scenario: I am not a premium subscriber
		Given I have logged out
		And John is subscribed with a basic subscription
		And John has 0 posts
		When I am logged in as "John"
		And I am on the my posts page
		Then show me the page
		Then I should see "Interested in upgrading?"
		And I should not see "create your first one"