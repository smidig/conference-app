Feature: User administration
  In order to manage the conference
  As a admin
  I should have a users admin page to manage participants

  Background:
    Given there is a user with email "admin@user.com" and password "password"
    And user with email "admin@user.com" is admin

  Scenario: New users should be listed on users admin page
    Given I am logged in as a user with email "admin@user.com" and password "password"
    And there is a user with email "valid_new@user.com" and password "password"
    When I am on the users admin page
    Then I should see "valid_new@user.com"

  Scenario: Regular users should not be able to access users admin page
    Given there is a user with email "valid@user.com" and password "password"
    When I am logged in as a user with email "valid@user.com" and password "password"
    And I go to the users admin page
    Then I should see a flash message saying "You must be an admin to access this view."
    And I should be on the home page

  Scenario: Should require to login as admin to access users admin page
    Given I am on the home page
    And I should not be logged in
    When I go to the users admin page
    Then I should see a flash message saying "You must login as an admin to access this view."
    And I should be on the login page