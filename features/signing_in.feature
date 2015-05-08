@javascript

Feature: Signing in

  Scenario: Unsuccessful log in
    Given User visits the log in page
    When He submit invalid log in information
    Then He should see an error message

  Scenario: Successful log in
    Given User visits the log in page
    And User has an account
    When User submits valid log in information
    Then He should see his profile page
    And He should see a log out link
