<%
'* $Id: loginGlobalsSvenska.asp 201 2010-04-28 09:43:15Z rdivilbiss $
'********************************************************************************************************************
'* Login Globals - ASP
'* 
'* NOTE: You must set lg_domain, lg_domain_secure, lg_loginPath and must set the full path to certain pages.
'*       You must set the webmaster e-mail addresses.
'*       You must set the database connection details below.
'*
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
'* Modification: 28 MAR 2010 :: J�rgen Kraus - translated to German
'* Modification: 28 MAR 2010 :: Cam Van T Divilbiss - translated to Vietnamese
'* Modification: 11 FEB 2010 :: Rod Divilbiss - recover password Constants added.
'* Modification: 07 FEB 2010 :: VGR - translation to French
'* Modification: 07 FEB 2010 :: Rod Divilbiss - added MS SQL and MySql Constants.
'* Modification: 20 FEB 2010 :: Rod Divilbiss - added missing lg_phrase_registration_mail0
'* Modification: 13 FEB 2010 :: Rod Divilbiss - set new password Constants added.
'*
'* Version: alpha 0.2 - Swedish - ASP
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
Const lg_webmaster_email = "webmaster@www.example.com"
Const lg_webmaster_email_link = "<a href=""mailto:webmaster@www.example.com"">Webmaster</a>"

'**********************************************************************
'* Login system database globals
'**********************************************************************
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

