Feature: Users can upgrade and extend existing subscriptions, and renew expired subscriptions
	
	Background:
		Given a school exists with a name of "Northwest"
	  Given the following subscription plan exists:
	    | name    | max teachers | cost |
	    | premium | 2            | 99   |
	    | basic   | 2            | 79   |
	  And the following subscription exists:
	    | pin   | subscription plan |
	    | 12345 | name: premium     |
	    | 54321 | name: basic       |
	  And the following teacher exists:
	    | subscription | school          | first_name | email               |
	    | pin: 12345   | name: Northwest | Bob        | premium@example.com |
	    | pin: 54321   | name: Normal    | Joe        | basic@example.com   |
	  And a game exists with a getting started of "true"
	  And a state exists with a name of "Pennsylvania"
	
	@javascript
	Scenario: User extends annual subscription
		Given I am logged in as "Bob"
		When I follow "Purchase now and send me an invoice for $99"
		Then I debug
		Then I should see "Your subscription has been renewed for one year."
		And "Bob" should receive an email