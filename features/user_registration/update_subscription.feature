Feature: Users can upgrade and extend existing subscriptions, and renew expired subscriptions
	
	Background:
		Given a school exists with a name of "Northwest"
	  Given the following subscription plan exists:
	    | name    | max teachers | cost |
	    | premium | 2            | 99   |
	    | basic   | 2            | 79   |
			| trial   | 1  					 | 0    |
	  And the following subscription exists:
	    | pin   | subscription plan |
	    | 12345 | name: premium     |
	    | 54321 | name: basic       |
	    | 99999 | name: trial       |
	  And the following teacher exists:
	    | subscription | school          | first_name | email               |
	    | pin: 12345   | name: Northwest | Bob        | premium@example.com |
	    | pin: 54321   | name: Normal    | Joe        | basic@example.com   |
			| pin: 99999   | name: FCS       | Steve      | trial@example.com   |
	  And a game exists with a getting started of "true"
	  And a state exists with a name of "Pennsylvania"
	
	@javascript
	Scenario: User extends annual subscription
		Given I am logged in as "Bob"
		When I follow "Purchase now and send me an invoice for $99" within "#extend"
		Then I should see "Your subscription has been renewed for one year."
		And "premium@example.com" opens the email with subject "LinguaZone.com Invoice"
		And they should see "Order total: $99" in the email body
	
	Scenario: User upgrades a subscription
		Given I am logged in as "Joe"
		When I follow "Purchase now and send me an invoice for $20" within "#upgrade"
		Then I should see "Your subscription has been upgraded."
		And "basic@example.com" opens the email with subject "LinguaZone.com Invoice"
		And they should see "Order total: $20" in the email body

	Scenario: User with an expired trial renews for a basic 12-month subscription
		Given "Steve"'s subscription has expired
		When I am on the teacher login page
		And I fill in "Email address:" with "trial@example.com"
		And I fill in "Password:" with "test"
		And I press "Login"
		Then I should see "Your subscription has expired"
		When I choose "Basic subscription for up to 2 teachers" 
		And I press "Activate my account now and send me an invoice"
		Then "trial@example.com" opens the email with subject "LinguaZone.com Invoice"
		And they should see "Order total: $79" in the email body
		And I should see "Your subscription has been renewed"
