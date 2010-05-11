<?PHP
// $Id$
$lg_filename = basename($_SERVER['PHP_SELF']);
/*******************************************************************************************************************
* Login Globals - PHP
* 
* NOTE: You must set lg_domain, lg_domain_secure, lg_loginPath and must set the full path to certain pages.
*       You must set the webmaster e-mail addresses.
*       You must set the database connection details in database.php.     
* 
* Modification: ?? ??? 2010 :: Saurabh - translation to Hindi
* Modification: 26 APR 2010 :: Rod Divilbiss - corrected some file paths.
* Modification: 24 APR 2010 :: Rod Divilbiss - Corrected debug output statements, added lg_term_log_out to
*                                              loginGlobals.php, and corrected paths in loginGlobals.php
* Modification: 23 APR 2010 :: Bob Stone - Beta Testing, Code / path correction and commenting
* Modification: 09 APR 2010 :: Rod Divilbiss - Machine Translation to Hindi
* Modification: 05 APR 2010 :: mplugjan - translation to Swedish
* Modification: 02 APR 2010 :: Rod Divilbiss - Spelling errors corrected.
* Modification: 02 APR 2010 :: acperkins - verified or corrected translation to Spanish (Mexican)
* Modification: 01 APR 2010 :: Bob Stone - translated to Spanish (Mexican)
* Modification: 28 MAR 2010 :: Jürgen Kraus - translated to German
* Modification: 28 MAR 2010 :: Cam Van T Divilbiss - translated to Vietnamese
* Modification: 11 FEB 2010 :: Rod Divilbiss - recover password Constants added.
* Modification: 07 FEB 2010 :: VGR - translation to French
* Modification: 07 FEB 2010 :: Rod Divilbiss - added MS SQL and MySql Constants.
* Modification: 20 FEB 2010 :: Rod Divilbiss - added missing lg_phrase_registration_mail0
* Modification: 13 FEB 2010 :: Rod Divilbiss - set new password Constants added.
* 
* Version: alpha 0.2 - English - PHP
******************************************************************************************************************/
define("lg_cancel_account_page", "cancel_account.php");
define("lg_change_password_page", "change_password.php");
/******************************************************************************************************************
* contact is not part of the login-system. Must specify the entire path possibly outside of the login-system.
******************************************************************************************************************/
define("lg_contact_form", "/login-system/contact.php");
define("lg_copyright", "&copy; 2010 EE Collaborative Login System http://www.webloginproject.com");
define("lg_domain", "www.example.com");
define("lg_domain_secure", "www.example.com");
/******************************************************************************************************************
* forbidden is not part of the login-system. Must specify the entire path possibly outside of the login-system.
******************************************************************************************************************/
define("lg_forbidden", "/login-system/forbidden.php");
/******************************************************************************************************************
* form error is not part of the login-system. Must specify the entire path possibly outside of the login-system.
******************************************************************************************************************/
define("lg_form_error", "/login-system/form_error.php");
/******************************************************************************************************************
* home page is not part of the login-system. Must specify the entire path possibly outside of the login-system.
******************************************************************************************************************/
define("lg_home", "/login-system/index.php");
define("lg_log_logins", true);
define("lg_logged_out_page", "loggedout.php");
define("lg_login_attempts", 5);
define("lg_loginPage", "login.php");
define("lg_loginPath", "/login-system/");
define("lg_logout_page", "logout.php");
define("lg_new_token_page", "issue_verification_token.php");
define("lg_recover_passsword_page", "recover_password.php");
define("lg_register_delete_page", "register_delete.php");
define("lg_register_page", "register.php");
define("lg_set_new_password_page", "set_new_password.php");
define("lg_success_page", "login_success.php");
define("lg_useCAPTCHA", true);
define("lg_useSSL", false);
define("lg_debug", false);
define("lg_verify_page", "register_verify.php");
define("lg_webmaster_email", "Webmaster <webmaster@example.com>");
define("lg_webmaster_email_link", '<a href="mailto:webmaster@example.com">Webmaster</a>');


