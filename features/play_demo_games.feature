Feature: Guests to the website can play demos of all games in all languages

	Background:
		Given the following languages exist:
		 | name    |
		 | Spanish |
		 | Latin   |
		And the following activities exist:
		 | name            |
		 | Leap Frog       |
		 | Fishing         |
		 | Sentence Swiper |
		And the following games exist:
		 | activity              |
		 | name: Leap Frog       |
		 | name: Fishing         |
		 | name: Sentence Swiper |
		And the following demos exist:
		  | language      | activity              |
		  | name: Spanish | name: Leap Frog       |
		  | name: Spanish | name: Fishing         |
		  | name: Spanish | name: Sentence Swiper |
	
	Scenario: Play Spanish demos
		When I am on the Spanish demos page
		Then I should see links for at least 2 games
		And I should not see "Sorry, demos for Spanish are not yet available."
	
	Scenario: No demos available
		When I am on the Latin demos page
		Then I should see links for 0 games
		And I should see "Sorry, demos for Latin are not yet available."
		