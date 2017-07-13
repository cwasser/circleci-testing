@hello_world
Feature: Get response from microservice
  After calling the microservice
  From specified path
  I need to get "Hello, World displayed

  Scenario: Display message from given path
    Given I am in "path"
    When I send a request
    Then I should get a "200" response
    And the response is a json object
    And it contains exactly "message"
