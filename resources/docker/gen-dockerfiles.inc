<?php

function gen_dockerfiles(array $config = []): void {
	global $argv;

	$script = realpath($_SERVER['SCRIPT_FILENAME']);
	$cwd    = dirname($script, 2);
	$target = basename($cwd);

	if (in_array('-h', $argv, true) || in_array('--help', $argv, true)) {
		$binary = basename($script);

		exit("{$binary}\nGenerate the Dockerfiles for building of the {$target} images.\n\nUSAGE:\n    {$binary} [FLAGS]\n\nFLAGS:\n    -h, --help       Prints help information\n\n");
	}

	chdir($cwd);
	$ini = parse_ini_file('config/docker/config.ini');

	$gen = function (string $env) use ($ini, $config, $target) {
		foreach ($config as $k => $v) {
			$ini[$k] = $v[$env];
		}

		file_put_contents("Dockerfile.{$target}-{$env}", preg_replace_callback(
			'/\{\{([a-z\d_]+)\}\}/',
			function ($matches) use ($ini) {
				return $ini[$matches[1]];
			},
			file_get_contents('resources/docker/Dockerfile.template')
		));
	};

	$gen('dev');
	$gen('prod');
}
