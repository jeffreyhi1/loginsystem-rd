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
* Version: alpha 0.2 - Hindi - PHP
******************************************************************************************************************/
define("lg_cancel_account_page", "cancel_account.php");
define("lg_change_password_page", "change_password.php");
/*****************************************************************************************************************
* contact is not part of the login-system. Must specify the entire path possibly outside of the login-system.
*****************************************************************************************************************/
define("lg_contact_form", "/login-system/contact.php");
define("lg_copyright", "&copy; 2010 EE Collaborative Login System http://www.webloginproject.com");
define("lg_domain", "www.example.com");
define("lg_domain_secure", "www.example.com");
/*****************************************************************************************************************
* forbidden is not part of the login-system. Must specify the entire path possibly outside of the login-system.
*****************************************************************************************************************/
define("lg_forbidden", "/login-system/forbidden.php");
/*****************************************************************************************************************
* form error is not part of the login-system. Must specify the entire path possibly outside of the login-system.
*****************************************************************************************************************/
define("lg_form_error", "/login-system/form_error.php");
/*****************************************************************************************************************
* home page is not part of the login-system. Must specify the entire path possibly outside of the login-system.
*****************************************************************************************************************/
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
define("lg_useSSL", true);
define("lg_debug", false);
define("lg_verify_page", "register_verify.php");
define("lg_webmaster_email", "webmaster@example.com");
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
define("lg_login_button_text", "लॉग इन");
define("lg_register_button_text", "रजिस्टर");
define("lg_term_at", "पर");
define("lg_term_cancel", "खाता रद्द करें");
define("lg_term_cancel_account", "खाता रद्द करें");
define("lg_term_change_password", "पासवर्ड बदलें");
define("lg_term_change_password_button_text", "पासवर्ड बदलें");
define("lg_term_checkToken", "checkToken");
define("lg_term_city", "शहर");
define("lg_term_confirm", "पासवर्ड की पुष्टि करें");
define("lg_term_contact", "संपर्क");
define("lg_term_contact_form", "संपर्क प्रपत्र");
define("lg_term_content_language", "<meta http-equiv=\"content-language\" content=\"hi-IN\" />");
define("lg_term_country", "देश");
define("lg_term_current_password", "वर्तमान पासवर्ड");
define("lg_term_delete_account", "खाता हटाना");
define("lg_term_do_registration", "doRegistration");
define("lg_term_email", "ईमेल");
define("lg_term_enter_information", "जानकारी दर्ज करें");
define("lg_term_error_string", "getPasshash");
define("lg_term_example", "उदाहरण");
define("lg_term_forbidden", "निषिद्ध");
define("lg_term_form_error", "फार्म में त्रुटि");
define("lg_term_from_error", "फार्म में त्रुटि");
define("lg_term_get_name", "getName");
define("lg_term_get_oldpassword", "getOldPassword");
define("lg_term_guest","अतिथि");
define("lg_term_home", "घर");
define("lg_term_immediately", "तुरंत");
define("lg_term_ip", "IP");
define("lg_term_issue_verification_token", "मुद्दा टोकन सत्यापन");
define("lg_term_language", "<meta name=\"language\" content=\"hi-IN\" />");
define("lg_term_log_out","बाहर प्रवेश करें");
define("lg_term_log_string", "logLogin");
define("lg_term_logged_out", "लॉग आउट");
define("lg_term_login", "लॉग इन");
define("lg_term_login_success", "सफलता");
define("lg_term_name", "नाम");
define("lg_term_new_password","नया पासवर्ड");
define("lg_term_optional", "ऐच्छिक");
define("lg_term_or", "या");
define("lg_term_password", "पासवर्ड");
define("lg_term_please_login", "कृपया लॉगिन");
define("lg_term_please_register", "कृपया रजिस्टर");
define("lg_term_project_home_link", "<a title=\"Google कोड पर प्रवेश प्रणाली\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password", "पुनर्प्राप्त पासवर्ड");
define("lg_term_region", "क्षेत्र");
define("lg_term_register", "रजिस्टर");
define("lg_term_register_confirmation", "पंजीकरण की पुष्टि");
define("lg_term_register_delete_enter_email", "ईमेल दर्ज करें");
define("lg_term_registration", "पंजीकरण");
define("lg_term_registration_thankyou", "आप पंजीकरण के लिए धन्यवाद");
define("lg_term_registration_verification", "पंजीकरण सत्यापन");
define("lg_term_remember", true);
define("lg_term_rememberme", "मुझे याद रखें");
define("lg_term_remove_registration", "निकालें पंजीकरण");
define("lg_term_required", "अपेक्षित");
define("lg_term_reset_password", "पासवर्ड रीसेट");
define("lg_term_set_new_password","नया पासवर्ड सेट करें");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_submit", "प्रस्तुत करना");
define("lg_term_to", "से");
define("lg_term_useragent", "Useragent");
define("lg_term_userid", "प्रयोक्ता आईडी");
define("lg_term_via_email", "ईमेल द्वारा पर");
define("lg_term_webloginproject_link", "<a title=\"वेब लॉगिन परियोजना\" href=\"http://www.webloginproject.com/index.php\">वेब लॉगिन परियोजना</a>");
define("lg_term_website","वेबसाइट");
define("lg_term_website_address", "वेबसाइट का पता");
define("lg_term_welcome","आपका स्वागत है");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"hi\" lang=\"hi\">");
define("lg_phrase_attention_webmaster", "वेबमास्टर ध्यान");
define("lg_phrase_cancel_account_canceled", "खाता रद्द कर दिया गया है");
define("lg_phrase_cancel_account_error", "वहाँ एक अप्रत्याशित अपना खाता रद्द त्रुटि थी. कृपया वेबमास्टर से संपर्क");
define("lg_phrase_cancel_account_warning", "अपने प्रयोक्ता आईडी और पासवर्ड दर्ज करने के लिए अपने खाते को रद्द<br>यह कार्रवाई चेतावनी पीछे लौट नहीं सकती<br>यदि आप अपना पासवर्ड भूल गए हैं नीचे दिए गए लिंक को ठीक पासवर्ड का उपयोग");
define("lg_phrase_change_password", "अपने वर्तमान पासवर्ड दर्ज करें, तो अपने इच्छित नया पासवर्ड");
define("lg_phrase_confirm_empty", "पासवर्ड की पुष्टि करें क्षेत्र खाली है, लेकिन आवश्यक है. कृपया अपने पासवर्ड की पुष्टि करें.");
define("lg_phrase_confirm_title", "कृपया अपना इच्छित पासवर्ड की पुष्टि करें. इस फ़ील्ड की आवश्यकता है.");
define("lg_phrase_contact_body", "<p>यह आपकी संपर्क पृष्ठ है. आमतौर पर यह एक रूप होगा. कम से कम आप वेबमास्टर का ईमेल पता प्रदान करना चाहिए.</p>")'
define("lg_phrase_contact_webmaster", "वेबमास्टर से संपर्क");
define("lg_phrase_contact_webmaster1", " सहायता के लिए कृपया वेबमास्टर से संपर्क करें.");
define("lg_phrase_default_body1", "इस साइट के लिए अपनी वेब साइट के डिजाइन में प्रवेश प्रणाली के प्रदर्शन को शामिल बनाया गया था.</p><p>हर वेब साइट को एक टेम्पलेट के रूप में की अवधारणा जा सकता है. एक वेब पेज के सामान्य वर्गों एक बैनर, नेविगेशन, एक मुख्य सामग्री क्षेत्र है, और शायद उपयोग की शर्तें करने के लिए लिंक के साथ एक पाद लेख शामिल हो सकता है टेम्पलेट कॉपीराइट विवरण, और निजता नीति.</p><p>क्षेत्र जहाँ आप अब "" इस पृष्ठ की मुख्य सामग्री क्षेत्र 'में पढ़ रहे हैं. इस जहाँ आप HTML या XHTML मार्कअप डालने जाएगा क्षेत्र है टेम्पलेट्स लॉगिन प्रणाली को सक्रिय करें.</p><p>Google कोड पर परियोजना के घर पर जाएँ:");
define("lg_phrase_default_body2", ".</p><p>या दुनिया में भाषाओं का एक संख्या में विभिन्न डेमो पृष्ठ पर जाएँ");
define("lg_phrase_default_body3", "प्रदर्शन और परीक्षण साइट.</p>");
define("lg_phrase_delete_account", "खाता हटाना");
define("lg_phrase_delete_already_verified", "खाता पहले से सत्यापित किया गया है और नष्ट नहीं किया जा सकता है");
define("lg_phrase_delete_deleted", "खाता हटा दिया गया है");
define("lg_phrase_email_empty", "ईमेल क्षेत्र खाली है, लेकिन आवश्यक है. कृपया अपना ईमेल पता दर्ज करें.");
define("lg_phrase_email_title", "कृपया अपना ईमेल पता दर्ज करें. इस फ़ील्ड की आवश्यकता है.");
define("lg_phrase_enter_set_new_password_token", "नया पासवर्ड दर्ज करें टोकन सेट");
define("lg_phrase_enter_unlock_code", "अनलॉक कोड दर्ज करें");
define("lg_phrase_forbidden_body", "<p><h1>आपको लगता है कि संसाधन के लिए उपयोग नहीं है.</h1></p><p>वेबमास्टर से संपर्क करें पर:");
define("lg_phrase_form_error_cookie",  "कुकीज़ प्रवेश के लिए आवश्यक हैं. आपके ब्राउज़र सुनिश्चित कृपया इस साइट से कुकीज़ को स्वीकार करता है.");
define("lg_phrase_form_error_time", "फार्म पूरा होने से पहले का समय समाप्त हो. में 5 मिनट से कम फार्म पूरा करें.");
define("lg_phrase_form_error_token", "वहाँ एक फार्म में त्रुटि थी. इस का उपयोग कर अपने ब्राउज़र के वापस बटन के एक पहले पूरा फार्म और फिर से इसे भेजने में लौटने के कारण हो सकता है.");
define("lg_phrase_is_logged_in","है में लॉग इन");
define("lg_phrase_issue_new_token", "अपने प्रयोक्ता आईडी और ईमेल दर्ज करें एक नया सत्यापन टोकन प्राप्त करने के लिए");
define("lg_phrase_issue_new_token_error", "वहाँ एक अप्रत्याशित आपकी सत्यापन टोकन पैदा करने में त्रुटि थी. कृपया वेबमास्टर से संपर्क करें.");
define("lg_phrase_issue_new_token_success", "आपका नया टोकन सत्यापन अपने ईमेल पते पर भेज दिया जाएगा.");
define("lg_phrase_logged_out", "तुम बाहर लॉग इन कर रहे हैं.");
define("lg_phrase_login_error", "वहाँ एक त्रुटि थी. कृपया फिर से अपने प्रयोक्ता आईडी और पासवर्ड दर्ज करें.");
define("lg_phrase_login_error_token", "आप अपने ईमेल पते को मान्य टोकन आपको भेजा गया था का उपयोग करने से पहले आप लॉग इन कर सकते अंदर होना चाहिए");
define("lg_phrase_login_token_problem", "सत्यापन प्रयोग किया गया है टोकन या तो, (और आप सत्यापित कर रहे हैं) या टोकन वैध नहीं है.");
define("lg_phrase_logout_continue", "यहाँ क्लिक करें जारी रखने के लिए.");
define("lg_phrase_name_empty", "नाम फ़ील्ड रिक्त है, लेकिन आवश्यक है. कृपया अपना नाम दर्ज करें.");
define("lg_phrase_name_title", "कृपया अपना पूरा नाम प्रविष्ट करें. इस फ़ील्ड की आवश्यकता है.");
define("lg_phrase_newpassword_empty", "नया पासवर्ड फ़ील्ड रिक्त है, लेकिन आवश्यक है. कृपया अपना पासवर्ड दर्ज करें.");
define("lg_phrase_news", "क्या आप आवधिक ईमेल जब वेबसाइट परिवर्तन या नए लेख पोस्ट कर रहे हैं प्राप्त करना चाहते हैं");
define("lg_phrase_no_matching_registration", "कोई प्रयोक्ता आईडी और ईमेल पते से मेल खाते के पंजीकरण था कि तुम में प्रवेश किया.");
define("lg_phrase_oldpassword_does_not_match", "अपने वर्तमान पासवर्ड संग्रहीत पासवर्ड मेल नहीं खाता. दुबारा कोशिश करें.");
define("lg_phrase_oldpassword_empty", "पुराना पासवर्ड फ़ील्ड रिक्त है, लेकिन आवश्यक है. कृपया अपना पासवर्ड दर्ज करें.");
define("lg_phrase_oldpassword_title", "कृपया अपना वर्तमान पासवर्ड दर्ज करें. इस फ़ील्ड की आवश्यकता है.");
define("lg_phrase_password_change_authorized", "यदि आप यह परिवर्तन अधिकृत नहीं किया था, वेबमास्टर से संपर्क करें कृपया");
define("lg_phrase_password_changed", "अपना पासवर्ड बदल गया था");
define("lg_phrase_password_changed_error", " वहाँ एक अप्रत्याशित त्रुटि हुई. पासवर्ड नहीं बदल गया था. कृपया वेबमास्टर से संपर्क ");
define("lg_phrase_password_changed_okay", "पासवर्ड सफलतापूर्वक बदल गया है.");
define("lg_phrase_password_changed_post", " बदल गया था पर ");
define("lg_phrase_password_changed_pre", "अपना पासवर्ड में ");
define("lg_phrase_password_empty", "पासवर्ड क्षेत्र खाली है, लेकिन आवश्यक है. कृपया अपना पासवर्ड दर्ज करें.");
define("lg_phrase_password_new_title", "कृपया अपना इच्छित पासवर्ड दर्ज करें. इस फ़ील्ड की आवश्यकता है.");
define("lg_phrase_password_nomatch_confirm", "पासवर्ड की पुष्टि पासवर्ड मेल नहीं खाता. कृपया फिर से दर्ज करें.");
define("lg_phrase_password_title", "कृपया अपना पासवर्ड दर्ज करें. इस फ़ील्ड की आवश्यकता है.");
define("lg_phrase_recaptcha_error", "ReCAPTCHA सही ढंग से दर्ज नहीं किया था.");
define("lg_phrase_recover_password", "पुनर्प्राप्त पासवर्ड");
define("lg_phrase_recover_password_error", " वहाँ एक अप्रत्याशित आपके अनुरोध प्रसंस्करण त्रुटि थी. कृपया वेबमास्टर से संपर्क करें.");
define("lg_phrase_recover_password_success", " अपना पासवर्ड की वसूली अनुरोध सफलतापूर्वक संसाधित किया गया था.<br>कृपया ईमेल में निर्देशों का पालन करें आप के लिए भेजा करने के लिए एक नया पासवर्ड सेट करें. ");
define("lg_phrase_recover_password2", "आप नीचे दिए लिंक पर क्लिक करके एक नया पासवर्ड सेट कर सकते हैं.");
define("lg_phrase_recover_password3", "नया पासवर्ड सेट करें");
define("lg_phrase_recover_password4", "यदि आप अपने पासवर्ड, वेबमास्टर से संपर्क करें ठीक अनुरोध नहीं किया था ");
define("lg_phrase_recover_password5", "निम्न ईमेल लिंक पर ईमेल ");
define("lg_phrase_register_delete_noemail", "कोई मेल खाता ईमेल पता था कि तुम में प्रवेश किया.");
define("lg_phrase_registration_email_verify", "आपका ईमेल पता सत्यापित करें");
define("lg_phrase_registration_email_verify_msg", "एक ईमेल ईमेल पते पंजीकरण के दौरान प्रदान करने के लिए भेजा गया था. क्लिक करें कि ईमेल या कॉपी और पेस्ट नीचे दिए गए फार्म क्षेत्र में कोड अनलॉक लिंक. अपने खाते में उपलब्ध नहीं हो जब तक यह सत्यापित कर दिया गया है.");
define("lg_phrase_registration_error", "वहाँ एक अप्रत्याशित आपके पंजीकरण पूरा करने में त्रुटि थी. कृपया वेबमास्टर से संपर्क ");
define("lg_phrase_registration_mail0", "जारी नई पंजीकरण टोकन सत्यापन");
define("lg_phrase_registration_mail1", "तुम पर दर्ज करने के लिए धन्यवाद");
define("lg_phrase_registration_mail2", "जरूरत है इससे पहले कि आप आप प्रवेश कर सकते हैं");
define("lg_phrase_registration_mail3", "अपना ईमेल पता सत्यापित करें.");
define("lg_phrase_registration_mail4", "यहाँ क्लिक करें सत्यापित करने के लिए");
define("lg_phrase_registration_mail5", "यदि ऊपर के लिंक काम नहीं करने के लिए जाना है <p>http://");
define("lg_phrase_registration_mail6", "कॉपी और फार्म पर क्लिक करें और नीचे में टोकन पेस्ट \" प्रस्तुत करना \"");
define("lg_phrase_registration_mail7", "अगर आप रजिस्टर, क्लिक नहीं किया");
define("lg_phrase_registration_mail8", "इस कड़ी: <a href=\"http://");
define("lg_phrase_registration_mail9", "यदि आप कोई प्रश्न है तो <a href=\"http://");
define("lg_phrase_registration_success", "पंजीकरण सफल");
define("lg_phrase_remember_me_warning", "चेक मुझे याद है अगर यह एक साझा कंप्यूटर है क्या नहीं.");
define("lg_phrase_request_password1", "एक अनुरोध पर अपने कूटशब्द को पुनः प्राप्त किया गया है ");
define("lg_phrase_set_new_password_error", "वहाँ आपके अनुरोध को पूरा करने में एक अनपेक्षित त्रुटि थी.");
define("lg_phrase_set_new_password_good_token", "आपके टोकन मान्य था. एक नया पासवर्ड दर्ज करें.");
define("lg_phrase_set_new_password_success", "अपना पासवर्ड सफलतापूर्वक बदल गया था.");
define("lg_phrase_set_new_password_token_expired", " 24 घंटे से अधिक समय के बाद से आप एक पासवर्ड टोकन वसूली का अनुरोध बीत चुके हैं.");
define("lg_phrase_user_registration","उपयोगकर्ता पंजीकरण");
define("lg_phrase_userid_empty", "प्रयोक्ता आईडी क्षेत्र की आवश्यकता है, लेकिन खाली है. कृपया अपने प्रयोक्ता आईडी दर्ज करें.");
define("lg_phrase_userid_inuse", "प्रयोक्ता आईडी का उपयोग करें या अमान्य है.");
define("lg_phrase_userid_new_title", "कृपया अपने प्रयोक्ता आईडी दर्ज वांछित. इस फ़ील्ड की आवश्यकता है.");
define("lg_phrase_userid_title", "कृपया अपने userid दर्ज करें. इस फ़ील्ड की आवश्यकता है.");
define("lg_phrase_verify_expired", "24 घंटे से अधिक समय आपके पंजीकरण के बाद से पारित किया है.");
define("lg_phrase_verify_login", "अब आप अपने खाते में प्रवेश कर सकते हैं.");
define("lg_phrase_verify_newtoken", "यहाँ क्लिक करें उत्पन्न एक नया कोड अनलॉक कर देंगे.");
define("lg_phrase_verify_verified", "आप अपने ईमेल पते को सत्यापित किया है.");
define("lg_phrase_webmaster_may_be_contacted", "वेबमास्टर ईमेल द्वारा संपर्क किया जा सकता है इस लिंक का उपयोग: ");
define("lg_phrase_website_title", "कृपया अपनी वेबसाइट के पते दर्ज करें.");
?>