@javascript
Feature: As a system user
  In order to be able to choose between SV end EN as language
  I would like to see UI elements translated to both languages
  Background:
    Given the following admin account is configured
      | email           | password |
      | admin@email.com | password |

    And the following resources exist
      | designation | description         |
      | Galaxy      | The Galaxy room     |

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
    And I should see "Forgot your password" link
    And I should see "Home"

  Scenario: Visiting the Forgot your password page as an en system user
    Given I navigate to the "Forgot your password" page
    Then I should see "Forgot your password?"
    And I should see "Email"
    And I should see "Reset password" button
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
      And I should see "Forgot your password" link

    Scenario: Visiting the dashboard landing page as an en system user
      Given I am logged in as "admin@email.com"
      Then I navigate to the "landing" page
      And show me the page
      And I should see "Click on the rooms you want to book or make a change."
      And I click on "10:30 - 11:00" for "Galaxy"
      And I should see "Add to reservation"
      And I should see "Client"
      And I should see "Start"
      And I should see "Finish"
      And I should see "Create" button

    Scenario: Log in with wrong email as a en system user
      Given I navigate to the "landing" page
      Then I fill in "user[email]" with "wrong@mail.com"
      And I fill in "user[password]" with "password"
      And I click "Sign in" button
      And I should see "Invalid Email or password."

    Scenario: Log in with wrong password as a en system user
      Given I navigate to the "landing" page
      Then I fill in "user[email]" with "admin@email.com"
      And I fill in "user[password]" with "password_wrong"
      And I click "Sign in" button
      And I should see "Invalid Email or password."

    Scenario: Sign up with blank fields as a en visitor
      Given I navigate to the "sign up" page
      Then I fill in "user[email]" with " "
      And I fill in "user[password]" with " "
      And I fill in "user[password_confirmation]" with " "
      And I click "Sign up" button
      Then I should see "Email can't be blank"
      And I should see "Password can't be blank"

  Scenario: Fill in forgot password with blank field as an en system user
    Given I navigate to the "Forgot your password" page
    Then I fill in "user[email]" with " "
    And I click "Reset password" button
    Then I should see "Email can't be blank"
