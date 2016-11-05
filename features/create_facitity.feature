@javascript
Feature: As a system owner
  In order to be able to manage multiple facilities
  I would like to assign resources and users to a facility


  Background:
    Given I am logged in as superadmin "superadmin@random.com"
    And I navigate to the "landing" page


  Scenario: Link not visible to regular users
    Given I am logged out
    And I am logged in as "admin@random.com"
    Then I should not see "New Facility"


  Scenario: New facility path is restricted for regular users
    Given I am logged out
    And I am logged in as "admin@random.com"
    Then I navigate to the "new facility" page
    Then I should see "You are not authorized to view this page"

  Scenario: Facilities index path is restricted for regular users
    Given I am logged out
    And I am logged in as "admin@random.com"
    Then I navigate to the "Facilities index" page
    Then I should see "You are not authorized to view this page"

  Scenario: Add a facility
    When I click on "Add Facility"
    And I fill in "Name" with "Stena Center"
    And I click on "Create Facility"
    Then I should be on the "Facilities index" page
    And I should see "Facility Stena Center was saved"
    And I should see "Stena Center"

  Scenario: Assign user to facility
    Given a facility named "Craft Academy" exists
    And the following admin accounts are configured
      | email                |
      | info@craftacademy.se |
    And I am on the "Facilities index" page
    Then show me the page
    And I select "info@craftacademy.se" from "user"
    And I click "Add"
    Then "info@craftacademy.se" should be assigned to "Craft Academy"