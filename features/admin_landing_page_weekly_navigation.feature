@javascript
Feature: As a system administrator
  In order to be able to configure the app to better serve my clients business objectives
  I would like to be able to choose between daily and weekly navigation

  Background:
    Given the following facilities exists
      | name          |
      | Stena Center  |
      | Craft Academy |

    And the following accounts are configured
      | email                   | password       | facility      |
      | admin@stena-center.com  | admin_password | Stena Center  |
      | admin@craft-academy.com | admin_password | Craft Academy |

    And I am logged in as "admin@craft-academy.com "

  Scenario: Weekly view
    Given the application is set up for "weekly view"
    Then the app should be in "weekly view"
    And I navigate to the "landing" page
    Then I should see "This is Weekly view"

  Scenario: Daily view
    Given the application is set up for "daily view"
    Then the app should be in "daily view"
    And I navigate to the "landing" page
    Then I should see "This is Daily view"
