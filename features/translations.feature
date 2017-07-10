@javascript
Feature: As a system user
  In order to be able to choose between SV end EN as language
  I would like to see UI elements translated to both languages

  Background:
    Given time is frozen at 2016-01-02
    And the application is set up for "daily view"
    Given the following facilities exists
      | name         |
      | Stena Center |

    And the following accounts are configured
      | email           | password       | facility     |
      | admin@email.com | admin_password | Stena Center |

    And the following resources exist
      | designation | description     | facility     |
      | Galaxy      | The Galaxy room | Stena Center |

    And the following bookings exist
      | resource | client | date       | start_time | end_time |
      | Galaxy   | Thomas | 2016-01-02 | 10:30      | 11:30    |

  Scenario: Visiting the landing page as an en visitor
    Given I navigate to the "landing" page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."
    And I should see "Email"
    And I should see "Password"
    And I should see "Remember me"
    And I should see "Sign in" button
    And I should see "Sign up" link
    And I should see "Forgot your password?"
    And I should see "Request new password" link

  Scenario: Visiting the Forgot your password page as an en system user
    Given I navigate to the "Forgot your password" page
    Then I should see "Forgot your password?"
    And I should see "Email"
    And I should see "Send me reset password instructions" button
    And I should see "Sign up" link
    And I should see "Sign in" link

  Scenario: Visiting the sign up page as an en visitor
    Given I navigate to the "sign up" page
    Then I should see "Sign up"
    And I should see "Email"
    And I should see "Password"
    And I should see "Password confirmation"
    And I should see "Sign up" button
    And I should see "Sign in" link
    And I should see "Forgot your password?"
    And I should see "Request new password" link

  Scenario: Visiting the dashboard landing page as an en system user
    Given I am logged in as "admin@email.com"
    Then I navigate to the "landing" page
    And I should see "Click on the rooms you want to book or make a change."
    And I click on "11:30 - 12:00" for "Galaxy"
    And I should see "Add reservation"
    And I should see "Client"
    And I should see "Start"
    And I should see "Finish"
    And I should see "Create" button

  Scenario: Log in with wrong email as an en system user
    Given I navigate to the "landing" page
    Then I fill in "Email" with "wrong@mail.com"
    And I fill in "Password" with "password"
    And I click "Sign in" button
    Then I should see "Invalid email address or password."

  Scenario: Log in with wrong password as an en system user
    Given I navigate to the "landing" page
    Then I fill in "Email" with "admin@email.com"
    And I fill in "Password" with "password_wrong"
    And I click "Sign in" button
    Then I should see "Invalid email or password."

  Scenario: Sign up with blank fields as an en visitor
    Given I navigate to the "sign up" page
    Then I fill in "Email" with " "
    And I fill in "Password" with " "
    And I fill in "Password confirmation" with " "
    And I click "Sign up" button
    Then I should see "Email can't be blank"
    And I should see "Password can't be blank"

  Scenario: Fill in forgot password with blank field as an en system user
    Given I navigate to the "Forgot your password" page
    Then I fill in "Email" with " "
    And I click "Send me reset password instructions" button
    Then I should see "Email can't be blank"

  Scenario: Visiting the landing page as a se visitor
    Given the application is set to "sv"
    And I navigate to the "landing" page
    Then I should be on the "login" page
    And I should see "Email"
    And I should see "Lösenord"
    And I should see "Kom ihåg mig"
    And I should see "Logga in"
    And I should see "Registrera dig" link
    And I should see "Glömt ditt lösenord?"
    And I should see "Begär nytt lösenord" link

  Scenario: Visiting the Forgot your password page as a se system user
    Given the application is set to "sv"
    And I navigate to the "landing" page
    And I navigate to the "Forgot your password" page
    And I should see "Glömt ditt lösenord?"
    And I should see "Email"
    And I should see button "Skicka instruktion för återställning av lösenord"

  Scenario: Visiting the sign up page as a se visitor
    Given the application is set to "sv"
    Given I navigate to the "landing" page
    And I navigate to the "sign up" page
    And I should see "Registrera dig"
    And I should see "Email"
    And I should see "Lösenord"
    And I should see "Bekräfta lösenord"
    And I should see "Registrera dig" button
    And I should see "Logga in" link
    And I should see "Glömt ditt lösenord?"
    And I should see "Begär nytt lösenord" link

  Scenario: Visiting the dashboard landing page as a se system user
    Given the application is set to "sv"
    Given I am logged in as "admin@email.com"
    Then I navigate to the "landing" page
    And I should see "Klicka på rummen ni vill boka eller göra en ändring."
    And I click on "10:30 - 11:00" for "Galaxy"
    And I should see "Lägg till bokning"
    And I should see "Klient"
    And I should see "Börjar"
    And I should see "Slutar"
    And I should see button "Skapa"

  Scenario: Log in with wrong email as a se system user
    Given the application is set to "sv"
    Given I navigate to the "landing" page
    And I fill in "Email" with "wrong@mail.com"
    And I fill in "Lösenord" with "password"
    And I click "Logga in" button
    Then I should see "Ogiltig epost eller lösenord."

  Scenario: Log in with wrong password as a se system user
    Given the application is set to "sv"
    Given I navigate to the "landing" page
    And I fill in "Email" with "admin@email.com"
    And I fill in "Lösenord" with "password_wrong"
    And I click "Logga in" button
    Then I should see "Ogiltig epost eller lösenord."

  Scenario: Sign up with blank fields as a se visitor
    Given the application is set to "sv"
    And I navigate to the "sign up" page
    Then I fill in "Email" with " "
    And I click "Registrera dig" button
    Then I should see "Email måste anges"
    And I should see "Lösenord måste anges"

  Scenario: Fill in forgot password with blank field as an en system user
    Given the application is set to "sv"
    Given I navigate to the "Forgot your password" page
    Then I fill in "Email" with " "
    And I click "Skicka instruktion för återställning av lösenord" button
    Then I should see "Email måste anges"

  Scenario: Visiting the instructions page as an en visitor
    Given the application is set to "en"
    And I am logged in as "admin@email.com"
    And I navigate to the "Instructions" page
    Then I should see "Getting started"

  Scenario: Visiting the instructions page as a sv visitor
    Given the application is set to "sv"
    And I am logged in as "admin@email.com"
    And I navigate to the "Instructions" page
    Then I should see "Kom igång"
