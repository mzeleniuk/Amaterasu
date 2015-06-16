@javascript

Feature: Static pages

  Scenario: Home page
    Given User visits home page
    Then He should see text 'Welcome to Amaterasu!'
    And He should see text 'Looking up for a service to make your own blog with minimalist, concise and unobtrusive interface? Amaterasu is your choice!'
    And He should see a 'Home' link
    And He should see a 'Log in' link
    And He should see a 'Sing up now!' link
    And He should see text 'Michael Zelenyuk'
    And He should see a 'About Us' link
    And He should see a 'Contacts' link
    And He should see a 'Help' link

  Scenario: About Us page
    Given User visits home page
    And He clicks on 'About Us' link
    Then He should see text 'About Us'
    And He should see text 'This site is written for educational purposes.'
    And He should see a 'Home' link
    And He should see a 'Log in' link
    And He should see text 'Michael Zelenyuk'
    And He should see a 'About Us' link
    And He should see a 'Contacts' link
    And He should see a 'Help' link

  Scenario: Contacts page
    Given User visits home page
    And He clicks on 'Contacts' link
    Then He should see text 'Contacts'
    And He should see text 'Currently, the development team consists of only one person.'
    And He should see text 'Michael Zelenyuk (Ukraine): zell.xp@gmail.com'
    And He should see a 'Home' link
    And He should see a 'Log in' link
    And He should see text 'Michael Zelenyuk'
    And He should see a 'About Us' link
    And He should see a 'Contacts' link
    And He should see a 'Help' link

  Scenario: Help page
    Given User visits home page
    And He clicks on 'Help' link
    Then He should see text 'Help'
    And He should see text 'Amaterasu is a test project developed using Ruby on Rails.'
    And He should see text 'To get started, please sign in. After completing the registration you will receive an email with a confirmation link.'
    And He should see text 'If you need any help, please contact site administrator. Administrator's contact email you can see in section Contacts.'
    And He should see a 'Home' link
    And He should see a 'Log in' link
    And He should see text 'Michael Zelenyuk'
    And He should see a 'About Us' link
    And He should see a 'Contacts' link
    And He should see a 'Help' link