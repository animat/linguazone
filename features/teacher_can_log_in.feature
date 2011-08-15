Feature: An existing teacher can log in

Background:
  Given the following student exists:
    | email             | password  |
    | tony@sopranos.com | badabing  |

Scenario:
  Given I go to the new user session page
  Then show me the page

