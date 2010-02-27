<%
'*******************************************************************************************************************
'* Login Globals
'* 
'* NOTE: You must set lg_loginPath and uncomment the correct connection string (lg_term_command_string)
'*
'* Modification: 07 FEB 2010 :: Rod Divilbiss - added MS SQL and MySql Constants.
'* Modification: 11 FEB 2010 :: Rod Divilbiss - recover password Constants added.
'* Modification: 20 FEB 2010 :: Rod Divilbiss - added missing lg_phrase_registration_mail0
'* Last Modification: 13 FEB 2010 :: Rod Divilbiss - set new password Constants added.
'* Version:  beta 1.2 - US English - ASP
'*******************************************************************************************************************
'* LOGIN GLOBALS LIBRARY
'* Purpose: Provide configuration and internatialization features for the EE Collaborative Login System.
'*
'* Copyright Information
'* © 2010, EE Collaborative Login Project, Some Rights Reserved 
'*
'* This code is protected by a compilation copyright in the United States of America based on 
'* U.S. Copyright Law (17 U.S.C. sec.101 et seq) and International Copyright Laws.  
'* This code distributed in accordance with the GNU General Public License v2. 
'* If you do not agree with the conditions of that license you may not use, copy, distribute or 
'* make derivative works based on this code.
'*
'* The author of this code is Roderick W. Divilbiss of Overland Park, Kansas, USA. The content is 
'* contributed to the EE Collaborative Login Project and is distributed in accordance with the 
'* Creative Commons 3.0 BY-SA license.
'*
'* NOTE that this in part requires that:
'*   * You must attribute the use of the code as follows:
'*     This site includes work © 2010, by the EE Collaborative Login Project, 
'*     used by permission in accordance with the Creative Commons 3.0 BY-SA license.
'*
'*   * If you alter, transform, or build upon this work, you may distribute the resulting work only 
'*     under the same, similar or a compatible license and must attribute the original authors as stated 
'*     above.
'*
'*   * For any reuse or distribution, you must make clear to others the license terms of this work. 
'*     The best way to do this is with a link to Creative Commons 3.0 BY-SA.
'*
'* Disclaimer of Warranties
'* NO WARRANTY 
'* Because the code is licensed free of charge, there is no warranty For the code, to the extent 
'* permitted by applicable law. Except when Otherwise stated in writing the copyright holders and/or 
'* other parties Provide the code "as is" without warranty of any kind, either expressed Or implied, 
'* including, but not limited to, the implied warranties of Merchantability and fitness for a particular 
'* purpose. The entire risk as To the quality and performance of the code is with you.
'*
'* Should the code prove defective, you assume the cost of all necessary servicing, Repair or correction. 
'* In no event unless required by applicable law or agreed to in writing Will any copyright holder, or 
'* any other party who may modify and/or Redistribute the program as permitted above, be liable to you 
'* for damages, Including any general, special, incidental or consequential damages arising out of the 
'* use or inability to use this code (including but not limited To loss of data or data being rendered 
'* inaccurate or losses sustained by You or third parties or a failure of the code to operate with any 
'* other Programs), even if such holder or other party has been advised of the Possibility of such damages.
'*
'*******************************************************************************************************************
Dim lg_filename
lg_filename = Trim(Mid(Request.ServerVariables("SCRIPT_NAME"),InStrRev(Request.ServerVariables("SCRIPT_NAME"),"/")+1,99))
'*********************************************************************
'* Login system globals
'*********************************************************************
Const lg_cancel_account_page = "cancel_account.asp"
Const lg_change_password_page = "change_password.asp"
Const lg_contact_form = "contact.asp"
Const lg_copyright = "&copy; 2010 EE Collaborative Login System http://www.webloginproject.com"
'Const lg_domain = "divilbiss"
Const lg_domain = "www.example.com"
Const lg_domain_secure = "www.example.com/"
Const lg_forbidden = "forbidden.asp"
Const lg_form_error = "oops.asp"
Const lg_home = "default.asp"
Const lg_log_logins = True
Const lg_logged_out_page = "loggedout.asp"
Const lg_login_attempts = 5
Const lg_loginPage = "login.asp"
Const lg_loginPath = "/login-project/"
Const lg_logout_page = "logout.asp"
Const lg_new_token_page = "register_newtoken.asp"
Const lg_recover_passsword_page = "recover_password.asp"
Const lg_register_delete_page = "register_delete.asp"
Const lg_register_page = "register.asp"
Const lg_set_new_password_page = "set_new_password.asp"
Const lg_success_page = "login_success.asp"
Const lg_useSSL = True
Const lg_debug = True
Const lg_verify_page = "register_verify.asp"
Const lg_webmaster_email = "Webmaster <webmaster@example.com>"
Const lg_webmaster_email_link = "<a href=""mailto:webmaster@example.com"">Webmaster</a>"
'*********************************************************************
'* Login system database globals
'*********************************************************************
'Const lg_database = "access"
'Const lg_database = "mysql"
'Const lg_database = "mssql"

