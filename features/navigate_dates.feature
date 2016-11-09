@javascript
Feature: As a dashboard user
  In order to view what rooms are available
  I would like to navigate dates by clicking the next and previous arrows


  Background:
    Given time is frozen at 2016-01-01

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

    And the following bookings exist
      | resource | client | date       | start_time | end_time |
      | Galaxy   | Thomas | 2016-01-02 | 10:30      | 11:30    |
      | Galaxy   | Raoul  | 2016-01-02 | 13:30      | 14:30    |
      | Atlantis | Raoul  | 2016-01-02 | 14:00      | 14:30    |
      | Atlantis | Volvo  | 2016-01-02 | 08:00      | 09:30    |
      | Atlantis | Thomas | 2016-01-02 | 17:00      | 18:30    |
      | Galaxy   | Thomas | 2016-01-03 | 10:30      | 11:30    |
      | Galaxy   | Raoul  | 2016-01-03 | 13:30      | 14:30    |
      | Atlantis | Raoul  | 2016-01-03 | 14:00      | 14:30    |
      | Atlantis | Volvo  | 2016-01-03 | 08:00      | 09:30    |
      | Atlantis | Thomas | 2016-01-03 | 17:00      | 18:30    |


  Scenario: Navigating to next date
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02" as "admin@stena-center.com"
    And I click arrow "next"
    Then I should see "2016-01-03"


  Scenario: Navigating to previous date
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02" as "admin@stena-center.com"
    And I click arrow "previous"
    Then I should see "2016-01-01"
