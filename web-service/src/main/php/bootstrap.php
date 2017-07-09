<?php
/**
 * The bootstrap script is executed before each controller action.
 */

declare(strict_types = 1);

// We can use an ultra-fast auto-loader as long as we have no external
// dependencies. Of course we could also load the composer auto-loader at this
// point.
spl_autoload_register(static function (string $class_name): void {
	/* @noinspection PhpIncludeInspection */
	require_once __DIR__ . '/' . str_replace('\\', '/', $class_name) . '.php';
});
