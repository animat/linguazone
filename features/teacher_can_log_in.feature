Feature: An existing teacher can log in

Background:
  Given the following student exists:
    | email             | password  |
    | tony@sopranos.com | badabing  |

Scenario:
  Given I go to the student login page
  And I fill in "Username or email address:" with "tony@sopranos.com"
  And I fill in "Password:" with "badabing"
  And I press "Login"
  Then I should see "Overview"
