<?PHP
/**
* Login System Form Error include
* 27 APR 2010 Version alpha 0.1b debug
*/

$page="";
$reason="";
$message="";

$page = getField("p,safe,get");
$reason = getField("t,alpha,get");

switch ($reason) {
    case "et":
        $message = "The form timed out before completion. Please complete the form in less than 5 minutes.";
        break;
    case "ec":
    	$message = "Cookies are required for login. Please ensure your browser accepts cookies from this site.";
    	break;
    case "e":
        $message = "There was a form error. This can be caused by using your browser's back button to return to a previously completed form and re-submitting it.";
        break;
}
?>