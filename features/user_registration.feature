Feature: User registration
  In order for someone to attend the conference
  As a guest/user
  They need to be able to create a profile

  Background:
    Given there exist a visible ticket

  Scenario: User must accept the terms
    Given I am on the registration page
    When I fill in the following:
      | Email address   | jane.doe@gmail.com               |
      | Name            | Jane Doe                         |
      | Telefon         | 22222222                         |
      | Password        | password                         |
    And I press "Create Customer"
    Then I should see an error in the form saying "You must accept"

  Scenario: Successful registration:
    Given I am on the registration page
    When I fill in the following:
      | Email address   | jane.doe@gmail.com               |
      | Name            | Jane Doe                         |
      | Telefon         | 22222222                         |
      | Password        | password                         |
    And check "Jeg aksepterer vilkårene"
    And I press "Create Customer"
    Then I should see a flash message saying "Welcome!"
