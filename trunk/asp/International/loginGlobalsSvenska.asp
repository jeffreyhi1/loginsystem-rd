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
'* Modification: 28 MAR 2010 :: Jürgen Kraus - translated to German
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
Const lg_term_at = "på"
Const lg_term_cancel = "Avsluta konto"
Const lg_term_cancel_account = "Avsluta konto"
Const lg_term_change_password = "Ändra lösenord"
Const lg_term_change_password_button_text = "Ändra lösenord"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "Stad"
Const lg_term_confirm = "Bekräfta lösenord"
Const lg_term_contact = "Kontakt"
Const lg_term_contact_form = "Kontaktformulär"
Const lg_term_content_language = "<meta http-equiv=""content-language"" content=""sv-SE"" />"
Const lg_term_country = "Land"
Const lg_term_current_password = "Nuvarande lösenord"
Const lg_term_delete_account = "Ta bort konto"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "E-post"
Const lg_term_enter_information = "Ange information"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Exempel"
Const lg_term_forbidden = "Förbjudna"
Const lg_term_form_error = "Form Fel"
Const lg_term_form_error = "Form Fel"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "Gäst."
Const lg_term_home = "Hem"
Const lg_term_immediately = "omedelbart!"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "Fråga identifieringskod"
Const lg_term_language = "<meta name="language" content="sv-SE" />"
Const lg_term_log_out = "Logga ut"
Const lg_term_log_string = "logLogin"
Const lg_term_logged_out = "Utloggad"
Const lg_term_login = "Logga in"
Const lg_term_login_success = "Framgång"
Const lg_term_name = "Namn"
Const lg_term_new_password = "Nytt lösenord"
Const lg_term_optional = "Valfritt"
Const lg_term_or = "eller"
Const lg_term_password = "lösenord"
Const lg_term_please_login = "Vänligen Logga in"
Const lg_term_please_register = "Vänligen registrera"
Const lg_term_project_home_link = "<a title=""Logga System på Google Code"" href=""http://code.google.com/p/loginsystem-rd/"">http://code.google.com/p/loginsystem-rd/</a>"
Const lg_term_recover_password = "Återställ lösenord"
Const lg_term_region = "region"
Const lg_term_register = "Registrera dig"
Const lg_term_register_confirmation = "bekräftelse på registrering"
Const lg_term_register_delete_enter_email = "Ange Email"
Const lg_term_registration = "Registrering"
Const lg_term_registration_thankyou = "Tack för din registrering."
Const lg_term_registration_verification = "Registrering Verification"
Const lg_term_remember = true
Const lg_term_rememberme = "Kom ihåg mig"
Const lg_term_remove_registration = "Ta bort Registrering"
Const lg_term_required = "obligatoriskt"
Const lg_term_reset_password = "Återställ lösenord"
Const lg_term_set_new_password = "ange ett nytt lösenord"
Const lg_term_set_newpassword = "changePassword"
Const lg_term_submit = "Skicka"
Const lg_term_to = "till"
Const lg_term_useragent = "useragent"
Const lg_term_userid = "ID"
Const lg_term_via_email = "via e-post"
Const lg_term_webloginproject_link = "<a title=""Webb Logga Project"" href=""http://www.webloginproject.com/index.php"">Webb Logga Project</a>"
Const lg_term_website_address = "Webbsida adress"
Const lg_term_welcome = "Välkommen"
Const lg_term_xhtml_xmlns = "<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""sv"" lang=""sv"">"
Const lg_phrase_attention_webmaster = "Uppmärksam Webmaster"
Const lg_phrase_cancel_account_canceled = "Kontot har är annullerat."
Const lg_phrase_cancel_account_error = "Det var ett oväntat fel när kontot blev avslutat. Vänligen kontakta webmaster"
Const lg_phrase_cancel_account_warning = "Ange ditt användarnamn och lösenord för att avsluta kontot.<p>VARNING: Denna åtgärd kan inte ångras.</p>Om du har glömt ditt lösenord använder återvinna lösenord länken nedan."
Const lg_phrase_change_password = "Ange ditt nuvarande lösenord och sedan önskat nytt lösenord"
Const lg_phrase_confirm_empty = "fältet Bekräfta lösenord är tomt men obligatoriskt. Vänligen bekräfta ditt lösenord."
Const lg_phrase_confirm_title = "Vänligen bekräfta önskat lösenord. Detta fält är obligatoriskt."
Const lg_phrase_contact_body = "<p>Detta är din kontaktsida. Vanligtvis skulle det vara en form. Åtminstone bör du ge Webmaster e-postadress.</p>"
Const lg_phrase_contact_webmaster = "kontakta webmastern"
Const lg_phrase_contact_webmaster1 = "Vänligen kontakta webmaster för att få hjälp."
Const lg_phrase_default_body1 = "Denna webbplats har skapats för att visa införliva inloggningssystem på din hemsida design.</p><p>Varje webbplats kan föreställas som en mall. Gemensamma delar av en webbsida mall kan innefatta en banderoll, navigering, ett huvudinnehållet område, och kanske en sidfot med länkar till Användarvillkor, upphovsrätt detaljer och sekretesspolicy.</p><p>Området där du nu läser i &quot;Main Content Area&quot; på denna sida. Detta är det område där du sätter i HTML eller XHTML mallar som gör det möjligt inloggningssystem.</p><p>Besök projektet hem på Google Code på:"
Const lg_phrase_default_body2 = ".</p><p>Eller besöka olika demo sidor i ett antal av världens språk på"
Const lg_phrase_default_body3 = "demonstration och mätplats.</p>"
Const lg_phrase_delete_account = "Ta bort konto"
Const lg_phrase_delete_already_verified = "kontot är redan verificerad och kunde inte tas bort"
Const lg_phrase_delete_deleted = "Kontot har raderats"
Const lg_phrase_email_empty = "The E-postadres fältet är tomt, men obligatoriskt. Ange din e-postadress."
Const lg_phrase_email_title = "Ange din E-postadress. Detta fält är obligatoriskt."
Const lg_phrase_enter_unlock_code = "Ange upplåsningskoden"
Const lg_phrase_forbidden_body = "<p><h1>Du har inte tillgång till denna resurs.</h1></p><p>Kontakta webmaster på:"
Const lg_phrase_form_error_cookie = "Cookies krävs för inloggning. Se till att din webbläsare accepterar cookies från denna webbplats."
Const lg_phrase_form_error_time = "Formuläret timeout innan den är slutförd. Fyll i formuläret på mindre än 5 minuter."
Const lg_phrase_form_error_token = "Det fanns en blankett fel. Detta kan orsakas av att använda webbläsarens tillbaka-knappen för att återgå till en tidigare ifyllda blanketten och återigen lämna in den."
Const lg_phrase_is_logged_in = "är inloggad"
Const lg_phrase_issue_new_token = "Ange ditt användarnamn och E-post för att få en ny identifieringskod."
Const lg_phrase_issue_new_token_error = "Det var ett oväntat fel du skapar en identifieringskod. Kontakta den webbansvariga."
Const lg_phrase_issue_new_token_success = "Ditt nya identifieringskod skickas till din E-postadress."
Const lg_phrase_logged_out = "Du är utloggad."
Const lg_phrase_login_error = "Det uppstod ett fel. Skriv in ditt användarnamn och lösenord."
Const lg_phrase_login_error_token = "Du måste bekräfta din e-postadress med hjälp av token du fick innan du kan logga in."
Const lg_phrase_login_token_problem = "Antingen identifieringskod har använts, (och du kontrolleras) eller token är inte giltig."
Const lg_phrase_logout_continue = "Klicka här för att fortsätta."
Const lg_phrase_name_empty = "Namn fältet är tomt, men obligatoriskt. Vänligen ange ditt namn."
Const lg_phrase_name_title = "Ange ditt fullständiga namn. Detta fält är obligatoriskt."
Const lg_phrase_newpassword_empty = "Fältet Nytt Lösenord är tomt, men obligatoriskt. Vänligen ange ditt lösenord."
Const lg_phrase_news = "Vill du ta emot regelbundna e-post när hemsidan ändringar eller nya artiklar läggs ut?"
Const lg_phrase_no_matching_registration = "Det var ingen registrering som matchade användar-ID och e-postadress du angav."
Const lg_phrase_oldpassword_does_not_match = "Den nuvarande lösenord matchar inte den lagrade lösenord. Försök igen"
Const lg_phrase_oldpassword_empty = "Fältet Gamla Lösenordet är tomt, men obligatoriskt. Vänligen ange ditt lösenord."
Const lg_phrase_oldpassword_title = "Ange ditt nuvarande lösenord. Detta fält är obligatoriskt."
Const lg_phrase_password_change_authorized = "Om du inte tillåter denna förändring, kontakta webmaster"
Const lg_phrase_password_changed = "Ditt lösenord har ändrats"
Const lg_phrase_password_changed_error = "Det var ett oväntat fel. Lösenordet ändrades inte. Vänligen kontakta webmaster"
Const lg_phrase_password_changed_okay = "lösenord har ändrats."
Const lg_phrase_password_changed_post = "var ändrats till"
Const lg_phrase_password_changed_pre = "Ditt lösenord på"
Const lg_phrase_password_empty = "Lösenordet är tomt men obligatoriskt. Vänligen ange ditt lösenord."
Const lg_phrase_password_new_title = "Ange ditt önskade lösenord. Detta fält är obligatoriskt."
Const lg_phrase_password_nomatch_confirm = "Lösenordet inte matchar Bekräftelse lösenord. Skriv in igen."
Const lg_phrase_password_title = "Ange ditt lösenord. Detta fält är obligatoriskt."
Const lg_phrase_recaptcha_error = "Den reCAPTCHA var inte korrekt."
Const lg_phrase_recover_password = "Återställ lösenord"
Const lg_phrase_recover_password_error = "Det var ett oväntat fel när din begäran. Kontakta webmaster."
Const lg_phrase_recover_password_success = "En begäran om att återfå ditt lösenord behandlades med success.<p>Följ instruktionerna i mailet till dig att sätta ett nytt lösenord.</p>"
Const lg_phrase_recover_password2 = "Du kan ange ett nytt lösenord genom att klicka på länken nedan."
Const lg_phrase_recover_password3 = "Set Nytt lösenord"
Const lg_phrase_recover_password4 = "Om du inte bad om att återfå ditt lösenord, kontakta webbansvarig av"
Const lg_phrase_recover_password5 = "E-post på följande e-länk"
Const lg_phrase_register_delete_noemail = "Det var ingen konto som matchar den E-postadress du angav."
Const lg_phrase_registration_email_verify = "Kontrollera din E-postadress"
Const lg_phrase_registration_email_verify_msg = "Ett mail skickades till den e-postadress du angav vid registreringen. Klicka på länken i e-post eller kopiera och klistra in upplåsningskoden i form fältet nedan. Ditt konto är inte tillgängligt förrän den har verifierats."
Const lg_phrase_registration_error = "Det var ett oväntat fel att slutföra din registrering. Vänligen kontakta webmaster"
Const lg_phrase_registration_mail0 = "utfärdat nya Registrering identifieringskod"
Const lg_phrase_registration_mail1 = "Tack för din registrering på"
Const lg_phrase_registration_mail2 = "Innan du kan logga in måste du"
Const lg_phrase_registration_mail3 = "att bekräfta din E-postadress"
Const lg_phrase_registration_mail4 = "Klicka här för att verifiera"
Const lg_phrase_registration_mail5 = "Om länken ovan inte fungerar går du till http://"
Const lg_phrase_registration_mail6 = "kopiera och klistra in symbolen nedan i formuläret och klicka på ""Skicka"""
Const lg_phrase_registration_mail7 = "Om du inte registrera dig, klicka på"
Const lg_phrase_registration_mail8 = "den här länken: <a href = ""http://"
Const lg_phrase_registration_mail9 = "om du har några frågor sedan <a href = ""http://"
Const lg_phrase_registration_success = "Registrering lyckades"
Const lg_phrase_remember_me_warning = "Kontrollera inte ihåg mig om detta är en delad dator."
Const lg_phrase_request_password1 = "har en begäran gjorts för att återställa ditt lösenord på"
Const lg_phrase_set_new_password_error = "Det var ett oväntat fel vid ifyllandet av din begäran."
Const lg_phrase_set_new_password_good_token = "Din token var giltig. Ange ett nytt lösenord."
Const lg_phrase_set_new_password_success = "Ditt lösenord har ändrats."
Const lg_phrase_set_new_password_tken_expired = "Mer än 24 timmar har gått sedan du begärt ett lösenord återhämtning."
Const lg_phrase_user_registration = " Registrering."
Const lg_phrase_userid_empty = "är den användare fältet som obligatoriskt men är tom. Ange ditt användar-ID."
Const lg_phrase_userid_inuse = "Användar-id används eller är ogiltigt."
Const lg_phrase_userid_new_title = "Ange ditt önskade användarnamn. Detta fält är obligatoriskt."
Const lg_phrase_userid_title = "Vänligen ange ditt användarnamn. Detta fält är obligatoriskt."
Const lg_phrase_verify_expired = "Mer än 24 timmar har gått sedan din registrering."
Const lg_phrase_verify_login = "Du kan nu logga in på ditt konto."
Const lg_phrase_verify_newtoken = "Klicka här för att skapa en ny upplåsningskod."
Const lg_phrase_verify_verified = "Du har bekräftat din e-postadress."
Const lg_phrase_webmaster_may_be_contacted = "kan Webmastern bli kontaktad via E-post via denna länk:"
Const lg_phrase_website_title = "Ange webbplatsens adress."
Const lg_register_button_text = "Registrera dig"
%>