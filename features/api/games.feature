Feature: Use CRUD API for LZ games
	
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
	
	@wip
  Scenario: Get a LZ game to edit
    When I am on the show game 1 api
		Then show me the page
    Then the XML response should have "//name" with the text "matching"
    Then the XML response should not have "//name" with the text "unscrambling"

