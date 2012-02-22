Feature: Get a list of media categories with counts

  Scenario: Get a list of media categories
    Given the following media categories exist:
      | name        |
      | matching    |
      | unscrambling|
    And the following media exist:
      | name | media category |
      | a    | name: matching |
    When I am on the media category index api
    And I am on the media category index api
    Then the XML response should have "//name" with the text "matching"
    Then the XML response should not have "//name" with the text "unscrambling"

