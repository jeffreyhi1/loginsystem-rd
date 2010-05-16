<%
* $Id$
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
* Version alpha 0.4 - Spanish/Español - ASP
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
Const lg_login_button_text = "Iniciar"
Const lg_phrase_attention_webmaster = "Atención Webmaster"
Const lg_phrase_cancel_account_canceled  = "La cuenta ha sido cancelada."
Const lg_phrase_cancel_account_error = "Se produjo un error inesperado cancelación de su cuenta. Por favor, póngase en contacto con el webmaster"
Const lg_phrase_cancel_account_warning = "Ingrese su usuario y contraseña para cancelar su cuenta. AVISO: ESTA ACCIÓN NO SE PUEDE DESHACER. Si olvidado tu contraseña utilice el enlace de recuperar su contraseña abajo."
Const lg_phrase_change_password = "Introduzca la contraseña actual, entonces su nueva contraseña deseada"
Const lg_phrase_confirm_empty = "El campo Confirmar Contraseña está vacía, pero se requiere. Por favor confirme su contraseña."
Const lg_phrase_confirm_title = "Por favor, confirme su contraseña deseada. Este campo es obligatorio."
Const lg_phrase_contact_body = "<p>Esta es la página de contacto. Por lo general, sería una forma. Como mínimo, debe proporcionar la dirección de correo electrónico del Webmaster.</p>"
Const lg_phrase_contact_webmaster = "contacto con el webmaster"
Const lg_phrase_contact_webmaster1 = "Por favor, póngase en contacto con el webmaster para obtener ayuda." 
Const lg_phrase_default_body1 = "Este sitio fue creado para demostrar que incorpora el sistema de acceso en el diseño de su sitio web.</p><p>Cada sitio web puede ser conceptualizado como una plantilla. secciones comunes de una plantilla de página web puede incluir un banner, la navegación, un área de contenido principal, y quizás un pie de página con enlaces a los Términos de Uso, detalles de Derecho de Autor y la Política de Privacidad.</p><p>The area where you are now reading in the "Main Content Area" of this page. Esta es el área donde se insertará el código HTML o XHTML plantillas que permiten al sistema de acceso.</p><p>Visite la web del proyecto en Google Code en:"
Const lg_phrase_default_body2 = ".</p><p>O visite las diferentes páginas de demostración en varios idiomas en el mundo"
Const lg_phrase_default_body3 = "la demostración y la zona de prueba.</p>"
Const lg_phrase_delete_account = "Eliminar cuenta"
Const lg_phrase_delete_already_verified = "La cuenta ya ha sido verificada y no se podía eliminar"
Const lg_phrase_delete_deleted = "La cuenta ha sido eliminada"
Const lg_phrase_email_empty = "El campo correo electrónico está vacía, pero se requiere. Por favor, introduzca su dirección de correo electrónico."
Const lg_phrase_email_title = "Por favor, introduzca su dirección de correo electrónico. Este campo es obligatorio."
Const lg_phrase_enter_set_new_password_token = "Introduzca la contraseña ajustada nuevo token"
Const lg_phrase_enter_unlock_code = "Ingrese código de desbloqueo"
Const lg_phrase_forbidden_body = "<p><h1>Usted no tiene acceso a ese recurso.</h1></p><p>Póngase en contacto con el webmaster en:"
Const lg_phrase_form_error_cookie = "Las cookies son necesarias para el acceso. Por favor, asegúrese que su navegador acepte cookies de este sitio."
Const lg_phrase_form_error_time = "La forma de tiempo de espera antes de completarse. Por favor, complete el formulario en menos de 5 minutos."
Const lg_phrase_form_error_token = "Hubo un error de forma. Esto puede deberse al uso de su navegador para volver de nuevo a un formulario completado con anterioridad y volver a presentarla."
Const lg_phrase_is_logged_in = "se conectó"
Const lg_phrase_issue_new_token = "Escriba su nombre de usuario y correo electrónico para recibir una nueva clave de verificación."
Const lg_phrase_issue_new_token_error = "Se produjo un error inesperado generar su clave de verificación. Póngase en contacto con el webmaster."
Const lg_phrase_issue_new_token_success = "Tu nuevo clave de verificación será enviado a tu dirección de correo electrónico."
Const lg_phrase_logged_out = "Usted se cerrará la sesión."
Const lg_phrase_login_error = "Se ha producido un error. Por favor introduzca su usuario y contraseña otra vez."
Const lg_phrase_login_error_token = "Usted tendrá que validar su dirección de correo electrónico utilizando el token que se han enviado antes de iniciar la sesiÃ."
Const lg_phrase_login_token_problem = "O bien la clave de verificación se ha utilizado (y que son verificados,) o de la ficha de la no es válido."
Const lg_phrase_logout_continue = "Haga clic aquí para continuar."
Const lg_phrase_name_empty = "El campo Nombre está vacío, pero es necesaria. Por favor escriba su nombre."
Const lg_phrase_name_title = "Por favor escriba su nombre completo. Este campo es obligatorio."
Const lg_phrase_newpassword_empty = "El campo Nueva Contraseña está vacía, pero se requiere. Por favor, introduzca su contraseña."
Const lg_phrase_news = "Desea recibir correos electrónicos periódicos cuando cambia la página web o los nuevos artículos se publican?"
Const lg_phrase_no_matching_registration = "No existía ningún registro que coincida con los Nombre de Usuario y Dirección de Correo Electrónico que ha entrado."
Const lg_phrase_oldpassword_does_not_match = "La contraseña actual no coincide con la contraseña almacenada. Inténtelo de nuevo." 
Const lg_phrase_oldpassword_empty = "El campo Contraseña anterior está vacía, pero se requiere. Por favor, introduzca su contraseña." 
Const lg_phrase_oldpassword_title = "Por favor, introduzca su contraseña actual. Este campo es obligatorio." 
Const lg_phrase_password_change_authorized = "Si usted no autorizó este cambio, por favor póngase en contacto con el webmaster" 
Const lg_phrase_password_changed = "Su contraseña se ha cambiado."
Const lg_phrase_password_changed_error = "Se produjo un error inesperado. La contraseña no ha cambiado. Póngase en contacto con el webmaster" 
Const lg_phrase_password_changed_okay = "Contraseña cambiado con éxito." 
Const lg_phrase_password_changed_post = "fue cambiado a" 
Const lg_phrase_password_changed_pre = "Tu contraseña en" 
Const lg_phrase_password_empty = "El campo de la contraseña está vacía, pero se requiere. Por favor, introduzca su contraseña." 
Const lg_phrase_password_new_title = "Por favor, introduzca su contraseña deseada . Este campo es obligatorio." 
Const lg_phrase_password_nomatch_confirm = "La contraseña no coincide con la Contraseña de Confirmación. Por favor, vuelva a entrar." 
Const lg_phrase_password_title = "Por favor, introduzca su contraseña. Este campo es obligatorio." 
Const lg_phrase_password_too_soon = "La contraseña es la misma que una de las contraseñas usadas recientemente. Por favor, elija una contraseña diferente."
Const lg_phrase_password_too_short_pre = "La contraseña introducida tiene muy pocos personajes. La longitud mínima de la contraseña es:"
Const lg_phrase_password_too_short_post = "letras, números y símbolos."
Const lg_phrase_password_too_simple = "La contraseña es demasiado simple. Por favor, introduzca una contraseña que tiene muchos caracteres aleatorios que incluyen una combinación de cartas superiores y minúsculas, números, y simbolos."
Const lg_phrase_recaptcha_error = "El reCAPTCHA no se ha escrito correctamente."
Const lg_phrase_recover_password = "Recuperar Contraseña" 
Const lg_phrase_recover_password_error = "Se produjo un error inesperado al procesar tu solicitud. Por favor, póngase en contacto con el webmaster." 
Const lg_phrase_recover_password_success = "La solicitud para recuperar su contraseña se procesó suiccessfully. Por favor, siga las instrucciones del correo electrónico enviado a usted para establecer una nueva contraseña."
Const lg_phrase_recover_password2 = "Usted puede establecer una nueva contraseña a clicando abajo." 
Const lg_phrase_recover_password3 = "Ponga Nueva Contraseña" 
Const lg_phrase_recover_password4 = "Si no ha solicitado la recuperación de su contraseña, póngase en contacto con el webmaster de" 
Const lg_phrase_recover_password5 = "Correo electrónico en el enlace siguiente e-mail" 
Const lg_phrase_register_delete_noemail = "No se encuentra un cuenta con la dirección de correo electrónico indicada." 
Const lg_phrase_registration_email_verify = "Verifique su correo electrónico" 
Const lg_phrase_registration_email_verify_msg = "Un correo electrónico fue enviado a la dirección de correo electrónico que proporcionó durante el registro. Haga clic en el vínculo que contiene dicho correo electrónico o copiar y pegar el código de desbloqueo en el campo de formulario a continuación. Su cuenta no estará disponible hasta que se haya verificado."
Const lg_phrase_registration_error = "Fue un error inesperado de completar su registro. Por favor, póngase en contacto con el webmaster " 
Const lg_phrase_registration_mail0 = "Nuevo registro emitido en clave de verificación " 
Const lg_phrase_registration_mail1 = "Gracias por registrarte en" 
Const lg_phrase_registration_mail2 = "Antes de que pueda entrada que necesita" 
Const lg_phrase_registration_mail3 = "para verificar su dirección de correo electrónico." 
Const lg_phrase_registration_mail4 = "Haga clic aquí para verificar" 
Const lg_phrase_registration_mail5 = "Si el enlace de arriba no funciona, vaya a <p>http://" 
Const lg_phrase_registration_mail6 = "copiar y pegar el ficha a continuación en el formulario y haga clic en ""Someter""" 
Const lg_phrase_registration_mail7 = "Si no se registró, haga clic en" 
Const lg_phrase_registration_mail8 = "en este enlace: <a href = ""http://" 
Const lg_phrase_registration_mail9 = "si usted tiene cualquier pregunta a continuación, <a href=""http://" 
Const lg_phrase_registration_success = "Registro éxito" 
Const lg_phrase_remember_me_warning = "No comprobar si acuerdas de mí éste es un ordenador compartido." 
Const lg_phrase_request_password1 = "La solicitud se ha hecho para recuperar la contraseña en" 
Const lg_phrase_set_new_password_error = "Se produjo un inesperado error en completar su solicitud." 
Const lg_phrase_set_new_password_good_token = "Su clave era válido. Escriba una nueva contraseña." 
Const lg_phrase_set_new_password_success = "Su contraseña se ha cambiado correctamente."
Const lg_phrase_set_new_password_token_expired = "Más de 24 horas ha pasado desde que usted solicitó una muestra de recuperación de contraseña." 
Const lg_phrase_user_registration = "Registro de Usuario"
Const lg_phrase_userid_empty = "el nombre de suario campo es necesaria, pero está vacío. Por favor, introduzca su nombre de usuario." 
Const lg_phrase_userid_inuse = "La nombre de usuario está en uso o no válido." 
Const lg_phrase_userid_new_title = "Por favor, introduzca su nombre de usuario que desee. Este campo es obligatorio." 
Const lg_phrase_userid_title = "Por favor ingrese su nombre de usuario. Este campo es obligatorio." 
Const lg_phrase_verify_expired = "Más de 24 hors han pasado desde su inscripción." 
Const lg_phrase_verify_login = "Ahora puede acceder a su cuenta." 
Const lg_phrase_verify_newtoken = "Haga clic aquí para crear un nuevo clave de desbloqueo." 
Const lg_phrase_verify_verified = "Usted ha verificado su dirección de correo electrónico."  
Const lg_phrase_webmaster_may_be_contacted = "El webmaster puede contactar por correo electrónico usando este enlace:" 
Const lg_phrase_website_title = "Por favor, introduzca su dirección de página web." 
Const lg_register_button_text = "Registro"
Const lg_term_at = "a"
Const lg_term_cancel = "Cancelar Cuenta"
Const lg_term_cancel_account = "Cancelar Cuenta"
Const lg_term_change_password = "Cambiar Contraseña"
Const lg_term_change_password_button_text = "Cambiar Contraseña"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "Ciudad "
Const lg_term_confirm = "Confirmar Contraseña"
Const lg_term_contact = "Contacto"
Const lg_term_contact_form = "Formulario de contacto"
Const lg_term_content_language = "<meta http-equiv=""content-language"" content=""es-MX"" />"
Const lg_term_country = "Paiz"
Const lg_term_current_password = "Contraseña Actual"
Const lg_term_delete_account = "Eliminar cuenta"
Const lg_term_do_registration = "Hace Registración"
Const lg_term_email = "Correo Electrónico"
Const lg_term_enter_information = "Entre la Información"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Ejemplo"
Const lg_term_forbidden = "Prohibido"
Const lg_term_form_error = "Formulario de error"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "Invitado"
Const lg_term_home = "Inicio"
Const lg_term_immediately = "inmediatamente"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "Cuestión de verificación"
Const lg_term_language = "<meta name=""language"" content=""es-MX"" />"
Const lg_term_log_out = "Cierre la sesión"
Const lg_term_log_string = "logLogin"
Const lg_term_logged_out = "Ha salido"
Const lg_term_login = "Login"
Const lg_term_login_success = "Éxito"
Const lg_term_name = "Nombre"
Const lg_term_new_password = "Nueva Contraseña" 
Const lg_term_optional = "Opcional"
Const lg_term_or = "o"
Const lg_term_password = "contraseña"
Const lg_term_please_login = "Por favor, Iniciarse"
Const lg_term_please_register = "Por favor Registro"
Const lg_term_project_home_link = "<a title=""Nombre del sistema en Google Code"" href=""http://code.google.com/p/loginsystem-rd/"">http://code.google.com/p/loginsystem-rd/</a>"
Const lg_term_recover_password = "Recuperar Contraseña"
Const lg_term_region = "Región"
Const lg_term_register = "Registro"
Const lg_term_register_confirmation = "Confirmación de Registro"
Const lg_term_register_delete_enter_email = "Ponga Correo Electrónico"
Const lg_term_registration = "Registro"
Const lg_term_registration_thankyou = "Gracias Por Registrarse."
Const lg_term_registration_verification = "Verificación de Registrado"
Const lg_term_remember = true
Const lg_term_rememberme = "Recuerdame"
Const lg_term_remove_registration = "Eliminar registro"
Const lg_term_required = "obligatorio"
Const lg_term_reset_password = "Contraseña Reajustar" 
Const lg_term_set_new_password = "introducir una nueva contraseña" 
Const lg_term_set_newpassword = "changePassword"
Const lg_term_submit = "Enviar"
Const lg_term_to = "A"
Const lg_term_useragent = "Useragent"
Const lg_term_userid = "Nobre de usuario"
Const lg_term_via_email = "por correo electrónico a"
Const lg_term_webloginproject_link = "<a title=""Proyecto Web Login"" href=""http://www.webloginproject.com/index.php"">Proyecto Web Login</a>"
Const lg_term_website = "sitio web"
Const lg_term_website_address = "Dirección del sitio web"
Const lg_term_welcome = "Bienvenido"
Const lg_term_xhtml_xmlns = "<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""es"" lang=""es"">"
%>
