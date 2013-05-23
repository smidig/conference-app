Feature: My Profile
  In order to to handle my registration
  As a registered user
  I should have a profile page

  Background:
    Given there is a user with name "Ola Hansen" and email "valid@user.com" and password "password"

  Scenario: Should greet user
    Given I am logged in as a user with email "valid@user.com" and password "password"
    When I am on the my profile page
    Then I should see "Hei Ola Hansen"
    And I should see "valid@user.com"

  Scenario: Should require login to access my profile page
    Given I am on the home page
    When I follow "Min profil"
    And I should be on the login page
    And I fill in "valid@user.com" for "user_email"
    And I fill in "password" for "user_password"
    And I press "Logg på"
    Then I should be on the my profile page

  Scenario: Should have edit profile link
    Given I am logged in as a user with email "valid@user.com" and password "password"
    And I am on the my profile page
    When I follow "Endre din profil"
    Then I should be on the edit user registration page