'Const lg_term_command_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='c:\inetpub\wwwroot\login-system\database\login_system.mdb'"
'Const lg_term_command_string = "Provider=SQLOLEDB; Server=#server#,1433; UID=#userid#; PWD=#password#; Database=loginproject"
'Const lg_term_command_string = "DRIVER={MySQL ODBC 3.51 Driver}; SERVER=#server#; PORT=3306; DATABASE=loginproject; USER=#userid#; PASSWORD=#password#; OPTION=3;"

Const lg_database_userid = ""
Const lg_database_password = ""

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

'*********************************************************************
'* Login system language globals
'*********************************************************************
Const lg_login_button_text = "Login"
Const lg_register_button_text = "Register"
Const lg_term_at = "at"
Const lg_term_cancel = "Cancel Account"
Const lg_term_cancel_account = "Cancel Account"
Const lg_term_change_password = "Change Password"
Const lg_term_change_password_button_text = "Change Password"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "City"
Const lg_term_confirm = "Confirm Password"
Const lg_term_contact_form = "Contact Form"
Const lg_term_country = "Country"
Const lg_term_current_password = "Current Password"
Const lg_term_delete_account = "Delete Account"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "EMail"
Const lg_term_enter_information = "Enter Information"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Example"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_immediately = "immediately!"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "Issue Verification Token"
Const lg_term_log_string = "logLogin"
Const lg_term_logged_out = "Logged Out"
Const lg_term_login = "Login"
Const lg_term_login_success = "Success"
Const lg_term_name = "Name"
Const lg_term_optional = "Optional"
Const lg_term_or = "or"
Const lg_term_password = "Password"
Const lg_term_please_login = "Please Login"
Const lg_term_please_register = "Please Register"
Const lg_term_recover_password = "Recover Password"
Const lg_term_region = "Region"
Const lg_term_register = "Register"
Const lg_term_register_confirmation = "Registration Confirmation"
Const lg_term_register_delete_enter_email = "Enter Email"
Const lg_term_registration = "Registration"
Const lg_term_registration_thankyou = "Thank you for registering."
Const lg_term_registration_newtoken = "New Registration Token"
Const lg_term_registration_verification = "Registration Verification"
Const lg_term_remember = True
Const lg_term_rememberme = "Remember Me"
Const lg_term_remove_registration = "Remove Registration"
Const lg_term_required = "required"
Const lg_term_set_newpassword = "Set New Password"
Const lg_term_submit = "Submit"
Const lg_term_to = "To "
Const lg_term_useragent = "Useragent"
Const lg_term_userid = "UserID"
Const lg_term_via_email = "by email at"
Const lg_term_website_address = "Website Address"


