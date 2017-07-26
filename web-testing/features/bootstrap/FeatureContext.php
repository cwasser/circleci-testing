<?php

use Behat\Behat\Context\Context;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context  {
    /** @When I call :host */
    public function iCall(string $host, string $port) :void {
        $timeout   = 5.00;
        $timeStart = microtime(true);
        $connection = @fsockopen($host, $port);

        while ((microtime(true) - $timeStart) < $timeout) {
            if ($connection === true) {
                assert($connection);
            }
            usleep(200000);
        }
        assert($connection, "API is not reachable!");
    }

    /** @Then I should get a :expectedBody response */
    public function iShouldGetAResponseWhenICall(string $expectedBody, string $url): void {
        $responseBody = file_get_contents($url);
        assert($responseBody === $expectedBody);
    }
}