/*********************************************************************
* Login system database globals
*********************************************************************/

function dbNow() {
	return date("Y-m-d H:i:s");
}


/*********************************************************************
* Login system language globals
*********************************************************************/
define("lg_login_button_text", "Login");
define("lg_register_button_text", "Register");
define("lg_term_at", "at");
define("lg_term_cancel", "Cancel Account");
define("lg_term_cancel_account", "Cancel Account");
define("lg_term_change_password", "Change Password");
define("lg_term_change_password_button_text", "Change Password");
define("lg_term_checkToken", "checkToken");
define("lg_term_city", "City");
define("lg_term_confirm", "Confirm Password");
define("lg_term_contact", "Contact");
define("lg_term_contact_form", "Contact Form");
define("lg_term_content_language", "<meta http-equiv=\"content-language\" content=\"en-US\" />");
define("lg_term_language", "<meta name=\"language\" content=\"en-US\" />");
define("lg_term_country", "Country");
define("lg_term_current_password", "Current Password");
define("lg_term_delete_account", "Delete Account");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "Email");
define("lg_term_enter_information", "Enter Information");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Example");
define("lg_term_from_error", "Form Error");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_guest","Guest.");
define("lg_term_home", "Home");
define("lg_term_immediately", "immediately!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Issue Verification Token");
define("lg_term_log_string", "logLogin");
define("lg_term_log_out", "Log Out");
define("lg_term_logged_out", "Logged Out");
define("lg_term_login", "Login");
define("lg_term_login_success", "Success");
define("lg_term_name", "Name");
define("lg_term_optional", "Optional");
define("lg_term_or", "or");
define("lg_term_password", "Password");
define("lg_term_please_login", "Please Login");
define("lg_term_please_register", "Please Register");
define("lg_term_project_home_link", "<a title=\"Login System on Google Code\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password", "Recover Password");
define("lg_term_region", "Region");
define("lg_term_register", "Register");
define("lg_term_register_confirmation", "Registration Confirmation");
define("lg_term_register_delete_enter_email", "Enter Email");
define("lg_term_registration", "Registration");
define("lg_term_registration_thankyou", "Thank you for registering.");
define("lg_term_registration_verification", "Registration Verification");
define("lg_term_remember", true);
define("lg_term_rememberme", "Remember Me");
define("lg_term_remove_registration", "Remove Registration");
define("lg_term_required", "required");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_submit", "Submit");
define("lg_term_to", "To ");
define("lg_term_useragent", "Useragent");
define("lg_term_userid", "UserID");
define("lg_term_via_email", "by email at");
define("lg_term_webloginproject_link", "<a title=\"Web Login Project\" href=\"http://www.webloginproject.com/index.php\">Web Login Project</a>");
define("lg_term_website_address", "Website Address");
define("lg_term_welcome","Welcome");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"en\" lang=\"en\">");
define("lg_phrase_attention_webmaster", "Attention Webmaster");
define("lg_phrase_cancel_account_canceled", "The account has been canceled.");
define("lg_phrase_cancel_account_error", "There was an unexpected error cancelling your account. Please contact the webmaster");
define("lg_phrase_cancel_account_warning", "Enter your User ID and Password to cancel your account.<br>WARNING: THIS ACTION CAN NOT BE UNDONE.<br>If you have forgotten your password use the recover password link below.");
define("lg_phrase_change_password", "Enter your current password, then your desired new password");
define("lg_phrase_confirm_empty", "The Confirm Password field is empty but is required. Please confirm your password.");
define("lg_phrase_confirm_title", "Please confirm your desired password. This field is required.");
define("lg_phrase_contact_body", "<p>This is your contact page. Usually it would be a form. At a minimum you should provide the Webmaster&#39;s email address.</p>");
define("lg_phrase_default_body1", "This site was created to demonstrate incorporating the Login System into your web site design.</p><p>Every web site can be conceptualized as a template. Common sections of a web page template might include a banner, navigation, a main content area, and maybe a footer with links to Terms Of Use, Copyright details, and the Privacy Policy.</p><p>The area where you are now reading in the &quot;Main Content Area&quot; of this page. This is the area where you will insert the HTML or XHTML markup templates that enable the Login System. Feel free to click the login link above, register and test the login system as implemented. This is a working beta test site and certain features may or not be implemented while you are testing.</p><p>Visit the project home on Google Code at:");
define("lg_phrase_default_body2", ".</p><p>Or visit various demo pages in a number of world languages at the");
define("lg_phrase_contact_webmaster", "contact the webmaster");
define("lg_phrase_delete_account", "Delete Account");
define("lg_phrase_delete_already_verified", "The account has already been verified and could not be deleted");
define("lg_phrase_delete_deleted", "The account has been deleted");
define("lg_phrase_email_empty", "The Email field is empty but is required. Please enter your Email address.");
define("lg_phrase_email_title", "Please enter your Email address. This field is required.");
define("lg_phrase_enter_unlock_code", "Enter Unlock Code");
define("lg_phrase_forbidden_body", "<p><h1>You do not have access to that resource.</h1></p><p>Contact the webmaster at:");
define("lg_phrase_form_error_cookie", "Cookies are required for login. Please ensure your browser accepts cookies from this site.");
define("lg_phrase_form_error_time", "The form timed out before completion. Please complete the form in less than 5 minutes.");
define("lg_phrase_form_error_token", "There was a form error. This can be caused by using your browser's back button to return to a previously completed form and re-submitting it.");
define("lg_phrase_is_logged_in"," is logged in.");
define("lg_phrase_issue_new_token", "Enter your userid and Email to receive a new verification token.");
define("lg_phrase_issue_new_token_error", "There was an unexpected error generating your verification token. Please contact the webmaster.");
define("lg_phrase_issue_new_token_success", "Your new verification token will be mailed to your Email address.");
define("lg_phrase_login_error", "There was an error. Please re-enter your User ID and Password.");
define("lg_phrase_login_error_token", "You must validate your email address using the token you were sent before you can log in.");
define("lg_phrase_login_token_problem", "Either the verification token has been used, (and you are verified,) or the token is not valid.");
define("lg_phrase_logged_out", "You are logged out.");
define("lg_phrase_logout_continue", "Click here to continue.");
define("lg_phrase_name_empty", "The Name field is empty but is required. Please enter your name.");
define("lg_phrase_name_title", "Please enter your full name. This field is required.");
define("lg_phrase_newpassword_empty", "The New Password field is empty but is required. Please enter your password.");
define("lg_phrase_news", "Do you wish to receive periodic Emails when the website changes or new articles are posted?");
define("lg_phrase_no_matching_registration", "There was no registration matching the User ID and Email address you entered.");
define("lg_phrase_oldpassword_does_not_match", "The current password does not match your stored password. Try again.");
define("lg_phrase_oldpassword_empty", "The Old Password field is empty but is required. Please enter your password.");
define("lg_phrase_oldpassword_title", "Please enter your current password. This field is required.");
define("lg_phrase_password_change_authorized", "If you did not authorize this change, please contact the webmaster ");
define("lg_phrase_password_changed", "Your password was changed");
define("lg_phrase_password_changed_error", "There was an unexpected error. The password was not changed. Please contact the webmaster");
define("lg_phrase_password_changed_okay", "Password changed successfully.");
define("lg_phrase_password_changed_post", " was changed at ");
define("lg_phrase_password_changed_pre", "Your password at ");
define("lg_phrase_password_empty", "The Password field is empty but is required. Please enter your password.");
define("lg_phrase_password_new_title", "Please enter your desired password. This field is required.");
define("lg_phrase_password_nomatch_confirm", "The Password does not match the Confirmation Password. Please re-enter.");
define("lg_phrase_password_title", "Please enter your password. This field is required.");
define("lg_phrase_recaptcha_error", "The reCAPTCHA wasn't entered correctly.");
define("lg_phrase_register_delete_noemail", "There was no account matching the email address you entered.");
define("lg_phrase_registration_email_verify", "Verify Your Email Address");
define("lg_phrase_registration_email_verify_msg", "An Email was sent to the Email address you provided during registration.&nbsp; Click the link in that Email or copy and paste the unlock code in the form field below. Your account will not be available until it has been verified.");
define("lg_phrase_registration_error", "There was an unexpected error completing your registration. Please contact the webmaster");
define("lg_phrase_registration_mail0", "Issued New Registration Verification Token");
define("lg_phrase_registration_mail1", "Thank you for registering at");
define("lg_phrase_registration_mail2", "Before you can login you need");
define("lg_phrase_registration_mail3", "to verify your Email address.");
define("lg_phrase_registration_mail4", "Click Here To Verify");
define("lg_phrase_registration_mail5", "If the above link does not work, go to http://");
define("lg_phrase_registration_mail6", "copy and paste the token below into the form and click \"Submit\"");
define("lg_phrase_registration_mail7", "If you did not register, click");
define("lg_phrase_registration_mail8", "this link: <a href=\"http://");
define("lg_phrase_registration_mail9", "if you have any questions then <a href=\"http://");
define("lg_phrase_registration_success", "Registration Successful");
define("lg_phrase_remember_me_warning", "Do not check remember me if this is a shared computer.");
define("lg_phrase_userid_empty", "The User ID field is required but is empty. Please enter your User ID.");
define("lg_phrase_userid_inuse", "The User ID is in use or invalid.");
define("lg_phrase_userid_new_title", "Please enter your desired User ID. This field is required.");
define("lg_phrase_userid_title", "Please enter your userid. This field is required.");
define("lg_phrase_verify_expired", "More than 24 hors have passed since your registration.");
define("lg_phrase_verify_login", "You may now login to your account.");
define("lg_phrase_verify_newtoken", "Click here to generate a new unlock code.");
define("lg_phrase_verify_verified", "You have verified your email address.");
define("lg_phrase_website_title", "Please enter your website address.");
define("lg_phrase_recover_password", "Recover Password");
define("lg_phrase_request_password1", "A request has been made to recover your password at ");
define("lg_phrase_recover_password2", "You may set a new password by clicking the link below.");
define("lg_phrase_recover_password3", "Set New Password");
define("lg_phrase_recover_password4", "If you did not request to recover your password, contact the webmaster by ");
define("lg_phrase_recover_password5", "Email at the following Email link ");
define("lg_phrase_recover_password_error", "There was an unexpected error processing your request. Please contact the webmaster.");
define("lg_phrase_recover_password_success", "The request to recover your password was processed successfully.<p>Please follow the instructions in the Email sent to you to set a new password.</p>");
define("lg_term_new_password", "New Password");
define("lg_term_reset_password", "Password Reset");
define("lg_term_set_new_password", "Enter A New Password");
define("lg_phrase_set_new_password_good_token", "Your token was valid. Enter a new password.");
define("lg_phrase_set_new_password_tken_expired", "More than 24 hours have passed since you requested a password recovery token.");
define("lg_phrase_contact_webmaster1", "Please contact the webmaster for assistance.");
define("lg_phrase_webmaster_may_be_contacted", "The webmaster may be contacted by Email using this link: ");
define("lg_phrase_set_new_password_error", "There was an unexpected error in completing your request. ");
define("lg_phrase_set_new_password_success", "Your password was successfully changed.");
define("lg_phrase_user_registration", " User Registration.");
?>