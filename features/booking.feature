Feature: As an admin
  In order be able to book a resource
  I would like to see current bookings on the dashboard


  Background:
    Given the following admin account is configured
      | email            | password       |
      | admin@random.com | admin_password |

    And the following resources exist
      | designation | description       |
      | Galaxy      | The Galaxy room   |
      | Atlantis    | The Atlantis room |

    And the following bookings exist
      | resource | client | date       | start_time | end_time |
      | Galaxy   | Thomas | 2016-11-01 | 10:30      | 11:30    |
      | Atlantis | Raoul  | 2016-11-01 | 10:30      | 11:30    |


  Scenario: Displaying bookings
    Given I am using the dashboard
    Then there should be "2" bookings in the system