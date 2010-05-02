<%
'* $Id: loginGlobalsFracais.asp 201 2010-04-28 09:43:15Z rdivilbiss $
'*******************************************************************************************************************
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
'* Modification: 07 FEB 2010 :: VGR - translation to French/Francais
'* Modification: 07 FEB 2010 :: Rod Divilbiss - added MS SQL and MySql Constants.
'* Modification: 20 FEB 2010 :: Rod Divilbiss - added missing lg_phrase_registration_mail0
'* Modification: 13 FEB 2010 :: Rod Divilbiss - set new password Constants added.
'*
'* Version:  28 APR 2010 - alpha 0.1c - French - ASP
'*******************************************************************************************************************
Dim lg_filename
lg_filename = Trim(Mid(Request.ServerVariables("SCRIPT_NAME"),InStrRev(Request.ServerVariables("SCRIPT_NAME"),"/")+1,99))
'******************************************************************************************************************
Const lg_cancel_account_page = "cancel_account.asp"
Const lg_change_password_page = "change_password.asp"
'*****************************************************************************************************************
'* contact is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'*****************************************************************************************************************
Const lg_contact_form = "/login-system/contact.asp"
Const lg_copyright = "&copy; 2010 EE Collaborative Login System http://www.webloginproject.com"
Const lg_domain = "www.example.com"
Const lg_domain_secure = "www.example.com"
'*****************************************************************************************************************
'* forbidden is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'*****************************************************************************************************************
Const lg_forbidden = "/login-system/forbidden.asp"
'*****************************************************************************************************************
'* form error is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'*****************************************************************************************************************
Const lg_form_error = "/login-system/form_error.asp"
'*****************************************************************************************************************
'* home page is not part of the login-system. Must specify the entire path possibly outside of the login-system.
'*****************************************************************************************************************
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
Const lg_webmaster_email = "webmaster@example.com"
Const lg_webmaster_email_link = "<a href=""mailto:webmaster@example.com"">Ouaibemestre</a>"

'*********************************************************************
'* Login system database globals
'*********************************************************************
Const lg_database = "access"
'Const lg_database = "mysql"
'Const lg_database = "mssql"

'Const lg_term_command_string = "Provider=SQLOLEDB; Server=localhost,1433; UID=webuser; PWD=password; Database=loginproject"
Const lg_term_command_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='c:\inetpub\wwwroot\login-system\database\login_system.mdb'"
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

