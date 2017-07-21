@javascript
Feature: As a Facility Manager
  In order to be able to keep information about my facility up to date
  I want to be able to access an info view of my facility


  Background:
    Given the following facilities exists
      | name          |
      | Stena Center  |
      | Craft Academy |

    And the following accounts are configured
      | email                   | password       | facility      |
      | admin@stena-center.com  | admin_password | Stena Center  |
      | admin@craft-academy.com | admin_password | Craft Academy |

    And I am logged in as "admin@stena-center.com"
    And I navigate to the "dashboard" page

  Scenario: Access Facility view as an logged in user
    When I click on menu item "Stena Center"
    Then I should be on the show page for "Stena Center"
    And I should see "Stena Center"