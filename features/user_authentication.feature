Feature: User authentication
  In order to utilize the access controlled features of the application
  As a registered user
  I want to log in

  Background:
    Given there is a user with email "valid@user.com" and password "password"

  Scenario: Successful login
    Given I am on the login page
    When I fill in "valid@user.com" for "user_email"
    And I fill in "password" for "user_password"
    And I press "Sign in"
    Then I should be on the home page
    And I should be logged in

  Scenario: Unsuccessful login
    Given I am on the login page
    When I fill in "invalid@user.com" for "user_email"
    And I fill in "invalid password" for "user_password"
    And I press "Sign in"
    Then I should be on the login page
    #And show me the page
    And I should not be logged in
    And the "Epostadresse" field should contain "invalid@user.com"
    And I should see a flash message saying "Ugyldig epost eller passord"
