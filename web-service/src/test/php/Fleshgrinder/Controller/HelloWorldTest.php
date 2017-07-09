<?php

declare(strict_types = 1);

namespace Fleshgrinder\Controller;

use PHPUnit\Framework\TestCase;

/**
 * This is a completely useless test and we will not write tests for the
 * controllers, however, we need one for CircleCI and this is it.
 */
final class HelloWorldTest extends TestCase {
	/**
	 * @coversNothing
	 */
	public function testHelloWorldController(): void {
		$this->expectOutputString('"Hello, World!"');
		require_once __DIR__ . '/../../../../webapp/hello-world.php';
	}
}
