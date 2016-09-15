Feature: As a system adminidtrator
  In order to retain control on who is using the system
  I would like to restrict access to registrations

  Scenario: Display pending approval message after sign up
    Given I navigate to the "sign up" page
    And I register a new user
    And I attempt to login
    Then I should see "Your account has not been approved by your administrator yet."
