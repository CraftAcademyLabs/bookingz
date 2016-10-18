@javascript
Feature: As an Administrator
  In order to get an overview of current resource bookings
  I would like to see a dashboard with today's bookings on the landing page


  Background:
    Given the following admin account is configured
      | email            | password       |
      | admin@random.com | admin_password |

    Given the following resources exist
      | designation | description         |
      | Galaxy      | The Galaxy room     |
      | Atlantis    | The Atlantis room   |
      | Enterprise  | The Enterprise room |


  Scenario: Visit landing page without logging in
    Given I navigate to the "landing" page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."

  Scenario: Visit landing page as admin
    Given I am logged in as "admin@random.com"
    And I navigate to the "landing" page
    Then I should see "Click on the rooms you want to book or make a change."
    And I should see "GALAXY"
    And I should see "ATLANTIS"

  Scenario: Toggle details visibility
    Given I am using the dashboard on "2016-01-01"
    And I click on "Galaxy"
    Then I should see "The Galaxy room"
    And I should not see "The Atlantis room"
    When I click on "Galaxy"
    Then I should not see "The Galaxy room"
    And I should not see "The Atlantis room"
    When I click on "Atlantis"
    Then I should see "The Atlantis room"
    And I should not see "The Galaxy room"
    When I click on "Atlantis"
    Then I should not see "The Atlantis room"
    And I should not see "The Galaxy room"
