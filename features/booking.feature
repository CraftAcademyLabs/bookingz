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
      | content                                  | resource |
      | Group: Thomas Start: 10:30 Finish: 11:30 | Galaxy   |
      | Group: Raoul Start: 13:30 Finish: 14:30  | Galaxy   |
      | Group: Raoul Start: 14:00 Finish: 14:30  | Atlantis |
      | Group: Volvo Start: 08:00 Finish: 09:30  | Atlantis |
      | Group: Thomas Start: 17:00 Finish: 18:30 | Atlantis |

  Scenario: Display slot details
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click on "11:00 - 11:30" for "Atlantis"
    Then I should see a details modal for "11:00 - 11:30" for "Atlantis"


  Scenario: Create a booking on slot
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click arrow "next"
    And I scroll down in the "Galaxy" box
    And I click on "16:30 - 17:00" for "Galaxy"
    And I fill in "Client" with "Craft Academy Labs"
    And I fill in "Start" with "16:00"
    And I fill in "Finish" with "16:30"
    And I click "Create"
    And I scroll down in the "Galaxy" box
    Then I should see the following content in resource box
      | content                                              | resource |
      | Group: Craft Academy Labs Start: 16:00 Finish: 16:30 | Galaxy   |
    And I should see "2016-01-03"

  Scenario: Change a booking
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I scroll down in the "Galaxy" box
    And I click on "10:30 - 11:00" for "Galaxy"
    And I fill in "Client" with "Thomas Ochman"
    And I fill in "Start" with "12:00"
    And I fill in "Finish" with "13:30"
    And I click "Update"
    And I scroll down in the "Galaxy" box
    Then I should see the following content in resource box
      | content                                         | resource |
      | Group: Thomas Ochman Start: 12:00 Finish: 13:30 | Galaxy   |


#  Scenario: Rejects a booking on unavailable slot
#    Given time is frozen at 2016-01-02
#    And I am using the dashboard on "2016-01-02"
#    And I click on "10:30 - 11:00" for "Galaxy"
#    And I fill in "Client" with "Jessica"
#    And I fill in "Start" with "10:30"
#    And I fill in "Finish" with "11:30"
#    And I click "Create"
#    Then I should see "The room is already booked"

  # Scenario: Rejects a booking on past date
  #   Given it is currently 2016-01-02
  #   And I am using the dashboard on "2016-01-01"
  #   And I click on "10:30 - 11:00" for "Galaxy"
  #   And I fill in "Client" with "Craft Academy"
  #   And I fill in "Start" with "10:30"
  #   And I fill in "Finish" with "11:30"
  #   And I click "Create"
  #   Then I should see "Validation failed: time start can't be in the past"

  # Scenario: Rejects a booking on past date
  #   Given time is frozen at 2016-01-02
  #   And I am using the dashboard on "2016-01-01"
  #   And I click on "10:30 - 11:00" for "Galaxy"
  #   Then I should see "Unavailable"

  # Scenario: Rejects a booking without a client
  #   Given time is frozen at 2016-01-02
  #   And I am using the dashboard on "2016-01-03"
  #   And I click on "10:30 - 11:00" for "Galaxy"
  #   And I fill in "Client" with ""
  #   And I fill in "Start" with "10:30"
  #   And I fill in "Finish" with "11:30"
  #   And I click "Create"
  #   Then I should see a required field error
  #   # Then I should see "Please fill out this field."
  #   # Then I should see "Validation failed: client can't be empty"

  Scenario: Edit a reservation
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click on "17:00 - 17:30" for "Atlantis"
    Then I should see a details modal for "17:00 - 17:30" for "Atlantis"
    And I should see "Thomas"
    And I should see "Edit reservation"
