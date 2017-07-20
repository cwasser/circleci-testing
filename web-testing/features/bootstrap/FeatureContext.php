<?php

use Behat\Behat\Context\Context;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context  {
    /** @Given API is reachable */
    public function apiIsReachable() {
        $timeout = 5.00;
        $errno = null;
        $message = 'API is not reachable';

        $start_time = microtime(true);
        while ((microtime(true) - $start_time) * 10000000 < $timeout) {
           if (fsockopen('api.fleshgrinder.docker/hello-world',80, $errno )) {
               assert(true);
           }
           else {
               sleep(2);
           }
        }
        return $message;
    }

    /** @Then I should get a :body response when I call :url */
    public function iShouldGetAResponseWhenICall(string $body, string $url): void {
        assert(file_get_contents($url) === $body);
    }
}
