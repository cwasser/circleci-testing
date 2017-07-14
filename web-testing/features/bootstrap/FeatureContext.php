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

    /** @Given API is running */
    public function apiIsRunning() {
        $this->server = new Process('make dev-server', __DIR__ . '/../../../');
        $this->server->start();

        assert($this->server->isRunning());
    }

    /** @Then I should get a :body response when I call :url */
    public function iShouldGetAResponseWhenICall(string $body, string $url): void {
        assert(file_get_contents($url) === $body);
    }
}
