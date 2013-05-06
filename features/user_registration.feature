Feature: User registration
  In order for someone to attend the conference
  As a guest/user
  They need to be able to create a profile

  Background:
    Given there exist a visible ticket

  Scenario: User must accept the terms
    Given I am on the registration page
    When I fill in the following:
      | Epostadresse    | jane.doe@gmail.com               |
      | Navn            | Jane Doe                         |
      | Telefon         | 22222222                         |
      | Passord         | password                         |
    And I press "Meld meg på!"
    Then I should see an error in the form saying "Du må godta vilkårene"

  Scenario: Successful registration:
    Given I am on the registration page
    When I fill in the following:
      | Epostadresse    | jane.doe@gmail.com               |
      | Navn            | Jane Doe                         |
      | Telefon         | 22222222                         |
      | Passord         | password                         |
    And check "Jeg forstår at påmeldingen er bindende og at Smidig vil sende meg epost"
    And I press "Meld meg på!"
    Then I should see a flash message saying "Velkommen!"
    And I should be on the order page
