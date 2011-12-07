Feature: Guests can browse the about section of the website

	Scenario: View home page
	  When I am on the home page
	  Then I should see "Customize your own audio blog, games, and word lists"

	Scenario: View features page
	  When I am on the about features page
		Then I should see "Made for language teachers"
	
	Scenario: View features page: games
		When I am on the about games page
		Then I should see "Create your own online games"
	
	Scenario: View features page: word lists
		When I am on the about word lists page
		Then I should see "Customize word lists"
	
	Scenario: View features page: audio blogs
		When I am on the about audio blogs page
		Then I should see "Engage your students in new ways"

	Scenario: View pricing page
		When I am on the pricing page
		Then I should see "Sign up for a basic subscription"
	
	Scenario: View about us page
		When I am on the about us page
		Then I should see "We are language teachers, too"
	
	Scenario: View contact page
		When I am on the contact page
		Then I should see "Get in touch with us"
	
	Scenario: View about languages page
		When I am on the about languages page
		Then I should see "LinguaZone is designed for language teachers"
	
	