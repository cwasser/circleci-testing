<?php

use Behat\Behat\Context\Context;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context  {
    /** @Given :host is reachable via port :port */
    public function apiIsReachable(string $host, string $port): void {
        $timeout = 6.00;
        $timeEnd = microtime(true) + $timeout;

        while (microtime(true) < $timeEnd) {
           if (@fsockopen($host, $port) !== false) {
               return;
           }
           else {
               sleep(1);
           }
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
