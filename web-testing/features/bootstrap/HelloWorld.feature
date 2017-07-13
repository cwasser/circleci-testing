@hello_world
Feature: Get response from microservice
  After calling the microservice
  From specified path
  I need to get "Hello, World!" displayed

  Scenario: Display message from given path
    Given Microservices are running
    Then I should get a "200" response
    And the response is a json string
    And it contains exactly "message"
