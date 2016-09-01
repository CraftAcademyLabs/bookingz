@javascript
Feature: As an admin
  In order be able to book a resource
  I would like to see current bookings on the dashboard


  Background:
    Given time is frozen at 2016-01-01

    And the following admin account is configured
      | email            | password       |
      | admin@random.com | admin_password |

    And the following resources exist
      | designation | description         |
      | Galaxy      | The Galaxy room     |
      | Atlantis    | The Atlantis room   |
      | Enterprise  | The Enterprise room |

    And the following bookings exist
      | resource | client | date       | start_time | end_time |
      | Galaxy   | Thomas | 2016-01-02 | 10:30      | 11:30    |
      | Galaxy   | Raoul  | 2016-01-02 | 13:30      | 14:30    |
      | Atlantis | Raoul  | 2016-01-02 | 14:00      | 14:30    |
      | Atlantis | Volvo  | 2016-01-02 | 08:00      | 09:30    |
      | Atlantis | Thomas | 2016-01-02 | 17:00      | 18:30    |


  Scenario: Displaying bookings
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    Then there should be "2" current bookings for "Galaxy"
    And I should see bookings for "Galaxy"
    Then there should be "3" current bookings for "Atlantis"
    And I should see bookings for "Atlantis"

  Scenario: Displaying booking details
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    Then I should see the following content in resource box
      | content                                | resource |
      | Grupp: Thomas Start: 10:30 Slut: 11:30 | Galaxy   |
      | Grupp: Raoul Start: 13:30 Slut: 14:30  | Galaxy   |
      | Grupp: Raoul Start: 14:00 Slut: 14:30  | Atlantis |
      | Grupp: Volvo Start: 08:00 Slut: 09:30  | Atlantis |
      | Grupp: Thomas Start: 17:00 Slut: 18:30 | Atlantis |

  Scenario: Display slot details
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click on "Slot 2" for "Atlantis"
    Then I should see a details modal for "Slot 2" for "Atlantis"


  Scenario: Create a booking on slot
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click on "16:00 - 16:30" for "Galaxy"
    And I fill in "Client" with "Jessica"
    And I fill in "Börjar" with "16:00"
    And I fill in "Slutar" with "16:30"
    And I click "Create"
    Then I should see the following content in resource box
      | content                                 | resource |
      | Grupp: Jessica Start: 16:00 Slut: 16:30 | Galaxy   |

  Scenario: Rejects a booking on unavailable slot
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click on "Slot 5" for "Galaxy"
    And I fill in "Client" with "Jessica"
    And I fill in "Börjar" with "10:30"
    And I fill in "Slutar" with "11:30"
    And I click "Create"
    Then I should see "The resource is fully booked"


