@hello_world
Feature: API is able to respond with "Hello, World!"

  Scenario: Get "Hello, World!" response from API
    Given 'api.fleshgrinder.docker' is reachable via port '80'
    Then I should get a '"Hello, World!"' response when I call 'http://api.fleshgrinder.docker/hello-world'
