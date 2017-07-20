@hello_world
Feature: API is able to respond with "Hello, World!"

  Scenario: Get "Hello, World!" response from API
    Given 'web-server' is reachable via port '80'
    Then I should get a '"Hello, World!"' response when I call 'http://web-server/hello-world'
