<%
'* $Id$
'********************************************************************************************************************
'* Login Globals - ASP
'* 
'* NOTE: You must set lg_domain, lg_domain_secure, lg_loginPath and must set the full path to certain pages.
'*       You must set the webmaster e-mail addresses.
'*       You must set the database connection details below.
'* 
'*
'* Modification: 13 MAY 2010 :: Karol Piczak - translation to Polish 
'* Modification: ?? ??? 2010 :: Saurabh - translation to Hindi
'* Modification: 27 APR 2010 :: Michel Plungjan - translation to Danish
'* Modification: 26 APR 2010 :: Rod Divilbiss - corrected some file paths.
'* Modification: 25 APR 2010 :: Rod Divilbiss - added lg_term_log_out, corrected paths.
'* Modification: 24 APR 2010 :: Rod Divilbiss - Corrected debug output statements, added lg_term_log_out to
'*                                              loginGlobals.php, and corrected paths in loginGlobals.php
'* Modification: 23 APR 2010 :: Bob Stone - Beta Testing, Code / path correction and commenting 
'* Modification: 09 APR 2010 :: Rod Divilbiss - Machine Translation to Hindi
'* Modification: 05 APR 2010 :: mplugjan - translation to Swedish
'* Modification: 02 APR 2010 :: Rod Divilbiss - Spelling errors corrected.
'* Modification: 02 APR 2010 :: acperkins - verified or corrected translation to Spanish (Mexican)
'* Modification: 01 APR 2010 :: Bob Stone - translated to Spanish (Mexican)
'* Modification: 28 MAR 2010 :: Jürgen Kraus - translated to German
'* Modification: 28 MAR 2010 :: Cam Van T Divilbiss - translated to Vietnamese
'* Modification: 11 FEB 2010 :: Rod Divilbiss - recover password Constants added.
'* Modification: 07 FEB 2010 :: VGR - translation to French
'* Modification: 07 FEB 2010 :: Rod Divilbiss - added MS SQL and MySql Constants.
'* Modification: 20 FEB 2010 :: Rod Divilbiss - added missing lg_phrase_registration_mail0
'* Modification: 13 FEB 2010 :: Rod Divilbiss - set new password Constants added.
'*
* Version: alpha 0.4 - English - ASP
'*******************************************************************************************************************
Dim lg_filename
lg_filename = Trim(Mid(Request.ServerVariables("SCRIPT_NAME"),InStrRev(Request.ServerVariables("SCRIPT_NAME"),"/")+1,99))
'******************************************************************************************************************
Const lg_cancel_account_page = "cancel_account.asp"
Const lg_change_password_page = "change_password.asp"
'******************************************************************************************************************
'* contact is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'******************************************************************************************************************
Const lg_contact_form = "/login-system/contact.asp"
Const lg_copyright = "&copy; 2010 EE Collaborative Login System http://www.webloginproject.com"
Const lg_domain = "www.example.com"
Const lg_domain_secure = "www.example.com"
'******************************************************************************************************************
'* forbidden is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'******************************************************************************************************************
Const lg_forbidden = "/login-system/forbidden.asp"
'******************************************************************************************************************
'* form error is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'******************************************************************************************************************
Const lg_form_error = "/login-system/form_error.asp"
'******************************************************************************************************************
'* home page is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'******************************************************************************************************************
Const lg_debug = false
Const lg_home = "/login-system/default.asp"
Const lg_log_logins = true
Const lg_logged_out_page = "loggedout.asp"
Const lg_login_attempts = 5
Const lg_loginPage = "login.asp"
Const lg_loginPath = "/login-system/"
Const lg_logout_page = "logout.asp"
Const lg_new_token_page = "issue_verification_token.asp"
Const lg_password_max_age = 6
Const lg_password_min_bits = 72
Const lg_password_min_length = 10
Const lg_recover_passsword_page = "recover_password.asp"
Const lg_register_delete_page = "register_delete.asp"
Const lg_register_page = "register.asp"
Const lg_set_new_password_page = "set_new_password.asp"
Const lg_success_page = "login_success.asp"
Const lg_useCAPTCHA = true
Const lg_useSSL = false
Const lg_verify_page = "register_verify.asp"
Const lg_webmaster_email = "webmaster@example.com"
Const lg_webmaster_email_link = "<a href=""mailto:webmaster@example.com"">Webmaster</a>"

