@javascript
Feature: As a dashboard user
  In order to view what rooms are available
  I would like to navigate dates by clicking the next and previous arrows


  Background:
    Given time is frozen at 2016-01-01
    And the application is set up for "weekly view"

    And the following admin account is configured
      | email            | password       |
      | admin@random.com | admin_password |

    And the following resources exist
      | designation | description         |
      | Galaxy      | The Galaxy room     |
      | Atlantis    | The Atlantis room   |
      | Enterprise  | The Enterprise room |

    And the following bookings exist
      | resource | client | date       |
      | Galaxy   | Thomas | 2016-01-02 |
      | Galaxy   | Raoul  | 2016-01-02 |
      | Atlantis | Raoul  | 2016-01-02 |
      | Atlantis | Volvo  | 2016-01-02 |
      | Atlantis | Thomas | 2016-01-02 |
      | Galaxy   | Thomas | 2016-01-03 |
      | Galaxy   | Raoul  | 2016-01-03 |
      | Atlantis | Raoul  | 2016-01-03 |
      | Atlantis | Volvo  | 2016-01-03 |
      | Atlantis | Thomas | 2016-01-03 |


  Scenario: Navigating to next week
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    Then show me an image of the page
    And I click arrow "next"
    Then I should see "Week of 2016-01-03 - 2016-01-03"


  Scenario: Navigating to previous week
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click arrow "previous"
    Then I should see "Week of 2016-01-03 - 2016-01-03"
