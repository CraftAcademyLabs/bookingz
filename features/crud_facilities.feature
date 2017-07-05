@javascript
Feature: As a system owner
  In order to be able to manage my facilities
  I would like to be able to perform CRUD actions on them


  Background:
    Given a facility named "Craft Academy - Gothenburg" exists
    And a facility named "Craft Academy - Stockholm" exists
    And I am logged in as superadmin "superadmin@random.com"
    And I navigate to the "landing" page

  Scenario: Superadmin can edit Facility


  Scenario: Superadmin can delete Facility



