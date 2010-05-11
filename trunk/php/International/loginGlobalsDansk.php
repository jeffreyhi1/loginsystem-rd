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
* Modification: 27 APR 2010 :: Michel Plungjan - translation to Danish
* Modification: 26 APR 2010 :: Rod Divilbiss - corrected some file paths.
* Modification: 24 APR 2010 :: Rod Divilbiss - Corrected debug output statements, added lg_term_log_out to
*                                              loginGlobals.php, and corrected paths in loginGlobals.php
* Modification: 23 APR 2010 :: Bob Stone - Beta Testing, Code / path correction and commenting
* Modification: 09 APR 2010 :: Rod Divilbiss - Machine Translation to Hindi
* Modification: 05 APR 2010 :: mplugjan - translation to Swedish
* Modification: 02 APR 2010 :: Rod Divilbiss - Spelling errors corrected.
* Modification: 02 APR 2010 :: acperkins - verified or corrected translation to Spanish (Mexican)
* Modification: 01 APR 2010 :: Bob Stone - translated to Spanish (Mexican)
* Modification: 28 MAR 2010 :: J�rgen Kraus - translated to German
* Modification: 28 MAR 2010 :: Cam Van T Divilbiss - translated to Vietnamese
* Modification: 11 FEB 2010 :: Rod Divilbiss - recover password Constants added.
* Modification: 07 FEB 2010 :: VGR - translation to French
* Modification: 07 FEB 2010 :: Rod Divilbiss - added MS SQL and MySql Constants.
* Modification: 20 FEB 2010 :: Rod Divilbiss - added missing lg_phrase_registration_mail0
* Modification: 13 FEB 2010 :: Rod Divilbiss - set new password Constants added.
*
* Version: alpha 0.2 - Danish - PHP
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
define("lg_login_button_text","Log ind");
define("lg_term_at", "at");
define("lg_term_cancel", "Annuller konto");
define("lg_term_cancel_account", "Annuller konto");
define("lg_term_change_password", "Skift adgangskode");
define("lg_term_change_password_button_text", "Skift adgangskode");
define("lg_term_checkToken", "checkToken");
define("lg_term_city", "City");
define("lg_term_confirm", "Bekr�ft kodeord");
define("lg_term_contact", "Kontakt");
define("lg_term_contact_form", "Kontakt Form");
define("lg_term_content_language", "<meta http-equiv=\"content-language\" content=\"da-DK\" />");
define("lg_term_country", "Land");
define("lg_term_current_password", "Nuv�rende adgangskode");
define("lg_term_delete_account", "Slet konto");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "Email");
define("lg_term_enter_information", "Indtast Information");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Eksempel");
define("lg_term_forbidden", "Forbudte");
define("lg_term_form_error", "Form Fejl");
define("lg_term_from_error", "Form Error");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_guest", "G�st");
define("lg_term_home", "Home");
define("lg_term_immediately", "med det samme!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Udsted Verifikation Token");
define("lg_term_language", "<meta name=\"language\" content=\"da-DK\" />");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "Logget ud");
define("lg_term_login", "Log ind");
define("lg_term_login_success", "Succes");
define("lg_term_name", "Navn");
define("lg_term_new_password", "Nyt Password");
define("lg_term_optional", "Frivilligt");
define("lg_term_or", "eller");
define("lg_term_password", "Password");
define("lg_term_please_login", "Venligst login");
define("lg_term_please_register", "Tilmeld dig venligst");
define("lg_term_project_home_link", "<a title=\"Login System p� Google Code\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password", "Genopret Password");
define("lg_term_region", "Region");
define("lg_term_register", "Registrer");
define("lg_term_register_confirmation", "Registreringsbekr�ftelse");
define("lg_term_register_delete_enter_email", "Indtast e-mail");
define("lg_term_registration", "Registrering");
define("lg_term_registration_thankyou", "Tak for din registrering.");
define("lg_term_registration_verification", "Registreringsverifikation");
define("lg_term_remember", true);
define("lg_term_rememberme", "Husk mig");
define("lg_term_remove_registration", "Fjern registrering");
define("lg_term_required", "n�dvendigt");
define("lg_term_reset_password", "Password Reset");
define("lg_term_set_new_password", "Indtast en ny adgangskode");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_submit", "Send");
define("lg_term_to", "Til");
define("lg_term_useragent", "UserAgent");
define("lg_term_userid", "Bruger Identifikation");
define("lg_term_via_email", "via email p�");
define("lg_term_webloginproject_link", "<a title=\"Web Login Project\" href=\"http://www.webloginproject.com/index.php\">Web Login Project</a>");
define("lg_term_website_address", "Website adresse");
define("lg_term_welcome", "Velkommen");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"da\" lang=\"da\">");
define("lg_phrase_attention_webmaster", "Webmaster bem�rk venligst");
define("lg_phrase_cancel_account_cacelled", "Denne konto er blevet annuleret.");
define("lg_phrase_cancel_account_error", "Der var en uventet fejl da vi annullerede din konto. Kontakt venligst webmasteren ");
define("lg_phrase_cancel_account_warning", "Indtast dit brugernavn og password for at annullere din konto.<br>ADVARSEL: Denne handling kan ikke fortrydes.<br>Hvis du har glemt dit password brug <i>genopret password</i> linket herunder.");
define("lg_phrase_change_password", "Indtast din nuv�rende adgangskode, derefter dit �nskede nye kodeord");
define("lg_phrase_confirm_empty", "Bekr�ft Password feltet er tomt, men er p�kr�vet. Bekr�ft venligst dit password.");
define("lg_phrase_confirm_title", "Bekr�ft venligst din �nskede adgangskode. Dette felt er p�kr�vet.");
define("lg_phrase_contact_body", "Dette er din kontakt side. Normalt ville det v�re en form. Som et minimum b�r du give Webmaster e-mail-adresse.</p>")'
define("lg_phrase_contact_webmaster", "kontakt webmaster");
define("lg_phrase_contact_webmaster1", "Kontakt venligst webmaster for at f� hj�lp.");
define("lg_phrase_default_body1", "Denne hjemmeside blev oprettet for at demonstrere at indarbejde Login System p� din hjemmeside design.</p><p>Hvert websted kan begrebsligg�res som en skabelon. F�lles dele af en webside skabelon kan omfatte et banner, navigation, en hovedindhold omr�de, og m�ske en sidefod med links betingelser for brug, Copyright detaljer, og Privacy Policy.</p><p>Det omr�de, hvor du nu l�ser i &quot;Main Content Area&quot; p� denne side. Dette er det omr�de, hvor du vil inds�tte HTML eller XHTML markup skabeloner, der giver Login System.</p><p>Bes�g projektet hjem p� Google Code p�:");
define("lg_phrase_default_body2", ".</p><p>Eller bes�ge forskellige demo sider i en r�kke af verdens sprog p�");
define("lg_phrase_default_body3", "demonstration og test site.</p>");
define("lg_phrase_delete_account", "Slet konto");
define("lg_phrase_delete_already_verified", "Denne konto er allerede blevet verificeret og kunne ikke slettes");
define("lg_phrase_delete_deleted", "Kontoen er blevet slettet");
define("lg_phrase_email_empty", "Email feltet er tomt, men er p�kr�vet. Indtast din e-mail-adresse.");
define("lg_phrase_email_title", "Indtast din e-mail adresse. Dette felt er p�kr�vet.");
define("lg_phrase_enter_unlock_code", "Indtast din Unlock kode");
define("lg_phrase_forbidden_body", "<p><h1>Du har ikke adgang til denne ressource.</h1></p><p>Kontakt webmaster p�:");
define("lg_phrase_form_error_cookie", "Cookies er n�dvendige for login. S�rg venligst for din browser accepterer cookies fra dette site.");
define("lg_phrase_form_error_time", "Den form timeout f�r afslutning. Udfyld formularen i mindre end 5 minutter.");
define("lg_phrase_form_error_token", "Der var en form fejl. Dette kan skyldes ved at bruge browserens tilbage-knappen for at vende tilbage til en tidligere udfyldt formular og re-sender den.");
define("lg_phrase_is_logged_in", "er logget ind");
define("lg_phrase_issue_new_token", "Indtast dit userid og din e-mail for at modtage en ny bekr�ftelses token.");
define("lg_phrase_issue_new_token_error", "Der opstod en uventet fejl da vi genererede din kontrol token. Kontakt venligst webmaster.");
define("lg_phrase_issue_new_token_success", "Dit nye bekr�ftelseskendetegn vil blive sendt til din e-mail adresse.");
define("lg_phrase_logged_out", "Du er logget ud.");
define("lg_phrase_login_error", "Der var en fejl. Indtast dit brugernavn og adgangskode igen.");
define("lg_phrase_login_error_token", "Du skal validere din e-mail adresse ved hj�lp af symbolske du blev sendt, f�r du kan logge ind.");
define("lg_phrase_login_token_problem", "Enten er verifikation token blevet brugt (og du er verificeret), eller token er ikke gyldig.");
define("lg_phrase_logout_continue", "klik her for at forts�tte.");
define("lg_phrase_name_empty", "Feltet er tomt, men er p�kr�vet. Indtast dit navn.");
define("lg_phrase_name_title", "Indtast dit fulde navn. Dette felt er p�kr�vet.");
define("lg_phrase_newpassword_empty", "Det Nye Password felt er tomt, men er p�kr�vet. Indtast dit kodeord.");
define("lg_phrase_news", "�nsker du at modtage regelm�ssige e-mails, n�r hjemmesiden �ndres eller nye artikler er indsendt?");
define("lg_phrase_no_matching_registration", "Der var ingen registrering, der matcher det Bruger ID og den e-mail-adresse, du har indtastet.");
define("lg_phrase_oldpassword_does_not_match", "Den nuv�rende adgangskode matcher ikke dine gemte adgangskode. Pr�v igen");
define("lg_phrase_oldpassword_empty", "Det Gamle Password felt er tomt, men er p�kr�vet. Indtast dit kodeord.");
define("lg_phrase_oldpassword_title", "Indtast din nuv�rende adgangskode. Dette felt er p�kr�vet.");
define("lg_phrase_password_change_authorized", "Hvis du ikke har tilladelse til denne �ndring, bedes du kontakte webmaster");
define("lg_phrase_password_changed", "Din adgangskode blev �ndret");
define("lg_phrase_password_changed_error", "Der opstod en uventet fejl. Adgangskoden blev ikke �ndret. Kontakt venligst webmaster");
define("lg_phrase_password_changed_okay", "Password skiftet.");
define("lg_phrase_password_changed_post", "var �ndret til");
define("lg_phrase_password_changed_pre", "Din adgangskode p�");
define("lg_phrase_password_empty", "Password feltet er tomt, men er p�kr�vet. Indtast dit kodeord.");
define("lg_phrase_password_new_title", "Indtast dit �nskede password. Dette felt er p�kr�vet.");
define("lg_phrase_password_nomatch_confirm", "Password matcher ikke Bekr�ftelsesadgangskoden. Indtast igen.");
define("lg_phrase_password_title", "Indtast din adgangskode. Dette felt er p�kr�vet. ");
define("lg_phrase_recaptcha_error", "Den reCAPTCHA var ikke indtastet korrekt.");
define("lg_phrase_recover_password", "Gendan Password");
define("lg_phrase_recover_password_error", "Der opstod en uventet fejl under behandling af din anmodning. Kontakt venligst webmaster.");
define("lg_phrase_recover_password_success", "Anmodningen om at gendanne din adgangskode blev behandlet med succes. <br> F�lg instruktionerne i e-mail sendt til dig for at lave en ny adgangskode.");
define("lg_phrase_recover_password2", "Du kan angive en ny adgangskode ved at klikke p� linket nedenfor.");
define("lg_phrase_recover_password3", "Forandr dit Password");
define("lg_phrase_recover_password4", "Hvis du ikke har anmodet om at gendanne din adgangskode, kan du kontakte webmaster via");
define("lg_phrase_recover_password5", "E-mail p� det f�lgende e-mail link");
define("lg_phrase_register_delete_noemail", "Der er ingen konto som matchede den e-mail adresse, du indtastede.");
define("lg_phrase_registration_email_verify", "Bekr�ft din e-mail-adresse");
define("lg_phrase_registration_email_verify_msg", "En e-mail blev sendt til den email adresse, du angav under registreringen. Klik p� linket i den e-mail eller klip og klistr l�se-op koden i form feltet nedenfor. Din konto vil ikke v�re tilg�ngelig f�r den er blevet bekr�ftet.");
define("lg_phrase_registration_error", "Der var en uventet fejl da vi fuldf�rte din registrering. Kontakt venligst webmaster");
define("lg_phrase_registration_mail0", "Udsted Ny Registrerings Kontrol Token");
define("lg_phrase_registration_mail1", "Tak for din registrering hos");
define("lg_phrase_registration_mail2", "F�r du kan logge ind skal du");
define("lg_phrase_registration_mail3", "at bekr�fte din e-mail-adresse.");
define("lg_phrase_registration_mail4", "Klik her for at kontrollere");
define("lg_phrase_registration_mail5", "Hvis ovenst�ende link ikke virker, skal du g� til http://");
define("lg_phrase_registration_mail6", "kopiere og klistre token nedenfor i skemaet og klik \"Send\"");
define("lg_phrase_registration_mail7", "Hvis du ikke registrerede, klik p�");
define("lg_phrase_registration_mail8", "dette link: <a href = \"http://");
define("lg_phrase_registration_mail9", "hvis du har sp�rgsm�l s� <a href = \"http://");
define("lg_phrase_registration_success", "Registrering lykkedes");
define("lg_phrase_remember_me_warning", "Tjek ikke \"husk mig\", hvis det er en delt computer.");
define("lg_phrase_request_password1", "Der er blevet anmodt om at gendanne din adgangskode ved");
define("lg_phrase_set_new_password_error", "Der var en uventet fejl ved udfyldelsen af din anmodning.");
define("lg_phrase_set_new_password_good_token", "Din token var gyldig. Indtast en ny adgangskode.");
define("lg_phrase_set_new_password_success", "Dit password er blevet �ndret.");
define("lg_phrase_set_new_password_tken_expired", "Mere end 24 timer er g�et, siden du har bedt om en gendannelse af adgangskode token.");
define("lg_phrase_user_registration", "Bruger registrering.");
define("lg_phrase_userid_empty", "Bruger-ID feltet er p�kr�vet, men er tomt. Indtast dit bruger-ID.");
define("lg_phrase_userid_inuse", "Bruger-ID er i brug eller ugyldigt.");
define("lg_phrase_userid_new_title", "Indtast dit �nskede bruger-ID. Dette felt er p�kr�vet.");
define("lg_phrase_userid_title", "Indtast dit bruger-ID. Dette felt er p�kr�vet.");
define("lg_phrase_verify_expired", "Der er g�et mere end 24 timer der er g�et siden din registrering.");
define("lg_phrase_verify_login", "Du kan nu logge ind p� din konto.");
define("lg_phrase_verify_newtoken", "Klik her for at generere en ny l�se-kode.");
define("lg_phrase_verify_verified", "Du har bekr�ftet din e-mail-adresse.");
define("lg_phrase_webmaster_may_be_contacted", "Webmasteren kan kontaktes via e-mail via dette link:");
define("lg_phrase_website_title", "Indtast dit website adresse.");
define("lg_register_button_text", "Registrer");
?>