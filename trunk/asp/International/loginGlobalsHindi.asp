﻿<%
'* $Id$
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
'* Version: alpha 0.4 - Hindi - ASP
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
Const lg_login_button_text = "लॉग इन"
Const lg_phrase_attention_webmaster = "वेबमास्टर ध्यान"
Const lg_phrase_cancel_account_canceled = "खाता रद्द कर दिया गया है"
Const lg_phrase_cancel_account_error = "वहाँ एक अप्रत्याशित अपना खाता रद्द त्रुटि थी. कृपया वेबमास्टर से संपर्क"
Const lg_phrase_cancel_account_warning = "अपने प्रयोक्ता आईडी और पासवर्ड दर्ज करने के लिए अपने खाते को रद्द<br>यह कार्रवाई चेतावनी पीछे लौट नहीं सकती<br>यदि आप अपना पासवर्ड भूल गए हैं नीचे दिए गए लिंक को ठीक पासवर्ड का उपयोग"
Const lg_phrase_change_password = "अपने वर्तमान पासवर्ड दर्ज करें, तो अपने इच्छित नया पासवर्ड"
Const lg_phrase_confirm_empty = "पासवर्ड की पुष्टि करें क्षेत्र खाली है, लेकिन आवश्यक है. कृपया अपने पासवर्ड की पुष्टि करें."
Const lg_phrase_confirm_title = "कृपया अपना इच्छित पासवर्ड की पुष्टि करें. इस फ़ील्ड की आवश्यकता है."
Const lg_phrase_contact_body = "<p>यह आपकी संपर्क पृष्ठ है. आमतौर पर यह एक रूप होगा. कम से कम आप वेबमास्टर का ईमेल पता प्रदान करना चाहिए.</p>"
Const lg_phrase_contact_webmaster = "वेबमास्टर से संपर्क"
Const lg_phrase_contact_webmaster1 = " सहायता के लिए कृपया वेबमास्टर से संपर्क करें."
Const lg_phrase_default_body1 = "इस साइट के लिए अपनी वेब साइट के डिजाइन में प्रवेश प्रणाली के प्रदर्शन को शामिल बनाया गया था.</p><p>हर वेब साइट को एक टेम्पलेट के रूप में की अवधारणा जा सकता है. एक वेब पेज के सामान्य वर्गों एक बैनर, नेविगेशन, एक मुख्य सामग्री क्षेत्र है, और शायद उपयोग की शर्तें करने के लिए लिंक के साथ एक पाद लेख शामिल हो सकता है टेम्पलेट कॉपीराइट विवरण, और निजता नीति.</p><p>क्षेत्र जहाँ आप अब "" इस पृष्ठ की मुख्य सामग्री क्षेत्र 'में पढ़ रहे हैं. इस जहाँ आप HTML या XHTML मार्कअप डालने जाएगा क्षेत्र है टेम्पलेट्स लॉगिन प्रणाली को सक्रिय करें.</p><p>Google कोड पर परियोजना के घर पर जाएँ:"
Const lg_phrase_default_body2 = ".</p><p>या दुनिया में भाषाओं का एक संख्या में विभिन्न डेमो पृष्ठ पर जाएँ"
Const lg_phrase_default_body3 = "प्रदर्शन और परीक्षण साइट.</p>"
Const lg_phrase_delete_account = "खाता हटाना"
Const lg_phrase_delete_already_verified = "खाता पहले से सत्यापित किया गया है और नष्ट नहीं किया जा सकता है"
Const lg_phrase_delete_deleted = "खाता हटा दिया गया है"
Const lg_phrase_email_empty = "ईमेल क्षेत्र खाली है, लेकिन आवश्यक है. कृपया अपना ईमेल पता दर्ज करें."
Const lg_phrase_email_title = "कृपया अपना ईमेल पता दर्ज करें. इस फ़ील्ड की आवश्यकता है."
Const lg_phrase_enter_set_new_password_token = "नया पासवर्ड दर्ज करें टोकन सेट"
Const lg_phrase_enter_unlock_code = "अनलॉक कोड दर्ज करें"
Const lg_phrase_forbidden_body = "<p><h1>आपको लगता है कि संसाधन के लिए उपयोग नहीं है.</h1></p><p>वेबमास्टर से संपर्क करें पर:"
Const lg_phrase_form_error_cookie = "कुकीज़ प्रवेश के लिए आवश्यक हैं. आपके ब्राउज़र सुनिश्चित कृपया इस साइट से कुकीज़ को स्वीकार करता है."
Const lg_phrase_form_error_time = "फार्म पूरा होने से पहले का समय समाप्त हो. में 5 मिनट से कम फार्म पूरा करें."
Const lg_phrase_form_error_token = "वहाँ एक फार्म में त्रुटि थी. इस का उपयोग कर अपने ब्राउज़र के वापस बटन के एक पहले पूरा फार्म और फिर से इसे भेजने में लौटने के कारण हो सकता है."
Const lg_phrase_is_logged_in = "है में लॉग इन"
Const lg_phrase_issue_new_token = "अपने प्रयोक्ता आईडी और ईमेल दर्ज करें एक नया सत्यापन टोकन प्राप्त करने के लिए"
Const lg_phrase_issue_new_token_error = "वहाँ एक अप्रत्याशित आपकी सत्यापन टोकन पैदा करने में त्रुटि थी. कृपया वेबमास्टर से संपर्क करें."
Const lg_phrase_issue_new_token_success = "आपका नया टोकन सत्यापन अपने ईमेल पते पर भेज दिया जाएगा."
Const lg_phrase_logged_out = "तुम बाहर लॉग इन कर रहे हैं."
Const lg_phrase_login_error = "वहाँ एक त्रुटि थी. कृपया फिर से अपने प्रयोक्ता आईडी और पासवर्ड दर्ज करें."
Const lg_phrase_login_error_token = "आप अपने ईमेल पते को मान्य टोकन आपको भेजा गया था का उपयोग करने से पहले आप लॉग इन कर सकते अंदर होना चाहिए"
Const lg_phrase_login_token_problem = "सत्यापन प्रयोग किया गया है टोकन या तो, (और आप सत्यापित कर रहे हैं) या टोकन वैध नहीं है."
Const lg_phrase_logout_continue = "यहाँ क्लिक करें जारी रखने के लिए."
Const lg_phrase_name_empty = "नाम फ़ील्ड रिक्त है, लेकिन आवश्यक है. कृपया अपना नाम दर्ज करें."
Const lg_phrase_name_title = "कृपया अपना पूरा नाम प्रविष्ट करें. इस फ़ील्ड की आवश्यकता है."
Const lg_phrase_newpassword_empty = "नया पासवर्ड फ़ील्ड रिक्त है, लेकिन आवश्यक है. कृपया अपना पासवर्ड दर्ज करें."
Const lg_phrase_news = "क्या आप आवधिक ईमेल जब वेबसाइट परिवर्तन या नए लेख पोस्ट कर रहे हैं प्राप्त करना चाहते हैं"
Const lg_phrase_no_matching_registration = "कोई प्रयोक्ता आईडी और ईमेल पते से मेल खाते के पंजीकरण था कि तुम में प्रवेश किया."
Const lg_phrase_oldpassword_does_not_match = "अपने वर्तमान पासवर्ड संग्रहीत पासवर्ड मेल नहीं खाता. दुबारा कोशिश करें."
Const lg_phrase_oldpassword_empty = "पुराना पासवर्ड फ़ील्ड रिक्त है, लेकिन आवश्यक है. कृपया अपना पासवर्ड दर्ज करें."
Const lg_phrase_oldpassword_title = "कृपया अपना वर्तमान पासवर्ड दर्ज करें. इस फ़ील्ड की आवश्यकता है."
Const lg_phrase_password_change_authorized = "यदि आप यह परिवर्तन अधिकृत नहीं किया था, वेबमास्टर से संपर्क करें कृपया"
Const lg_phrase_password_changed = "अपना पासवर्ड बदल गया था"
Const lg_phrase_password_changed_error = " वहाँ एक अप्रत्याशित त्रुटि हुई. पासवर्ड नहीं बदल गया था. कृपया वेबमास्टर से संपर्क "
Const lg_phrase_password_changed_okay = "पासवर्ड सफलतापूर्वक बदल गया है."
Const lg_phrase_password_changed_post = " बदल गया था पर "
Const lg_phrase_password_changed_pre = "अपना पासवर्ड में "
Const lg_phrase_password_empty = "पासवर्ड क्षेत्र खाली है, लेकिन आवश्यक है. कृपया अपना पासवर्ड दर्ज करें."
Const lg_phrase_password_new_title = "कृपया अपना इच्छित पासवर्ड दर्ज करें. इस फ़ील्ड की आवश्यकता है."
Const lg_phrase_password_nomatch_confirm = "पासवर्ड की पुष्टि पासवर्ड मेल नहीं खाता. कृपया फिर से दर्ज करें."
Const lg_phrase_password_title = "कृपया अपना पासवर्ड दर्ज करें. इस फ़ील्ड की आवश्यकता है."
Const lg_phrase_password_too_soon = "यह पासवर्ड फिर से उपयोग नहीं किया जा सकता है. कृपया एक अलग पासवर्ड का चयन करें."
Const lg_phrase_password_too_short_pre = "यह पासवर्ड बहुत छोटा है. है न्यूनतम पासवर्ड लंबाई:"
Const lg_phrase_password_too_short_post = "पत्र, प्रतीक, या संख्या."
Const lg_phrase_password_too_simple = "पासवर्ड बहुत आसान है. एक नया पासवर्ड दर्ज करें कि मुश्किल है. उपयोग यादृच्छिक पत्र, प्रतीक और संख्या."
Const lg_phrase_recaptcha_error = "ReCAPTCHA सही ढंग से दर्ज नहीं किया था."
Const lg_phrase_recover_password = "पुनर्प्राप्त पासवर्ड"
Const lg_phrase_recover_password_error = " वहाँ एक अप्रत्याशित आपके अनुरोध प्रसंस्करण त्रुटि थी. कृपया वेबमास्टर से संपर्क करें."
Const lg_phrase_recover_password_success = " अपना पासवर्ड की वसूली अनुरोध सफलतापूर्वक संसाधित किया गया था.<br>कृपया ईमेल में निर्देशों का पालन करें आप के लिए भेजा करने के लिए एक नया पासवर्ड सेट करें. "
Const lg_phrase_recover_password2 = "आप नीचे दिए लिंक पर क्लिक करके एक नया पासवर्ड सेट कर सकते हैं."
Const lg_phrase_recover_password3 = "नया पासवर्ड सेट करें"
Const lg_phrase_recover_password4 = "यदि आप अपने पासवर्ड, वेबमास्टर से संपर्क करें ठीक अनुरोध नहीं किया था "
Const lg_phrase_recover_password5 = "निम्न ईमेल लिंक पर ईमेल "
Const lg_phrase_register_delete_noemail = "कोई मेल खाता ईमेल पता था कि तुम में प्रवेश किया."
Const lg_phrase_registration_email_verify = "आपका ईमेल पता सत्यापित करें"
Const lg_phrase_registration_email_verify_msg = "एक ईमेल ईमेल पते पंजीकरण के दौरान प्रदान करने के लिए भेजा गया था. क्लिक करें कि ईमेल या कॉपी और पेस्ट नीचे दिए गए फार्म क्षेत्र में कोड अनलॉक लिंक. अपने खाते में उपलब्ध नहीं हो जब तक यह सत्यापित कर दिया गया है."
Const lg_phrase_registration_error = "वहाँ एक अप्रत्याशित आपके पंजीकरण पूरा करने में त्रुटि थी. कृपया वेबमास्टर से संपर्क "
Const lg_phrase_registration_mail0 = "जारी नई पंजीकरण टोकन सत्यापन"
Const lg_phrase_registration_mail1 = "तुम पर दर्ज करने के लिए धन्यवाद"
Const lg_phrase_registration_mail2 = "जरूरत है इससे पहले कि आप आप प्रवेश कर सकते हैं"
Const lg_phrase_registration_mail3 = "अपना ईमेल पता सत्यापित करें."
Const lg_phrase_registration_mail4 = "यहाँ क्लिक करें सत्यापित करने के लिए"
Const lg_phrase_registration_mail5 = "यदि ऊपर के लिंक काम नहीं करने के लिए जाना है <p>http://"
Const lg_phrase_registration_mail6 = "कॉपी और फार्म पर क्लिक करें और नीचे में टोकन पेस्ट \" प्रस्तुत करना \""
Const lg_phrase_registration_mail7 = "अगर आप रजिस्टर, क्लिक नहीं किया"
Const lg_phrase_registration_mail8 = "इस कड़ी: <a href=\"http://"
Const lg_phrase_registration_mail9 = "यदि आप कोई प्रश्न है तो <a href=\"http://"
Const lg_phrase_registration_success = "पंजीकरण सफल"
Const lg_phrase_remember_me_warning = "चेक मुझे याद है अगर यह एक साझा कंप्यूटर है क्या नहीं."
Const lg_phrase_request_password1 = "एक अनुरोध पर अपने कूटशब्द को पुनः प्राप्त किया गया है "
Const lg_phrase_set_new_password_error = "वहाँ आपके अनुरोध को पूरा करने में एक अनपेक्षित त्रुटि थी."
Const lg_phrase_set_new_password_good_token = "आपके टोकन मान्य था. एक नया पासवर्ड दर्ज करें."
Const lg_phrase_set_new_password_success = "अपना पासवर्ड सफलतापूर्वक बदल गया था."
Const lg_phrase_set_new_password_token_expired = " 24 घंटे से अधिक समय के बाद से आप एक पासवर्ड टोकन वसूली का अनुरोध बीत चुके हैं."
Const lg_phrase_user_registration = "उपयोगकर्ता पंजीकरण"
Const lg_phrase_userid_empty = "प्रयोक्ता आईडी क्षेत्र की आवश्यकता है, लेकिन खाली है. कृपया अपने प्रयोक्ता आईडी दर्ज करें."
Const lg_phrase_userid_inuse = "प्रयोक्ता आईडी का उपयोग करें या अमान्य है."
Const lg_phrase_userid_new_title = "कृपया अपने प्रयोक्ता आईडी दर्ज वांछित. इस फ़ील्ड की आवश्यकता है."
Const lg_phrase_userid_title = "कृपया अपने userid दर्ज करें. इस फ़ील्ड की आवश्यकता है."
Const lg_phrase_verify_expired = "24 घंटे से अधिक समय आपके पंजीकरण के बाद से पारित किया है."
Const lg_phrase_verify_login = "अब आप अपने खाते में प्रवेश कर सकते हैं."
Const lg_phrase_verify_newtoken = "यहाँ क्लिक करें उत्पन्न एक नया कोड अनलॉक कर देंगे."
Const lg_phrase_verify_verified = "आप अपने ईमेल पते को सत्यापित किया है."
Const lg_phrase_webmaster_may_be_contacted = "वेबमास्टर ईमेल द्वारा संपर्क किया जा सकता है इस लिंक का उपयोग: "
Const lg_phrase_website_title = "कृपया अपनी वेबसाइट के पते दर्ज करें."
Const lg_register_button_text = "रजिस्टर"
Const lg_term_at = "पर"
Const lg_term_cancel = "खाता रद्द करें"
Const lg_term_cancel_account = "खाता रद्द करें"
Const lg_term_change_password = "पासवर्ड बदलें"
Const lg_term_change_password_button_text = "पासवर्ड बदलें"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "शहर"
Const lg_term_confirm = "पासवर्ड की पुष्टि करें"
Const lg_term_contact = "संपर्क"
Const lg_term_contact_form = "संपर्क प्रपत्र"
Const lg_term_content_language = "<meta http-equiv=""content-language"" content=""hi-IN"" />"
Const lg_term_country = "देश"
Const lg_term_current_password = "वर्तमान पासवर्ड"
Const lg_term_delete_account = "खाता हटाना"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "ईमेल"
Const lg_term_enter_information = "जानकारी दर्ज करें"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "उदाहरण"
Const lg_term_forbidden = "निषिद्ध"
Const lg_term_form_error = "फार्म में त्रुटि"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "अतिथि"
Const lg_term_home = "घर"
Const lg_term_immediately = "तुरंत"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "मुद्दा टोकन सत्यापन"
Const lg_term_language = "<meta name=""language"" content=""hi-IN"" />"
Const lg_term_log_out = "बाहर प्रवेश करें"
Const lg_term_log_string = "logLogin"
Const lg_term_logged_out = "लॉग आउट"
Const lg_term_login = "लॉग इन"
Const lg_term_login_success = "सफलता"
Const lg_term_name = "नाम"
Const lg_term_new_password = "नया पासवर्ड"
Const lg_term_optional = "ऐच्छिक"
Const lg_term_or = "या"
Const lg_term_password = "पासवर्ड"
Const lg_term_please_login = "कृपया लॉगिन"
Const lg_term_please_register = "कृपया रजिस्टर"
Const lg_term_project_home_link = "<a title=""Google कोड पर प्रवेश प्रणाली"" href=""http://code.google.com/p/loginsystem-rd/"">http://code.google.com/p/loginsystem-rd/</a>"
Const lg_term_recover_password = "पुनर्प्राप्त पासवर्ड"
Const lg_term_region = "क्षेत्र"
Const lg_term_register = "रजिस्टर"
Const lg_term_register_confirmation = "पंजीकरण की पुष्टि"
Const lg_term_register_delete_enter_email = "ईमेल दर्ज करें"
Const lg_term_registration = "पंजीकरण"
Const lg_term_registration_thankyou = "आप पंजीकरण के लिए धन्यवाद"
Const lg_term_registration_verification = "पंजीकरण सत्यापन"
Const lg_term_remember = true
Const lg_term_rememberme = "मुझे याद रखें"
Const lg_term_remove_registration = "निकालें पंजीकरण"
Const lg_term_required = "अपेक्षित"
Const lg_term_reset_password = "पासवर्ड रीसेट"
Const lg_term_set_new_password = "नया पासवर्ड सेट करें"
Const lg_term_set_newpassword = "changePassword"
Const lg_term_submit = "प्रस्तुत करना"
Const lg_term_to = "से"
Const lg_term_useragent = "Useragent"
Const lg_term_userid = "प्रयोक्ता आईडी"
Const lg_term_via_email = "ईमेल द्वारा पर"
Const lg_term_webloginproject_link = "<a title=""वेब लॉगिन परियोजना"" href=""http://www.webloginproject.com/index.php"">वेब लॉगिन परियोजना</a>"
Const lg_term_website = "वेबसाइट"
Const lg_term_website_address = "वेबसाइट का पता"
Const lg_term_welcome = "आपका स्वागत है"
Const lg_term_xhtml_xmlns = "<html xmlns=""http://www.w3.org/1999/xhtml"" xml:lang=""hi"" lang=""hi"">"
%>
