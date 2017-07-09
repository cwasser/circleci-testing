<?php
/**
 * The shutdown script is executed after each controller action.
 */

declare(strict_types = 1);

if (fastcgi_finish_request() === false) {
	trigger_error('Finishing of FastCGI request failed', E_USER_WARNING);
}

// This is the perfect place to write logs, or perform other lengthy operations
// that can be postponed.
