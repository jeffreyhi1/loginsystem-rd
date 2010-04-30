<?php
//  $Id$
/*********************************************************
* To be added at the top of the form page
**********************************************************
require_once('include/recaptchalib.php');
$publickey = "6Lfe3rkSAAAAAPrJLxSOPkUCq2OqbA5cNZ6kUYen";


/*********************************************************
* To be added in the form where the CAPTCHA	should appear
**********************************************************
echo recaptcha_get_html($publickey);


/*********************************************************
* To be added where the CAPTCHA	should be verified
**********************************************************
if ($_SERVER["RESPONSE_METHOD"]="POST") {
	$privatekey = "6Lfe3rkSAAAAAMutk1SNbCduQqZpJ8Fnv5FnOIAL";
	$resp = recaptcha_check_answer ($privatekey,$_SERVER["REMOTE_ADDR"],$_POST["recaptcha_challenge_field"],$_POST["recaptcha_response_field"]);

	if (!$resp->is_valid) {
		die ("The reCAPTCHA wasn't entered correctly. Go back and try it again." . "(reCAPTCHA said: " . $resp->error . ")");
	}
}
?>