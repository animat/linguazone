Feature: Get a list of media categories with counts

  @wip
  Scenario: Get a list of media categories
    Given the following media categories exist:
      | name        |
      | matching    |
      | unscrambling|
    And the following media exist:
      | name | media category |
      | a    | name: matching |
    When I am on the media category index api

