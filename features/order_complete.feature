Feature: Order Complete
  In order to earn money
  As a guest/user
  I should be able to complete my order

  Background:
    Given there exist a visible ticket
    And user will complete at paypal

  Scenario: Participant should be able to complete order
    Given I have just registered as a new participant
    And I am on the order page
    When I follow "Fullfør med Paypal"
    # User will automagically complete at paypal
    Then I should be on the paypal completed page
    And It should exist one paypal payment
