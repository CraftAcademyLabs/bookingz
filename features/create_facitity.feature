Feature: As a system owner
  In order to be able to manage multiple facilities
  I would like to assign resources and users to a facility


  Background:
    Given I am logged in as superadmin "admin@random.com"
    And I navigate to the "landing" page


  Scenario: Add a facility
    When I click on "Add Facility"
    Then I should be on the "New Facility" page
