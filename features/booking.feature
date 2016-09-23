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

  @javascript
  Scenario: Displaying bookings
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    Then there should be "2" current bookings for "Galaxy"
    And I should see bookings for "Galaxy"
    Then there should be "3" current bookings for "Atlantis"
    And I should see bookings for "Atlantis"

  @javascript
  Scenario: Displaying booking details
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    Then I should see the following content in resource box
      | content                                     | resource |
      | Group: Thomas Starts: 10:30 Finishes: 11:30 | Galaxy   |
      | Group: Raoul Starts: 13:30 Finishes: 14:30  | Galaxy   |
      | Group: Raoul Starts: 14:00 Finishes: 14:30  | Atlantis |
      | Group: Volvo Starts: 08:00 Finishes: 09:30  | Atlantis |
      | Group: Thomas Starts: 17:00 Finishes: 18:30 | Atlantis |

  @javascript
  Scenario: Display slot details
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click on "11:00 - 11:30" for "Atlantis"
    Then I should see a details modal for "11:00 - 11:30" for "Atlantis"


  @javascript
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
      | content                                               | resource |
      | Group: Craft Academy Labs Starts: 16:00 Finishes: 16:30 | Galaxy   |
    And I should see "2016-01-03"

  @javascript
  Scenario: Change a booking

    And I am using the dashboard on "2016-01-02"
    And I scroll down in the "Galaxy" box
    And I click on "10:30 - 11:00" for "Galaxy"
    And I fill in "Client" with "Thomas Ochman"
    And I fill in "Start" with "12:00"
    And I fill in "Finish" with "13:30"
    And I click "Update"
    And I scroll down in the "Galaxy" box
    Then I should see the following content in resource box
      | content                                          | resource |
      | Group: Thomas Ochman Starts: 12:00 Finishes: 13:30 | Galaxy   |


  @javascript
  Scenario: Rejects a booking on unavailable slot
    Given I want to make a booking with following settings
      | resource | date       | slot          | start | end   | client  |
      | Galaxy   | 2016-01-02 | 10:30 - 11:00 | 10:30 | 11:00 | Jessica |
    Then I should get "The room is already booked" message

  @javascript
  Scenario: Rejects a booking on past date
    Given time is frozen at 2016-01-02
    Given I want to make a booking with following settings
      | resource | date       | slot          | start | end   | client  |
      | Galaxy   | 2016-01-01 | 10:30 - 11:00 | 10:30 | 11:00 | Jessica |
    Then I should get "Validation failed: time start can't be in the past" message


  @javascript
  Scenario: Rejects a booking without a client
    Given I want to make a booking with following settings
      | resource | date       | slot          | start | end   | client |
      | Galaxy   | 2016-01-01 | 19:30 - 20:00 | 19:30 | 20:00 |        |
    Then I should get "Validation failed: client can't be empty" message


  @javascript
  Scenario: Edit a reservation
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click on "17:00 - 17:30" for "Atlantis"
    Then I should see a details modal for "17:00 - 17:30" for "Atlantis"
    And I should see "Thomas"
    And I should see "Edit reservation"

  @javascript
  Scenario: Delete a reservation
    Given time is frozen at 2016-01-02
    And I am using the dashboard on "2016-01-02"
    And I click on "17:00 - 17:30" for "Atlantis"
    And I should see "Edit reservation"
    Then I click on "Delete"
    And I click on "17:00 - 17:30" for "Atlantis"
    Then I should see "Add reservation"
