<?php

use Behat\Behat\Context\Context;
use PHPUnit\Framework\Assert;
use Symfony\Component\HttpFoundation\Response;

/**
 * Defines application features from the specific context.
 */
class FeatureContext implements Context
{
    /**
     * @var \Symfony\Component\HttpFoundation\Response|null
     */
    protected $response;

    protected $server = [];

    /**
     * Initializes context.
     *
     * Every scenario gets its own context instance.
     * You can also pass arbitrary arguments to the
     * context constructor through behat.yml.
     *
     */
    public function __construct() {
    }

    /**
     * @Given I am in :path
     * @param string path
    **/
    public function iAmInPath (string $path){

    }

    /**
     * @When I send a request
    **/
    public function sendRequest (){

    }

    /**
     * @Then I should get a :statusCode response
     * @param int $statusCode
     */
    public function iShouldGetAResponse(int $statusCode) {
        Assert::assertEquals($statusCode, $this->response->getStatusCode());
    }

    /**
     * @And the response is a json object
     **/
    public function responseObjectType (){

    }

    /**
     * @And it contains exactly :message
     * @param string message
     **/
    public function containsMessage (string $message){

    }
}
