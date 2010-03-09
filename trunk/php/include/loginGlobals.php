<?PHP
$lg_filename = basename($_SERVER['PHP_SELF']);
/*******************************************************************************************************************
* Login Globals
* 
* NOTE: You must set lg_loginPath and uncomment the correct connection string (lg_term_command_string)
*
* Last Modification: 06 MAR 2010 :: Rod Divilbiss - used for testing HTML 4.01 Strict templates.
* Version:  beta 1.5 - US English - PHP
******************************************************************************************************************/
define("lg_cancel_account_page", "cancel_account.php");
define("lg_change_password_page", "change_password.php");
// contact is not part of the login-system. Must specify the entire path possibly outside of the login-system.
define("lg_contact_form", "/login-project/phphtml/contact.php");
define("lg_copyright", "&copy; 2010 EE Collaborative Login System http://www.webloginproject.com");
define("lg_domain", "www.webloginproject.com");
define("lg_domain_secure", "www.webloginproject.com");
// forbidden is not part of the login-system. Must specify the entire path possibly outside of the login-system.
define("lg_forbidden", "/login-project/phphtml/forbidden.php");
// form error is not necessarily part of the login-system. Must specify the entire path possibly outside of the login-system.
define("lg_form_error", "/login-project/phphtml/form_error.php");
// home page is not part of the login-system. Must specify the entire path possibly outside of the login-system.
define("lg_home", "/login-project/phphtml/index.php");
define("lg_log_logins", true);
define("lg_logged_out_page", "loggedout.php");
define("lg_login_attempts", 5);
define("lg_loginPage", "login.php");
define("lg_loginPath", "/login-project/phphtml/");
define("lg_logout_page", "logout.php");
define("lg_new_token_page", "issue_verification_token.php");
define("lg_recover_passsword_page", "recover_password.php");
define("lg_register_delete_page", "register_delete.php");
define("lg_register_page", "register.php");
define("lg_set_new_password_page", "set_new_password.php");
define("lg_success_page", "login_success.php");
define("lg_useSSL", true);
define("lg_debug", true);
define("lg_verify_page", "register_verify.php");
define("lg_webmaster_email", "Webmaster <webmaster@webloginproject.com>");
define("lg_webmaster_email_link", '<a href="mailto:webmaster@webloginproject.com">Webmaster</a>');

/*********************************************************************
* Login system database globals
*********************************************************************/
//define("lg_database", "access");
//define("lg_database", "mysql");
//define("lg_database", "mssql");

//define("lg_term_command_string", "Provider=SQLOLEDB; Server=VCNSQL81\loginproject,1433; UID=lgproject; PWD=A8349&ijq9!ww; Database=loginproject");
//define("lg_term_command_string", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='\\boswinfs03\home\users\web\b1463\whl.rdivilbiss\database\login_system.mdb'");
//define("lg_term_command_string", "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='c:\inetpub\wwwroot\login-system\asp\database\login_system.mdb'");

//define("lg_database_userid", "");
//define("lg_database_password", "");

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

/*********************************************************************
* Login system language globals
*********************************************************************/
define("lg_term_confirm", "Confirm Password");
define("lg_term_contact_form", "Contact Form");
define("lg_term_country", "Country");
define("lg_term_current_password", "Current Password");
define("lg_term_delete_account", "Delete Account");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "EMail");
define("lg_term_enter_information", "Enter Information");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Example");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_immediately", "immediately!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Issue Verification Token");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "Logged Out");
define("lg_term_login", "Login");
define("lg_term_login_success", "Success");
define("lg_term_name", "Name");
define("lg_term_optional", "Optional");
define("lg_term_or", "or");
define("lg_term_password", "Password");
define("lg_term_please_login", "Please Login");
define("lg_term_please_register", "Please Register");
define("lg_term_recover_password", "Recover Password");
define("lg_term_region", "Region");
define("lg_term_register", "Register");
define("lg_term_register_confirmation", "Registration Confirmation");
define("lg_term_register_delete_enter_email", "Enter EMail");
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
define("lg_term_website_address", "Website Address");


