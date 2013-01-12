When "I fill in my school's address" do
  steps %Q{
    And I fill in "Your school's address:" with "123 Fake St"
    And I fill in "Your school's city:" with "Springfield"
    And I select "Pennsylvania" from "Your school's state:"
    And I fill in "Your school's zip code:" with "19103"
    And I press "Add your school to the database"
  }
end

When /^I enter "([^\"]*)" as my school/ do |school|
  steps %Q{
    When I fill in "Your school's name:" with "#{school}"
    And I press "Check the database"
  }
end

When "I fill in my account details" do
  steps %Q{
    When I fill in "Your first name:" with "Tony"
    And I fill in "Your last name:" with "Soprano"
    And I fill in "Your email address:" with "tony@njwaste.com"
    And I fill in "Create a LinguaZone password" with "badabing"
  }
end
