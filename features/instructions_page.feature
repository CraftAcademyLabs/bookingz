Feature: As a system owner
  In order to help end users use the application
  I would like to have an instructions page with
  detailed information about the usage of the system

  Background:
    Given the following admin account is configured
      | email            | password       |
      | admin@random.com | admin_password |

  Scenario: Visit instructions page as admin
    Given I am logged in as "admin@random.com"
    And I navigate to the "Instructions" page
    Then I should see "LOREM IPSUM BACON"

  Scenario: Trying to access instructions page without being logged in
    Given I navigate to the "Instructions" page
    Then show me the page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."
