@javascript
Feature: As a system user
  In order to be able to choose between SV end EN as language
  I would like to see UI elements translated to both languages

  Scenario: Visiting the landing page as an english visitor
    Given I navigate to the "landing" page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."
    And I should see "Email"
    And I should see "Password"
    And I should see "Remember me"
    And I should see "Sign in"
    And I should see "Sign up"
    And I should see "Forgot your password"
    And I should see "Home"

    Scenario: Visiting the sign up page as an english visitor
      Given I navigate to the "sign up" page
      Then show me the page
      And I should see "Sign up"
      And I should see "Email"
      And I should see "Password"
      And I should see "Password confirmation"
      And I should see "Sign up"
      And I should see "Forgot your password"

      # Scenario: Visiting the landing page as an swedish visitor
      #   Given I navigate to the "landing" page
      #   Then I should be on the "login" page
      #   And I should see "Du måste logga in eller registrera dig innan du fortsätter."
      #   And I should see "Email"
      #   And I should see "Lösenord"
      #   And I should see "Kom ihåg mig"
      #   And I should see "Logga in"
      #   And I should see "Registrera dig"
      #   And I should see "Glömt ditt lösenord?"
      #   And I should see "Hem"
