<?php

use Behat\Behat\Context\Context;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context  {
    /** @Given :host is reachable via port :port */
    public function apiIsReachable(string $host, string $port): void {
        $timeout = 5.00;
        $timeStart = microtime(true);

        while ($timeStart + microtime(true) < $timeout) {
           if (@fsockopen($host, $port) !== false) {
               return;
           }

           usleep(200000);
        }

        throw new \Exception('API is not reachable');
    }

    /** @Then I should get a :expectedBody response when I call :url */
    public function iShouldGetAResponseWhenICall(string $expectedBody, string $url): void {
        $responseBody = file_get_contents($url);
        if ($responseBody !== $expectedBody) {
            throw new \Exception("Wrong response received");
        }
    }
}
