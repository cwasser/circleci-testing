<?php

declare(strict_types = 1);

if (fastcgi_finish_request() === false) {
	trigger_error('Finishing of FastCGI request failed', E_USER_WARNING);
}
