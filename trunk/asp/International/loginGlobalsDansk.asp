<%
'* $Id$
'*******************************************************************************************************************
'* Login Globals - ASP
'* 
'* NOTE: You must set lg_domain, lg_domain_secure, lg_loginPath and must set the full path to certain pages.
'*       You must set the webmaster e-mail addresses.
'*       You must set the database connection details below.
'*
'* 
'* Modification: ?? ??? 2010 :: Saurabh - translation to Hindi
'* Modification: 27 APR 2010 :: Michel Plungjan - translation to Danish
'* Modification: 26 APR 2010 :: Rod Divilbiss - corrected some file paths.
'* Modification: 25 APR 2010 :: Rod Divilbiss - added lg_term_log_out, corrected paths.
'* Modification: 24 APR 2010 :: Rod Divilbiss - Corrected debug output statements, added lg_term_log_out to
'*                                              loginGlobals.asp, and corrected paths in loginGlobals.asp
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
'* Version: alpha 0.2 - Danish - ASP
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
'*******************************************************************************************************************
Const lg_forbidden = "/login-system/forbidden.asp"
'******************************************************************************************************************
'* form error is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'*******************************************************************************************************************
Const lg_form_error = "/login-system/form_error.asp"
'******************************************************************************************************************
'* home page is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'******************************************************************************************************************
Const lg_home = "/login-system/default.asp"
Const lg_log_logins = true
Const lg_logged_out_page = "loggedout.asp"
Const lg_login_attempts = 5
Const lg_loginPage = "login.asp"
Const lg_loginPath = "/login-system/"
Const lg_logout_page = "logout.asp"
Const lg_new_token_page = "issue_verification_token.asp"
Const lg_recover_passsword_page = "recover_password.asp"
Const lg_register_delete_page = "register_delete.asp"
Const lg_register_page = "register.asp"
Const lg_set_new_password_page = "set_new_password.asp"
Const lg_success_page = "login_success.asp"
Const lg_useCAPTCHA = true
Const lg_useSSL = false
Const lg_debug = false
Const lg_verify_page = "register_verify.asp"
Const lg_webmaster_email = "Webmaster <webmaster@example.com>"
Const lg_webmaster_email_link  "<a href=""mailto:webmaster@example.com"">Webmaster</a>"
'*********************************************************************
'* Login system database globals
'*********************************************************************
'Const lg_database = "access"
'Const lg_database = "mysql"
'Const lg_database = "mssql"

