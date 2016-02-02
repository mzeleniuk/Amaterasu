@javascript

Feature: Forgot password

  Scenario: Email not found
    Given User visits the log in page
    And User has an account
    Then He should see text 'Log in'
    And He should see a 'Forgot password?' link

    When He clicks on 'Forgot password?' link
    Then He should see text 'Forgot password?'
    And He should see button 'Submit'

    When He fill in the 'password_reset_email' field with 'wrong@mail.com'
    And He clicks on 'Submit' link
    Then He should see text 'Email address not found.'

  Scenario: Email is found
    Given User visits the log in page
    And User has an account
    And He clicks on 'Forgot password?' link

    When He fill in the 'password_reset_email' field with 'user@example.com'
    And He clicks on 'Submit' link
    Then He should see text 'Welcome to Amaterasu!'
    Then He should see text 'Check your Email for password reset instructions.'
