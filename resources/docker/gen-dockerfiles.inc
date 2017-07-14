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
	($ini = parse_ini_file('config/docker/config.ini', true)) || exit(1);
	($tpl = file_get_contents('resources/docker/Dockerfile.template')) || exit(1);

	$gen = function (string $env) use ($ini, $config, $target, $tpl) {
		if (isset($ini[$env])) {
			foreach ((array) $ini[$env] as $k => $v) {
				if (is_array($v)) {
					$ini[$k] = array_merge($ini[$k], $v);
				}
				else {
					$ini[$k] = $v;
				}
			}
			unset($ini[$env]);
		}

		foreach ($config as $k => $v) {
			$ini[$k] = $v[$env];
		}

		$ini['env'] = $env;

		file_put_contents("Dockerfile.{$target}-{$env}", preg_replace_callback(
			/** @lang RegExp */ '/\{\{([a-z\d_]+)\}\}/',
			function ($matches) use ($ini) {
				return is_array($ini[$matches[1]]) ? implode(' ', $ini[$matches[1]]) : $ini[$matches[1]];
			},
			$tpl
		)) || exit(1);
	};

	$gen('dev');
	$gen('prod');
}
