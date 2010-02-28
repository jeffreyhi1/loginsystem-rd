<?PHP
include "include\loginGlobals.php";

echo lg_domain . "<br>\n";
if (lg_useSSL===true) {
	echo "use SSL is True<br>\n";
}else{
	echo "use SSL is False<br>\n";
}

$now = date("n/j/Y h:i:s A");
$name = "John Doe";
$email = "jdoe@example.com";
$destination = "\protected_page.php";
$token = "0ADF42686D1E7B631BE19FC023C4DC59E6C9BDFA";
$regMail = "";
echo "----------------------------- REGISTRATION E-MAIL ---------------------------------<br>\n";
$regMail .=  "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
$regMail .=  "<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=UTF-8\">";
$regMail .=  "</HEAD><BODY><DIV><FONT face=Arial size=2>". lg_term_register_confirmation ."<br><br>";
$regMail .=  lg_term_to . $name . "<br><br>";
$regMail .=  lg_phrase_registration_mail1 ." ". lg_domain .". " . lg_phrase_registration_mail2 . "<br>";
$regMail .=  lg_phrase_registration_mail3 . ".<br><br>";
$regMail .=  '<a href="http://' . lg_domain . lg_loginPath . lg_verify_page . '?token=' . $token .'&p='. $destination. '">'. lg_phrase_registration_mail4 .'</a><br><br>';
$regMail .=  lg_phrase_registration_mail5 . lg_domain . lg_loginPath . lg_verify_page . "<br>";
$regMail .=  lg_phrase_registration_mail6 . "<br><br>";
$regMail .=  $token . "<br><br>";
$regMail .=  lg_phrase_registration_mail7 . "<br>";
$regMail .=  'this link: <a href="http://' . lg_domain . lg_loginPath . lg_register_delete_page . '?email='. $email .'">'. lg_term_remove_registration .'</a><br><br>';
$regMail .=  lg_phrase_registration_mail9 . lg_domain . lg_contact_form . '\">' . lg_phrase_contact_webmaster ."</a><br><br>";
$regMail .=  lg_copyright ."<br>";
$regMail .=  "</FONT></DIV></BODY></HTML>";

echo $regMail . "<br>\n";
echo "----------------------------- END REGISTRATION E-MAIL -----------------------------<br><br>\n";

$newToken = "";
echo "----------------------------- ISSUE NEW TOKEN E-MAIL ------------------------------<br>\n";
$newToken .= "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
$newToken .= "<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=UTF-8\">";
$newToken .= "</HEAD><BODY><DIV><FONT face=Arial size=2>". lg_phrase_registration_mail0 ."<br><br>";
$newToken .= lg_term_to . $name . "<br><br>";
$newToken .= lg_phrase_registration_mail1 ." ". lg_domain .". ". lg_phrase_registration_mail2 . "<br>";
$newToken .= lg_phrase_registration_mail3 . ".<br><br>";
$newToken .= '<a href="http://' . lg_domain . lg_loginPath . lg_verify_page . '?token=' . $token . '&id=1\">'. lg_phrase_registration_mail4 . '</a><br><br>';
$newToken .= lg_phrase_registration_mail5 . lg_domain . lg_loginPath . lg_verify_page . "<br>";
$newToken .= lg_phrase_registration_mail6 . "<br><br>";
$newToken .= $token . "<br><br>";
$newToken .= lg_phrase_registration_mail7 . "<br>";
$newToken .= 'this link: <a href="http://' . lg_domain . lg_loginPath . lg_register_delete_page . '?email='. $email .'">'. lg_term_remove_registration .'</a><br><br>';
$newToken .= lg_phrase_registration_mail9 . lg_domain . lg_contact_form . '\">' . lg_phrase_contact_webmaster ."</a><br><br>";
$newToken .= lg_copyright ."<br>";
$newToken .= "</FONT></DIV></BODY></HTML>";

