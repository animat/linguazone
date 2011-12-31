Feature: Teacher manages customized word lists
	
	# TODO: How to handle word_lists/ word lists/ games in the steps?
	Background:
	  Given a teacher exists with a first name of "John"
		And John has 10 word_lists
		And John has a word_list with a description of "This is a unique post for searching"
		And I am logged in as "John"
		And I am on the my word lists page
	
	Scenario: View all my word lists
		Then I should see "(11 total)"
	
	