'*********************************************************************
'* Login system language globals
'*********************************************************************
Const lg_login_button_text = "Connexion"
Const lg_register_button_text = "Inscription"
Const lg_term_at = "à"
Const lg_term_cancel = "Annuler"
Const lg_term_cancel_account = "Supprimer Mon Compte"
Const lg_term_change_password = "Changer le mot de passe"
Const lg_term_change_password_button_text = "Changer le mot de passe"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "Ville"
Const lg_term_confirm = "Confirmer le mot de passe"
Const lg_term_contact_form = "Formulaire de contact"
Const lg_term_country = "Pays"
Const lg_term_current_password = "Mot de passe actuel"
Const lg_term_delete_account = "Supprimer le compte"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "Mél"
Const lg_term_enter_information = "Entrez l'information"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Exemple"
Const lg_term_from_error = "Formulaire d'erreur"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "Invité"
Const lg_term_home = "Commencer"
Const lg_term_immediately = "immédiatement"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "question de la vérification par jeton"
Const lg_term_log_string = "logLogin"
Const lg_term_log_out = "Déconnectez-vous"
Const lg_term_logged_out = "Déconnecté"
Const lg_term_login = "Login"
Const lg_term_login_success = "Succès"
Const lg_term_name = "Nom"
Const lg_term_new_password = "Nouveau mot de passe"
Const lg_term_optional = "facultatif"
Const lg_term_or = "ou"
Const lg_term_password = "Mot de passe"
Const lg_term_please_login = "Identifiez-vous s'il vous plaît"
Const lg_term_please_register = "enregistrez-vous s'il vous plaît"
Const lg_term_recover_password = "Mot de passe oublié"
Const lg_term_region = "Région"
Const lg_term_register = "S'enregistrer"
Const lg_term_register_confirmation = "Confirmation d'inscription"
Const lg_term_register_delete_enter_email = "Entrez une adresse mél"
Const lg_term_registration = "Enregistrement"
Const lg_term_registration_thankyou = "Merci d'avoir demandé"
Const lg_term_registration_verification = "Enregistrement de vérification"
Const lg_term_remember = true
Const lg_term_rememberme = "Se souvenir de moi"
Const lg_term_remove_registration = "Supprimer l'enregistrement"
Const lg_term_reset_password = "Mot de passe oublié"
Const lg_term_required = "nécessaire"
Const lg_term_set_new_password = "Entrez un nouveau mot de passe"
Const lg_term_set_newpassword = "changePassword"
Const lg_term_submit = "Valider"
Const lg_term_to = "A"
Const lg_term_useragent = "Useragent"
Const lg_term_userid = "Identifiant"
Const lg_term_via_email = "par mél à"
Const lg_term_website = "site internet"
Const lg_term_website_address = "Adresse du site internet"
Const lg_term_welcome = "Accueil"
Const lg_phrase_attention_webmaster = "Attention Ouaibemestre"
Const lg_phrase_cancel_account_canceled = "Le compte a été annulé."
Const lg_phrase_cancel_account_error = "Il y a eu une erreur inattendue lors de l'annulation de votre compte. S'il vous plaît contactez le ouaibemestre."
Const lg_phrase_cancel_account_warning = "Entrez votre identifiant et votre mot de passe pour supprimer votre compte.<p>AVERTISSEMENT: Cette action ne peut pas être annulée.</p>Si vous avez oublié votre mot de passe utilisez le lien ""Mot de passe oublié"" ci-dessous."
Const lg_phrase_change_password = "Entrez votre mot de passe actuel, puis votre nouveau mot de passe souhaité."
Const lg_phrase_confirm_empty = "Le champ Confirmer le mot de passe est vide, mais est nécessaire. S'il vous plaît confirmez votre mot de passe."
Const lg_phrase_confirm_title = "S'il vous plaît confirmez votre mot de passe souhaité. Ce champ est requis."
Const lg_phrase_contact_webmaster = "contact avec le ouaibemestre"
Const lg_phrase_delete_account = "Supprimer le compte"
Const lg_phrase_delete_already_verified = "Le compte a déjà été vérifiée et ne pouvait pas être supprimé"
Const lg_phrase_delete_deleted = "Le compte a été supprimé"
Const lg_phrase_email_empty = "Le champ Mél est vide, mais est nécessaire. S'il vous plaît, entrez votre adresse mél."
Const lg_phrase_email_title = "S'il vous plaît, entrez votre adresse mél. Ce champ est requis."
Const lg_phrase_enter_set_new_password_token = "entrer nouveau mot de passe jeton"
Const lg_phrase_enter_unlock_code = "Entrer le code de déblocage"
Const lg_phrase_is_logged_in = "est enregistré dans"
Const lg_phrase_issue_new_token = "Entrez vos nom d'utilisateur et mél pour recevoir un nouveau jeton de contrôle."
Const lg_phrase_issue_new_token_error = "Il y a eu une erreur inattendue de la génération du jeton de contrôle. S'il vous plaît contactez le ouaibemestre."
Const lg_phrase_issue_new_token_success = "Votre nouvelle vérification va vous être envoyée à votre adresse mél."
Const lg_phrase_login_error = "Il y a eu une erreur. S'il vous plaît saisissez à nouveau vos identifiant utilisateur et mot de passe."
Const lg_phrase_login_error_token = "Vous devez valider votre adresse e-mail en utilisant le jeton que vous ont été envoyés avant que vous puissiez connecter!"
Const lg_phrase_login_token_problem = "Soit le jeton de contrôle a été utilisé (et revu), ou le caractère n'est pas valide."
Const lg_phrase_logged_out = "Vous êtes déconnecté."
Const lg_phrase_logout_continue = "Cliquez ici pour continuer."
Const lg_phrase_name_empty = "Le champ Nom est vide, mais est nécessaire. Veuillez saisir votre nom."
Const lg_phrase_name_title = "S'il vous plaît entrer votre nom complet. Ce champ est requis."
Const lg_phrase_newpassword_empty = "Le champ Nouveau mot de passe est vide, mais est nécessaire. Veuillez entrer votre mot de passe."
Const lg_phrase_news = "Voulez-vous recevoir régulièrement par mél une notification des modifications du site Web ou des nouveaux articles affichés?"
Const lg_phrase_no_matching_registration = "Il n'existe pas d'enregistrement correspondant à l'identifiant utilisateur et adresse mél saisis."
Const lg_phrase_oldpassword_does_not_match = "Le mot de passe actuel ne correspond pas à votre mot de passe stocké. Réessayez."
Const lg_phrase_oldpassword_empty = "Le champ Ancien mot de passe est vide, mais est nécessaire. Veuillez saisir votre mot de passe."
Const lg_phrase_oldpassword_title = "S'il vous plaît saisissez votre mot de passe actuel. Ce champ est requis."
Const lg_phrase_password_change_authorized = "Si vous n'avez pas autorisé ce changement, s'il vous plaît contactez le ouaibemestre"
Const lg_phrase_password_changed = "Votre mot de passe a été modifié."
Const lg_phrase_password_changed_error = "Il y a eu une erreur inattendue. Le mot de passe n'a pas changé. S'il vous plaît contactez le ouaibemestre"
Const lg_phrase_password_changed_okay = "Mot de passe changé avec succès."
Const lg_phrase_password_changed_post = "a été changé à"
Const lg_phrase_password_changed_pre = "Votre mot de passe à"
Const lg_phrase_password_empty = "Le champ Mot de passe est vide, mais est nécessaire. Veuillez le saisir."
Const lg_phrase_password_new_title = "S'il vous plaît entrez votre mot de passe souhaité. Ce champ est requis."
Const lg_phrase_password_nomatch_confirm = "Le mot de passe ne correspondent pas du mot de passe Confirmation. S'il vous plaît resaisissez."
Const lg_phrase_password_title = "S'il vous plaît entrer votre mot de passe. Ce champ est requis."
Const lg_phrase_recaptcha_error = "Le reCAPTCHA n'a pas été entré correctement."
Const lg_phrase_register_delete_noemail = "Il n'y avait pas de compte correspondant à l'adresse mél que vous avez entré."
Const lg_phrase_registration_email_verify = "Vérifier Votre Adresse mél"
Const lg_phrase_registration_email_verify_msg = "Un mél a été envoyé à l'adresse fournie lors de votre inscription. Cliquez sur le lien contenu dans ce mél, ou copiez et collez le code de déverrouillage dans le champ de formulaire ci-dessous. Votre compte ne sera pas disponible tant qu'il n'aura pas été vérifié."
Const lg_phrase_registration_error = "Il ya eu une erreur inattendue lors de votre inscription. S'il vous plaît contactez le ouaibemestre"
Const lg_phrase_registration_mail0 = "a publié le nouveau jeton de contrôle d'enregistrement"
Const lg_phrase_registration_mail1 = "Merci pour votre inscription à"
Const lg_phrase_registration_mail2 = "Avant que vous puissiez vous connectez il est nécessaire"
Const lg_phrase_registration_mail3 = "afin de vérifier votre adresse mél."
Const lg_phrase_registration_mail4 = "Cliquez ici pour vérifier"
Const lg_phrase_registration_mail5 = "mél à l'adresse électronique suivante"
Const lg_phrase_registration_mail6 = "copier et coller le jeton dans le formulaire ci-dessous et cliquez sur ""Soumettre"""
Const lg_phrase_registration_mail7 = "Si vous ne vous enregistrez pas, cliquez sur"
Const lg_phrase_registration_mail8 = "ce lien: <a href =""http://"
Const lg_phrase_registration_mail9 = "si vous avez des questions, puis <a href =""http://"
Const lg_phrase_registration_success = "Enregistrement réussi"
Const lg_phrase_remember_me_warning = "Ne pas utiliser ""se souvenir de moi"" s'il s'agit d'un ordinateur partagé."
Const lg_phrase_user_registration = "Enregistrement de l'utilisateur"
Const lg_phrase_userid_empty = "Le champ identifiant utilisateur est requis, mais est vide. Saisissez-le."
Const lg_phrase_userid_inuse = "L'identifiant utilisateur est en cours d'utilisation ou non valide."
Const lg_phrase_userid_new_title = "S'il vous plaît entrer votre identifiant utilisateur souhaité. Ce champ est requis."
Const lg_phrase_userid_title = "S'il vous plaît entrez votre nom d'utilisateur. Ce champ est requis."
Const lg_phrase_verify_expired = "Plus de 24 heures ont passé depuis votre inscription."
Const lg_phrase_verify_login = "Vous pouvez maintenant vous connecter à votre compte."
Const lg_phrase_verify_newtoken = "Cliquez ici pour générer un nouveau code de déverrouillage."
Const lg_phrase_verify_verified = "Vous avez validé votre adresse mél."
Const lg_phrase_website_title = "S'il vous plaît entrer votre adresse de site Web."
Const lg_phrase_recover_password = "Récupérer le mot de passe"
Const lg_phrase_request_password1 = "Une demande a été faite pour récupérer votre mot de passe à"
Const lg_phrase_recover_password2 = "Vous pouvez définir un nouveau mot de passe en cliquant sur le lien ci-dessous."
Const lg_phrase_recover_password3 = "Définir le nouveau mot de passe"
Const lg_phrase_recover_password4 = "Si vous n'avez pas demandé à récupérer votre mot de passe, contactez le ouaibemestre par"
Const lg_phrase_recover_password5 = "email à l'adresse électronique suivante"
Const lg_phrase_recover_password_error = "Il y a eu une erreur inattendue du traitement de votre demande. S'il vous plaît contactez le ouaibemestre."
Const lg_phrase_recover_password_success = "La requête pour récupérer votre mot de passe a été générée avec succès.<p>S'il vous plaît suivez les instructions dans le mél qui vous a été envoyé afin de fixer un nouveau mot de passe.</p>"
Const lg_phrase_set_new_password_good_token = "Votre jeton était valide. Entrez un nouveau mot de passe."
Const lg_phrase_set_new_password_token_expired = "Plus de 24 heures ont passé depuis que vous avez demandé une récupération de mot de passe (jeton de sécurité expiré)."
Const lg_phrase_contact_webmaster1 = "S'il vous plaît contactez le ouaibemestre pour l'assistance."
Const lg_phrase_webmaster_may_be_contacted = "Le ouaibemestre peut être contacté par mél en utilisant le lien suivant:"
Const lg_phrase_set_new_password_error = "Il y a eu une erreur inattendue lors de votre demande."
Const lg_phrase_set_new_password_success = "Votre mot de passe a été changé."
%>