'**********************************************************************
'* Login system database globals
'**********************************************************************
'Const lg_database = "mysql"
'Const lg_database = "access"
'Const lg_database = "mssql"

'Const lg_term_command_string = "DRIVER={MySQL ODBC 3.51 Driver}; SERVER=localhost; PORT=3306; DATABASE=login-system; USER=webuser; PASSWORD=password; OPTION=3;"
'Const lg_term_command_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='c:\inetpub\wwwroot\login-system\database\login_system.mdb'"
'Const lg_term_command_string = "Provider=SQLOLEDB; Server=localhost,1433; UID=webuser; PWD=password; Database=loginproject"

Const lg_database_password = ""
Const lg_database_userid = ""

Function dbNow
    'MS Access & MS SQL Server datetime fileds accept ASP now
    'MySql requires YYYY-MM-DD HH:MM:SS
    Dim dt
    dt = now
    If lg_database = "mysql" Then
        dbNow = Year(dt)&"-"&Right("00"&CStr(Month(dt)),2)&"-"&Right("00"&CStr(Day(dt)),2)&" "&Right("00"&CStr(Hour(dt)),2)&":"&Right("00"&CStr(Minute(dt)),2)&":"&Right("00"&CStr(Second(dt)),2)
    Else
        dbNow = dt
    End If
End Function

