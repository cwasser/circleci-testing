<?php

declare(strict_types = 1);

use PHPUnit\Framework\TestCase;

final class HelloWorldTest extends TestCase {
	/**
	 * @coversNothing
	 */
	public function testHelloWorldController(): void {
		$this->expectOutputString('Hello, World!');
		require_once __DIR__ . '/../../webapp/hello-world.php';
	}
}
