<%
'* $Id$
'********************************************************************************************************************
'* Login Globals - ASP
'* 
'* NOTE: You must set lg_domain, lg_domain_secure, lg_loginPath and must set the full path to certain pages.
'*       You must set the webmaster e-mail addresses.
'*       You must set the database connection details in database.asp.     
'*
'* 
'* Modification: 13 MAY 2010 :: Karol Piczak - translation to Polish
'* Modification: ?? ??? 2010 :: Saurabh - translation to Hindi (pending)
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
'* Version: alpha 0.5a - German - ASP
'******************************************************************************************************************
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

'*********************************************************************
'* Login system database globals
'*********************************************************************
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

'*********************************************************************
'* Login system language globals
'*********************************************************************
Const lg_login_button_text = "Anmeldung"
Const lg_phrase_attention_webmaster = "Webmaster benachrichtigen"
Const lg_phrase_cancel_account_canceled = "Das Konto wurde gelöscht."
Const lg_phrase_cancel_account_error = "Ein unerwarteter Fehler trat beim Löschen des Kontos auf. Bitte kontaktieren Sie den Webmaster"
Const lg_phrase_cancel_account_warning = "Geben Sie Ihre User-ID und Passwort ein, um Ihren Account zu löschen.<p>WARNUNG: Dieser Vorgang kann nicht rückgängig gemacht werden.</p>Benutzen Sie den unten stehenden Link Passwort wiederherstellen, wenn Ihr Kennwort Vergessenes wurde."
Const lg_phrase_change_password = "Geben Sie Ihr aktuelles Passwort ein, gefolgt von Ihrem gewünschten neuen Passwort"
Const lg_phrase_confirm_empty = "Das Feld 'Kennwort bestätigen' ist leer, wird aber benötigt. Bitte bestätigen Sie Ihr Passwort."
Const lg_phrase_confirm_title = "Bitte bestätigen Sie Ihr gewünschtes Passwort ein. Dieses Feld ist unbedingt nötig."
Const lg_phrase_contact_body = "<p>Das ist Ihre Kontakt-Seite. Normalerweise wäre es ein Formular. Sie sollten zumindest die Webmaster-Mail-Adresse eintragen.</p>"
Const lg_phrase_contact_webmaster = "an den Webmaster"
Const lg_phrase_contact_webmaster1 = "Bitte kontaktieren Sie den Webmaster zu Ihrer Unterstützung."
Const lg_phrase_default_body1 = "Diese Website wurde erstellt, um die Einbeziehung des Login-Systems in Ihre Website nachzuweisen .</p><p>Jede Website kann als Vorlage gedacht werden. Gemeinsame Abschnitte einer Webseitevorlage könnten ein Banner, Navigations-, eine Hauptinhaltbereich, und vielleicht eine Fußzeile mit Links zu den Nutzungsbedingungen enthalten, Copyright Informationen, und die Datenschutzbestimmungen.</p><p>Der Bereich, in dem Sie jetzt lesen in der &quot;Hauptinhaltbereit&quot; auf dieser Seite. Dies ist der Bereich, wo Sie die HTML-oder XHTML-Markup-Vorlagen einbinden, damit die Login-System aktiviert wird.</p><p>Besuchen Sie die Homepage des Projekts auf Google Code auf:"
Const lg_phrase_default_body2 = ".</p><p>Oder besuchen Sie verschiedene Demo-Seiten in einer Reihe von Sprachen der Welt auf der"
Const lg_phrase_default_body3 = "Demonstrations-und Test-Site.</p>"
Const lg_phrase_delete_account = "Konto löschen"
Const lg_phrase_delete_already_verified = "Das Konto wurde bereits überprüft und konnte nicht gelöscht werden."
Const lg_phrase_delete_deleted = "Das Konto wurde gelöscht"
Const lg_phrase_email_empty = "Die E-Mail-Feld ist leer, wird aber benötigt. Geben Sie bitte Ihre E-Mail-Adresse ein."
Const lg_phrase_email_title = "Bitte geben Sie Ihre E-Mail-Adresse. Dieses Feld ist obligatorisch."
Const lg_phrase_enter_set_new_password_token = "Geben Sie das Passwort-Reset-Token in das entsprechende Feld ein und drücken Sie auf den Absenden Button"
Const lg_phrase_enter_unlock_code = "Geben Sie den Entsperr-Code ein."
Const lg_phrase_forbidden_body = "<p><h1>Sie haben keinen Zugriff auf diese Ressource.</h1></p><p>Kontakt mit dem Webmaster unter:"
Const lg_phrase_form_error_cookie = "Cookies sind für die Anmeldung erforderlich. Bitte stellen Sie sicher dass Ihr Browser Cookies für diese Addresse akzeptiert."
Const lg_phrase_form_error_time = "Sie haben zum Ausfüllen des Formulars das Zeitlimit von 5 Minuten überschritten."
Const lg_phrase_form_error_token = "Es ist ein Fehler beim Verarbeiten der Daten des Formulars aufgetreten. Bitte rufen Sie das Formular wieder auf, dies mit Hilfe Ihres Browsers, Schaltfläche Zurück, und versuchen sie es erneut."
Const lg_phrase_is_logged_in = "angemeldet ist"
Const lg_phrase_issue_new_token = "Geben Sie Ihren Benutzernamen und E-Mail-Adresse ein, um ein neues Bestätigungs-Token zu erhalten."
Const lg_phrase_issue_new_token_error = "Ein unerwarteter Fehler ist beim Erstellen Ihres Bestätigungs-Tokens aufgetreten. Bitte kontaktieren Sie den Webmaster."
Const lg_phrase_issue_new_token_success = "Ihr neuer Überprüfungscode wird an Ihre E-Mail-Adresse verschickt."
Const lg_phrase_logged_out = "Sie sind ausgeloggt."
Const lg_phrase_login_error = "Es ist ein Fehler aufgetreten. Bitte geben Sie Ihre User-ID und Ihr Passwort ein."
Const lg_phrase_login_error_token = "Bevor Sie sich einloggen können, müssen Sie Ihre E-Mail-Adresse mit dem Token validieren, das and Sie geschickt wurde."
Const lg_phrase_login_token_problem = "Entweder ist der Bestätigungs-Token bereits benutzt worden oder nicht gültig."
Const lg_phrase_logout_continue = "Klicken Sie hier, um fortzufahren."
Const lg_phrase_name_empty = "Das Feld Name ist leer, aber notwendig . Geben Sie Ihren Namen ein."
Const lg_phrase_name_title = "Bitte geben Sie Ihren vollständigen Namen ein. Dieses Feld ist obligatorisch."
Const lg_phrase_newpassword_empty = "Das 'Neues Passwort'-Feld ist leer, wird aber benötigt. Bitte geben Sie Ihr neues Kennwort ein."
Const lg_phrase_news = "Möchten Sie in regelmäßigen Abständen E-Mails empfangen, wenn die Webseite geändert oder neue Artikel geschrieben wurden?"
Const lg_phrase_no_matching_registration = "Es wurde kein passender Registrierungeintrag mit dieser Benutzer-ID und E-Mail-Adresse gefunden."
Const lg_phrase_oldpassword_does_not_match = "Das eingegebene Passwort stimmt nicht mit Ihrem gespeicherten Passwort überein. Bitte überprüfen und wiederholen Sie die Eingabe."
Const lg_phrase_oldpassword_empty = "Das 'altes Passwort'-Feld ist leer, wird aber benötigt. Bitte geben Sie Ihr altes Kennwort ein."
Const lg_phrase_oldpassword_title = "Bitte geben Sie Ihr aktuelles Passwort ein. Dieses Feld ist obligatorisch."
Const lg_phrase_password_change_authorized = "Wenn Sie diese Änderung nicht selbst veranlasst haben, wenden Sie sich bitte an den Webmaster"
Const lg_phrase_password_changed = "Ihr Passwort wurde geändert."
Const lg_phrase_password_changed_error = "Es ist ein unerwarteter Fehler aufgetreten. Das Passwort wurde nicht geändert. Bitte kontaktieren Sie den Webmaster"
Const lg_phrase_password_changed_okay = "Passwort erfolgreich geändert."
Const lg_phrase_password_changed_post = " wurde geändert um "
Const lg_phrase_password_changed_pre = "Ihr Kennwort bei "
Const lg_phrase_password_empty = "Das 'Passwort'-Feld ist leer, wird aber benötigt. Bitte geben Sie Ihr Kennwort ein."
Const lg_phrase_password_new_title = "Bitte geben Sie Ihr gewünschtes Passwort ein. Dieses Feld ist obligatorisch."
Const lg_phrase_password_nomatch_confirm = "Das Passwort stimmt nicht mit der Bestätigungs-Passwort überein. Bitte versuchen Sie den Vorgang erneut."
Const lg_phrase_password_title = "Bitte geben Sie Ihr Kennwort ein. Dieses Feld ist obligatorisch."
Const lg_phrase_password_too_soon = "Das Passwort ist das gleiche wie eines Ihrer kürzlich verwendeten Passwörter. Bitte wählen Sie ein anderes Kennwort."
Const lg_phrase_password_too_short_pre = "Das Kennwort weist zu wenige Zeichen auf. Die Mindestlänge eines Passwortes ist:"
Const lg_phrase_password_too_short_post = "Buchstaben, Zahlen und Symbolen."
Const lg_phrase_password_too_simple = "Das eingegebene Passwort ist zu einfach. Bitte geben Sie ein Kennwort, dass viele zufällige Zeichen einschließlich einer Mischung von Groß-und Kleinbuchstaben, Symbole und Zahlen hat."
Const lg_phrase_recaptcha_error = "Die reCAPTCHA wurde nicht richtig eingegeben."
Const lg_phrase_recover_password = "Passwort wiederherstellen."
Const lg_phrase_recover_password_error = "Es gab einen unerwarteten Fehler bei der Bearbeitung Ihrer Anfrage. Bitte kontaktieren Sie den Webmaster."
Const lg_phrase_recover_password_success = "Die Anfrage zur Passwortwiederherstellung wurde erfolgreich verarbeitet.<p>Bitte folgen Sie den Anweisungen in der E-Mail, die an Sie gesendet wurde, um das neue Passwort zu setzen.</p>"
Const lg_phrase_recover_password2 = "Sie können ein neues Passwort setzen, indem Sie auf den Link unten klicken."
Const lg_phrase_recover_password3 = "Neues Kennwort setzen"
Const lg_phrase_recover_password4 = "Wenn Sie keine Passwortwiederherstellung angefordert haben, wenden Sie sich bitte an den Webmaster von"
Const lg_phrase_recover_password5 = "E-Mail an die folgenden E-Mail-Link"
Const lg_phrase_register_delete_noemail = "Es existiert kein Benutzerkonto für die angegebene Email-Adresse."
Const lg_phrase_registration_email_verify = "Überprüfen Sie Ihre Email-Adresse"
Const lg_phrase_registration_email_verify_msg = "Es wurde eine E-Mail an die E-Mail-Adresse versandt, die Sie während der Registrierung angegeben haben. Klicken Sie auf den Link in der E-Mail oder kopieren und fügen Sie den Freischalt-Code in das Feld unten ein. Ihr Konto wird nicht verfügbar sein, bevor dies geprüft worden ist."
Const lg_phrase_registration_error = "Es wurde ein unerwarteter Fehler bei der Registrierung festgestellt. Bitte kontaktieren Sie den Webmaster"
Const lg_phrase_registration_mail0 = "Ein Überprüfungs-Token für die Neuregistrierung wurde erstellt."
Const lg_phrase_registration_mail1 = "Vielen Dank für Ihre Anmeldung auf dieser Seite"
Const lg_phrase_registration_mail2 = "Bevor Sie sich einloggen können benötigen Sie"
Const lg_phrase_registration_mail3 = " um Ihre E-Mail-Adresse zu überprüfen"
Const lg_phrase_registration_mail4 = "Klicken Sie bitte hier zur Überprüfung"
Const lg_phrase_registration_mail5 = "Falls der Link nicht funktioniert, besuchen Sie bitte <p>http://"
Const lg_phrase_registration_mail6 = "Kopieren Sie bitte das Token und fügen Sie es unten in das Formular ein. Anschliessend klicken Sie auf ""Abschicken"""
Const lg_phrase_registration_mail7 = "Wenn Sie sich nicht registrieren konnten, klicken Sie auf"
Const lg_phrase_registration_mail8 = "diesen Link: <a href = ""http://"
Const lg_phrase_registration_mail9 = "wenn Sie Fragen haben, besuchen Sie <a href=""http://"
Const lg_phrase_registration_success = "Anmeldung erfolgreich"
Const lg_phrase_remember_me_warning = "Bitte aktivieren Sie nicht 'Angemeldet bleiben', wenn Sie sich an einem gemeinsam genutzten Computer befinden."
Const lg_phrase_request_password1 = "Eine Anfrage auf Passwortwiederherstellung wurde gesendet von "
Const lg_phrase_set_new_password_error = "Es war ein unerwarteter Fehler beim Ausfüllen Ihrer Anfrage aufgetreten."
Const lg_phrase_set_new_password_good_token = "Ihr Token ist gültig. Bitte geben Sie ein neues Passwort ein."
Const lg_phrase_set_new_password_success = "Ihr Passwort wurde erfolgreich geändert."
Const lg_phrase_set_new_password_token_expired = "Es sind bereits über 24 Stunden vergangen, seit Sie das Passwort-Wiederherstellungs-Token angefordert haben."
Const lg_phrase_user_registration = "Benutzer-Registrierung"
Const lg_phrase_userid_empty = "Die Benutzer-ID ist erforderlich, aber leer. Bitte geben Sie Ihre User-ID an."
Const lg_phrase_userid_inuse = "Die Benutzer-ID ist ungültig oder wird bereits verwendet."
Const lg_phrase_userid_new_title = "Bitte geben Sie Ihre gewünschte Benutzer-ID an. Dieses Feld ist obligatorisch."
Const lg_phrase_userid_title = "Bitte geben Sie Ihre Benutzerkennung an. Dieses Feld ist obligatorisch."
Const lg_phrase_verify_expired = "Es sind bereits über 24 Stunden seit Ihrer Anmeldung verstrichen."
Const lg_phrase_verify_login = "Sie können sich nun mit Ihrem Konto anmelden."
Const lg_phrase_verify_newtoken = "Klicken Sie hier, um einen neuen Freischaltcode zu generieren."
Const lg_phrase_verify_verified = "Sie haben Ihre E-Mail-Adresse bestätigt."
Const lg_phrase_webmaster_may_be_contacted = "Sie können den Webmaster per E-Mail über diesen Link kontaktieren:"
Const lg_phrase_website_title = "Bitte geben Sie Ihre Website-Adresse an."
Const lg_register_button_text = "Registrieren"
Const lg_term_at = "bei"
Const lg_term_cancel = "Konto löschen"
Const lg_term_cancel_account = "Konto löschen"
Const lg_term_change_password = "Passwort ändern"
Const lg_term_change_password_button_text = "Passwort ändern"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "Stadt"
Const lg_term_confirm = "Passwort bestätigen"
Const lg_term_contact = "Kontakt"
Const lg_term_contact_form = "Kontaktformular"
Const lg_term_content_language = "<meta http-equiv=""content-language"" content=""de-DE"" />"
Const lg_term_country = "Land"
Const lg_term_current_password = "Aktuelles Passwort"
Const lg_term_delete_account = "Konto löschen"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "Email"
Const lg_term_enter_information = "Bitte Informationen eingeben"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Beispiel"
Const lg_term_fair = "BAD"
Const lg_term_forbidden = "Verboten"
Const lg_term_form_error = "Form-Fehler"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "Gast"
Const lg_term_home = "Heim"
Const lg_term_immediately = "sofor"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "Ausgabe des Kontrolltokens"
Const lg_term_language = "<meta name=""language"" content=""de-DE"" />"
Const lg_term_log_out = "Abmelden"
Const lg_term_log_string = "logLogin"
Const lg_term_logged_out = "Abgemeldet"
Const lg_term_login = "Anmeldung"
Const lg_term_login_success = "Erfolg"
Const lg_term_medium = "GUT"
Const lg_term_name = "Name"
Const lg_term_new = "Neues"
Const lg_term_new_password = "Neues Passwort"
Const lg_term_poor = "Sehr schlecht"
Const lg_term_optional = "Optional"
Const lg_term_or = "oder"
Const lg_term_password = "Passwort"
Const lg_term_please_login = "Bitte anmelden"
Const lg_term_please_register = "Bitte registrieren"
Const lg_term_project_home_link = "<a title=""Login-System auf Google Code"" href=""http://code.google.com/p/loginsystem-rd/"">http://code.google.com/p/loginsystem-rd/</a>"
Const lg_term_recover_password = "Passwort wiederherstellen"
Const lg_term_region = "Region"
Const lg_term_register = "Registrieren"
Const lg_term_register_confirmation = "Bestätigung der Registrierung"
Const lg_term_register_delete_enter_email = "E-Mail eingeben"
Const lg_term_registration = "Anmeldung"
Const lg_term_registration_thankyou = "Vielen Dank für Ihre Anmeldung."
Const lg_term_registration_verification = "Überprüfung der Anmeldung"
Const lg_term_remember = true
Const lg_term_rememberme = "Angemeldet bleiben"
Const lg_term_remove_registration = "Anmeldung löschen"
Const lg_term_required = "erforderlich"
Const lg_term_reset_password = "Passwort zurücksetzen"
Const lg_term_set_new_password = "ein neues Passwort eingeben"
Const lg_term_set_newpassword = "changePassword"
Const lg_term_strong = "STARK"
Const lg_term_submit = "Übermitteln"
Const lg_term_to = "Zu"
Const lg_term_useragent = "Useragent"
Const lg_term_userid = "UserID"
Const lg_term_via_email = "per E-Mail an"
Const lg_term_webloginproject_link = "<a title=""Web Project Login"" href=""http://www.webloginproject.com/index.php"">Web Project Login</a>"
Const lg_term_website = "Website"
Const lg_term_website_address = "Website-Adresse"
Const lg_term_welcome = "Willkommen"
Const lg_term_xhtml_xmlns = "<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""de"" lang=""de"">"
%>