'**********************************************************************
'* Login system language globals
'**********************************************************************
Const lg_login_button_text = "Login"
Const lg_phrase_attention_webmaster = "Attention Webmaster"
Const lg_phrase_cancel_account_canceled = "The account has been canceled."
Const lg_phrase_cancel_account_error = "There was an unexpected error canceling your account. Please contact the webmaster"
Const lg_phrase_cancel_account_warning = "Enter your User ID and Password to cancel your account.<p>WARNING: THIS ACTION CAN NOT BE UNDONE.</p>If you have forgotten your password use the recover password link below."
Const lg_phrase_change_password = "Enter your current password, then your desired new password"
Const lg_phrase_confirm_empty = "The Confirm Password field is empty but is required. Please confirm your password."
Const lg_phrase_confirm_title = "Please confirm your desired password. This field is required."
Const lg_phrase_contact_body = "<p>This is your contact page. Usually it would be a form. At a minimum you should provide the Webmaster&#39;s email address.</p>"
Const lg_phrase_contact_webmaster = "contact the webmaster"
Const lg_phrase_contact_webmaster1 = "Please contact the webmaster for assistance."
Const lg_phrase_default_body1 = "This site was created to demonstrate incorporating the Login System into your web site design.</p><p>Every web site can be conceptualized as a template. Common sections of a web page template might include a banner, navigation, a main content area, and maybe a footer with links to Terms Of Use, Copyright details, and the Privacy Policy.</p><p>The area where you are now reading in the &quot;Main Content Area&quot; of this page. This is the area where you will insert the HTML or XHTML markup templates that enable the Login System. Feel free to click the login link above, register and test the login system as implemented. This is a working beta test site and certain features may or not be implemented while you are testing.</p><p>Visit the project home on Google Code at: "
Const lg_phrase_default_body2 = ".</p><p>Or visit various demo pages in a number of world languages at the"
Const lg_phrase_default_body3 = "demonstration and test site.</p>"
Const lg_phrase_delete_account = "Delete Account"
Const lg_phrase_delete_already_verified = "The account has already been verified and could not be deleted"
Const lg_phrase_delete_deleted = "The account has been deleted"
Const lg_phrase_email_empty = "The Email field is empty but is required. Please enter your Email address."
Const lg_phrase_email_title = "Please enter your Email address. This field is required."
Const lg_phrase_enter_set_new_password_token = "Enter set new password token"
Const lg_phrase_enter_unlock_code = "Enter Unlock Code"
Const lg_phrase_forbidden_body = "<p><h1>You do not have access to that resource.</h1></p><p>Contact the webmaster at:"
Const lg_phrase_form_error_cookie = "Cookies are required for login. Please ensure your browser accepts cookies from this site."
Const lg_phrase_form_error_time = "The form timed out before completion. Please complete the form in less than 5 minutes."
Const lg_phrase_form_error_token = "There was a form error. This can be caused by using your browser's back button to return to a previously completed form and re-submitting it."
Const lg_phrase_is_logged_in = "is logged in."
Const lg_phrase_issue_new_token = "Enter your userid and Email to receive a new verification token."
Const lg_phrase_issue_new_token_error = "There was an unexpected error generating your verification token. Please contact the webmaster."
Const lg_phrase_issue_new_token_success = "Your new verification token will be mailed to your Email address."
Const lg_phrase_logged_out = "You are logged out."
Const lg_phrase_login_error = "There was an error. Please re-enter your User ID and Password."
Const lg_phrase_login_error_token = "You must validate your email address using the token you were sent before you can log in."
Const lg_phrase_login_token_problem = "Either the verification token has been used, (and you are verified,) or the token is not valid."
Const lg_phrase_logout_continue = "Click here to continue."
Const lg_phrase_name_empty = "The Name field is empty but is required. Please enter your name."
Const lg_phrase_name_title = "Please enter your full name. This field is required."
Const lg_phrase_newpassword_empty = "The New Password field is empty but is required. Please enter your new password."
Const lg_phrase_news = "Do you wish to receive periodic Emails when the website changes or new articles are posted?"
Const lg_phrase_no_matching_registration = "There was no registration matching the User ID and Email address you entered."
Const lg_phrase_oldpassword_does_not_match = "The current password does not match your stored password. Try again."
Const lg_phrase_oldpassword_empty = "The Current Password field is empty but is required. Please enter your current password."
Const lg_phrase_oldpassword_title = "Please enter your current password. This field is required."
Const lg_phrase_password_change_authorized = "If you did not authorize this change, please contact the webmaster"
Const lg_phrase_password_changed = "Your password was changed."
Const lg_phrase_password_changed_error = "There was an unexpected error. The password was not changed. Please contact the webmaster"
Const lg_phrase_password_changed_okay = "Password changed successfully."
Const lg_phrase_password_changed_post = " was changed at "
Const lg_phrase_password_changed_pre = "Your password at "
Const lg_phrase_password_empty = "The Password field is empty but is required. Please enter your password."
Const lg_phrase_password_new_title = "Please enter your desired password. This field is required."
Const lg_phrase_password_nomatch_confirm = "The Password does not match the Confirmation Password. Please re-enter."
Const lg_phrase_password_title = "Please enter your password. This field is required."
Const lg_phrase_password_too_soon = "The password is the same as a recently used password. Please choose a different password."
Const lg_phrase_password_too_short_pre = "The password entered has too few charaters. The minimum password length is:"
Const lg_phrase_password_too_short_post = "letters, symbols, and numbers."
Const lg_phrase_password_too_simple = "The entered password is too simple. Please enter a password which has many random characters including a mix of upper and lower case letters, symbols, and digits."
Const lg_phrase_recaptcha_error = "The reCAPTCHA wasn't entered correctly."
Const lg_phrase_recover_password = "Recover Password"
Const lg_phrase_recover_password_error = "There was an unexpected error processing your request. Please contact the webmaster."
Const lg_phrase_recover_password_success = "The request to recover your password was processed successfully.<p>Please follow the instructions in the Email sent to you to set a new password.</p>"
Const lg_phrase_recover_password2 = "You may set a new password by clicking the link below."
Const lg_phrase_recover_password3 = "Set New Password"
Const lg_phrase_recover_password4 = "If you did not request to recover your password, contact the webmaster by "
Const lg_phrase_recover_password5 = "Email at the following Email link "
Const lg_phrase_register_delete_noemail = "There was no account matching the email address you entered."
Const lg_phrase_registration_email_verify = "Verify Your Email Address"
Const lg_phrase_registration_email_verify_msg = "An Email was sent to the Email address you provided during registration.&nbsp; Click the link in that Email or copy and paste the unlock code in the form field below. Your account will not be available until it has been verified."
Const lg_phrase_registration_error = "There was an unexpected error completing your registration. Please contact the webmaster"
Const lg_phrase_registration_mail0 = "Issued New Registration Verification Token"
Const lg_phrase_registration_mail1 = "Thank you for registering at"
Const lg_phrase_registration_mail2 = "Before you can login you need"
Const lg_phrase_registration_mail3 = "to verify your Email address."
Const lg_phrase_registration_mail4 = "Click Here To Verify"
Const lg_phrase_registration_mail5 = "If the above link does not work, go to <p>http://"
Const lg_phrase_registration_mail6 = "copy and paste the token below into the form and click ""Submit"""
Const lg_phrase_registration_mail7 = "If you did not register, click"
Const lg_phrase_registration_mail8 = "this link: <a href=""http://"
Const lg_phrase_registration_mail9 = "if you have any questions then <a href=""http://"
Const lg_phrase_registration_success = "Registration Successful"
Const lg_phrase_remember_me_warning = "Do not check remember me if this is a shared computer."
Const lg_phrase_request_password1 = "A request has been made to recover your password at "
Const lg_phrase_set_new_password_error = "There was an unexpected error in completing your request. "
Const lg_phrase_set_new_password_good_token = "Your token was valid. Enter a new password."
Const lg_phrase_set_new_password_success = "Your password was successfully changed."
Const lg_phrase_set_new_password_token_expired = "More than 24 hours have passed since you requested a password recovery token."
Const lg_phrase_user_registration = "User Registration"
Const lg_phrase_userid_empty = "The User ID field is required but is empty. Please enter your User ID."
Const lg_phrase_userid_inuse = "The User ID is in use or invalid."
Const lg_phrase_userid_new_title = "Please enter your desired User ID. This field is required."
Const lg_phrase_userid_title = "Please enter your userid. This field is required."
Const lg_phrase_verify_expired = "More than 24 hours have passed since your registration."
Const lg_phrase_verify_login = "You may now login to your account."
Const lg_phrase_verify_newtoken = "Click here to generate a new unlock code."
Const lg_phrase_verify_verified = "You have verified your email address."
Const lg_phrase_webmaster_may_be_contacted = "The webmaster may be contacted by Email using this link: "
Const lg_phrase_website_title = "Please enter your website address."
Const lg_register_button_text = "Register"
Const lg_term_at = "at"
Const lg_term_cancel = "Cancel Account"
Const lg_term_cancel_account = "Cancel Account"
Const lg_term_change_password = "Change Password"
Const lg_term_change_password_button_text = "Change Password"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "City"
Const lg_term_confirm = "Confirm Password"
Const lg_term_contact = "Contact"
Const lg_term_contact_form = "Contact Form"
Const lg_term_content_language = "<meta http-equiv=""content-language"" content=""en-US"" />"
Const lg_term_country = "Country"
Const lg_term_current_password = "Current Password"
Const lg_term_delete_account = "Delete Account"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "Email"
Const lg_term_enter_information = "Enter Information"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Example"
Const lg_term_forbidden = "Forbidden"
Const lg_term_form_error = "Form Error"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "Guest"
Const lg_term_home = "Home"
Const lg_term_immediately = "immediately"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "Issue Verification Token"
Const lg_term_language = "<meta name=""language"" content=""en-US"" />"
Const lg_term_log_out = "Log out"
Const lg_term_log_string = "logLogin"
Const lg_term_logged_out = "Logged Out"
Const lg_term_login = "Login"
Const lg_term_login_success = "Success"
Const lg_term_name = "Name"
Const lg_term_new_password = "New Password"
Const lg_term_optional = "Optional"
Const lg_term_or = "or"
Const lg_term_password = "Password"
Const lg_term_please_login = "Please Login"
Const lg_term_please_register = "Please Register"
Const lg_term_project_home_link = "<a title=""Login System on Google Code"" href=""http://code.google.com/p/loginsystem-rd/"">http://code.google.com/p/loginsystem-rd/</a>"
Const lg_term_recover_password = "Recover Password"
Const lg_term_region = "Region"
Const lg_term_register = "Register"
Const lg_term_register_confirmation = "Registration Confirmation"
Const lg_term_register_delete_enter_email = "Enter Email"
Const lg_term_registration = "Registration"
Const lg_term_registration_thankyou = "Thank you for registering."
Const lg_term_registration_verification = "Registration Verification"
Const lg_term_remember = true
Const lg_term_rememberme = "Remember Me"
Const lg_term_remove_registration = "Remove Registration"
Const lg_term_required = "required"
Const lg_term_reset_password = "Password Reset"
Const lg_term_set_new_password = "Enter A New Password"
Const lg_term_set_newpassword = "changePassword"
Const lg_term_submit = "Submit"
Const lg_term_to = "To"
Const lg_term_useragent = "Useragent"
Const lg_term_userid = "UserID"
Const lg_term_via_email = "by email at"
Const lg_term_webloginproject_link = "<a title=""Web Login Project"" href=""http://www.webloginproject.com/index.php"">Web Login Project</a>"
Const lg_term_website = "Website"
Const lg_term_website_address = "Website Address"
Const lg_term_welcome = "Welcome"
Const lg_term_xhtml_xmlns = "<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""en"" lang=""en"">"
%>
