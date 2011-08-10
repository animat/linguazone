Feature: A new teacher creates a trial account

Background:
  Given a subscription plan exists with a name of "trial"
  And a game exists with a getting started of "true"
  And a state exists with a name of "Pennsylvania"
  And I am on the new trial page

Scenario: Sign up for a new plan with a new school
  When I fill in "Your school's name:" with "Northwest"
  And I press "Check the database"
  And I fill in "Your school's address:" with "123 Fake St"
  And I fill in "Your school's city:" with "Springfield"
  And I select "Pennsylvania" from "Your school's state:"
  And I fill in "Your school's zip code:" with "19103"
  And I press "Add your school to the database"
  Then I should see "Lastly, create your account"
  When I fill in "Your first name:" with "Tony"
  And I fill in "Your last name:" with "Soprano"
  And I fill in "Your email address:" with "tony@njwaste.com"
  And I fill in "Create a LinguaZone password" with "badabing"
  And I press "user_submit"
  Then I should see "Let's get started!"
