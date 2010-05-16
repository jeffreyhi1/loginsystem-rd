<?php
// $Id: loginGlobalsPolski.php 297 2010-05-05 22:40:09Z rdivilbiss $
$lg_filename = basename($_SERVER['PHP_SELF']);
/*******************************************************************************************************************
* Login Globals - PHP
*
* NOTE: You must set lg_domain, lg_domain_secure, lg_loginPath and must set the full path to certain pages.
*       You must set the webmaster e-mail addresses.
*       You must set the database connection details in database.php.     
*
* Modification: 13 MAY 2010 :: Karol Piczak - translation to Polish 
* Modification: ?? ??? 2010 :: Saurabh - translation to Hindi
* Modification: 27 APR 2010 :: Michel Plungjan - translation to Danish
* Modification: 26 APR 2010 :: Rod Divilbiss - corrected some file paths.
* Modification: 25 APR 2010 :: Rod Divilbiss - added lg_term_log_out, corrected paths.
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
* Version: alpha 0.4 - Polish/polski - PHP
******************************************************************************************************************/


/*****************************************************************************************************************/
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
define("lg_debug", false);
define("lg_home", "/login-system/index.php");
define("lg_log_logins", true);
define("lg_logged_out_page", "loggedout.php");
define("lg_login_attempts", 5);
define("lg_loginPage", "login.php");
define("lg_loginPath", "/login-system/");
define("lg_logout_page", "logout.php");
define("lg_new_token_page", "issue_verification_token.php");
define("lg_password_max_age", 6);
define("lg_password_min_bits", 72);
define("lg_password_min_length", 10)
define("lg_recover_passsword_page", "recover_password.php");
define("lg_register_delete_page", "register_delete.php");
define("lg_register_page", "register.php");
define("lg_set_new_password_page", "set_new_password.php");
define("lg_success_page", "login_success.php");
define("lg_useCAPTCHA", true);
define("lg_useSSL", false);
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
define("lg_login_button_text", "Zaloguj");
define("lg_phrase_attention_webmaster", "Uwaga webmasterze");
define("lg_phrase_cancel_account_canceled", "Konto zostało zdezaktywowane.");
define("lg_phrase_cancel_account_error", "Wystąpił nieoczekiwany błąd przy dezaktywacji konta. Proszę, skontaktuj się z webmasterem.");
define("lg_phrase_cancel_account_warning", "Wprowadź swój login i hasło w celu dezaktywacji konta.<br>UWAGA: DEZAKTYWACJA NIE MOŻE BYĆ COFNIĘTA.<br>Jeżeli nie pamiętasz swojego hasła, użyj opcji odzyskiwania poniżej.");
define("lg_phrase_change_password", "Wprowadź swoje obecne hasło, następnie podaj nowe hasło");
define("lg_phrase_confirm_empty", "Wymagane pole &quot;Potwierdzenie hasła&quot; jest puste. Proszę, wprowadź potwierdzenie hasła.");
define("lg_phrase_confirm_title", "Proszę, potwierdź swoje nowe hasło. To pole jest wymagane.");
define("lg_phrase_contact_body", "<p>To jest Twoja strona kontaktowa. Normalnie byłby to formularz. Powinieneś przynajmniej podać adres e-mail webmastera.</p>");
define("lg_phrase_contact_webmaster", "skontaktuj się z webmasterem");
define("lg_phrase_contact_webmaster1", "Proszę, skontaktuj się z webmasterem w celu uzyskania pomocy.");
define("lg_phrase_default_body1", "Ta strona została stworzona w celu zademonstrowania włączenia Systemu Logowania w Twój projekt istniejącej strony.</p><p>Każdą stronę można wyobrazić sobie jako szablon. Powszechnie występujące sekcje takiego szablonu mogą zawierać baner, nawigację, obszar przeznaczony na treść główną i być może stopkę z linkami do Warunków Użytkowania, Informacji o prawach autorskich i Polityki Prywatności.</p><p>Obszar, który teraz czytasz to &quot;Obszar Treści Głównej&quot; niniejszej strony. W tym miejscu powinieneś umieścić znaczniki HTML lub XHTML, które umożliwią korzystanie z Systemu Logowania. Spróbuj kliknąć link logowania powyżej, zarejestruj się i przetestuj zaimplementowany system logowania. Znajdujesz się na działającej stronie do beta-testów i niektóre funkcje mogą nie być zaimplementowane w momencie testowania.</p><p>Odwiedź stronę projektu na Google Code:");
define("lg_phrase_default_body2", ".</p><p>Sprawdź też różne strony demonstracyjne w wielu językach na");
define("lg_phrase_default_body3", "demonstracji i miejsce badania.</p>");
define("lg_phrase_delete_account", "Usuń konto");
define("lg_phrase_delete_already_verified", "Konto zostało już zweryfikowane i nie może zostać usunięte");
define("lg_phrase_delete_deleted", "Konto zostało usunięte");
define("lg_phrase_email_empty", "Wymagany adres e-mail jest pusty. Proszę, wprowadź swój adres e-mail.");
define("lg_phrase_email_title", "Proszę wprowadź swój adres e-mail. To pole jest wymagane.");
define("lg_phrase_enter_set_new_password_token", "Wpisz token ustawić nowe hasło");
define("lg_phrase_enter_unlock_code", "Wprowadź kod odblokowujący");
define("lg_phrase_forbidden_body", "<p><h1>Nie masz dostępu do tego zasobu.</h1></p><p>Skontaktuj się z webmasterem na:");
define("lg_phrase_form_error_cookie", "Ciasteczka są wymagane do zalogowania się. Sprawdź proszę, czy Twoja przeglądarka akceptuje ciasteczka pochodzące z tej strony.");
define("lg_phrase_form_error_time", "Ważność formularza wygasła przed wysłaniem. Proszę, wypełnij formularz w czasie krótszym niż 5 minut.");
define("lg_phrase_form_error_token", "Wystąpił błąd formularza. Może to być spowodowane użyciem przycisku &quot;wstecz&quot; w przeglądarce i ponownym wysłaniem wypełnionego formularza.");
define("lg_phrase_is_logged_in"," jest zalogowany.");
define("lg_phrase_issue_new_token", "Wprowadź swój login i adres e-mail, aby uzyskać nowy kod weryfikujący.");
define("lg_phrase_issue_new_token_error", "Wystąpił nieoczekiwany błąd przy generowaniu kodu weryfikującego. Proszę, skontaktuj się z webmasterem.");
define("lg_phrase_issue_new_token_success", "Twój nowy kod weryfikujący zostanie wkrótce przesłany na Twój adres e-mail.");
define("lg_phrase_logged_out", "Jesteś wylogowany.");
define("lg_phrase_login_error", "Wystąpił błąd. Proszę, wprowadź ponownie swój login i hasło.");
define("lg_phrase_login_error_token", "Musisz zweryfikować swój adres e-mail poprzez użycie przesłanego kodu, zanim będziesz mógł się zalogować.");
define("lg_phrase_login_token_problem", "Albo kod weryfikujący został już użyty (i Twoje konto zostało zweryfikowane), albo wprowadzony kod jest niepoprawny.");
define("lg_phrase_logout_continue", "Kliknij tutaj, aby kontynuować.");
define("lg_phrase_name_empty", "Wymagane pole &quot;Imię i nazwisko&quot; nie zostało uzupełnione. Proszę wprowadź swoje imię i nazwisko.");
define("lg_phrase_name_title", "Proszę wprowadź swoje pełne imię i nazwisko. To pole jest wymagane.");
define("lg_phrase_newpassword_empty", "Wymagane pole &quot;Nowe hasło&quot; jest puste. Proszę wprowadź swoje nowe hasło.");
define("lg_phrase_news", "Czy chcesz otrzymywać okresowe wiadomości, gdy na stronie pojawią się zmiany lub ukaże się nowy artykuł?");
define("lg_phrase_no_matching_registration", "Nie znaleziono konta odpowiadającego podanemu loginowi i adresowi e-mail.");
define("lg_phrase_oldpassword_does_not_match", "Podane hasło nie zgadza się z zapisanym hasłem. Spróbuj ponownie.");
define("lg_phrase_oldpassword_empty", "Wymagane pole &quot;Stare hasło&quot; jest puste. Wprowadź swoje hasło.");
define("lg_phrase_oldpassword_title", "Proszę, wprowadź swoje obecne hasło. To pole jest wymagane.");
define("lg_phrase_password_change_authorized", "Jeżeli nie zatwierdziłeś tej zmiany, skontaktuj się z webmasterem ");
define("lg_phrase_password_changed", "Twoje hasło zostało zmienione");
define("lg_phrase_password_changed_error", "Wystąpił nieoczekiwany błąd. Hasło nie zostało zmienione. Proszę, skontaktuj się z webmasterem ");
define("lg_phrase_password_changed_okay", "Hasło zmienione pomyślnie.");
define("lg_phrase_password_changed_post", " zostało zmienione ");
define("lg_phrase_password_changed_pre", "Twoje hasło na ");
define("lg_phrase_password_empty", "Wymagane pole &quot;Hasło&quot; jest puste. Proszę, wprowadź swoje hasło.");
define("lg_phrase_password_new_title", "Proszę wprowadź swoje nowe hasło. To pole jest wymagane.");
define("lg_phrase_password_nomatch_confirm", "Wprowadzone hasło nie zgadza się z potwierdzeniem. Proszę, wprowadź hasła ponownie.");
define("lg_phrase_password_title", "Proszę, wprowadź swoje hasło. To pole jest wymagane.");
define("lg_phrase_password_too_soon", "Hasło jest takie samo jak jeden z ostatnio używanych haseł. Proszę wybrać inne hasło.");
define("lg_phrase_password_too_short_pre", "Hasło jest za krótkie. Minimalna długość hasła to:");
define("lg_phrase_password_too_short_post", "liter, symboli i cyfr.");
define("lg_phrase_password_too_simple", "Wprowadzone hasło jest zbyt proste. Wpisz hasło, które ma wiele przypadkowych znaków, w tym symbole, małe i wielkie litery oraz cyfry.");
define("lg_phrase_recaptcha_error", "Wprowadzony kod reCAPTCHA jest niepoprawny.");
define("lg_phrase_recover_password", "Odzyskaj hasło");
define("lg_phrase_recover_password_error", "Wystąpił nieoczekiwany błąd w przetwarzaniu Twojego żądania. Proszę, skontaktuj się z webmasterem.");
define("lg_phrase_recover_password_success", "Żądanie odzyskania hasła przebiegło pomyślnie.<p>Proszę, postępuj zgodnie z instrukcjami przesłanymi na Twój adres e-mail w celu ustalenia nowego hasła.</p>");
define("lg_phrase_recover_password2", "Możesz ustalić nowe hasło klikając na poniższy link.");
define("lg_phrase_recover_password3", "Ustal nowe hasło");
define("lg_phrase_recover_password4", "Jeśli nie zgłaszałeś prośby o zmianę hasła, skontaktuj się z webmasterem przez ");
define("lg_phrase_recover_password5", "e-mail pod poniższym linkiem ");
define("lg_phrase_register_delete_noemail", "Nie znaleziono konta odpowiadającego podanemu adresowi e-mail.");
define("lg_phrase_registration_email_verify", "Zweryfikuj swój adres e-mail");
define("lg_phrase_registration_email_verify_msg", "Nowa wiadomość została wysłana na adres e-mail podany przy rejestracji.&nbsp; Kliknij na link podany w treści wiadomości lub skopiuj i wklej poniżej przesłany kod weryfikujący. Twoje konto nie będzie dostępne, dopóki nie dokonasz weryfikacji.");
define("lg_phrase_registration_error", "Wystąpił nieoczekiwany błąd przy rejestracji. Proszę, skontaktuj się z webmasterem ");
define("lg_phrase_registration_mail0", "Wygenerowano nowy kod weryfikujący");
define("lg_phrase_registration_mail1", "Dziękujemy za zarejestrowanie się na");
define("lg_phrase_registration_mail2", "Zanim będziesz się mógł zalogować, musisz");
define("lg_phrase_registration_mail3", "zweryfikować swój adres e-mail.");
define("lg_phrase_registration_mail4", "Kliknij tutaj, aby zweryfikować swój adres e-mail");
define("lg_phrase_registration_mail5", "Jeżeli powyższy link nie działa, udaj się na http://");
define("lg_phrase_registration_mail6", "skopiuj i wklej podany poniżej kod weryfikujący do formularza i kliknij \"Wyślij\"");
define("lg_phrase_registration_mail7", "Jeżeli się nie rejestrowałeś, kliknij");
define("lg_phrase_registration_mail8", "ten link: <a href=\"http://");
define("lg_phrase_registration_mail9", "jeżeli masz jakiekolwiek pytania, <a href=\"http://");
define("lg_phrase_registration_success", "Rejestracja przebiegła pomyślnie");
define("lg_phrase_remember_me_warning", "Nie zaznaczaj &quot;zapamiętaj mnie&quot;, jeśli korzystasz z współdzielonego komputera.");
define("lg_phrase_request_password1", "Żądanie odzyskania hasła zostało zgłoszone na ");
define("lg_phrase_set_new_password_error", "Wystąpił nieoczekiwany błąd przy przetwarzaniu Twojego żądania. ");
define("lg_phrase_set_new_password_good_token", "Podany kod jest poprawny. Wprowadź nowe hasło.");
define("lg_phrase_set_new_password_success", "Twoje hasło zostało pomyślnie zmienione.");
define("lg_phrase_set_new_password_tken_expired", "Minęło więcej niż 24 godziny od czasu zgłoszenia odzyskiwania hasła.");
define("lg_phrase_user_registration", " Rejestracja użytkownika.");
define("lg_phrase_userid_empty", "Wymagane pole &quot;Login&quot; jest puste. Proszę, wprowadź swój login.");
define("lg_phrase_userid_inuse", "Podany login jest zajęty lub nieprawidłowy.");
define("lg_phrase_userid_new_title", "Proszę, wprowadź swój login. To pole jest wymagane.");
define("lg_phrase_userid_title", "Proszę, wprowadź swój login. To pole jest wymagane.");
define("lg_phrase_verify_expired", "Minęło więcej niż 24 godziny od czasu Twojej rejestracji.");
define("lg_phrase_verify_login", "Możesz teraz się zalogować na swoje konto.");
define("lg_phrase_verify_newtoken", "Kliknij tutaj, aby wygenerować nowy kod odblokowujący.");
define("lg_phrase_verify_verified", "Zweryfikowałeś swój adres e-mailowy.");
define("lg_phrase_webmaster_may_be_contacted", "Z webmasterem można się skontaktować poprzez e-mail przy użyciu poniższego linku: ");
define("lg_phrase_website_title", "Prosze, podaj adres swojej strony internetowej.");
define("lg_register_button_text", "Zarejestruj");
define("lg_term_at", "na");
define("lg_term_cancel", "Zdezaktywuj konto");
define("lg_term_cancel_account", "Zdezaktywuj konto");
define("lg_term_change_password", "Zmień hasło");
define("lg_term_change_password_button_text", "Zmień hasło");
define("lg_term_checkToken", "checkToken");
define("lg_term_city", "Miasto");
define("lg_term_confirm", "Potwierdzenie hasła");
define("lg_term_contact", "Kontakt");
define("lg_term_contact_form", "Formularz kontaktowy");
define("lg_term_content_language", "<meta http-equiv=\"content-language\" content=\"pl-PL\" />");
define("lg_term_country", "Kraj");
define("lg_term_current_password", "Obecne hasło");
define("lg_term_delete_account", "Usuń konto");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "E-mail");
define("lg_term_enter_information", "Wprowadź dane");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Przykład");
define("lg_term_forbidden", "Dostęp zabroniony");
define("lg_term_form_error", "Błąd formularza");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_guest","Gościu!");
define("lg_term_home", "Home");
define("lg_term_immediately", "natychmiastowo!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Wygeneruj nowy kod weryfikujący");
define("lg_term_language", "<meta name=\"language\" content=\"pl-PL\" />");
define("lg_term_log_out", "Wyloguj");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "Wylogowany");
define("lg_term_login", "Zaloguj się");
define("lg_term_login_success", "Logowanie pomyślnie ukończone");
define("lg_term_name", "Imię i nazwisko");
define("lg_term_new_password", "Nowe hasło");
define("lg_term_optional", "opcjonalne");
define("lg_term_or", "lub");
define("lg_term_password", "Hasło");
define("lg_term_please_login", "Proszę, zaloguj się");
define("lg_term_please_register", "Proszę, zarejestruj się");
define("lg_term_project_home_link", "<a title=\"System Logowania na Google Code\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password", "Odzyskaj hasło");
define("lg_term_region", "Region");
define("lg_term_register", "Zarejestruj się");
define("lg_term_register_confirmation", "Potwierdzenie rejestracji");
define("lg_term_register_delete_enter_email", "Wprowadź adres e-mail");
define("lg_term_registration", "Rejestracja");
define("lg_term_registration_thankyou", "Dziękujemy za zarejestrowanie się.");
define("lg_term_registration_verification", "Potwierdzenie rejestracji");
define("lg_term_remember", true);
define("lg_term_rememberme", "Zapamiętaj mnie");
define("lg_term_remove_registration", "Usuń rejestrację");
define("lg_term_required", "wymagane");
define("lg_term_reset_password", "Odzyskiwanie hasła");
define("lg_term_set_new_password", "Wprowadź nowe hasło");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_submit", "Wyślij");
define("lg_term_to", "Do ");
define("lg_term_useragent", "Useragent");
define("lg_term_userid", "Identyfikacja użytkownika");
define("lg_term_via_email", "e-mailem na");
define("lg_term_webloginproject_link", "<a title=\"Web Login Project\" href=\"http://www.webloginproject.com/index.php\">Web Login Project</a>");
define("lg_term_website", "strony");
define("lg_term_website_address", "Adres strony");
define("lg_term_welcome","Witaj");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"pl\" lang=\"pl\">");
?>
