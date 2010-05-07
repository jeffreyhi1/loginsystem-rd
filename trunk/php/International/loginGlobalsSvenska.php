<?php
// $Id: loginGlobalsSvenska.php 297 2010-05-05 22:40:09Z rdivilbiss $
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
* Version: alpha 0.1c - Swedish/Svenska - PHP
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
define("lg_login_button_text", "Logga in");
define("lg_register_button_text", "Registrera dig");
define("lg_term_at", "på");
define("lg_term_cancel", "Avsluta konto");
define("lg_term_cancel_account", "Avsluta konto");
define("lg_term_change_password", "Ändra lösenord");
define("lg_term_change_password_button_text", "Ändra lösenord");
define("lg_term_checkToken", "checkToken");
define("lg_term_city", "Stad");
define("lg_term_confirm", "Bekräfta lösenord");
define("lg_term_contact", "Kontakt");
define("lg_term_contact_form", "Kontaktformulär");
define("lg_term_content_language", "<meta http-equiv=\"content-language\" content=\"sv-SE\" />");
define("lg_term_country", "Land");
define("lg_term_current_password", "Nuvarande lösenord");
define("lg_term_delete_account", "Ta bort konto");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "E-post");
define("lg_term_enter_information", "Ange information");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Exempel");
define("lg_term_forbidden", "Förbjudna");
define("lg_term_form_error", "Form Fel");
define("lg_term_form_error", "Form Fel");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_guest", "Gäst.");
define("lg_term_home", "Hem");
define("lg_term_immediately", "omedelbart!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Fråga identifieringskod");
define("lg_term_language", "<meta name=\"language\" content=\"sv-SE\" />");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "Utloggad");
define("lg_term_login", "Logga in");
define("lg_term_login_success", "Framgång");
define("lg_term_name", "Namn");
define("lg_term_new_password", "Nytt lösenord");
define("lg_term_optional", "Valfritt");
define("lg_term_or", "eller");
define("lg_term_password", "lösenord");
define("lg_term_please_login", "Vänligen Logga in");
define("lg_term_please_register", "Vänligen registrera");
define("lg_term_project_home_link", "<a title=\"Logga System på Google Code\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password", "Återställ lösenord");
define("lg_term_region", "region");
define("lg_term_register", "Registrera dig");
define("lg_term_register_confirmation", "bekräftelse på registrering");
define("lg_term_register_delete_enter_email", "Ange Email");
define("lg_term_registration", "Registrering");
define("lg_term_registration_thankyou", "Tack för din registrering.");
define("lg_term_registration_verification", "Registrering Verification");
define("lg_term_remember", true);
define("lg_term_rememberme", "Kom ihåg mig");
define("lg_term_remove_registration", "Ta bort Registrering");
define("lg_term_required", "obligatoriskt");
define("lg_term_reset_password", "Återställ lösenord");
define("lg_term_set_new_password", "ange ett nytt lösenord");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_submit", "Skicka");
define("lg_term_to", "till");
define("lg_term_useragent", "useragent");
define("lg_term_userid", "ID");
define("lg_term_via_email", "via e-post");
define("lg_term_webloginproject_link", "<a title=\"Webb Logga Project\" href=\"http://www.webloginproject.com/index.php\">Webb Logga Project</a>");
define("lg_term_website_address", "Webbsida adress");
define("lg_term_welcome", "Välkommen");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"sv\" lang=\"sv\">");
define("lg_phrase_attention_webmaster", "Uppmärksam Webmaster");
define("lg_phrase_cancel_account_canceled", "Kontot har är annullerat.");
define("lg_phrase_cancel_account_error", "Det var ett oväntat fel när kontot blev avslutat. Vänligen kontakta webmaster");
define("lg_phrase_cancel_account_warning", "Ange ditt användarnamn och lösenord för att avsluta kontot.<p>VARNING: Denna åtgärd kan inte ångras.</p>Om du har glömt ditt lösenord använder återvinna lösenord länken nedan.");
define("lg_phrase_change_password", "Ange ditt nuvarande lösenord och sedan önskat nytt lösenord");
define("lg_phrase_confirm_empty", "fältet Bekräfta lösenord är tomt men obligatoriskt. Vänligen bekräfta ditt lösenord.");
define("lg_phrase_confirm_title", "Vänligen bekräfta önskat lösenord. Detta fält är obligatoriskt.");
define("lg_phrase_contact_body", "<p>Detta är din kontaktsida. Vanligtvis skulle det vara en form. Åtminstone bör du ge Webmaster e-postadress.</p>")'
define("lg_phrase_contact_webmaster", "kontakta webmastern");
define("lg_phrase_contact_webmaster1", "Vänligen kontakta webmaster för att få hjälp.");
define("lg_phrase_default_body1", "Denna webbplats har skapats för att visa införliva inloggningssystem på din hemsida design.</p><p>Varje webbplats kan föreställas som en mall. Gemensamma delar av en webbsida mall kan innefatta en banderoll, navigering, ett huvudinnehållet område, och kanske en sidfot med länkar till Användarvillkor, upphovsrätt detaljer och sekretesspolicy.</p><p>Området där du nu läser i &quot;Main Content Area&quot; på denna sida. Detta är det område där du sätter i HTML eller XHTML mallar som gör det möjligt inloggningssystem.</p><p>Besök projektet hem på Google Code på:");
define("lg_phrase_default_body2", ".</p><p>Eller besöka olika demo sidor i ett antal av världens språk på");
define("lg_phrase_default_body3", "demonstration och mätplats.</p>");
define("lg_phrase_delete_account", "Ta bort konto");
define("lg_phrase_delete_already_verified", "kontot är redan verificerad och kunde inte tas bort");
define("lg_phrase_delete_deleted", "Kontot har raderats");
define("lg_phrase_email_empty", "The E-postadres fältet är tomt, men obligatoriskt. Ange din e-postadress.");
define("lg_phrase_email_title", "Ange din E-postadress. Detta fält är obligatoriskt.");
define("lg_phrase_enter_unlock_code", "Ange upplåsningskoden");
define("lg_phrase_forbidden_body", "<p><h1>You do not have access to that resource.</h1></p><p>Contact the webmaster at:");
define("lg_phrase_form_error_cookie", "Cookies krävs för inloggning. Se till att din webbläsare accepterar cookies från denna webbplats.");
define("lg_phrase_form_error_time", "Formuläret timeout innan den är slutförd. Fyll i formuläret på mindre än 5 minuter.");
define("lg_phrase_form_error_token", "Det fanns en blankett fel. Detta kan orsakas av att använda webbläsarens tillbaka-knappen för att återgå till en tidigare ifyllda blanketten och återigen lämna in den.");
define("lg_phrase_is_logged_in", "är inloggad");
define("lg_phrase_issue_new_token", "Ange ditt användarnamn och E-post för att få en ny identifieringskod.");
define("lg_phrase_issue_new_token_error", "Det var ett oväntat fel du skapar en identifieringskod. Kontakta den webbansvariga.");
define("lg_phrase_issue_new_token_success", "Ditt nya identifieringskod skickas till din E-postadress.");
define("lg_phrase_logged_out", "Du är utloggad.");
define("lg_phrase_login_error", "Det uppstod ett fel. Skriv in ditt användarnamn och lösenord.");
define("lg_phrase_login_error_token", "Du måste bekräfta din e-postadress med hjälp av token du fick innan du kan logga in.");
define("lg_phrase_login_token_problem", "Antingen identifieringskod har använts, (och du kontrolleras) eller token är inte giltig.");
define("lg_phrase_logout_continue", "Klicka här för att fortsätta.");
define("lg_phrase_name_empty", "Namn fältet är tomt, men obligatoriskt. Vänligen ange ditt namn.");
define("lg_phrase_name_title", "Ange ditt fullständiga namn. Detta fält är obligatoriskt.");
define("lg_phrase_newpassword_empty", "Fältet Nytt Lösenord är tomt, men obligatoriskt. Vänligen ange ditt lösenord.");
define("lg_phrase_news", "Vill du ta emot regelbundna e-post när hemsidan ändringar eller nya artiklar läggs ut?");
define("lg_phrase_no_matching_registration", "Det var ingen registrering som matchade användar-ID och e-postadress du angav.");
define("lg_phrase_oldpassword_does_not_match", "Den nuvarande lösenord matchar inte den lagrade lösenord. Försök igen");
define("lg_phrase_oldpassword_empty", "Fältet Gamla Lösenordet är tomt, men obligatoriskt. Vänligen ange ditt lösenord.");
define("lg_phrase_oldpassword_title", "Ange ditt nuvarande lösenord. Detta fält är obligatoriskt.");
define("lg_phrase_password_change_authorized", "Om du inte tillåter denna förändring, kontakta webmaster");
define("lg_phrase_password_changed", "Ditt lösenord har ändrats");
define("lg_phrase_password_changed_error", "Det var ett oväntat fel. Lösenordet ändrades inte. Vänligen kontakta webmaster");
define("lg_phrase_password_changed_okay", "lösenord har ändrats.");
define("lg_phrase_password_changed_post", "var ändrats till");
define("lg_phrase_password_changed_pre", "Ditt lösenord på");
define("lg_phrase_password_empty", "Lösenordet är tomt men obligatoriskt. Vänligen ange ditt lösenord.");
define("lg_phrase_password_new_title", "Ange ditt önskade lösenord. Detta fält är obligatoriskt.");
define("lg_phrase_password_nomatch_confirm", "Lösenordet inte matchar Bekräftelse lösenord. Skriv in igen.");
define("lg_phrase_password_title", "Ange ditt lösenord. Detta fält är obligatoriskt.");
define("lg_phrase_recaptcha_error", "Den reCAPTCHA var inte korrekt.");
define("lg_phrase_recover_password", "Återställ lösenord");
define("lg_phrase_recover_password_error", "Det var ett oväntat fel när din begäran. Kontakta webmaster.");
define("lg_phrase_recover_password_success", "En begäran om att återfå ditt lösenord behandlades med success.<p>Följ instruktionerna i mailet till dig att sätta ett nytt lösenord.</p>");
define("lg_phrase_recover_password2", "Du kan ange ett nytt lösenord genom att klicka på länken nedan.");
define("lg_phrase_recover_password3", "Set Nytt lösenord");
define("lg_phrase_recover_password4", "Om du inte bad om att återfå ditt lösenord, kontakta webbansvarig av");
define("lg_phrase_recover_password5", "E-post på följande e-länk");
define("lg_phrase_register_delete_noemail", "Det var ingen konto som matchar den E-postadress du angav.");
define("lg_phrase_registration_email_verify", "Kontrollera din E-postadress");
define("lg_phrase_registration_email_verify_msg", "Ett mail skickades till den e-postadress du angav vid registreringen.&nbsp; Klicka på länken i e-post eller kopiera och klistra in upplåsningskoden i form fältet nedan. Ditt konto är inte tillgängligt förrän den har verifierats.");
define("lg_phrase_registration_error", "Det var ett oväntat fel att slutföra din registrering. Vänligen kontakta webmaster");
define("lg_phrase_registration_mail0", "utfärdat nya Registrering identifieringskod");
define("lg_phrase_registration_mail1", "Tack för din registrering på");
define("lg_phrase_registration_mail2", "Innan du kan logga in måste du");
define("lg_phrase_registration_mail3", "att bekräfta din E-postadress");
define("lg_phrase_registration_mail4", "Klicka här för att verifiera");
define("lg_phrase_registration_mail5", "Om länken ovan inte fungerar går du till http://");
define("lg_phrase_registration_mail6", "kopiera och klistra in symbolen nedan i formuläret och klicka på \"Skicka\"");
define("lg_phrase_registration_mail7", "Om du inte registrera dig, klicka på");
define("lg_phrase_registration_mail8", "den här länken: <a href = \"http://");
define("lg_phrase_registration_mail9", "om du har några frågor sedan <a href = \"http://");
define("lg_phrase_registration_success", "Registrering lyckades");
define("lg_phrase_remember_me_warning", "Kontrollera inte ihåg mig om detta är en delad dator.");
define("lg_phrase_request_password1", "har en begäran gjorts för att återställa ditt lösenord på");
define("lg_phrase_set_new_password_error", "Det var ett oväntat fel vid ifyllandet av din begäran.");
define("lg_phrase_set_new_password_good_token", "Din token var giltig. Ange ett nytt lösenord.");
define("lg_phrase_set_new_password_success", "Ditt lösenord har ändrats.");
define("lg_phrase_set_new_password_tken_expired", "Mer än 24 timmar har gått sedan du begärt ett lösenord återhämtning.");
define("lg_phrase_user_registration", " Registrering.");
define("lg_phrase_userid_empty", "är den användare fältet som obligatoriskt men är tom. Ange ditt användar-ID.");
define("lg_phrase_userid_inuse", "Användar-id används eller är ogiltigt.");
define("lg_phrase_userid_new_title", "Ange ditt önskade användarnamn. Detta fält är obligatoriskt.");
define("lg_phrase_userid_title", "Vänligen ange ditt användarnamn. Detta fält är obligatoriskt.");
define("lg_phrase_verify_expired", "Mer än 24 timmar har gått sedan din registrering.");
define("lg_phrase_verify_login", "Du kan nu logga in på ditt konto.");
define("lg_phrase_verify_newtoken", "Klicka här för att skapa en ny upplåsningskod.");
define("lg_phrase_verify_verified", "Du har bekräftat din e-postadress.");
define("lg_phrase_webmaster_may_be_contacted", "kan Webmastern bli kontaktad via E-post via denna länk:");
define("lg_phrase_website_title", "Ange webbplatsens adress.");
?>