Feature: Teacher manages posts for audio blogs

	Background:
	  Given a teacher exists with a first name of "John"
		And John has 10 posts
		And John has a post with a description of "This is a unique post for searching"
		And the following course exists:
		 | user             | name       |
		 | first_name: John | Test class |
		And I am logged in as "John"
	
  Scenario: I do not have any posts and the site points me to create a new post
		Given I have 0 posts
    When I am on the my posts page
		Then I should see "create your first one"
	
	Scenario: I browse my posts
		When I am on the my posts page
		Then I should see "Sample post"
	
	Scenario: I am booted because I am not a premium subscriber
		Given I have logged out
		And John is subscribed with a basic subscription
		And John has 0 posts
		When I am logged in as "John"
		And I am on the my posts page
		Then I should see "Upgrade to use audio blogs"
		And I should not see "You have not yet created any audio blog posts"
	
	Scenario: Create a new post
		Given I am on the my posts page
		When I follow "Create a new audio blog post"
		And I follow "Test class" within the wrapper
		And I fill in "Enter a title for your post" with "Sample title of an audio blog post"
		And I press "Create"
		Then I should see "Your new post has been created and added to the class page"