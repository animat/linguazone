Feature: Student views audio blogs
  In order to allow teachers access to the site
  As a teacher
  I want to login

  Background:
    Given the following teacher exists:
      | email             | password |
      | tony@sopranos.com | badabing |

  Scenario: Don't show hidden audio blogs
    Given I am on the teacher login page
    And I fill in "Email address:" with "tony@sopranos.com"
    And I fill in "Password:" with "badabing"
    And I press "Login"
    Then show me the page