'Const lg_term_command_string = "Provider=SQLOLEDB; Server=localhost,1433; UID=webuser; PWD=password; Database=loginproject"
'Const lg_term_command_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='c:\inetpub\wwwroot\login-system\database\login_system.mdb'"
'Const lg_term_command_string = "DRIVER={MySQL ODBC 3.51 Driver}; SERVER=localhost; PORT=3306; DATABASE=login-system; USER=webuser; PASSWORD=password; OPTION=3;"

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
'**********************************************************************
Const lg_register_button_text = "Registrer"
Const lg_term_at = "at"
Const lg_term_cancel = "Annuller konto"
Const lg_term_cancel_account = "Annuller konto"
Const lg_term_change_password = "Skift adgangskode"
Const lg_term_change_password_button_text = "Skift adgangskode"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "City"
Const lg_term_confirm = "Bekræft kodeord"
Const lg_term_contact = "Contact"
Const lg_term_contact_form = "Kontakt Form"
Const lg_term_content_language = "<meta http-equiv=""content-language"" content=""en-US"" />"
Const lg_term_country = "Land"
Const lg_term_current_password = "Nuværende adgangskode"
Const lg_term_delete_account = "Slet konto"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "Email"
Const lg_term_enter_information = "Indtast Information"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Eksempel"
Const lg_term_forbidden = "Forbidden"
Const lg_term_forbidden = "Forbidden"
Const lg_term_form_error = "Form Error"
Const lg_term_from_error = "Form Error"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "Gæst"
Const lg_term_home = "Home"
Const lg_term_immediately = "med det samme!"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "Udsted Verifikation Token"
Const lg_term_language = "<meta name="language" content="en-US" />"
Const lg_term_log_string = "logLogin"
Const lg_term_logged_out = "Logget ud"
Const lg_term_login = "Log ind"
Const lg_term_login_success = "Succes"
Const lg_term_name = "Navn"
Const lg_term_new_password = "Nyt Password"
Const lg_term_optional = "Frivilligt"
Const lg_term_or = "eller"
Const lg_term_password = "Password"
Const lg_term_please_login = "Venligst login"
Const lg_term_please_register = "Tilmeld dig venligst"
Const lg_term_project_home_link = "<a title=""Login System on Google Code"" href=""http://code.google.com/p/loginsystem-rd/"">http://code.google.com/p/loginsystem-rd/</a>"
Const lg_term_recover_password = "Genopret Password"
Const lg_term_region = "Region"
Const lg_term_register = "Registrer"
Const lg_term_register_confirmation = "Registreringsbekræftelse"
Const lg_term_register_delete_enter_email = "Indtast e-mail"
Const lg_term_registration = "Registrering"
Const lg_term_registration_thankyou = "Tak for din registrering."
Const lg_term_registration_verification = "Registreringsverifikation"
Const lg_term_remember = true
Const lg_term_rememberme = "Husk mig"
Const lg_term_remove_registration = "Fjern registrering"
Const lg_term_required = "nødvendigt"
Const lg_term_reset_password = "Password Reset"
Const lg_term_set_new_password = "Indtast en ny adgangskode"
Const lg_term_set_newpassword = "changePassword"
Const lg_term_submit = "Send"
Const lg_term_to = "Til"
Const lg_term_useragent = "UserAgent"
Const lg_term_userid = "Bruger Identifikation"
Const lg_term_via_email = "via email på"
Const lg_term_webloginproject_link = "<a title=""Web Login Project"" href=""http://www.webloginproject.com/index.php"">Web Login Project</a>"
Const lg_term_website_address = "Website adresse"
Const lg_term_welcome = "Velkommen"
Const lg_term_xhtml_xmlns = "<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""en"" lang=""en"">"
Const lg_login_button_text = "Log ind"
Const lg_phrase_attention_webmaster = "Webmaster bemærk venligst"
Const lg_phrase_cancel_account_cacelled = "Denne konto er blevet annuleret."
Const lg_phrase_cancel_account_error = "Der var en uventet fejl da vi annullerede din konto. Kontakt venligst webmasteren "
Const lg_phrase_cancel_account_warning = "Indtast dit brugernavn og password for at annullere din konto.<p>ADVARSEL: Denne handling kan ikke fortrydes.</p>Hvis du har glemt dit password brug <i>genopret password</i> linket herunder."
Const lg_phrase_change_password = "Indtast din nuværende adgangskode, derefter dit ønskede nye kodeord"
Const lg_phrase_confirm_empty = "Bekræft Password feltet er tomt, men er påkrævet. Bekræft venligst dit password."
Const lg_phrase_confirm_title = "Bekræft venligst din ønskede adgangskode. Dette felt er påkrævet."
Const lg_phrase_contact_body = "<p>This is your contact page. Usually it would be a form. At a minimum you should provide the Webmaster&#39;s email address.</p>"
Const lg_phrase_contact_webmaster = "kontakt webmaster"
Const lg_phrase_contact_webmaster1 = "Kontakt venligst webmaster for at få hjælp."
Const lg_phrase_default_body1 = "This site was created to demonstrate incorporating the Login System into your web site design.</p><p>Every web site can be conceptualized as a template. Common sections of a web page template might include a banner, navigation, a main content area, and maybe a footer with links to Terms Of Use, Copyright details, and the Privacy Policy.</p><p>The area where you are now reading in the &quot;Main Content Area&quot; of this page. This is the area where you will insert the HTML or XHTML markup templates that enable the Login System.</p><p>Visit the project home on Google Code at:"
Const lg_phrase_default_body2 = ".</p><p>Or visit various demo pages in a number of world languages at the"
Const lg_phrase_default_body3 = "demonstration and test site.</p>"
Const lg_phrase_delete_account = "Slet konto"
Const lg_phrase_delete_already_verified = "Denne konto er allerede blevet verificeret og kunne ikke slettes"
Const lg_phrase_delete_deleted = "Kontoen er blevet slettet"
Const lg_phrase_email_empty = "Email feltet er tomt, men er påkrævet. Indtast din e-mail-adresse."
Const lg_phrase_email_title = "Indtast din e-mail adresse. Dette felt er påkrævet."
Const lg_phrase_enter_unlock_code = "Indtast din Unlock kode"
Const lg_phrase_forbidden_body = "<p><h1>You do not have access to that resource.</h1></p><p>Contact the webmaster at:"
Const lg_phrase_form_error_cookie = "Cookies are required for login. Please ensure your browser accepts cookies from this site."
Const lg_phrase_form_error_time = "The form timed out before completion. Please complete the form in less than 5 minutes."
Const lg_phrase_form_error_token = "There was a form error. This can be caused by using your browser's back button to return to a previously completed form and re-submitting it."
Const lg_phrase_is_logged_in = "er logget ind"
Const lg_phrase_issue_new_token = "Indtast dit userid og din e-mail for at modtage en ny bekræftelses token."
Const lg_phrase_issue_new_token_error = "Der opstod en uventet fejl da vi genererede din kontrol token. Kontakt venligst webmaster."
Const lg_phrase_issue_new_token_success = "Dit nye bekræftelseskendetegn vil blive sendt til din e-mail adresse."
Const lg_phrase_logged_out = "Du er logget ud."
Const lg_phrase_login_error = "Der var en fejl. Indtast dit brugernavn og adgangskode igen."
Const lg_phrase_login_error_token = "Du skal validere din e-mail adresse ved hjælp af symbolske du blev sendt, før du kan logge ind."
Const lg_phrase_login_token_problem = "Enten er verifikation token blevet brugt (og du er verificeret), eller token er ikke gyldig."
Const lg_phrase_logout_continue = "klik her for at fortsætte."
Const lg_phrase_name_empty = "Feltet er tomt, men er påkrævet. Indtast dit navn."
Const lg_phrase_name_title = "Indtast dit fulde navn. Dette felt er påkrævet."
Const lg_phrase_newpassword_empty = "Det Nye Password felt er tomt, men er påkrævet. Indtast dit kodeord."
Const lg_phrase_news = "Ønsker du at modtage regelmæssige e-mails, når hjemmesiden ændres eller nye artikler er indsendt?"
Const lg_phrase_no_matching_registration = "Der var ingen registrering, der matcher det Bruger ID og den e-mail-adresse, du har indtastet."
Const lg_phrase_oldpassword_does_not_match = "Den nuværende adgangskode matcher ikke dine gemte adgangskode. Prøv igen"
Const lg_phrase_oldpassword_empty = "Det Gamle Password felt er tomt, men er påkrævet. Indtast dit kodeord."
Const lg_phrase_oldpassword_title = "Indtast din nuværende adgangskode. Dette felt er påkrævet."
Const lg_phrase_password_change_authorized = "Hvis du ikke har tilladelse til denne ændring, bedes du kontakte webmaster"
Const lg_phrase_password_changed = "Din adgangskode blev ændret"
Const lg_phrase_password_changed_error = "Der opstod en uventet fejl. Adgangskoden blev ikke ændret. Kontakt venligst webmaster"
Const lg_phrase_password_changed_okay = "Password skiftet."
Const lg_phrase_password_changed_post = "var ændret til"
Const lg_phrase_password_changed_pre = "Din adgangskode på"
Const lg_phrase_password_empty = "Password feltet er tomt, men er påkrævet. Indtast dit kodeord."
Const lg_phrase_password_new_title = "Indtast dit ønskede password. Dette felt er påkrævet."
Const lg_phrase_password_nomatch_confirm = "Password matcher ikke Bekræftelsesadgangskoden. Indtast igen."
Const lg_phrase_password_title = "Indtast din adgangskode. Dette felt er påkrævet. "
Const lg_phrase_recaptcha_error = "Den reCAPTCHA var ikke indtastet korrekt."
Const lg_phrase_recover_password = "Gendan Password"
Const lg_phrase_recover_password_error = "Der opstod en uventet fejl under behandling af din anmodning. Kontakt venligst webmaster."
Const lg_phrase_recover_password_success = "Anmodningen om at gendanne din adgangskode blev behandlet med succes.<p>Følg instruktionerne i e-mail sendt til dig for at lave en ny adgangskode.</p>"
Const lg_phrase_recover_password2 = "Du kan angive en ny adgangskode ved at klikke på linket nedenfor."
Const lg_phrase_recover_password3 = "Forandr dit Password"
Const lg_phrase_recover_password4 = "Hvis du ikke har anmodet om at gendanne din adgangskode, kan du kontakte webmaster via"
Const lg_phrase_recover_password5 = "E-mail på det følgende e-mail link"
Const lg_phrase_register_delete_noemail = "Der er ingen konto som matchede den e-mail adresse, du indtastede."
Const lg_phrase_registration_email_verify = "Bekræft din e-mail-adresse"
Const lg_phrase_registration_email_verify_msg = "En e-mail blev sendt til den email adresse, du angav under registreringen. Klik på linket i den e-mail eller klip og klistr låse-op koden i form feltet nedenfor. Din konto vil ikke være tilgængelig før den er blevet bekræftet."
Const lg_phrase_registration_error = "Der var en uventet fejl da vi fuldførte din registrering. Kontakt venligst webmaster"
Const lg_phrase_registration_mail0 = "Udsted Ny Registrerings Kontrol Token"
Const lg_phrase_registration_mail1 = "Tak for din registrering hos"
Const lg_phrase_registration_mail2 = "Før du kan logge ind skal du"
Const lg_phrase_registration_mail3 = "at bekræfte din e-mail-adresse."
Const lg_phrase_registration_mail4 = "Klik her for at kontrollere"
Const lg_phrase_registration_mail5 = "Hvis ovenstående link ikke virker, skal du gå til http://"
Const lg_phrase_registration_mail6 = "kopiere og klistre token nedenfor i skemaet og klik ""Send"""
Const lg_phrase_registration_mail7 = "Hvis du ikke registrerede, klik på"
Const lg_phrase_registration_mail8 = "dette link: <a href = ""http://"
Const lg_phrase_registration_mail9 = "hvis du har spørgsmål så <a href = ""http://"
Const lg_phrase_registration_success = "Registrering lykkedes"
Const lg_phrase_remember_me_warning = "Tjek ikke <b>husk mig</b>, hvis det er en delt computer."
Const lg_phrase_request_password1 = "Der er blevet anmodt om at gendanne din adgangskode ved"
Const lg_phrase_set_new_password_error = "Der var en uventet fejl ved udfyldelsen af din anmodning."
Const lg_phrase_set_new_password_good_token = "Din token var gyldig. Indtast en ny adgangskode."
Const lg_phrase_set_new_password_success = "Dit password er blevet ændret."
Const lg_phrase_set_new_password_tken_expired = "Mere end 24 timer er gået, siden du har bedt om en gendannelse af adgangskode token."
Const lg_phrase_user_registration = "Bruger registrering."
Const lg_phrase_userid_empty = "Bruger-ID feltet er påkrævet, men er tomt. Indtast dit bruger-ID."
Const lg_phrase_userid_inuse = "Bruger-ID er i brug eller ugyldigt."
Const lg_phrase_userid_new_title = "Indtast dit ønskede bruger-ID. Dette felt er påkrævet."
Const lg_phrase_userid_title = "Indtast dit bruger-ID. Dette felt er påkrævet."
Const lg_phrase_verify_expired = "Der er gået mere end 24 timer der er gået siden din registrering."
Const lg_phrase_verify_login = "Du kan nu logge ind på din konto."
Const lg_phrase_verify_newtoken = "Klik her for at generere en ny låse-kode."
Const lg_phrase_verify_verified = "Du har bekræftet din e-mail-adresse."
Const lg_phrase_webmaster_may_be_contacted = "Webmasteren kan kontaktes via e-mail via dette link:"
Const lg_phrase_website_title = "Indtast dit website adresse."
%>