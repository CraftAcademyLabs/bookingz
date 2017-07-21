@javascript
Feature: As an Administrator
  In order to get an overview of current resource bookings
  I would like to see a dashboard with today's bookings on the landing page

  Additional User Story:
  As a system user
  In order to take bookings on my resources
  I only want to see my own resources on the dashboard


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


  Scenario: Visit landing page without logging in
    Given I navigate to the "dashboard" page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."

  Scenario: Visit landing page as admin
    Given I am logged in as "admin@stena-center.com"
    And I navigate to the "dashboard" page
    Then I should see "Click on the rooms you want to book or make a change."
    And I should see "Galaxy"
    And I should see "Atlantis"
    And I should see "Enterprise"
    And I should not see "NCC Enterprise"
    And I should not see "Cohort Room"

  Scenario: Toggle details visibility
    Given I am using the dashboard on "2016-01-01" as "admin@stena-center.com"
    And I click on card for "Galaxy"
    Then I should see "The Galaxy room"
    And I should not see "The Atlantis room"
    When I click on card for "Atlantis"
    Then I should see "The Galaxy room"
    And I should see "The Atlantis room"
