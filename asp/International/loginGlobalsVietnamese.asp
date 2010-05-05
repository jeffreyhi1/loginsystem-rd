<%
'* $Id: loginGlobalsVietnamese.asp 201 2010-04-28 09:43:15Z rdivilbiss $
'********************************************************************************************************************
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
'* Modification: 07 FEB 2010 :: VGR - translation to French
'* Modification: 07 FEB 2010 :: Rod Divilbiss - added MS SQL and MySql Constants.
'* Modification: 20 FEB 2010 :: Rod Divilbiss - added missing lg_phrase_registration_mail0
'* Modification: 13 FEB 2010 :: Rod Divilbiss - set new password Constants added.
'*
'* Version: alpha 0.1ca - Vietnamese - ASP
'*******************************************************************************************************************
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
Const lg_useSSL = true
Const lg_debug = false
Const lg_verify_page = "register_verify.asp"
Const lg_webmaster_email = "webmaster@example.com"
Const lg_webmaster_email_link = "<a href=""mailto:webmaster@example.com"">Web người chủ</a>"

'**********************************************************************
'* Login system database globals
'**********************************************************************
'Const lg_database = "access"
'Const lg_database = "mysql"
'Const lg_database = "mssql"

'Const lg_term_command_string = "Provider=SQLOLEDB; Server=localhost,1433; UID=webuser; PWD=password; Database=loginproject"
'Const lg_term_command_string = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source='c:\inetpub\wwwroot\login-system\database\login_system.mdb'"
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

