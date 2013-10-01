Feature: User registration
  In order to receive abstracts to the conference
  As a guest/user
  They need to be able to register a new talk

  Background:
    Given there exist a speaker ticket
    And there is a user with email "valid@user.com" and password "password"

  #Scenario: Should send user to the sign up page with special ticket
  #  Given I am on the home page
  #  When I follow "Foreslå foredrag"
  #  Then I should be on the registration page
  #  And the "user_ticket_id" drop-down should contain the option "Speaker - (kr 0,-)"


  Scenario: A registered user should be able to submit abstracts
    Given I am logged in as a user with email "valid@user.com" and password "password"
    And I am on the talk registration page
    When I fill in the following:
      | Tittel          | Min lyntale                      |
      | Argumentasjon   | Jeg hater scrum!                 |
    And I select "Lyntale" from "Type foredrag"
    And I select "Annet" from "Hovedkategori"
    And check "Jeg forstår at foredraget blir gjort tilgjengelig med en Creative Commons Navngivelse 3.0 Norge lisens."
    And I press "Send inn forslag!"
    Then I should be on the my profile page
    And I should see a flash message saying "Takk, ditt foredragsforslag er registrert."

  Scenario: User must accept license in order to register talk
    Given I am logged in as a user with email "valid@user.com" and password "password"
    And I am on the talk registration page
    When I fill in the following:
      | Tittel          | Min lyntale                      |
      | Argumentasjon   | Jeg hater scrum!                 |
    And I select "Lyntale" from "Type foredrag"
    And I select "Annet" from "Hovedkategori"
    And I press "Send inn forslag!"
    Then I should see an error in the form saying "Du må godta vilkårene"
