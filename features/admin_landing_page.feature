Feature: As an Administrator
  In order to get an overview of current resource bookings
  I would like to see a dashboard with today's bookings on the landing page


  Background:
    Given the following admin account is configured
      | email            | password       |
      | admin@random.com | admin_password |

    Given the following resources exist
      | designation |
      | Galaxy      |
      | Atlantis    |


  Scenario: Visit landing page without logging in
    Given I navigate to the "landing" page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."

  Scenario: Visit landing page as admin
    Given I am logged in as "admin@random.com"
    And I navigate to the "landing" page
    Then I should see "Bookingz Dashboard"
    And I should see "Galaxy"
    And I should see "Atlantis"
    Then show me the page



