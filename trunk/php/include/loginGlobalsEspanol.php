<?php
// $Id$
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
* Version: alpha 0.5 - Spanish-Mexican/Español - PHP
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
define("lg_login_button_text", "Iniciar");
define("lg_phrase_attention_webmaster", "Atención Webmaster ");
define("lg_phrase_cancel_account_canceled", "La cuenta ha sido cancelada.");
define("lg_phrase_cancel_account_error", "Se produjo un error inesperado cancelación de su cuenta. Por favor, póngase en contacto con el webmaster");
define("lg_phrase_cancel_account_warning", "Ingrese su usuario y contraseña para cancelar su cuenta. AVISO: ESTA ACCIÓN NO SE PUEDE DESHACER. Si olvidado tu contraseña utilice el enlace de recuperar su contraseña abajo.");
define("lg_phrase_change_password", "Introduzca la contraseña actual, entonces su nueva contraseña deseada");
define("lg_phrase_confirm_empty", "El campo Confirmar Contraseña está vacía, pero se requiere. Por favor confirme su contraseña.");
define("lg_phrase_confirm_title", "Por favor, confirme su contraseña deseada. Este campo es obligatorio.");
define("lg_phrase_contact_body", "<p>Esta es la página de contacto. Por lo general, sería una forma. Como mínimo, debe proporcionar la dirección de correo electrónico del Webmaster.</p>")'
define("lg_phrase_contact_webmaster", "contacto con el webmaster");
define("lg_phrase_contact_webmaster1", "Por favor, póngase en contacto con el webmaster para obtener ayuda.");
define("lg_phrase_default_body1", "Este sitio fue creado para demostrar que incorpora el sistema de acceso en el diseño de su sitio web.</p><p>Cada sitio web puede ser conceptualizado como una plantilla. secciones comunes de una plantilla de página web puede incluir un banner, la navegación, un área de contenido principal, y quizás un pie de página con enlaces a los Términos de Uso, detalles de Derecho de Autor y la Política de Privacidad.</p><p>The area where you are now reading in the "Main Content Area" of this page. Esta es el área donde se insertará el código HTML o XHTML plantillas que permiten al sistema de acceso.</p><p>Visite la web del proyecto en Google Code en:");
define("lg_phrase_default_body2", ".</p><p>O visite las diferentes páginas de demostración en varios idiomas en el mundo");
define("lg_phrase_default_body3", "la demostración y la zona de prueba.</p>");
define("lg_phrase_delete_account", "Eliminar cuenta");
define("lg_phrase_delete_already_verified", "La cuenta ya ha sido verificada y no se podía eliminar");
define("lg_phrase_delete_deleted", "La cuenta ha sido eliminada");
define("lg_phrase_email_empty", " El campo correo electrónico está vacía, pero se requiere. Por favor, introduzca su dirección de correo electrónico.");
define("lg_phrase_email_title", "Por favor, introduzca su dirección de correo electrónico. Este campo es obligatorio.");
define("lg_phrase_enter_set_new_password_token", "Introduzca la contraseña ajustada nuevo token");
define("lg_phrase_enter_unlock_code", "Ingrese código de desbloqueo");
define("lg_phrase_forbidden_body", "<p><h1>Usted no tiene acceso a ese recurso.</h1></p><p>Póngase en contacto con el webmaster en:");
define("lg_phrase_form_error_cookie", "Las cookies son necesarias para el acceso. Por favor, asegúrese que su navegador acepte cookies de este sitio.");
define("lg_phrase_form_error_time", "La forma de tiempo de espera antes de completarse. Por favor, complete el formulario en menos de 5 minutos.");
define("lg_phrase_form_error_token", "Hubo un error de forma. Esto puede deberse al uso de su navegador para volver de nuevo a un formulario completado con anterioridad y volver a presentarla.");
define("lg_phrase_is_logged_in", "se conectó");
define("lg_phrase_issue_new_token", "Escriba su nombre de usuario y correo electrónico para recibir una nueva clave de verificación.");
define("lg_phrase_issue_new_token_error", "Se produjo un error inesperado generar su clave de verificación. Póngase en contacto con el webmaster.");
define("lg_phrase_issue_new_token_success", "Tu nuevo clave de verificación será enviado a tu dirección de correo electrónico.");
define("lg_phrase_logged_out", "Usted se cerrará la sesión.");
define("lg_phrase_login_error", "Se ha producido un error. Por favor introduzca su usuario y contraseña otra vez.");
define("lg_phrase_login_error_token", "Usted tendrá que validar su dirección de correo electrónico utilizando el token que se han enviado antes de iniciar la sesiÃ");
define("lg_phrase_login_token_problem", "O bien la clave de verificación se ha utilizado (y que son verificados,) o de la ficha de la no es válido.");
define("lg_phrase_logout_continue", "Haga clic aquí para continuar.");
define("lg_phrase_name_empty", "El campo Nombre está vacío, pero es necesaria. Por favor escriba su nombre.");
define("lg_phrase_name_title", "Por favor escriba su nombre completo. Este campo es obligatorio.");
define("lg_phrase_newpassword_empty", "El campo Nueva Contraseña está vacía, pero se requiere. Por favor, introduzca su contraseña.");
define("lg_phrase_news", "Desea recibir correos electrónicos periódicos cuando cambia la página web o los nuevos artículos se publican?");
define("lg_phrase_no_matching_registration", "No existía ningún registro que coincida con los Nombre de Usuario y Dirección de Correo Electrónico que ha entrado.");
define("lg_phrase_oldpassword_does_not_match", "La contraseña actual no coincide con la contraseña almacenada. Inténtelo de nuevo. ");
define("lg_phrase_oldpassword_empty", "El campo Contraseña anterior está vacía, pero se requiere. Por favor, introduzca su contraseña. ");
define("lg_phrase_oldpassword_title", "Por favor, introduzca su contraseña actual. Este campo es obligatorio. ");
define("lg_phrase_password_change_authorized", "Si usted no autorizó este cambio, por favor póngase en contacto con el webmaster ");
define("lg_phrase_password_changed", "Su contraseña se ha cambiado ");
define("lg_phrase_password_changed_error", "Se produjo un error inesperado. La contraseña no ha cambiado. Póngase en contacto con el webmaster");
define("lg_phrase_password_changed_okay", "Contraseña cambiado con éxito.");
define("lg_phrase_password_changed_post", "fue cambiado a") ;
define("lg_phrase_password_changed_pre", "Tu contraseña en");
define("lg_phrase_password_empty", "El campo de la contraseña está vacía, pero se requiere. Por favor, introduzca su contraseña.");
define("lg_phrase_password_new_title", "Por favor, introduzca su contraseña deseada . Este campo es obligatorio. ");
define("lg_phrase_password_nomatch_confirm", "La contraseña no coincide con la Contraseña de Confirmación. Por favor, vuelva a entrar. ");
define("lg_phrase_password_title", "Por favor, introduzca su contraseña. Este campo es obligatorio. ");
define("lg_phrase_password_too_soon", "La contraseña es la misma que una de las contraseñas usadas recientemente. Por favor, elija una contraseña diferente.");
define("lg_phrase_password_too_short_pre", "La contraseña introducida tiene muy pocos personajes. La longitud mínima de la contraseña es:");
define("lg_phrase_password_too_short_post", "letras, números y símbolos.");
define("lg_phrase_password_too_simple", "La contraseña es demasiado simple. Por favor, introduzca una contraseña que tiene muchos caracteres aleatorios que incluyen una combinación de cartas superiores y minúsculas, números, y simbolos.");
define("lg_phrase_recaptcha_error", "El reCAPTCHA no se ha escrito correctamente.");
define("lg_phrase_recover_password", "Recuperar Contraseña");
define("lg_phrase_recover_password_error", "Se produjo un error inesperado al procesar tu solicitud. Por favor, póngase en contacto con el webmaster. ");
define("lg_phrase_recover_password_success", "La solicitud para recuperar su contraseña se procesó suiccessfully. Por favor, siga las instrucciones del correo electrónico enviado a usted para establecer una nueva contraseña.");
define("lg_phrase_recover_password2", "Usted puede establecer una nueva contraseña a clicando abajo.");
define("lg_phrase_recover_password3", "  Ponga Nueva Contraseña");
define("lg_phrase_recover_password4", "Si no ha solicitado la recuperación de su contraseña, póngase en contacto con el webmaster de ");
define("lg_phrase_recover_password5", "Correo electrónico en el enlace siguiente e-mail ");
define("lg_phrase_register_delete_noemail", "No se encuentra un cuenta con la dirección de correo electrónico indicada. ");
define("lg_phrase_registration_email_verify", "Verifique su correo electrónico");
define("lg_phrase_registration_email_verify_msg", "Un correo electrónico fue enviado a la dirección de correo electrónico que proporcionó durante el registro. Haga clic en el vínculo que contiene dicho correo electrónico o copiar y pegar el código de desbloqueo en el campo de formulario a continuación. Su cuenta no estará disponible hasta que se haya verificado.");
define("lg_phrase_registration_error", "Fue un error inesperado de completar su registro. Por favor, póngase en contacto con el webmaster ");
define("lg_phrase_registration_mail0", "Nuevo registro emitido en clave de verificación ");
define("lg_phrase_registration_mail1", "Gracias por registrarte en ");
define("lg_phrase_registration_mail2", "Antes de que pueda entrada que necesita");
define("lg_phrase_registration_mail3", "para verificar su dirección de correo electrónico.");
define("lg_phrase_registration_mail4", "Haga clic aquí para verificar");
define("lg_phrase_registration_mail5", "Si el enlace de arriba no funciona, vaya a http:// ");
define("lg_phrase_registration_mail6", "copiar y pegar el ficha a continuación en el formulario y haga clic en \"Someter\"");
define("lg_phrase_registration_mail7", "Si no se registró, haga clic en ");
define("lg_phrase_registration_mail8", "en este enlace: <a href = \"http://");
define("lg_phrase_registration_mail9", "si usted tiene cualquier pregunta a continuación, <a href=\"http://");
define("lg_phrase_registration_success", "Registro éxito");
define("lg_phrase_remember_me_warning", "No comprobar si acuerdas de mí éste es un ordenador compartido.");
define("lg_phrase_request_password1", "La solicitud se ha hecho para recuperar la contraseña en");
define("lg_phrase_set_new_password_error", "Se produjo un inesperado error en completar su solicitud.");
define("lg_phrase_set_new_password_good_token", "Su clave era válido. Escriba una nueva contraseña.");
define("lg_phrase_set_new_password_success", "Su contraseña se ha cambiado correctamente.");
define("lg_phrase_set_new_password_token_expired", "Más de 24 horas ha pasado desde que usted solicitó una muestra de recuperación de contraseña.") ;
define("lg_phrase_user_registration", "Registro de Usuario.");
define("lg_phrase_userid_empty", "el nombre de suario campo es necesaria, pero está vacío. Por favor, introduzca su nombre de usuario.");
define("lg_phrase_userid_inuse", "La nombre de usuario está en uso o no válido.");
define("lg_phrase_userid_new_title", "Por favor, introduzca su nombre de usuario que desee. Este campo es obligatorio.");
define("lg_phrase_userid_title", "Por favor ingrese su nombre de usuario. Este campo es obligatorio. ");
define("lg_phrase_verify_expired", "Más de 24 hors han pasado desde su inscripción. ");
define("lg_phrase_verify_login", "Ahora puede acceder a su cuenta.");
define("lg_phrase_verify_newtoken", "Haga clic aquí para crear un nuevo clave de desbloqueo.");
define("lg_phrase_verify_verified", "Usted ha verificado su dirección de correo electrónico." );
define("lg_phrase_webmaster_may_be_contacted", "El webmaster puede contactar por correo electrónico usando este enlace:");
define("lg_phrase_website_title", "Por favor, introduzca su dirección de página web.");
define("lg_register_button_text", "Registro");
define("lg_term_at", "a");
define("lg_term_cancel", "Cancelar Cuenta");
define("lg_term_cancel_account", "Cancelar Cuenta");
define("lg_term_change_password", "Cambiar Contraseña");
define("lg_term_change_password_button_text", "Cambiar Contraseña");
define("lg_term_checkToken", "Chequeo Clave");
define("lg_term_city", "Ciudad ");
define("lg_term_confirm", "Confirmar Contraseña");
define("lg_term_contact", "Contacto");
define("lg_term_contact_form", "Formulario de contacto");
define("lg_term_content_language", "<meta http-equiv=\"content-language\" content=\"es-MX\" />");
define("lg_term_country", "Paiz");
define("lg_term_current_password", "Contraseña Actual ");
define("lg_term_delete_account", "Eliminar cuenta");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "Correo Electrónico");
define("lg_term_enter_information", "Entre la Información");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "Ejemplo");
define("lg_term_fair", "BUENO NO");
define("lg_term_forbidden", "Prohibido");
define("lg_term_form_error", "Formulario de error");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_guest", "Invitado");
define("lg_term_home", "Inicio");
define("lg_term_immediately", "inmediatamente!");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "Cuestión de verificación");
define("lg_term_language", "<meta name=\"language\" content=\"es-MX\" />");
define("lg_term_log_out", "Cierre la sesión");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "Ha salido");
define("lg_term_login", "Login");
define("lg_term_login_success", "Éxito");
define("lg_term_medium", "BUENO");
define("lg_term_name", "Nombre");
define("lg_term_new", "Nueva");
define("lg_term_new_password", "Nueva Contraseña");
define("lg_term_poor", "MUY DÉBIL");
define("lg_term_optional", "Opcional");
define("lg_term_or", "o");
define("lg_term_password", "contraseña");
define("lg_term_please_login", "Por favor, Iniciarse");
define("lg_term_please_register", "Por favor Registro");
define("lg_term_project_home_link", "<a title=\"Nombre del sistema en Google Code\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password", "Recuperar Contraseña");
define("lg_term_region", "Región");
define("lg_term_register", "Registro");
define("lg_term_register_confirmation", "Confirmación de Registro");
define("lg_term_register_delete_enter_email", "Ponga Correo Electrónico");
define("lg_term_registration", "Registro ");
define("lg_term_registration_thankyou", "Gracias Por Registrarse.");
define("lg_term_registration_verification", "Verificación de Registrado");
define("lg_term_remember ", true);
define("lg_term_rememberme", "Recuerdame");
define("lg_term_remove_registration", "Eliminar registro");
define("lg_term_required ", "obligatorio");
define("lg_term_reset_password", "Contraseña Reajustar");
define("lg_term_set_new_password", "introducir una nueva contraseña");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_strong", "EXCELENTE");
define("lg_term_submit", "Enviar");
define("lg_term_to", "A");
define("lg_term_useragent", "Useragent");
define("lg_term_userid", "Nobre de usuario");
define("lg_term_via_email", "por correo electrónico a");
define("lg_term_webloginproject_link", "<a title=\"Proyecto Web Login\" href=\"http://www.webloginproject.com/index.php\">Proyecto Web Login</a>");
define("lg_term_website", "sitio web");
define("lg_term_website_address", "Dirección del sitio web");
define("lg_term_welcome", "Bienvenido");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"es\" lang=\"es\">");
?>


