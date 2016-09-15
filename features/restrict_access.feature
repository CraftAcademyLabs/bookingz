Feature: As a system adminidtrator
  In order to retain control on who is using the system
  I would like to restrict access to registrations

  Scenario: Display pending approval message after sign up
    Given I navigate to the "sign up" page
    And I register a new user
    And I attempt to login
    Then I should see "Your account has not been approved by your administrator yet."

  Scenario: Display user approval page
    Given I am logged in as "admin@random.com"
    And I navigate to the "dashboard" page
    And I click on "Users"
    Then I should be on the "Users" page
    And I should see "Pending approvals"