'**********************************************************************
'* Login system language globals
'**********************************************************************
Const lg_login_button_text = "Đăng nhập"
Const lg_register_button_text = "Đăng ký"
Const lg_term_at = "tại"
Const lg_term_cancel = "Hủy bỏ tài khoản"
Const lg_term_cancel_account = "Hủy bỏ tài khoản"
Const lg_term_change_password = "Thay đổi mật khẩu"
Const lg_term_change_password_button_text = "Thay đổi mật khẩu"
Const lg_term_checkToken = "checkToken"
Const lg_term_city = "Thành phố"
Const lg_term_confirm = "Đánh lại mật khẩu"
Const lg_term_contact_form = "Mẫu liên hệ"
Const lg_term_country = "Quốc gia"
Const lg_term_current_password = "Mật khẩu hiện tại"
Const lg_term_delete_account = "Tài khoản xóa"
Const lg_term_do_registration = "doRegistration"
Const lg_term_email = "Thư điện tử"
Const lg_term_enter_information = "Nhập thông tin"
Const lg_term_error_string = "getPasshash"
Const lg_term_example = "Ví dụ"
Const lg_term_from_error = "cách tao nhã lỗi"
Const lg_term_get_name = "getName"
Const lg_term_get_oldpassword = "getOldPassword"
Const lg_term_guest = "tôn vinh khách."
Const lg_term_home = "Trang Chủ"
Const lg_term_immediately = "ngay lập tức"
Const lg_term_ip = "IP"
Const lg_term_issue_verification_token = "Lấy mã xác minh"
Const lg_term_log_string = "logLogin"
Const lg_term_log_out = " Đăng xuất"
Const lg_term_logged_out = "Thoát khỏi tài khoản"
Const lg_term_login = "Đăng nhập"
Const lg_term_login_success = "Thành công"
Const lg_term_name = "Tên"
Const lg_term_new_password = "Mật khẩu mới"
Const lg_term_optional = "tùy chọn"
Const lg_term_or = "hoặc"
Const lg_term_password = "Mật khẩu"
Const lg_term_please_login = "Vui lòng đăng nhập"
Const lg_term_please_register = "Hãy đăng ký"
Const lg_term_recover_password = "Khôi phục mật khẩu"
Const lg_term_region = "Vùng"
Const lg_term_register = "Đăng ký"
Const lg_term_register_confirmation = "Xác nhận đăng ký"
Const lg_term_register_delete_enter_email = "Nhập thư điện tử"
Const lg_term_registration = "Đăng ký"
Const lg_term_registration_thankyou = "Cảm ơn bạn đã đăng ký."
Const lg_term_registration_verification = "Đăng ký xác nhận"
Const lg_term_remember = true
Const lg_term_rememberme = "Nhớ đăng nhập của tôi"
Const lg_term_remove_registration = "Hủy bỏ đăng ký"
Const lg_term_required = "Được yêu cầu"
Const lg_term_reset_password = " Mật khẩu sự chứa"
Const lg_term_set_new_password = " Tạo mật khẩu mới "
Const lg_term_set_newpassword = "changePassword"
Const lg_term_submit = "Gửi"
Const lg_term_to = "Đến"
Const lg_term_useragent = "Useragent"
Const lg_term_userid = "Tên truy nhập"
Const lg_term_via_email = "bằng thư điện tử"
Const lg_term_website = "Trang web"
Const lg_term_website_address = "Địa chỉ website"
Const lg_term_welcome = "Chào mừng"
Const lg_phrase_attention_webmaster = "Chú ý cho web người chủ"
Const lg_phrase_cancel_account_canceled = "Tài khoản đã được hủy bỏ."
Const lg_phrase_cancel_account_error = "Có một lỗi bất ngờ không thể hủy bỏ tài khoản của bạn. Xin vui lòng liên lạc với web người chủ."
Const lg_phrase_cancel_account_warning = "Cảnh báo! Tài khoản của bạn không bao giờ có thể được phục hồi."
Const lg_phrase_change_password = "Nhập mật khẩu hiện tại của bạn, sau đó nhập mật khẩu mới của bạn."
Const lg_phrase_confirm_empty = "Các lĩnh vực xác nhận mật khẩu là trống rỗng, nhưng là bắt buộc. Xin hãy xác nhận lại mật khẩu."
Const lg_phrase_confirm_title = "Hãy xác nhận mật khẩu mong muốn của bạn. Lĩnh vực này là bắt buộc."
Const lg_phrase_contact_webmaster = "Liên lạc với web người chủ."
Const lg_phrase_delete_account = "Xóa tài khoản"
Const lg_phrase_delete_already_verified = "Tài khoản đã được xác minh và không thể xóa."
Const lg_phrase_delete_deleted = "Tài khoản đã bị xoá"
Const lg_phrase_email_empty = "Trường thư điện tử là trống rỗng, nhưng là bắt buộc. Xin vui lòng nhập địa chỉ thư điện tử của bạn."
Const lg_phrase_email_title = "Hãy nhập địa chỉ thư điện tử của bạn. Lĩnh vực này là bắt buộc."
Const lg_phrase_enter_set_new_password_token = "nhập mã số thiết lập mật khẩu mới"
Const lg_phrase_enter_unlock_code = "Nhập mã số mở khóa"
Const lg_phrase_is_logged_in = " đã đăng nhập"
Const lg_phrase_issue_new_token = "Nhập tên truy nhập và địa chỉ thư điện tử của bạn để nhận được một mã thông báo xác minh mới."
Const lg_phrase_issue_new_token_error = "Có một lỗi không mong muốn tạo ra mã xác minh của bạn. Xin vui lòng liên lạc với web người chủ."
Const lg_phrase_issue_new_token_success = "Mã xác minh mới sẽ được gửi đến địa chỉ thư điện tử của bạn."
Const lg_phrase_login_error = "Có một lỗi. Vui lòng nhập lại tên truy nhập và mật khẩu của bạn."
Const lg_phrase_login_error_token = "Bạn phải xác nhận địa chỉ email của bạn bằng cách sử dụng mã thông báo bạn đã được gửi trước khi bạn có thể đăng nhập."
Const lg_phrase_login_token_problem = "Hoặc là mã xác minh đã được sử dụng, và bạn được xác minh; hoặc mã xác minh là không hợp lệ."
Const lg_phrase_logged_out = "Bạn đang đăng xuất."
Const lg_phrase_logout_continue = "Nhấp vào đây để tiếp tục."
Const lg_phrase_name_empty = "Các trường tên là trống rỗng, nhưng là bắt buộc. Hãy nhập tên của bạn."
Const lg_phrase_name_title = "Hãy nhập tên của bạn. Lĩnh vực này là bắt buộc."
Const lg_phrase_newpassword_empty = "Mật khẩu mới là trống, nhưng là bắt buộc. Xin vui lòng nhập mật khẩu mới."
Const lg_phrase_news = "Bạn có muốn nhận định kỳ bằng thư điện tử khi những thay đổi trang web hoặc bài viết mới được đăng."
Const lg_phrase_no_matching_registration = " Không có đăng ký được kết hợp với tên người dùng và địa chỉ email bạn đã nhập."
Const lg_phrase_oldpassword_does_not_match = "Mật khẩu hiện hành không phù hợp với mật khẩu của bạn được lưu trữ. Hãy thử lại."
Const lg_phrase_oldpassword_empty = " Mật khẩu hiện tại là trống, nhưng là bắt buộc. Xin vui lòng nhập mật khẩu hiện tại của bạn."
Const lg_phrase_oldpassword_title = "Hãy nhập mật khẩu hiện tại của bạn. Lĩnh vực này là bắt buộc."
Const lg_phrase_password_change_authorized = "Nếu bạn không cho phép thay đổi này, xin vui lòng liên lạc với web người chủ"
Const lg_phrase_password_changed = "Mật khẩu của bạn đã được thay đổi."
Const lg_phrase_password_changed_error = "Có một lỗi bất ngờ. Mật khẩu này được không thay đổi. Xin vui lòng liên lạc với web người chủ."
Const lg_phrase_password_changed_okay = "thay đổi mật khẩu thành công."
Const lg_phrase_password_changed_post = "đã được thay đổi tại."
Const lg_phrase_password_changed_pre = "mật khẩu của bạn tại."
Const lg_phrase_password_empty = " Lĩnh vực mật khẩu được yêu cầu nhưng bỏ trống. Hãy nhập mật khẩu của bạn."
Const lg_phrase_password_new_title = "Hãy nhập mật khẩu của bạn mong muốn. Lĩnh vực này là bắt buộc."
Const lg_phrase_password_nomatch_confirm = "The Mật khẩu không khớp với mật khẩu xác nhận. Vui lòng nhập lại."
Const lg_phrase_password_title = "Hãy nhập mật khẩu của bạn. Lĩnh vực này là bắt buộc."
Const lg_phrase_recaptcha_error = "reCAPTCHA đã không được nhập chính xác."
Const lg_phrase_register_delete_noemail  = "Không có tài khoản phù hợp với địa chỉ thư điện tử bạn đã nhập."
Const lg_phrase_registration_email_verify = "Xác minh địa chỉ thư điện tử của bạn."
Const lg_phrase_registration_email_verify_msg = " Một thư điện tử đã được gửi đến địa chỉ thư điện tử mà bạn cung cấp trong quá trình đăng ký. Nhấp vào liên kết trong thư điện tử đó hoặc sao chép và dán mã mở khóa vào trường mẫu dưới đây. Tài khoản của bạn sẽ không có sẵn cho đến khi nó đã được xác minh."
Const lg_phrase_registration_error = "Có một lỗi bất ngờ hoàn tất đăng ký của bạn. Xin vui lòng liên lạc với web người chủ."
Const lg_phrase_registration_mail0 = "Ngày cấp mới đăng ký Mã xác nhận."
Const lg_phrase_registration_mail1 = "Cảm ơn bạn đã đăng ký tại "
Const lg_phrase_registration_mail2 = "Trước khi có thể đăng nhập, bạn cần phải."
Const lg_phrase_registration_mail3 = "xác nhận địa chỉ  thư điện tử."
Const lg_phrase_registration_mail4 = "Nhấn vào Đây Để Xác nhận"
Const lg_phrase_registration_mail5 = "Nếu liên kết ở trên không hoạt động, đi đến <p>http://"
Const lg_phrase_registration_mail6 = "sao chép và dán mã thông báo dưới đây vào các biểu mẫu và bấm vào ""Đăng ký """
Const lg_phrase_registration_mail7 = "Nếu bạn chưa đăng ký, bấm vào"
Const lg_phrase_registration_mail8 = "liên kết này: <a href =""http://"
Const lg_phrase_registration_mail9 = " nếu bạn có bất kỳ câu hỏi nào xin <a href =""http://"
Const lg_phrase_registration_success = "Đăng ký thành công."
Const lg_phrase_remember_me_warning = "Đừng chọn (nhớ tôi) nếu bạn đang sử dụng máy tính công cộng."
Const lg_phrase_user_registration = "Đăng ký người dùng"
Const lg_phrase_userid_empty = "Lĩnh vực tên truy nhập được yêu cầu nhưng bỏ trống. Hãy nhập tên truy nhập của bạn."
Const lg_phrase_userid_inuse = "Nhận dạng người dùng đang sử dụng hoặc không hợp lệ."
Const lg_phrase_userid_new_title = "Hãy nhập mong muốn của bạn Tên truy nhập lĩnh vực này là cần thiết."
Const lg_phrase_userid_title = "Hãy nhập userid của bạn. Lĩnh vực này là bắt buộc."
Const lg_phrase_verify_expired = "Hơn 24 hors đã trôi qua kể từ khi đăng ký của bạn."
Const lg_phrase_verify_login = "Bây giờ bạn có thể đăng nhập vào tài khoản của bạn."
Const lg_phrase_verify_newtoken = "Nhấp vào đây để tạo mới mở khóa mã"
Const lg_phrase_verify_verified = "Bạn đã xác minh địa chỉ thư điện tử của bạn."
Const lg_phrase_website_title = "Hãy nhập địa chỉ trang web của bạn."
Const lg_phrase_recover_password = "Khôi phục mật khẩu"
Const lg_phrase_request_password1 = "Một yêu cầu đã được thực hiện để phục hồi mật khẩu của bạn tại"
Const lg_phrase_recover_password2 = "Bạn có thể thiết lập một mật khẩu mới bằng cách nhấp vào liên kết bên dưới."
Const lg_phrase_recover_password3 = "Đặt mật khẩu"
Const lg_phrase_recover_password4 = "Nếu bạn không yêu cầu để khôi phục mật khẩu của bạn, xin liên lạc với web người chủ bởi."
Const lg_phrase_recover_password5 = "thư điện tử tại liên kết thư điện tử sau"
Const lg_phrase_recover_password_error = "Có một lỗi không mong muốn xử lý yêu cầu của bạn Xin vui lòng liên lạc với web người chủ."
Const lg_phrase_recover_password_success = "Yêu cầu khôi phục mật khẩu của bạn đã được xử lý thành công.<p>Hãy làm theo hướng dẫn trong thư điện tử gửi đến để thiết lập mật khẩu mới.</p>"
Const lg_phrase_set_new_password_good_token = "Là mã thông báo của bạn hợp lệ. Nhập một mật khẩu mới."
Const lg_phrase_set_new_password_token_expired = "Nhiều hơn 24 giờ đã trôi qua kể từ khi bạn yêu cầu một mật khẩu thu hồi mã thông báo."
Const lg_phrase_contact_webmaster1 = "Xin vui lòng liên lạc với web người chủ để được hỗ trợ."
Const lg_phrase_webmaster_may_be_contacted = "Bộ quản trị web có thể liên lạc bằng thư điện tử bằng cách sử dụng liên kết này:"
Const lg_phrase_set_new_password_error = "Có một lỗi bất ngờ trong hoàn thành yêu cầu của bạn."
Const lg_phrase_set_new_password_success = "Mật khẩu của bạn đã được thay đổi."
%>
