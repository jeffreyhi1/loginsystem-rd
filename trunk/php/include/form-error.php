<?PHP
// alpha 0.5 debug
// $Id$
/**
* Login System Form Error include
* 27 APR 2010 Version alpha 0.3 debug
*/

$page="";
$reason="";
$message="";

$page = getField("p,safe,get");
$reason = getField("t,alpha,get");

switch ($reason) {
    case "et":
        $message = lg_phrase_form_error_token;
        break;
    case "ec":
    	$message = lg_phrase_form_error_cookie;
    	break;
    case "e":
        $message = lg_phrase_form_error_time;
        break;
}
?>