Const lg_phrase_cancel_account_cacelled = "The account has been cancelled."
Const lg_phrase_cancel_account_error = "There was an unexpected error cancelling your account. Please contact the webmaster"
Const lg_phrase_cancel_account_warning = "Enter your User ID and Password to cancel your account.<br />WARNING: THIS ACTION CAN NOT BE UNDONE.<br />If you have forgotten your password use the recover password link below."
Const lg_phrase_change_password = "Enter your current password, then your desired new password"
Const lg_phrase_confirm_empty = "The Confirm Password field is empty but is required. Please confirm your password."
Const lg_phrase_confirm_title = "Please confirm your desired password. This field is required."
Const lg_phrase_contact_webmaster = "contact the webmaster"
Const lg_phrase_delete_account = "Delete Account"
Const lg_phrase_delete_already_verified = "The account has already been verified and could not be deleted"
Const lg_phrase_delete_deleted = "The account has been deleted"
Const lg_phrase_email_empty = "The EMail field is empty but is required. Please enter your email address."
Const lg_phrase_email_title = "Please enter your email address. This field is required."
Const lg_phrase_enter_unlock_code = "Enter Unlock Code"
Const lg_phrase_issue_new_token = "Enter your userid and email to receive a new verification token."
Const lg_phrase_issue_new_token_error = "There was an unexpected error generating your verification token. Please contact the webmaster."
Const lg_phrase_issue_new_token_success = "Your new verification token will be mailed to your email address."
Const lg_phrase_login_error = "There was an error. Please re-enter your User ID and Password."
Const lg_phrase_login_error_token = "You must validate your email address using the token you were sent before you can log in."
Const lg_phrase_login_token_problem = "Either the verification token has been used, (and you are verified,) or the token is not valid."
Const lg_phrase_logged_out = "You are logged out."
Const lg_phrase_logout_continue = "Click here to continue."
Const lg_phrase_name_empty = "The Name field is empty but is required. Please enter your name."
Const lg_phrase_name_title = "Please enter your full name. This field is required."
Const lg_phrase_newpassword_empty = "The New Password field is empty but is required. Please enter your password."
Const lg_phrase_news = "Do you wish to receive periodic e-mails when the website changes or new articles are posted?"
Const lg_phrase_no_matching_registration = "There was no registration matching the User ID and email address you entered."
Const lg_phrase_oldpassword_does_not_match = "The current password does not match your stored password. Try again."
Const lg_phrase_oldpassword_empty = "The Old Password field is empty but is required. Please enter your password."
Const lg_phrase_oldpassword_title = "Please enter your current password. This field is required."
Const lg_phrase_password_change_authorized = "If you did not authorize this change, please contact the webmaster "
Const lg_phrase_password_changed = "Your password was changed"
Const lg_phrase_password_changed_error = "There was an unexpected error. The password was not changed. Please contact the webmaster"
Const lg_phrase_password_changed_okay = "Password changed successfully."
Const lg_phrase_password_changed_post = " was changed at "
Const lg_phrase_password_changed_pre = "Your password at "
Const lg_phrase_password_empty = "The Password field is empty but is required. Please enter your password."
Const lg_phrase_password_new_title = "Please enter your desired password. This field is required."
Const lg_phrase_password_nomatch_confirm = "The Password does not match the Confirmation Password. Please re-enter."
Const lg_phrase_password_title = "Please enter your password. This field is required."
Const lg_phrase_register_delete_noemail = "There was no account matching the email address you entered."
Const lg_phrase_registration_email_verify = "Verify Your Email Address"
Const lg_phrase_registration_email_verify_msg = "An e-mail was sent to the e-mail address you provided during registration.&nbsp; Click the link in that e-mail or copy and paste the unlock code in the form field below. Your account will not be available until it has been verified."
Const lg_phrase_registration_error = "There was an unexpected error completing your registration. Please contact the webmaster"
Const lg_phrase_registration_mail0 = "Issued New Registration Verification Token"
Const lg_phrase_registration_mail1 = "Thank you for registering at"
Const lg_phrase_registration_mail2 = "Before you can login you need"
Const lg_phrase_registration_mail3 = "to verify your e-mail address."
Const lg_phrase_registration_mail4 = "Click Here To Verify"
Const lg_phrase_registration_mail5 = "If the above link does not work, go to http://"
Const lg_phrase_registration_mail6 = "copy and paste the token below into the form and click ""Submit"""
Const lg_phrase_registration_mail7 = "If you did not register, click"
Const lg_phrase_registration_mail8 = "this link: <a href=""http://"
Const lg_phrase_registration_mail9 = "if you have any questions then <a href=""http://"
Const lg_phrase_registration_success = "Registration Successful"
Const lg_phrase_remember_me_warning = "Do not check remember me if this is a shared computer."
Const lg_phrase_userid_empty = "The User ID field is required but is empty. Please enter your User ID."
Const lg_phrase_userid_inuse = "The User ID is in use or invalid."
Const lg_phrase_userid_new_title = "Please enter your desired User ID. This field is required."
Const lg_phrase_userid_title = "Please enter your userid. This field is required."
Const lg_phrase_verify_expired = "More than 24 hors have passed since your registration."
Const lg_phrase_verify_login = "You may now login to your account."
Const lg_phrase_verify_newtoken = "Click here to generate a new unlock code."
Const lg_phrase_verify_verified  = "You have verified your email address."
Const lg_phrase_website_title = "Please enter your website address."
Const lg_phrase_recover_password = "Recover Password"
Const lg_phrase_request_password1 = "A request has been made to recover your password at "
Const lg_phrase_recover_password2 = "You may set a new password by clicking the link below."
Const lg_phrase_recover_password3 = "Set New Password"
Const lg_phrase_recover_password4 = "If you did not request to recover your password, contact the webmaster by "
Const lg_phrase_recover_password5 = "email at the following email link "
Const lg_phrase_recover_password_error = "There was an unexpected error processing your request. Please contact the webmaster."
Const lg_phrase_recover_password_success = "The request to recover your password was processed suiccessfully.<br>Please follow the instructions in the email sent to you to set a new password."
Const lg_term_new_password = "New Password"
Const lg_term_reset_password = "Password Reset"
Const lg_term_set_new_password = "Enter A New Password"
Const lg_phrase_set_new_password_good_token = "Your token was valid. Enter a new password."
Const lg_phrase_set_new_password_tken_expired = "More than 24 hors have passed since you requested a password recovery token."
Const lg_phrase_contact_webmaster1 = "Please contact the webmaster for assistance."
Const lg_phrase_webmaster_may_be_contacted = "The webmaster may be contact by email using this link: "
Const lg_phrase_set_new_password_error = "There was an unexpected error in completing your request. "
Const lg_phrase_set_new_password_success = "Your password was successfully changed."
%>
