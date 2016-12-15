@javascript
Feature: As a Superadmin
  In order to get an overview of Facilities in the system
  I would like to see aggregated info about each facility when I access the system

  Background:
    Given the following facilities exists
      | name          |
      | Stena Center  |
      | Craft Academy |

    And the following accounts are configured
      | email                   | password       | facility      |
      | admin@stena-center.com  | admin_password | Stena Center  |
      | admin@craft-academy.com | admin_password | Craft Academy |

    And the following resources exist
      | designation    | description             | facility      |
      | Galaxy         | The Galaxy room         | Stena Center  |
      | Atlantis       | The Atlantis room       | Stena Center  |
      | Enterprise     | The Enterprise room     | Stena Center  |
      | Cohort Room    | The Cohort Room         | Craft Academy |
      | NCC Enterprise | The NCC Enterprise room | Craft Academy |

    Given I am logged in as superadmin "superadmin@random.com"
    And I navigate to the "landing" page


  Scenario: Viewing aggregated info on Facilities index page
    When I click on "Admin"
    And I click on "Facilities"
    Then I should see "Galaxy" in a section for "Stena Center"
    And I should see "Atlantis" in a section for "Stena Center"
    And I should see "Enterprise" in a section for "Stena Center"
    And I should not see "Cohort Room" in a section for "Stena Center"
    And I should not see "NCC Enterprise" in a section for "Stena Center"
    And I should see "admin@stena-center.com" in a section for "Stena Center"
    And I should not see "admin@craft-academy.com" in a section for "Stena Center"
    And I should see "Cohort Room" in a section for "Craft Academy"
    And I should see "NCC Enterprise" in a section for "Craft Academy"
    And I should see "admin@craft-academy.com" in a section for "Craft Academy"
