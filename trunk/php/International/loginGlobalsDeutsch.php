<?php
// $Id$
$lg_filename = basename($_SERVER['PHP_SELF']);
/*******************************************************************************************************************
* Login Globals - PHP
* 
* NOTE: You must set lg_domain, lg_domain_secure, lg_loginPath and must set the full path to certain pages.
*       You must set the webmaster e-mail addresses.
*       You must set the database connection details below.
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
* Version: alpha 0.2 - German/Deutsch - PHP
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
/*****************************************************************************************************************
* forbidden is not part of the login-system. Must specify the entire path possibly outside of the login-system.
******************************************************************************************************************/
define("lg_forbidden", "/login-system/forbidden.php");
/*****************************************************************************************************************
* form error is not part of the login-system. Must specify the entire path possibly outside of the login-system.
******************************************************************************************************************/
define("lg_form_error", "/login-system/form_error.php");
/*****************************************************************************************************************
* home page is not part of the login-system. Must specify the entire path possibly outside of the login-system.
******************************************************************************************************************/
define("lg_home", "/login-system/index.php");
define("lg_log_logins", true);
define("lg_logged_out_page", "loggedout.php");
define("lg_login_attempts", 5);
define("lg_loginPage", "login.php");
define("lg_loginPath", "/login-system/");
define("lg_logout_page", "logout.php");
define("lg_new_token_page", "register_newtoken.php");
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
define("lg_login_button_text", "Anmeldung");
define("lg_term_at", "bei");
define("lg_term_cancel", "Konto löschen");
define("lg_term_cancel_account", "Konto löschen");
define("lg_term_change_password", "Passwort ändern");
define("lg_term_change_password_button_text", "Passwort ändern");
define("lg_term_checkToken", "checkToken");
define("lg_term_city", "Stadt");
define("lg_term_confirm", "Passwort bestätigen");
define("lg_term_contact", "Kontakt");
define("lg_term_contact_form", "Kontaktformular");
define("lg_term_content_language", "<meta http-equiv=\"content-language\" content=\"de-DE\" />");
define("lg_term_country", "Land");
define("lg_term_current_password", "Aktuelles Passwort");
define("lg_term_delete_account", "Konto löschen");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "Email");
define("lg_term_enter_information", "Bitte Informationen eingeben");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Beispiel");
define("lg_term_forbidden", "Verboten");
define("lg_term_form_error", "Form-Fehler");
define("lg_term_from_error","Form-Fehler");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_home","Heim");
define("lg_term_immediately", "sofort!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Ausgabe des Verification Tokens");
define("lg_term_language", "<meta name=\"language\" content=\"de-DE\" />");
define("lg_term_log_out", "Log Aus");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "Abgemeldet");
define("lg_term_login", "Anmeldung");
define("lg_term_login_success", "Erfolg");
define("lg_term_name", "Name");
define("lg_term_new_password", "Neues Passwort");
define("lg_term_optional", "Optional");
define("lg_term_or", "oder");
define("lg_term_password", "Passwort");
define("lg_term_please_login", "Bitte anmelden");
define("lg_term_please_register", "Bitte registrieren");
define("lg_term_project_home_link", "<a title=\"Login-System auf Google Code\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password", "Passwort wiederherstellen");
define("lg_term_region", "Region");
define("lg_term_register", "Registrieren");
define("lg_term_register_confirmation", "Bestätigung der Registrierung");
define("lg_term_register_delete_enter_email", "E-Mail eingeben");
define("lg_term_registration", "Anmeldung");
define("lg_term_registration_thankyou", "Vielen Dank für Ihre Anmeldung.");
define("lg_term_registration_verification", "Überprüfung der Registrierung");
define("lg_term_remember", true);
define("lg_term_rememberme", "Angemeldet bleiben");
define("lg_term_remove_registration", "Registrierung löschen");
define("lg_term_required", "erforderlich");
define("lg_term_reset_password", "Passwort zurücksetzen");
define("lg_term_set_new_password", "ein neues Passwort eingeben");
define("lg_term_set_newpassword", "Passwort ändern");
define("lg_term_submit", "Übermitteln");
define("lg_term_to", "Zu");
define("lg_term_useragent", "Useragent");
define("lg_term_userid", "UserID");
define("lg_term_via_email", "per E-Mail an");
define("lg_term_webloginproject_link", "<a title=\"Web Project Login\" href=\"http://www.webloginproject.com/index.php\">Web Project Login</a>");
define("lg_term_website", "Website");
define("lg_term_website_address", "Website-Adresse");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"de\" lang=\"de\">");
define("lg_phrase_attention_webmaster", "Webmaster benachrichtigen");
define("lg_phrase_cancel_account_canceled", "Das Konto wurde gelöscht.");
define("lg_phrase_cancel_account_error", "Ein unerwarteter Fehler trat beim Löschen des Kontos auf. Bitte kontaktieren Sie den Webmaster");
define("lg_phrase_cancel_account_warning", "Geben Sie Ihre User-ID und Passwort ein, um Ihren Account zu löschen.<p>WARNUNG: Dieser Vorgang kann nicht rückgängig gemacht werden.</p>Benutzen Sie den unten stehenden Link Passwort wiederherstellen, wenn Ihr Kennwort Vergessenes wurde.");
define("lg_phrase_change_password", "Geben Sie Ihr aktuelles Passwort ein, gefolgt von Ihrem gewünschten neuen Passwort");
define("lg_phrase_confirm_empty", "Das Feld 'Kennwort bestätigen' ist leer, wird aber benötigt. Bitte bestätigen Sie Ihr Passwort.");
define("lg_phrase_confirm_title", "Bitte bestätigen Sie Ihr gewünschtes Passwort ein. Dieses Feld ist unbedingt nötig.");
define("lg_phrase_contact_body", "<p>Das ist Ihre Kontakt-Seite. Normalerweise wäre es ein Formular sein. Zumindest sollten Sie bieten die Webmaster-Mail-Adresse.</p>");
define("lg_phrase_contact_webmaster", "an den Webmaster");
define("lg_phrase_contact_webmaster1", "Bitte kontaktieren Sie den Webmaster um Unterstützung.");
define("lg_phrase_default_body1", "Diese Website wurde erstellt, um nachzuweisen Einbeziehung der Login-System in Ihre Website-Design.</p><p>Jede Website kann als Vorlage gedacht werden. Gemeinsame Abschnitte einer Webseite Vorlage könnte ein Banner, Navigations-, eine Haupt-Content-Bereich, und vielleicht eine Fußzeile mit Links zu den Nutzungsbedingungen enthalten, Copyright Informationen, und die Datenschutzbestimmungen.</p><p>Der Bereich, in dem Sie jetzt lesen in der &quot;Main Content Area&quot; auf dieser Seite. Dies ist der Bereich, wo Sie den HTML-oder XHTML-Markup-Vorlagen, damit die Login-System.</p><p>Besuchen Sie die Homepage des Projekts auf Google Code auf:");
define("lg_phrase_default_body2", ".</p><p>Oder besuchen Sie verschiedene Demo-Seiten in einer Reihe von Sprachen der Welt auf der");
define("lg_phrase_default_body3", "Demonstrations-und Test-Site.</p>");
define("lg_phrase_delete_account", "Konto löschen");
define("lg_phrase_delete_already_verified", "Das Konto wurde bereits überprüft und konnte nicht gelöscht werden.");
define("lg_phrase_delete_deleted", "Das Konto wurde gelöscht");
define("lg_phrase_email_empty", "Die E-Mail-Feld ist leer, wird aber benötigt. Geben Sie bitte Ihre E-Mail-Adresse ein.");
define("lg_phrase_email_title", "Bitte geben Sie Ihre E-Mail-Adresse. Dieses Feld ist obligatorisch.");
define("lg_phrase_enter_set_new_password_token", "Geben Sie Passwort-Reset-Token in das entsprechende Feld ein und drücken Sie die Absenden");
define("lg_phrase_enter_unlock_code", "Geben Sie den Entsperr-Code ein.");
define("lg_phrase_forbidden_body", "<p><h1>Sie haben keinen Zugriff auf diese Ressource.</h1></p><p>Kontakt mit dem Webmaster unter:");
define("lg_phrase_form_error_cookie", "Cookies sind für die Anmeldung erforderlich. Bitte stellen Sie sicher Ihr Browser Cookies akzeptiert from this site.");
define("lg_phrase_form_error_time", "Die Form, die vor Vollendung gestoppt. Bitte füllen Sie das Formular in weniger als 5 Minuten.");
define("lg_phrase_form_error_token", "Es war ein Formfehler. Dies kann mit Hilfe Ihres Browsers Schaltfläche Zurück, um einen zuvor ausgefüllte Formular und neu vorzulegen es wieder hervorgerufen werden.");
define("lg_phrase_issue_new_token", "Geben Sie Ihren Benutzernamen und E-Mail-Adresse ein, um ein neues Bestätigungs-Token zu erhalten.");
define("lg_phrase_issue_new_token_error", "Ein unerwarteter Fehler ist beim Erstellen Ihres Bestätigungs-Tokens aufgetreten. Bitte kontaktieren Sie den Webmaster.");
define("lg_phrase_issue_new_token_success", "Ihr neuer Überprüfungscode wird an Ihre E-Mail-Adresse verschickt.");
define("lg_phrase_logged_out", "Sie sind ausgeloggt.");
define("lg_phrase_login_error", "Es ist ein Fehler aufgetreten. Bitte geben Sie Ihre User-ID und Ihr Passwort ein.");
define("lg_phrase_login_error_token", "Sie müssen Ihre E-Mail-Adresse validieren mit dem Token, das Sie wurden geschickt, bevor du dich einloggen kannst in.");
define("lg_phrase_login_token_problem", "Entweder ist der Bestätigungs-Token benutzt worden ist, (und überprüft werden,) oder das Zeichen ist nicht gültig.");
define("lg_phrase_logout_continue", "Klicken Sie hier, um fortzufahren.");
define("lg_phrase_name_empty", "Das Feld Name ist leer, aber notwendig . Geben Sie Ihren Namen ein.");
define("lg_phrase_name_title", "Bitte geben Sie Ihren vollständigen Namen ein. Dieses Feld ist obligatorisch.");
define("lg_phrase_newpassword_empty", "Das 'Neues Passwort'-Feld ist leer, wird aber benötigt. Bitte geben Sie Ihr neues Kennwort ein.");
define("lg_phrase_news", "Möchten Sie in regelmäßigen Abständen E-Mails empfangen, wenn die Webseite geändert oder neue Artikel geschrieben wurden?");
define("lg_phrase_no_matching_registration", "Es wurde kein passender Registrierungeintrag mit dieser Benutzer-ID und E-Mail-Adresse gefunden.");
define("lg_phrase_oldpassword_does_not_match", "Das eingegebene Passwort stimmt nicht mit Ihrem gespeicherten Passwort überein. Wiederholen");
define("lg_phrase_oldpassword_empty", "Das 'altes Passwort'-Feld ist leer, wird aber benötigt. Bitte geben Sie Ihr altes Kennwort ein.");
define("lg_phrase_oldpassword_title", "Bitte geben Sie Ihr aktuelles Passwort ein. Dieses Feld ist obligatorisch.");
define("lg_phrase_password_change_authorized", "Wenn Sie diese Änderung nicht selbst veranlasst haben, wenden Sie sich bitte an den Webmaster");
define("lg_phrase_password_changed", "Ihr Passwort wurde geändert");
define("lg_phrase_password_changed_error", "Es ist ein unerwarteter Fehler aufgetreten. Das Passwort wurde nicht geändert. Bitte kontaktieren Sie den Webmaster");
define("lg_phrase_password_changed_okay", "Passwort erfolgreich geändert.");
define("lg_phrase_password_changed_post", " wurde geändert um ");
define("lg_phrase_password_changed_pre", "Ihr Kennwort bei ");
define("lg_phrase_password_empty", "Das 'Passwort'-Feld ist leer, wird aber benötigt. Bitte geben Sie Ihr Kennwort ein.");
define("lg_phrase_password_new_title", "Bitte geben Sie Ihre gewünschtes Passwort ein. Dieses Feld ist obligatorisch.");
define("lg_phrase_password_nomatch_confirm", "Das Passwort stimmt nicht mit der Bestätigungs-Passwort überein. Bitte wiederholen.");
define("lg_phrase_password_title", "Bitte geben Sie Ihr Kennwort ein. Dieses Feld ist obligatorisch.");
define("lg_phrase_recaptcha_error", "Die reCAPTCHA wurde nicht richtig eingegeben.");
define("lg_phrase_recover_password", "Passwort wiederherstellen.");
define("lg_phrase_recover_password_error", "Es gab einen unerwarteten Fehler bei der Bearbeitung Ihrer Anfrage. Bitte kontaktieren Sie den Webmaster.");
define("lg_phrase_recover_password_success", "Der Anfrage zur Passwortwiederherstellung wurde erfolgreich verarbeitet.<p>Bitte folgen Sie den Anweisungen in der E-Mail, die an Sie gesendet wurde, um ein neues Passwort zu setzen.</p>");
define("lg_phrase_recover_password2", "Sie können ein neues Passwort setzen, indem Sie auf den Link unten klicken.");
define("lg_phrase_recover_password3", "Neues Kennwort setzen");
define("lg_phrase_recover_password4", "Wenn Sie keine Passwortwiederherstellung angefordert haben, wenden Sie sich an den Webmaster von");
define("lg_phrase_recover_password5", "E-Mail an die folgenden E-Mail-Link");
define("lg_phrase_register_delete_noemail", "Es existiert kein Benutzerkonto für die angegebene Email-Adresse.");
define("lg_phrase_registration_email_verify", "Überprüfen Sie Ihre Email-Adresse");
define("lg_phrase_registration_email_verify_msg", "Es wurde eine E-Mail an die E-Mail-Adresse versandt, die Sie während der Registrierung angegeben haben. Klicken Sie auf den Link in der E-Mail oder kopieren und fügen Sie den Freischalt-Code in das Feld unten ein. Ihr Konto wird nicht verfügbar sein, bevor dies geprüft worden ist.");
define("lg_phrase_registration_error", "Es wurde ein unerwarteter Fehler bei der Registrierung festgestellt. Bitte kontaktieren Sie den Webmaster");
define("lg_phrase_registration_mail0", "Ein Überprüfungs-Token für die Neuregistrierung wurde erstellt.");
define("lg_phrase_registration_mail1", "Vielen Dank für Ihre Anmeldung auf dieser Seite");
define("lg_phrase_registration_mail2", "Bevor Sie sich einloggen können benötigen Sie");
define("lg_phrase_registration_mail3", " um Ihre E-Mail-Adresse zu überprüfen");
define("lg_phrase_registration_mail4", "Clicken Sie hier zur Überprüfung");
define("lg_phrase_registration_mail5", "Falls der Link nicht funktioniert, besuchen Sie bitte<br>http://");
define("lg_phrase_registration_mail6", "Kopieren Sie das Token fügen Sie es unten in das Formular ein. Dann klicken Sie auf \"Abschicken\"");
define("lg_phrase_registration_mail7", "Wenn Sie sich nicht registrieren konnten, klicken Sie auf");
define("lg_phrase_registration_mail8", "diesen Link: <a href = \" http://");
define("lg_phrase_registration_mail9", "wenn Sie Fragen haben, besuchen Sie <a href=\"http://");
define("lg_phrase_registration_success", "Anmeldung erfolgreich");
define("lg_phrase_remember_me_warning", "Bitte aktivieren Sie nicht 'Angemeldet bleiben', wenn Sie sich an einem gemeinsam genutzten Computer befinden.");
define("lg_phrase_request_password1", "Eine Anfrage auf Passwortwiederherstellung wurde gesendet von ");
define("lg_phrase_set_new_password_error", "Es war ein unerwarteter Fehler beim Ausfüllen Ihrer Anfrage aufgetreten.");
define("lg_phrase_set_new_password_good_token", "Ihr Token war gültig. Geben Sie ein neues Passwort ein.");
define("lg_phrase_set_new_password_success", "Ihr Passwort wurde erfolgreich geändert.");
define("lg_phrase_set_new_password_tken_expired", "Mehr als 24 Stunde sind vergangen, seit Sie ein Passwort-Wiederherstellungs-Token angefordert haben.");
define("lg_phrase_user_registration", "Benutzer-Registrierung");
define("lg_phrase_userid_empty", "Die Benutzer-ID ist erforderlich, aber leer. Bitte geben Sie Ihre User-ID an.");
define("lg_phrase_userid_inuse", "Die Benutzer-ID ist ungültig oder wird bereits verwendet.");
define("lg_phrase_userid_new_title", "Bitte geben Sie Ihre gewünschte Benutzer-ID an. Dieses Feld ist obligatorisch.");
define("lg_phrase_userid_title", "Bitte geben Sie Ihre Benutzerkennung an. Dieses Feld ist obligatorisch.");
define("lg_phrase_verify_expired", "Mehr als 24 Stunden seit Ihrer Anmeldung verstrichen.");
define("lg_phrase_verify_login", "Sie können sich nun mit Ihrem Konto anmelden.");
define("lg_phrase_verify_newtoken", "Klicken Sie hier, um einen neuen Freischalt code zu generieren.");
define("lg_phrase_verify_verified", "Sie haben Ihre E-Mail-Adresse bestätigt.");
define("lg_phrase_webmaster_may_be_contacted", "Sie können den Webmaster per E-Mail über diesen Link kontaktieren:");
define("lg_phrase_website_title", "Bitte geben Sie Ihre Website-Adresse an.");
define("lg_register_button_text", "Registrieren");
?>