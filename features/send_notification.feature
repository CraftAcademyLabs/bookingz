@javascript @action_cable
Feature: As an administrator of a facility
  In order to inform my guests about special offers
  I would like to be able to push out notifications to all resources in my facility

  Background:
    Given the following facilities exists
      | name          |
      | Stena Center  |
      | Craft Academy |

    And the following accounts are configured
      | email                   | password       | facility      |
      | admin@stena-center.com  | admin_password | Stena Center  |
      | admin@craft-academy.com | admin_password | Craft Academy |

  Scenario: Filling out the 'Send a Note' Form
    Given I am logged in as "admin@stena-center.com"
    And I navigate to the "landing" page
    Then I should see "Send a note to all rooms in this facility."
    When I fill in "note" with "Lunch is now served"
    And I click "Send"
    Then I should see "Your message 'Lunch is now served' was sent at "

  Scenario: Trying to send a message that is too long
    Given I am logged in as "admin@stena-center.com"
    And I navigate to the "landing" page
    When I fill in "note" with "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturien. Extra text that won't get sent"
    And show me an image of the page
    And I click "Send"
    Then I should see "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturien."
    Then I should not see "Extra text that won't get sent"

  Scenario: Viewing only my own facility's message
    Given I am logged in as "admin@stena-center.com"
    And I navigate to the "landing" page
    And I switch to a new window
    And I am logged in as "admin@craft-academy.com"
    And I navigate to the "landing" page
    When I fill in "note" with "Note to Craft Academy"
    And I click "Send"
    Then I should see "Note to Craft Academy"
    When I switch to window "1"
    Then I should not see "Note to Craft Academy"

  # We need to return to these tests later - why are these windows not behaving as intended?

#    When I navigate to the "landing" page
#    And I fill in "note" with "Note to Stena Center"
#    And I click "Send"
#    Then I should see "Note to Stena Center"
#    When I switch to window "2"
#    And I navigate to the "landing" page
#    Then I should not see "Note to Stena Center"
