Feature: Send reminder emails to users whose accounts will soon expire
	
	Background:
		Given the following subscription plans exist:
		 | name    |
		 | trial   |
		 | basic   |
		 | premium |
		And a teacher exists with an email of "teacher@example.com"
		And the trial subscription for "teacher@example.com" will expire in 5 weeks
	
	Scenario: Trial account will expire in one week
		Given a teacher exists with an email of "trial@example.com"
 		And the trial subscription for "trial@example.com" will expire in 1 week
		When the reminder emails are sent
		Then "trial@example.com" should receive 1 email with subject "One week left in your trial at LinguaZone.com"
		And "teacher@example.com" should receive 0 emails
	
	Scenario: Trial account will expire in two days
		Given a teacher exists with an email of "trial@example.com"
 		And the trial subscription for "trial@example.com" will expire in 3 days
		When the reminder emails are sent
		Then "trial@example.com" should receive 1 email with subject "Three days left in your trial at LinguaZone.com"
		And "teacher@example.com" should receive 0 emails
	
	Scenario: Trial account has expired
		Given a teacher exists with an email of "trial@example.com"
 		And the trial subscription for "trial@example.com" expired yesterday
		When the reminder emails are sent
		Then "trial@example.com" should receive 1 email with subject "Subscribing to LinguaZone.com"
		And "teacher@example.com" should receive 0 emails

	Scenario: Paid account will expire in two weeks
		Given a teacher exists with an email of "paid@example.com"
 		And the basic subscription for "paid@example.com" will expire in 14 days
		When the reminder emails are sent
		Then "paid@example.com" should receive 1 email with subject "Time to renew your LinguaZone subscription"
		And "teacher@example.com" should receive 0 emails

	Scenario: Paid account will expire in one week
		Given a teacher exists with an email of "paid@example.com"
 		And the basic subscription for "paid@example.com" will expire in 7 days
		When the reminder emails are sent
		Then "paid@example.com" should receive 1 email with subject "One week left: renew your LinguaZone subscription"
		And "teacher@example.com" should receive 0 emails

	Scenario: Paid account will expire in two days
		Given a teacher exists with an email of "paid@example.com"
 		And the basic subscription for "paid@example.com" will expire in 2 days
		When the reminder emails are sent
		Then "paid@example.com" should receive 1 email with subject "Checking in about your subscription to LinguaZone"
		And "teacher@example.com" should receive 0 emails