define("lg_phrase_cancel_account_cacelled", "The account has been cancelled.");
define("lg_phrase_cancel_account_error", "There was an unexpected error cancelling your account. Please contact the webmaster");
define("lg_phrase_cancel_account_warning", "Enter your User ID and Password to cancel your account.<br>WARNING: THIS ACTION CAN NOT BE UNDONE.<br>If you have forgotten your password use the recover password link below.");
define("lg_phrase_change_password", "Enter your current password, then your desired new password");
define("lg_phrase_confirm_empty", "The Confirm Password field is empty but is required. Please confirm your password.");
define("lg_phrase_confirm_title", "Please confirm your desired password. This field is required.");
define("lg_phrase_contact_webmaster", "contact the webmaster");
define("lg_phrase_delete_account", "Delete Account");
define("lg_phrase_delete_already_verified", "The account has already been verified and could not be deleted");
define("lg_phrase_delete_deleted", "The account has been deleted");
define("lg_phrase_email_empty", "The Email field is empty but is required. Please enter your email address.");
define("lg_phrase_email_title", "Please enter your email address. This field is required.");
define("lg_phrase_enter_unlock_code", "Enter Unlock Code");
define("lg_phrase_issue_new_token", "Enter your userid and email to receive a new verification token.");
define("lg_phrase_issue_new_token_error", "There was an unexpected error generating your verification token. Please contact the webmaster.");
define("lg_phrase_issue_new_token_success", "Your new verification token will be mailed to your email address.");
define("lg_phrase_login_error", "There was an error. Please re-enter your User ID and Password.");
define("lg_phrase_login_token_problem", "Either the verification token has been used, (and you are verified,) or the token is not valid.");
define("lg_phrase_logged_out", "You are logged out.");
define("lg_phrase_logout_continue", "Click here to continue.");
define("lg_phrase_name_empty", "The Name field is empty but is required. Please enter your name.");
define("lg_phrase_name_title", "Please enter your full name. This field is required.");
define("lg_phrase_newpassword_empty", "The New Password field is empty but is required. Please enter your password.");
define("lg_phrase_news", "Do you wish to receive periodic e-mails when the website changes or new articles are posted?");
define("lg_phrase_no_matching_registration", "There was no registration matching the User ID and email address you entered.");
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
define("lg_phrase_register_delete_noemail", "There was no account matching the email address you entered.");
define("lg_phrase_registration_email_verify", "Verify Your EMail Address");
define("lg_phrase_registration_email_verify_msg", "An e-mail was sent to the e-mail address you provided during registration.&nbsp; Click the link in that e-mail or copy and paste the unlock code in the form field below. Your account will not be available until it has been verified.");
define("lg_phrase_registration_error", "There was an unexpected error completing your registration. Please contact the webmaster");
define("lg_phrase_registration_mail0", "Issued New Registration Verification Token");
define("lg_phrase_registration_mail1", "Thank you for registering at");
define("lg_phrase_registration_mail2", "Before you can login you need");
define("lg_phrase_registration_mail3", "to verify your e-mail address.");
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
define("lg_phrase_recover_password5", "email at the following email link ");
define("lg_phrase_recover_password_error", "There was an unexpected error processing your request. Please contact the webmaster.");
define("lg_phrase_recover_password_success", "The request to recover your password was processed suiccessfully.<br>Please follow the instructions in the email sent to you to set a new password.");
define("lg_term_new_password", "New Password");
define("lg_term_reset_password", "Password Reset");
define("lg_term_set_new_password", "Enter A New Password");
define("lg_phrase_set_new_password_good_token", "Your token was valid. Enter a new password.");
define("lg_phrase_set_new_password_tken_expired", "More than 24 hors have passed since you requested a password recovery token.");
define("lg_phrase_contact_webmaster1", "Please contact the webmaster for assistance.");
define("lg_phrase_webmaster_may_be_contacted", "The webmaster may be contact by email using this link: ");
define("lg_phrase_set_new_password_error", "There was an unexpected error in completing your request. ");
define("lg_phrase_set_new_password_success", "Your password was successfully changed.");
?>