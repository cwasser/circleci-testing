<?php

use Behat\Behat\Context\Context;
use Symfony\Component\Process\Process;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context  {
    /** @var Process|null */
    private $server;

    public function __destruct() {
        if ($this->server !== \null) {
            $this->server->stop();
        }
    }

    /** @Given API is reachable */
    public function apiIsReachable() {
        $timeout = 5.00;
        $errno = null;
        $message = 'API is not reachable';
        $this->server = new Process('make dev-server', __DIR__ . '/../../../');
        $this->server->start();
        $start_time = microtime(true);

        while ((microtime(true) - $start_time) * 10000000 < $timeout) {
           if (fsockopen('api.fleshgrinder.docker/hello-world',80, $errno )) {
               assert($this->server->isRunning());
           }
           else {
               usleep(200000);
           }
        }
        return $message;
    }

    /** @Then I should get a :body response when I call :url */
    public function iShouldGetAResponseWhenICall(string $body, string $url): void {
        assert(file_get_contents($url) === $body);
    }
}
