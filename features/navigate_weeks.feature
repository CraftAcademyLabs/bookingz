@javascript
Feature: As a dashboard user
  In order to view what rooms are available
  I would like to navigate weeks by clicking the next and previous arrows


  Background:
    Given time is frozen at 2016-01-01
    And the application is set up for "weekly view"

    Given the following facilities exists
      | name          |
      | Stena Center  |
      | Craft Academy |

    And the following accounts are configured
      | email                   | password       | facility      |
      | admin@stena-center.com  | admin_password | Stena Center  |

    And the following resources exist
      | designation    | description             | facility      |
      | Galaxy         | The Galaxy room         | Stena Center  |
      | Atlantis       | The Atlantis room       | Stena Center  |
      | Enterprise     | The Enterprise room     | Stena Center  |


  Scenario: Navigating to next week
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02" as "admin@stena-center.com"
    And I click arrow "next"
    Then I should see "Week of 2016-01-04 - 2016-01-10"


  Scenario: Navigating to previous week
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02" as "admin@stena-center.com"
    And I click arrow "previous"
    Then I should see "Week of 2015-12-21 - 2015-12-27"