echo $newToken . "<br>\n";
echo "----------------------------- END ISSUE NEW TOKEN E-MAIL --------------------------<br><br>\n";

$changePW = "";
echo "----------------------------- CHANGE PASSWORD E-MAIL ------------------------------<br>\n";

$changePW .= "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
$changePW .= "<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=UTF-8\">";
$changePW .= "</HEAD><BODY><DIV><FONT face=Arial size=2>" . lg_term_to . $name . "<br><br>";
$changePW .= lg_phrase_password_changed_pre . lg_domain . lg_phrase_password_changed_post ." ". $now ."<br><br>";
$changePW .= lg_phrase_password_change_authorized;
$changePW .= lg_term_via_email . " " . lg_webmaster_email_link . " " . lg_term_immediately . "<br>";
$changePW .= lg_term_or . " " . lg_term_at . '&nbsp;the <a "http://' . lg_domain . lg_loginPath . lg_contact_form . '\">' . lg_term_contact_form . '</a><br>';
$changePW .= "</FONT></DIV>";
$changePW .= "</div></BODY></HTML>";

echo $changePW . "<br>\n";
echo "----------------------------- END CHANGE PASSWORD E-MAIL --------------------------<br><br>\n";

$recoverPW = "";
echo "----------------------------- RECOVER PASSWORD E-MAIL -----------------------------<br>\n";

$recoverPW .= "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
$recoverPW .= "<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=UTF-8\">";
$recoverPW .= "</HEAD><BODY><DIV><FONT face=Arial size=2>". lg_phrase_recover_password ."<br><br>";
$recoverPW .= lg_term_to . $name . "<br><br>";
$recoverPW .= lg_phrase_request_password1 ." ". lg_domain .". <br>";
$recoverPW .= lg_phrase_recover_password2 . "<br><br>";
$recoverPW .= '<a href="http://' . lg_domain . lg_loginPath . lg_set_new_password_page . '?resettoken=' . $token . '&id=1">'. lg_phrase_recover_password3 .'</a><br><br>';
$recoverPW .= lg_phrase_registration_mail5 . lg_domain . lg_loginPath . lg_set_new_password_page . "<br>";
$recoverPW .= lg_phrase_registration_mail6 . "<br><br>";
$recoverPW .= $token . "<br><br>";
$recoverPW .= lg_phrase_recover_password4 . "<br>";
$recoverPW .= lg_phrase_recover_password5 . lg_webmaster_email_link . "<br><br>";
$recoverPW .= lg_copyright ."<br>";
$recoverPW .= "</FONT></DIV></BODY></HTML>";

echo $recoverPW . "<br>\n";
echo "----------------------------- END RECOVER PASSWORD E-MAIL -------------------------<br><br>\n";

$setNewPW = "";
echo "----------------------------- SET NEW PASSWORD E-MAIL -----------------------------<br>\n";

$setNewPW .= "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.0 Transitional//EN\">";
$setNewPW .= "<HTML><HEAD><META http-equiv=Content-Type content=\"text/html; charset=UTF-8\">";
$setNewPW .= "</HEAD><BODY><DIV><FONT face=Arial size=2>". lg_phrase_password_changed_pre . lg_domain . lg_phrase_password_changed_post ." ". $now ."<br><br>";
$setNewPW .= lg_phrase_password_change_authorized;
$setNewPW .= lg_term_via_email . " " . lg_webmaster_email_link . " " . lg_term_immediately . "<br>";
$setNewPW .= lg_term_or . " " . lg_term_at . '&nbsp;the <a href="' . lg_contact_form . '">'. lg_term_contact_form .'</a><br>';
$setNewPW .= "</FONT></DIV>";
$setNewPW .= "</div></BODY></HTML>";

echo $setNewPW . "<br>\n";
echo "----------------------------- END SET NEW PASSWORD E-MAIL -------------------------<br><br>\n";

?>
