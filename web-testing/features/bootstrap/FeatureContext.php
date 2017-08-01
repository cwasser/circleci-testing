<?php

use Behat\Behat\Context\Context;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context  {
    /**
     * @var string
     */
    private $host;

    /** @When I call :host */
    public function iCall(string $host) :void {
        $this->host = $host;

        $timeout   = 5.00;
        $timeStart = microtime(true);
        $connection = null;

        while ((microtime(true) - $timeStart) < $timeout) {
            $connection = @fsockopen($host, 80);
            if ($connection !== false) {
                break;
            }
            usleep(200000);
        }

        assert($connection !== false, "API is not reachable!");
    }

    /** @Then I should get a :expectedBody response */
    public function iShouldGetAResponseWhenICall(string $expectedBody): void {
        $url = sprintf('http://%s/hello-world', $this->host);
        $responseBody = @file_get_contents($url);
        assert($responseBody === $expectedBody);
    }
}



