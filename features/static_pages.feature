@javascript
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
    And I navigate to the "landing" page
    And I click on "Instructions"
    Then I should be on the "Instructions" page
    Then I should see "LOREM IPSUM BACON"

  Scenario: Visit Ca Labs page as admin
    Given I am logged in as "admin@random.com"
    And I navigate to the "landing" page
    And I click on "CA Labs"
    Then I should be on the "CA Labs" page
    Then I should see "This application was created by CA Labs"

  Scenario: Trying to access a static page without being logged in
    Given I navigate to the "landing" page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."
    And I should not see "Instructions"
