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
* Modification: 28 MAR 2010 :: Jürgen Kraus - translated to German
* Modification: 28 MAR 2010 :: Cam Van T Divilbiss - translated to Vietnamese
* Modification: 11 FEB 2010 :: Rod Divilbiss - recover password Constants added.
* Modification: 07 FEB 2010 :: VGR - translation to French
* Modification: 07 FEB 2010 :: Rod Divilbiss - added MS SQL and MySql Constants.
* Modification: 20 FEB 2010 :: Rod Divilbiss - added missing lg_phrase_registration_mail0
* Modification: 13 FEB 2010 :: Rod Divilbiss - set new password Constants added.
*
* Version: 26 APR 2010 - alpha 0.1b - Danish - ASP
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
define("lg_register_button_text", "Registrer");
define("lg_term_at", "at");
define("lg_term_cancel", "Annuller konto");
define("lg_term_cancel_account", "Annuller konto");
define("lg_term_change_password", "Skift adgangskode");
define("lg_term_change_password_button_text", "Skift adgangskode");
define("lg_term_checkToken", "checkToken");
define("lg_term_city", "City");
define("lg_term_confirm", "Bekræft kodeord");
define("lg_term_contact_form", "Kontakt Form");
define("lg_term_country", "Land");
define("lg_term_current_password", "Nuværende adgangskode");
define("lg_term_delete_account", "Slet konto");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "Email");
define("lg_term_enter_information", "Indtast Information");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Eksempel");
define("lg_term_from_error", "Form Error");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_guest", "Gæst");
define("lg_term_home", "Home");
define("lg_term_immediately", "med det samme!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Udsted Verifikation Token");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "Logget ud");
define("lg_term_login", "Log ind");
define("lg_term_login_success", "Succes");
define("lg_term_name", "Navn");
define("lg_term_optional", "Frivilligt");
define("lg_term_or", "eller");
define("lg_term_password", "Password");
define("lg_term_please_login", "Venligst login");
define("lg_term_please_register", "Tilmeld dig venligst ");
define("lg_term_recover_password", "Genopret Password");
define("lg_term_region", "Region");
define("lg_term_register", "Registrer");
define("lg_term_register_confirmation", "Registreringsbekræftelse");
define("lg_term_register_delete_enter_email", "Indtast e-mail");
define("lg_term_registration", "Registrering");
define("lg_term_registration_thankyou", "Tak for din registrering.");
define("lg_term_registration_verification", "Registreringsverifikation");
define("lg_term_remember", true);
define("lg_term_rememberme", "Husk mig");
define("lg_term_remove_registration", "Fjern registrering");
define("lg_term_required", "nødvendigt");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_submit", "Send");
define("lg_term_to", "Til");
define("lg_term_useragent", "UserAgent");
define("lg_term_userid", "Bruger Identifikation");
define("lg_term_via_email", "via email på");
define("lg_term_website_address", "Website adresse");
define("lg_term_welcome", "Velkommen");
define("lg_phrase_attention_webmaster", "Webmaster bemærk venligst");
define("lg_phrase_cancel_account_cacelled", "Denne konto er blevet annuleret.");
define("lg_phrase_cancel_account_error", "Der var en uventet fejl da vi annullerede din konto. Kontakt venligst webmasteren");
define("lg_phrase_cancel_account_warning", "Indtast dit brugernavn og password for at annullere din konto.<p>ADVARSEL: Denne handling kan ikke fortrydes.</p>Hvis du har glemt dit password brug <i>genopret password</i> linket herunder.");
define("lg_phrase_change_password", "Indtast din nuværende adgangskode, derefter dit ønskede nye kodeord");
define("lg_phrase_confirm_empty", "Bekræft Password feltet er tomt, men er påkrævet. Bekræft venligst dit password.");
define("lg_phrase_confirm_title", "Bekræft venligst din ønskede adgangskode. Dette felt er påkrævet.");
define("lg_phrase_contact_webmaster", "kontakt webmaster");
define("lg_phrase_delete_account", "Slet konto");
define("lg_phrase_delete_already_verified", "Denne konto er allerede blevet verificeret og kunne ikke slettes");
define("lg_phrase_delete_deleted", "Kontoen er blevet slettet");
define("lg_phrase_email_empty", "Email feltet er tomt, men er påkrævet. Indtast din e-mail-adresse.");
define("lg_phrase_email_title", "Indtast din e-mail adresse. Dette felt er påkrævet.");
define("lg_phrase_enter_unlock_code", "Indtast din Unlock kode");
define("lg_phrase_is_logged_in", "er logget ind");
define("lg_phrase_issue_new_token", "Indtast dit userid og din e-mail for at modtage en ny bekræftelses token.");
define("lg_phrase_issue_new_token_error", "Der opstod en uventet fejl da vi genererede din kontrol token. Kontakt venligst webmaster.");
define("lg_phrase_issue_new_token_success", "Dit nye bekræftelseskendetegn vil blive sendt til din e-mail adresse.");
define("lg_phrase_login_error", "Der var en fejl. Indtast dit brugernavn og adgangskode igen.");
define("lg_phrase_login_token_problem", "Enten er verifikation token blevet brugt (og du er verificeret), eller token er ikke gyldig.");
define("lg_phrase_logged_out", "Du er logget ud.");
define("lg_phrase_logout_continue", "klik her for at fortsætte.");
define("lg_phrase_name_empty", "Feltet er tomt, men er påkrævet. Indtast dit navn.");
define("lg_phrase_name_title", "Indtast dit fulde navn. Dette felt er påkrævet.");
define("lg_phrase_newpassword_empty", "Det Nye Password felt er tomt, men er påkrævet. Indtast dit kodeord.");
define("lg_phrase_news", "Ønsker du at modtage regelmæssige e-mails, når hjemmesiden ændres eller nye artikler er indsendt?");
define("lg_phrase_no_matching_registration", "Der var ingen registrering, der matcher det Bruger ID og den e-mail-adresse, du har indtastet.");
define("lg_phrase_oldpassword_does_not_match", "Den nuværende adgangskode matcher ikke dine gemte adgangskode. Prøv igen");
define("lg_phrase_oldpassword_empty", "Det Gamle Password felt er tomt, men er påkrævet. Indtast dit kodeord.");
define("lg_phrase_oldpassword_title", "Indtast din nuværende adgangskode. Dette felt er påkrævet.");
define("lg_phrase_password_change_authorized", "Hvis du ikke har tilladelse til denne ændring, bedes du kontakte webmaster");
define("lg_phrase_password_changed", "Din adgangskode blev ændret");
define("lg_phrase_password_changed_error", "Der opstod en uventet fejl. Adgangskoden blev ikke ændret. Kontakt venligst webmaster");
define("lg_phrase_password_changed_okay", "Password skiftet.");
define("lg_phrase_password_changed_post", "var ændret til");
define("lg_phrase_password_changed_pre", "Din adgangskode på");
define("lg_phrase_password_empty", "Password feltet er tomt, men er påkrævet. Indtast dit kodeord.");
define("lg_phrase_password_new_title", "Indtast dit ønskede password. Dette felt er påkrævet.");
define("lg_phrase_password_nomatch_confirm", "Password matcher ikke Bekræftelsesadgangskoden. Indtast igen.");
define("lg_phrase_password_title", "Indtast din adgangskode. Dette felt er påkrævet.");
define("lg_phrase_register_delete_noemail", "Der er ingen konto som matchede den e-mail adresse, du indtastede.");
define("lg_phrase_registration_email_verify", "Bekræft din e-mail-adresse");
define("lg_phrase_registration_email_verify_msg", "En e-mail blev sendt til den email adresse, du angav under registreringen. Klik på linket i den e-mail eller klip og klistr låse-op koden i form feltet nedenfor. Din konto vil ikke være tilgængelig før den er blevet bekræftet.");
define("lg_phrase_registration_error", "Der var en uventet fejl da vi fuldførte din registrering. Kontakt venligst webmaster");
define("lg_phrase_registration_mail0", "Udsted Ny Registrerings Kontrol Token");
define("lg_phrase_registration_mail1", "Tak for din registrering hos");
define("lg_phrase_registration_mail2", "Før du kan logge ind skal du");
define("lg_phrase_registration_mail3", "at bekræfte din e-mail-adresse.");
define("lg_phrase_registration_mail4", "Klik her for at kontrollere");
define("lg_phrase_registration_mail5", "Hvis ovenstående link ikke virker, skal du gå til http://");
define("lg_phrase_registration_mail6", "kopiere og klistre token nedenfor i skemaet og klik \"Send\"");
define("lg_phrase_registration_mail7", "Hvis du ikke registrerede, klik på");
define("lg_phrase_registration_mail8", "dette link: <a href = \"http://");
define("lg_phrase_registration_mail9", "hvis du har spørgsmål så <a href = \"http://");
define("lg_phrase_registration_success", "Registrering lykkedes");
define("lg_phrase_remember_me_warning", "Tjek ikke \"husk mig\", hvis det er en delt computer.");
define("lg_phrase_userid_empty", "Bruger-ID feltet er påkrævet, men er tomt. Indtast dit bruger-ID. ");
define("lg_phrase_userid_inuse", "Bruger-ID er i brug eller ugyldigt.");
define("lg_phrase_userid_new_title", "Indtast dit ønskede bruger-ID. Dette felt er påkrævet.");
define("lg_phrase_userid_title", "Indtast dit bruger-ID. Dette felt er påkrævet.");
define("lg_phrase_verify_expired", "Der er gået mere end 24 timer der er gået siden din registrering.");
define("lg_phrase_verify_login", "Du kan nu logge ind på din konto.");
define("lg_phrase_verify_newtoken", "Klik her for at generere en ny låse-kode.");
define("lg_phrase_verify_verified", "Du har bekræftet din e-mail-adresse.");
define("lg_phrase_website_title", "Indtast dit website adresse.");
define("lg_phrase_recover_password", "Gendan Password");
define("lg_phrase_request_password1", "Der er blevet anmodt om at gendanne din adgangskode ved");
define("lg_phrase_recover_password2", "Du kan angive en ny adgangskode ved at klikke på linket nedenfor.");
define("lg_phrase_recover_password3", "Forandr dit Password");
define("lg_phrase_recover_password4", "Hvis du ikke har anmodet om at gendanne din adgangskode, kan du kontakte webmaster via");
define("lg_phrase_recover_password5", "E-mail på det følgende e-mail link");
define("lg_phrase_recover_password_error", "Der opstod en uventet fejl under behandling af din anmodning. Kontakt venligst webmaster.");
define("lg_phrase_recover_password_success", "Anmodningen om at gendanne din adgangskode blev behandlet med succes.<p>Følg instruktionerne i e-mail sendt til dig for at lave en ny adgangskode.</p>");
define("lg_term_new_password", "Nyt Password");
define("lg_term_reset_password", "Password Reset");
define("lg_term_set_new_password", "Indtast en ny adgangskode");
define("lg_phrase_set_new_password_good_token", "Din token var gyldig. Indtast en ny adgangskode.");
define("lg_phrase_set_new_password_tken_expired", "Mere end 24 timer er gået, siden du har bedt om en gendannelse af adgangskode token.");
define("lg_phrase_contact_webmaster1", "Kontakt venligst webmaster for at få hjælp.");
define("lg_phrase_webmaster_may_be_contacted", "Webmasteren kan kontaktes via e-mail via dette link:");
define("lg_phrase_set_new_password_error", "Der var en uventet fejl ved udfyldelsen af din anmodning.");
define("lg_phrase_set_new_password_success", "Dit password er blevet ændret.");
define("lg_phrase_user_registration", "Bruger registrering.");
?>