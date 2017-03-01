Feature: Check various site layout components

  @javascript
  Scenario: Flash message disspears after 15 seconds
    Given I navigate to the "landing" page
    Then I should be on the "login" page
    And I should see "You need to sign in or sign up before continuing."
    Then I wait for 16 seconds
    Then I should not see "You need to sign in or sign up before continuing."
