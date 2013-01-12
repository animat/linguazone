Feature: Teacher manages customized word lists
	
	Background:
	  Given a teacher exists with a first name of "John"
		And John has 10 word_lists
		And John has a word_list with a description of "This is a unique post for searching"
		And a teacher exists with a first name of "Bob"
		And Bob has a word_list with a description of "adopt this list"
		And I am logged in as "John"
		And I am on the my word lists page
	
	Scenario: View all my word lists
		Then I should see "(11 total)"
	@wip
	Scenario: Adopt a word list
		Given I follow "Adopt a word list"
		When I fill in "Search for:" with "adopt this list"
		And I press "Search"
		Then I should see "Adopt" within the first search result row
		And I should not see "Edit" within the first search result row
	
	Scenario: Import a valid word list
		Given I follow "Import a word list"
		And I fill in "Description" with "Sample description"
		And I upload a spreadsheet with 3 rows of valid data
		And I press "Go!"
		Then I should see "Verify and import"
		And I should see 3 word node rows
	
	Scenario: Fail to import a word list with missing data
		Given I follow "Import a word list"
		And I fill in "Description" with "Failed import"
		And I upload a spreadsheet with invalid data
		And I press "Go!"
		Then I should see "there was an error importing your data"
	
	Scenario: Fail to import a word list of an invalid type
		Given I follow "Import a word list"
		And I fill in "Description" with "Failed import"
		And I upload a PDF
		And I press "Go!"
		Then I should see "Please confirm that you are uploading an Excel Spreadsheet"