'**********************************************************************
'* Login system language globals
'**********************************************************************
Const lg_login_button_text = "Logga in"
Const lg_term_at = "p�"
Const lg_term_cancel = "Avsluta konto"
Const lg_term_cancel_account = "Avsluta konto"
Const lg_term_change_password = "�ndra l�senord"
Const lg_term_change_password_button_text = "�ndra l�senord"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "Stad"
Const lg_term_confirm = "Bekr�fta l�senord"
Const lg_term_contact = "Kontakt"
Const lg_term_contact_form = "Kontaktformul�r"
Const lg_term_content_language = "<meta http-equiv=""content-language"" content=""sv-SE"" />"
Const lg_term_country = "Land"
Const lg_term_current_password = "Nuvarande l�senord"
Const lg_term_delete_account = "Ta bort konto"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "E-post"
Const lg_term_enter_information = "Ange information"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Exempel"
Const lg_term_forbidden = "F�rbjudna"
Const lg_term_form_error = "Form Fel"
Const lg_term_form_error = "Form Fel"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "G�st."
Const lg_term_home = "Hem"
Const lg_term_immediately = "omedelbart!"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "Fr�ga identifieringskod"
Const lg_term_language = "<meta name="language" content="sv-SE" />"
Const lg_term_log_out = "Logga ut"
Const lg_term_log_string = "logLogin"
Const lg_term_logged_out = "Utloggad"
Const lg_term_login = "Logga in"
Const lg_term_login_success = "Framg�ng"
Const lg_term_name = "Namn"
Const lg_term_new_password = "Nytt l�senord"
Const lg_term_optional = "Valfritt"
Const lg_term_or = "eller"
Const lg_term_password = "l�senord"
Const lg_term_please_login = "V�nligen Logga in"
Const lg_term_please_register = "V�nligen registrera"
Const lg_term_project_home_link = "<a title=""Logga System p� Google Code"" href=""http://code.google.com/p/loginsystem-rd/"">http://code.google.com/p/loginsystem-rd/</a>"
Const lg_term_recover_password = "�terst�ll l�senord"
Const lg_term_region = "region"
Const lg_term_register = "Registrera dig"
Const lg_term_register_confirmation = "bekr�ftelse p� registrering"
Const lg_term_register_delete_enter_email = "Ange Email"
Const lg_term_registration = "Registrering"
Const lg_term_registration_thankyou = "Tack f�r din registrering."
Const lg_term_registration_verification = "Registrering Verification"
Const lg_term_remember = true
Const lg_term_rememberme = "Kom ih�g mig"
Const lg_term_remove_registration = "Ta bort Registrering"
Const lg_term_required = "obligatoriskt"
Const lg_term_reset_password = "�terst�ll l�senord"
Const lg_term_set_new_password = "ange ett nytt l�senord"
Const lg_term_set_newpassword = "changePassword"
Const lg_term_submit = "Skicka"
Const lg_term_to = "till"
Const lg_term_useragent = "useragent"
Const lg_term_userid = "ID"
Const lg_term_via_email = "via e-post"
Const lg_term_webloginproject_link = "<a title=""Webb Logga Project"" href=""http://www.webloginproject.com/index.php"">Webb Logga Project</a>"
Const lg_term_website_address = "Webbsida adress"
Const lg_term_welcome = "V�lkommen"
Const lg_term_xhtml_xmlns = "<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""sv"" lang=""sv"">"
Const lg_phrase_attention_webmaster = "Uppm�rksam Webmaster"
Const lg_phrase_cancel_account_canceled = "Kontot har �r annullerat."
Const lg_phrase_cancel_account_error = "Det var ett ov�ntat fel n�r kontot blev avslutat. V�nligen kontakta webmaster"
Const lg_phrase_cancel_account_warning = "Ange ditt anv�ndarnamn och l�senord f�r att avsluta kontot.<p>VARNING: Denna �tg�rd kan inte �ngras.</p>Om du har gl�mt ditt l�senord anv�nder �tervinna l�senord l�nken nedan."
Const lg_phrase_change_password = "Ange ditt nuvarande l�senord och sedan �nskat nytt l�senord"
Const lg_phrase_confirm_empty = "f�ltet Bekr�fta l�senord �r tomt men obligatoriskt. V�nligen bekr�fta ditt l�senord."
Const lg_phrase_confirm_title = "V�nligen bekr�fta �nskat l�senord. Detta f�lt �r obligatoriskt."
Const lg_phrase_contact_body = "<p>Detta �r din kontaktsida. Vanligtvis skulle det vara en form. �tminstone b�r du ge Webmaster e-postadress.</p>"
Const lg_phrase_contact_webmaster = "kontakta webmastern"
Const lg_phrase_contact_webmaster1 = "V�nligen kontakta webmaster f�r att f� hj�lp."
Const lg_phrase_default_body1 = "Denna webbplats har skapats f�r att visa inf�rliva inloggningssystem p� din hemsida design.</p><p>Varje webbplats kan f�rest�llas som en mall. Gemensamma delar av en webbsida mall kan innefatta en banderoll, navigering, ett huvudinneh�llet omr�de, och kanske en sidfot med l�nkar till Anv�ndarvillkor, upphovsr�tt detaljer och sekretesspolicy.</p><p>Omr�det d�r du nu l�ser i &quot;Main Content Area&quot; p� denna sida. Detta �r det omr�de d�r du s�tter i HTML eller XHTML mallar som g�r det m�jligt inloggningssystem.</p><p>Bes�k projektet hem p� Google Code p�:"
Const lg_phrase_default_body2 = ".</p><p>Eller bes�ka olika demo sidor i ett antal av v�rldens spr�k p�"
Const lg_phrase_default_body3 = "demonstration och m�tplats.</p>"
Const lg_phrase_delete_account = "Ta bort konto"
Const lg_phrase_delete_already_verified = "kontot �r redan verificerad och kunde inte tas bort"
Const lg_phrase_delete_deleted = "Kontot har raderats"
Const lg_phrase_email_empty = "The E-postadres f�ltet �r tomt, men obligatoriskt. Ange din e-postadress."
Const lg_phrase_email_title = "Ange din E-postadress. Detta f�lt �r obligatoriskt."
Const lg_phrase_enter_unlock_code = "Ange uppl�sningskoden"
Const lg_phrase_forbidden_body = "<p><h1>Du har inte tillg�ng till denna resurs.</h1></p><p>Kontakta webmaster p�:"
Const lg_phrase_form_error_cookie = "Cookies kr�vs f�r inloggning. Se till att din webbl�sare accepterar cookies fr�n denna webbplats."
Const lg_phrase_form_error_time = "Formul�ret timeout innan den �r slutf�rd. Fyll i formul�ret p� mindre �n 5 minuter."
Const lg_phrase_form_error_token = "Det fanns en blankett fel. Detta kan orsakas av att anv�nda webbl�sarens tillbaka-knappen f�r att �terg� till en tidigare ifyllda blanketten och �terigen l�mna in den."
Const lg_phrase_is_logged_in = "�r inloggad"
Const lg_phrase_issue_new_token = "Ange ditt anv�ndarnamn och E-post f�r att f� en ny identifieringskod."
Const lg_phrase_issue_new_token_error = "Det var ett ov�ntat fel du skapar en identifieringskod. Kontakta den webbansvariga."
Const lg_phrase_issue_new_token_success = "Ditt nya identifieringskod skickas till din E-postadress."
Const lg_phrase_logged_out = "Du �r utloggad."
Const lg_phrase_login_error = "Det uppstod ett fel. Skriv in ditt anv�ndarnamn och l�senord."
Const lg_phrase_login_error_token = "Du m�ste bekr�fta din e-postadress med hj�lp av token du fick innan du kan logga in."
Const lg_phrase_login_token_problem = "Antingen identifieringskod har anv�nts, (och du kontrolleras) eller token �r inte giltig."
Const lg_phrase_logout_continue = "Klicka h�r f�r att forts�tta."
Const lg_phrase_name_empty = "Namn f�ltet �r tomt, men obligatoriskt. V�nligen ange ditt namn."
Const lg_phrase_name_title = "Ange ditt fullst�ndiga namn. Detta f�lt �r obligatoriskt."
Const lg_phrase_newpassword_empty = "F�ltet Nytt L�senord �r tomt, men obligatoriskt. V�nligen ange ditt l�senord."
Const lg_phrase_news = "Vill du ta emot regelbundna e-post n�r hemsidan �ndringar eller nya artiklar l�ggs ut?"
Const lg_phrase_no_matching_registration = "Det var ingen registrering som matchade anv�ndar-ID och e-postadress du angav."
Const lg_phrase_oldpassword_does_not_match = "Den nuvarande l�senord matchar inte den lagrade l�senord. F�rs�k igen"
Const lg_phrase_oldpassword_empty = "F�ltet Gamla L�senordet �r tomt, men obligatoriskt. V�nligen ange ditt l�senord."
Const lg_phrase_oldpassword_title = "Ange ditt nuvarande l�senord. Detta f�lt �r obligatoriskt."
Const lg_phrase_password_change_authorized = "Om du inte till�ter denna f�r�ndring, kontakta webmaster"
Const lg_phrase_password_changed = "Ditt l�senord har �ndrats"
Const lg_phrase_password_changed_error = "Det var ett ov�ntat fel. L�senordet �ndrades inte. V�nligen kontakta webmaster"
Const lg_phrase_password_changed_okay = "l�senord har �ndrats."
Const lg_phrase_password_changed_post = "var �ndrats till"
Const lg_phrase_password_changed_pre = "Ditt l�senord p�"
Const lg_phrase_password_empty = "L�senordet �r tomt men obligatoriskt. V�nligen ange ditt l�senord."
Const lg_phrase_password_new_title = "Ange ditt �nskade l�senord. Detta f�lt �r obligatoriskt."
Const lg_phrase_password_nomatch_confirm = "L�senordet inte matchar Bekr�ftelse l�senord. Skriv in igen."
Const lg_phrase_password_title = "Ange ditt l�senord. Detta f�lt �r obligatoriskt."
Const lg_phrase_recaptcha_error = "Den reCAPTCHA var inte korrekt."
Const lg_phrase_recover_password = "�terst�ll l�senord"
Const lg_phrase_recover_password_error = "Det var ett ov�ntat fel n�r din beg�ran. Kontakta webmaster."
Const lg_phrase_recover_password_success = "En beg�ran om att �terf� ditt l�senord behandlades med success.<p>F�lj instruktionerna i mailet till dig att s�tta ett nytt l�senord.</p>"
Const lg_phrase_recover_password2 = "Du kan ange ett nytt l�senord genom att klicka p� l�nken nedan."
Const lg_phrase_recover_password3 = "Set Nytt l�senord"
Const lg_phrase_recover_password4 = "Om du inte bad om att �terf� ditt l�senord, kontakta webbansvarig av"
Const lg_phrase_recover_password5 = "E-post p� f�ljande e-l�nk"
Const lg_phrase_register_delete_noemail = "Det var ingen konto som matchar den E-postadress du angav."
Const lg_phrase_registration_email_verify = "Kontrollera din E-postadress"
Const lg_phrase_registration_email_verify_msg = "Ett mail skickades till den e-postadress du angav vid registreringen. Klicka p� l�nken i e-post eller kopiera och klistra in uppl�sningskoden i form f�ltet nedan. Ditt konto �r inte tillg�ngligt f�rr�n den har verifierats."
Const lg_phrase_registration_error = "Det var ett ov�ntat fel att slutf�ra din registrering. V�nligen kontakta webmaster"
Const lg_phrase_registration_mail0 = "utf�rdat nya Registrering identifieringskod"
Const lg_phrase_registration_mail1 = "Tack f�r din registrering p�"
Const lg_phrase_registration_mail2 = "Innan du kan logga in m�ste du"
Const lg_phrase_registration_mail3 = "att bekr�fta din E-postadress"
Const lg_phrase_registration_mail4 = "Klicka h�r f�r att verifiera"
Const lg_phrase_registration_mail5 = "Om l�nken ovan inte fungerar g�r du till http://"
Const lg_phrase_registration_mail6 = "kopiera och klistra in symbolen nedan i formul�ret och klicka p� ""Skicka"""
Const lg_phrase_registration_mail7 = "Om du inte registrera dig, klicka p�"
Const lg_phrase_registration_mail8 = "den h�r l�nken: <a href = ""http://"
Const lg_phrase_registration_mail9 = "om du har n�gra fr�gor sedan <a href = ""http://"
Const lg_phrase_registration_success = "Registrering lyckades"
Const lg_phrase_remember_me_warning = "Kontrollera inte ih�g mig om detta �r en delad dator."
Const lg_phrase_request_password1 = "har en beg�ran gjorts f�r att �terst�lla ditt l�senord p�"
Const lg_phrase_set_new_password_error = "Det var ett ov�ntat fel vid ifyllandet av din beg�ran."
Const lg_phrase_set_new_password_good_token = "Din token var giltig. Ange ett nytt l�senord."
Const lg_phrase_set_new_password_success = "Ditt l�senord har �ndrats."
Const lg_phrase_set_new_password_tken_expired = "Mer �n 24 timmar har g�tt sedan du beg�rt ett l�senord �terh�mtning."
Const lg_phrase_user_registration = " Registrering."
Const lg_phrase_userid_empty = "�r den anv�ndare f�ltet som obligatoriskt men �r tom. Ange ditt anv�ndar-ID."
Const lg_phrase_userid_inuse = "Anv�ndar-id anv�nds eller �r ogiltigt."
Const lg_phrase_userid_new_title = "Ange ditt �nskade anv�ndarnamn. Detta f�lt �r obligatoriskt."
Const lg_phrase_userid_title = "V�nligen ange ditt anv�ndarnamn. Detta f�lt �r obligatoriskt."
Const lg_phrase_verify_expired = "Mer �n 24 timmar har g�tt sedan din registrering."
Const lg_phrase_verify_login = "Du kan nu logga in p� ditt konto."
Const lg_phrase_verify_newtoken = "Klicka h�r f�r att skapa en ny uppl�sningskod."
Const lg_phrase_verify_verified = "Du har bekr�ftat din e-postadress."
Const lg_phrase_webmaster_may_be_contacted = "kan Webmastern bli kontaktad via E-post via denna l�nk:"
Const lg_phrase_website_title = "Ange webbplatsens adress."
Const lg_register_button_text = "Registrera dig"
%>