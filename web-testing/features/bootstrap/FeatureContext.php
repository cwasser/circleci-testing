<?php

use Behat\Behat\Context\Context;
use Symfony\Component\Process\Process;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context  {
    /** @var Process */
    private $server;

    /**
     * @Given Microservices are running
     */
    public function microserviceAreRunning() {
        $this->server = new Process('make dev-server', __DIR__ . '/../../../');
        $this->server->mustRun();
    }

    /**
     * @When I send a request
     */
    public function sendRequest () {
        $body = file_get_contents('http://api.fleshgrinder.docker/hello-world');
    }

    /**
     * @Then I should get a :statusCode response
     */
    public function iShouldGetAResponse(int $statusCode) {
        assertEquals($statusCode, $this->response->getStatusCode());
    }

    /**
     * @And the response is a json string
     */
    public function responseObjectType () {
        $body = file_get_contents('http://api.fleshgrinder.docker/hello-world');
    }

    /**
     * @And it contains exactly :message
     */
    public function containsMessage (string $message) {
        assertEquals($message, $this->response->getContent());
    }
}
