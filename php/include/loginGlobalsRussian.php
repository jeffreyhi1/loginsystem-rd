<?PHP
// $Id: loginGlobalsRussian.php 298 2010-06-05 02:53:46Z rdivilbiss $
$lg_filename = basename($_SERVER['PHP_SELF']);
/*******************************************************************************************************************
* Login Globals - PHP
* 
* NOTE: You must set lg_domain, lg_domain_secure, lg_loginPath and must set the full path to certain pages.
*       You must set the webmaster e-mail addresses.
*       You must set the database connection details in database.php.     
* Modification: 13 MAY 2010 :: Vadim Rapp - translation to Russian 
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
* Version:  alpha 0.6 - Russian - PHP
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
define("lg_password_min_length", 10);
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
define("lg_login_button_text", "Авторизация");
define("lg_phrase_attention_webmaster", "Вниманию вебмастера");
define("lg_phrase_cancel_account_cacelled", "Эта учетная запись была удалена.");
define("lg_phrase_cancel_account_error", "Непредвиденная ошибка во время удаления Вашей учетной записи. Свяжитесь с вебмастером");
define("lg_phrase_cancel_account_warning", "Для удаления учетной записи введите Ваше имя и пароль.<br>ВНИМАНИЕ: ЭТО РЕШЕНИЕ БУДЕТ БЕСПОВОРОТНЫМ.<br>Если Вы забыли пароль, воспользуйтесь следующим линком.");
define("lg_phrase_change_password", "Введите сначала Ваш текущий пароль, затем новый");
define("lg_phrase_confirm_empty", "Укаэите пароль второй раз.");
define("lg_phrase_confirm_title", "Подтвердите Ваш новый пароль.");
define("lg_phrase_contact_body", "<p>Это контактная страница. Обычно здась будет форма. Как минимум, необходимо указать email адрес вебмастера.</p>");
define("lg_phrase_contact_webmaster", "свяжитесь с вебмастером");
define("lg_phrase_contact_webmaster1", "Свяжитесь с вебмастером.");
define("lg_phrase_default_body1", "Этот сайт был создан для демострации применения Login System в Вашем вебсайте.</p><p>Каждый вебсайт может быть представлен в виде шаблона. Общие секции шаблона страницы могут включать баннер, навигацию, содержательную область, и возможно нижнюю область с линками к условиям пользования, копирайт, и правила неразглашения.</p><p>Область, которую Вы сейчас читаете, называется &quot;Главное содержание &quot; этой страницы. Это та область, где нужно вставить HTML or XHTML шаблоны, которые задействуют Login System. Попробуйте зайти на вышеуказанный линк, зарегистрируйтесь  и попробуйте эту систему. Это рабочий бета сайт, и какие-то его области возможно и не сработают.</p><p>Посетите сайт этого проекта на Google Code по следующему адресу:");
define("lg_phrase_default_body2", ".</p><p>Или посетите различные демострационные страницы на разных языках по адресам");
define("lg_phrase_default_body3", "демострационный и тест-сайт.</p>");
define("lg_phrase_delete_account", "Удалить учетную запись");
define("lg_phrase_delete_already_verified", "Эта учетная запись уже была проверена и не может быть удалена");
define("lg_phrase_delete_deleted", "Эта учетной запись была удалена");
define("lg_phrase_email_empty", " Поле email не может быть пустым. Введите Ваш email адрес.");
define("lg_phrase_email_title", "Укажите Ваш email адрес.");
define("lg_phrase_enter_set_new_password_token", "Enter set new password token.");
define("lg_phrase_enter_unlock_code", "Введите код разблокировки");
define("lg_phrase_forbidden_body", "<p><h1>Вы не имеете доступа к данному ресурсу.</h1></p><p>Свяжитесь с вебмастером по адресу");
define("lg_phrase_form_error_cookie", "Для входа необходимы куки. Убедитесь в том, что Ваш браузер принимает куки с этого сайта.");
define("lg_phrase_form_error_time", "Форма истекла до того, как Вы ее заполнили. Пожалуйста, постарайтесь уложиться в 5 минут.");
define("lg_phrase_form_error_token", "В форме произошла ошибка. Возможно, это вызвано использованием кнопки «назад» в браузере, которая вернула Вас на ранее использованную форму и посылкой ее заново.");
define("lg_phrase_is_logged_in", "успешно вошел в систему.");
define("lg_phrase_issue_new_token", "Чтобы получить новый токен верификации, введите Ваше имя и email адрес.");
define("lg_phrase_issue_new_token_error", "Непредвиденная ошибка при генерации токена. Свяжитесь с вебмастером.");
define("lg_phrase_issue_new_token_success", "Ваш токен верификации быдет послан на Ваш email адрес.");
define("lg_phrase_logged_out", "Выход из системы выполнен успешно");
define("lg_phrase_login_error", "Ошибка. Введите имя и пароль еще раз.");
define("lg_phrase_login_error_token", "Сначала необходимо проверить Ваш email адрес путем применения токена, который был Вам выслан.");
define("lg_phrase_login_token_problem", "Либо верификационный токен уже был введен, т.е Вы уже прошли проверку, либо токен неправильный.");
define("lg_phrase_logout_continue", "Продолжить");
define("lg_phrase_name_empty", "Необходимо указать имя.");
define("lg_phrase_name_title", "Введите Ваше полное имя.");
define("lg_phrase_newpassword_empty", "Введите новый пароль.");
define("lg_phrase_news", "Получать email уведомления об изменениях в вебсайте или новых публикациях?");
define("lg_phrase_no_matching_registration", "Учетная запись с таким именем и email-ом не найдена.");
define("lg_phrase_oldpassword_does_not_match", "Неправильный пароль. Попробуйте еще раз.");
define("lg_phrase_oldpassword_empty", "Укажите старый пароль.");
define("lg_phrase_oldpassword_title", "Укажите новый пароль.");
define("lg_phrase_password_change_authorized", "Если Вы это не санкционировали, свяжитесь с вебмастером");
define("lg_phrase_password_changed", "Пароль сменен");
define("lg_phrase_password_changed_error", "Непредвиденная ошибка при смене пароля. Пароль не изменился. Свяжитесь с вебмастером");
define("lg_phrase_password_changed_okay", "Пароль изменен успешно.");
define("lg_phrase_password_changed_post", "был изменен в");
define("lg_phrase_password_changed_pre", "Ваш пароль на");
define("lg_phrase_password_empty", "Укажите непустой пароль.");
define("lg_phrase_password_new_title", "Введите новый пароль.");
define("lg_phrase_password_nomatch_confirm", "Пароль не соответствует паролю подтверждения. Введите заново.");
define("lg_phrase_password_title", "Введите пароль.");
define("lg_phrase_password_too_short_post", "букв, символов и цифр.");
define("lg_phrase_password_too_short_pre", "Пароль слишком короткий. Минимальная длина -");
define("lg_phrase_password_too_simple", "Этот пароль слишком прост. Пожалуйста, создайте пароль, в которам были бы многочисленные случайные строчные и заглавные буквы, символы и цифры.");
define("lg_phrase_password_too_soon", "Этот тот же пароль, что и предыдущий. Пожалуйста, выберите другой пароль.");
define("lg_phrase_recaptcha_error", "Неправильно введен графический код.");
define("lg_phrase_recover_password", "Напомнить пароль");
define("lg_phrase_recover_password_error", "Непредвиденная ошибка во время обработки запроса. Свяжитесь с вебмастером.");
define("lg_phrase_recover_password_success", "Запрос на восстановеление пароля успешно обработан.<br>Вам послан email с инструкциями по установке нового пароля.");
define("lg_phrase_recover_password2", "Вы можете установить новый пароль с помощью следющего линка.");
define("lg_phrase_recover_password3", "Установить новый пароль");
define("lg_phrase_recover_password4", "Если Вы не просили восстановить пароль, свяжитесь с вебмастером");
define("lg_phrase_recover_password5", "– пошлите email на следующий линк");
define("lg_phrase_register_delete_noemail", "Учетная запись с таком email адресом не найдена.");
define("lg_phrase_registration_email_verify", "Проверка Вашего email адреса");
define("lg_phrase_registration_email_verify_msg", "Мы выслали email на указанный Вами адрес. Найдите в нем линк, или скопируйте сюда проверочный код. Ваша учетная запись будет функционировать только после этого.");
define("lg_phrase_registration_error", "Непредвиденная ошибка при завершении регистрации. Свяжитесь с вебмастером");
define("lg_phrase_registration_mail0", "Выдан новый токен");
define("lg_phrase_registration_mail1", "Спасибо за зарегистрацию на");
define("lg_phrase_registration_mail2", "Перед входом в систему необходимо");
define("lg_phrase_registration_mail3", "проверить Ваш email адрес.");
define("lg_phrase_registration_mail4", "Для проверки нажмите здесь");
define("lg_phrase_registration_mail5", "Если этот линк не работает, зайдите на http://");
define("lg_phrase_registration_mail6", "скопируйте этот токен в форму и нажмите \"Послать\"");
define("lg_phrase_registration_mail7", "Если Вы не регистрировались, нажмите");
define("lg_phrase_registration_mail8", "этот линк: <a href=\"http://");
define("lg_phrase_registration_mail9", "Если у Вас есть вопросы, <a href=\"http://");
define("lg_phrase_registration_success", "Регистрация выполнена успещно");
define("lg_phrase_remember_me_warning", "Не ставьте \"запомнить меня\", если Вы не на Вашем собственном компьютере.");
define("lg_phrase_request_password1", "Был сделан запрос на восстановление пароля");
define("lg_phrase_set_new_password_error", "Непредвиденная ошибка во время обработки запроса.");
define("lg_phrase_set_new_password_good_token", "Токен принят. Введите новый пароль.");
define("lg_phrase_set_new_password_success", "Пароль успешно изменен.");
define("lg_phrase_set_new_password_token_expired", "Запрос на токен смены пароля был сделан более чем 24 часа назад.");
define("lg_phrase_user_registration", "Регистрация пользователя.");
define("lg_phrase_userid_empty", "Введите имя.");
define("lg_phrase_userid_inuse", "Это имя либо уже кем-то использыется, либо неправильное.");
define("lg_phrase_userid_new_title", "Введите желаемый логин. Это обязательное поле.");
define("lg_phrase_userid_title", "Введите Ваш логин. Это обязательное поле.");
define("lg_phrase_verify_expired", "С момента Вашей регистрации прошло более 24 часов.");
define("lg_phrase_verify_login", "Вы можете зайти на Ваш профиль.");
define("lg_phrase_verify_newtoken", "Нажмите здесь, чтобы получить новый проверочный код.");
define("lg_phrase_verify_verified", "Проверка email адреса выполнена успешно.");
define("lg_phrase_webmaster_may_be_contacted", "С вебмастером можно связаться email-ом с помощью следующего линка:");
define("lg_phrase_website_title", "Введите адрес Вашего вебсайта.");
define("lg_register_button_text", "Регистрация");
define("lg_term_at", "по адресу");
define("lg_term_cancel", "Закрыть учетную запись");
define("lg_term_cancel_account", "Закрыть учетную запись");
define("lg_term_change_password", "Сменить пароль");
define("lg_term_change_password_button_text", "Сменить пароль");
define("lg_term_checkToken", "checkToken");
define("lg_term_city", "Город");
define("lg_term_confirm", "Подтвердить пароль");
define("lg_term_contact", "Свяжитесь с");
define("lg_term_contact_form", "Контактная форма");
define("lg_term_content_language", "<meta http-equiv=\"content-language\"content=\"ru-RU\"/>");
define("lg_term_country", "Страна");
define("lg_term_current_password", "Текущий пароль");
define("lg_term_delete_account", "Удалить учетную запись");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "Email");
define("lg_term_enter_information", "Введите информацию");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Пример");
define("lg_term_fair", "так себе");
define("lg_term_forbidden", "Запрещенный");
define("lg_term_from_error", "Ошибка в форме");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_guest", "Гость.");
define("lg_term_home", "Домой");
define("lg_term_immediately", "немедленно!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Верификационный токен");
define("lg_term_language", "<meta name=\"language\" content=\"ru-RU\" />");
define("lg_term_log_out", "Выйти из системы");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "Вышел из системы");
define("lg_term_login", "Войти");
define("lg_term_login_success", "Вход в систему выполнен успещно");
define("lg_term_medium", "средне");
define("lg_term_name", "Логин");
define("lg_term_new", "новый");
define("lg_term_new_password", "Новый пароль");
define("lg_term_poor", "слабо");
define("lg_term_optional", "Необязательно");
define("lg_term_or", "или");
define("lg_term_password", "Пароль");
define("lg_term_please_login", "Пожалуйста, зайдите");
define("lg_term_please_register", "Реигстрация");
define("lg_term_project_home_link", "<a title=\"Login System на Google Code\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password", "Напомнить пароль");
define("lg_term_region", "Регион/штат");
define("lg_term_register", "Регистрация");
define("lg_term_register_confirmation", "Подтверждение регистрации");
define("lg_term_register_delete_enter_email", "Введите email адрес");
define("lg_term_registration", "Регистрация");
define("lg_term_registration_thankyou", "Спасибо за регистрацию.");
define("lg_term_registration_verification", "Подтверждение регистрации");
define("lg_term_remember", true);
define("lg_term_rememberme", "Запомнить меня");
define("lg_term_remove_registration", "Удалить регистрацию");
define("lg_term_required", "обязательный параметр");
define("lg_term_reset_password", "Пароль изменен");
define("lg_term_set_new_password", "Введите новый пароль");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_strong", "сильно");  
define("lg_term_submit", "Отправить");
define("lg_term_to", "Кому:");
define("lg_term_useragent", "Useragent");
define("lg_term_userid", "Логин");
define("lg_term_via_email", "email-ом");
define("lg_term_webloginproject_link", "<a title=\"Web Login Project\" href=\"http://www.webloginproject.com/index.php\">Проект Web Login</a>");
define("lg_term_website", "вебсайта");
define("lg_term_website_address", "Адрес вебсайта");
define("lg_term_welcome", "Добро пожаловать");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"ru\" lang=\"ru\">");
?>