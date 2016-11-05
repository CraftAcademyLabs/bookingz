@javascript
Feature: As a system adminidtrator
  In order to retain control on who is using the system
  I would like to restrict access to registrations

  Background:
    Given the following user is pending approval
      | email          |
      | user1@user.com |
      | user2@user.com |

    And a facility named "Craft Academy" exists
    And a facility named "Stena Center" exists


  Scenario: Users path is restricted for regular users
    Given I am logged out
    And I am logged in as "admin@random.com"
    Then I navigate to the "users" page
    Then I should see "You are not authorized to view this page"

  Scenario: Display pending approval message after sign up
    Given I navigate to the "sign up" page
    And I register a new user
    And I attempt to login
    Then I should see "Your account has not been approved by your administrator yet."

  Scenario: Display no pending approval message
    Given there are no pending approval requests
    Given I am logged in as superadmin "superadmin@random.com"
    And I navigate to the "users" page
    And I click on "Pending approvals"
    Then I should see "There are no pending registration requests"

  Scenario: Display user approval page
    Given I am logged in as superadmin "superadmin@random.com"
    And I navigate to the "landing" page
    And I click on "Users"
    Then I should be on the "users" page
    And I should see "Pending approval"

  Scenario: Approving a pending registration request
    Given I am logged in as superadmin "superadmin@random.com"
    And I navigate to the "users" page
    And I click on "Pending approvals"
    And I click on "Accept" for user "user1@user.com"
    Then I should not see "user1@user.com"
    And I should see "user2@user.com"


