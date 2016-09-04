Feature: As a system user
  In order to be able to choose between SV end EN as language
  I would like to see UI elements translated to both languages

  Scenario: Visiting the landing page as an english system user
    Given I navigate to the "landing" page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."
    And I should see "Email"
    And I should see "Password"
    And I should see "Remember me"
    And I should see "Sign in"
    And I should see "Sign up"
    And I should see "Forgot your password?"

  # Scenario: Visiting the landing page as an swedish system user
  #   Given I navigate to the "landing" page
  #   Then I should be on the "Logga in" page
  #   And I should see "Du måste logga in eller registrera dig innan du fortsätter."
