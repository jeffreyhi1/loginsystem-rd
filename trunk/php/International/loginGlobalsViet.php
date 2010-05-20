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
* Version: alpha 0.5 - Vietnamese/Tiếng Việt - PHP
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
define("lg_login_button_text","Đăng nhập");
define("lg_phrase_attention_webmaster","Chú ý cho web người chủ");
define("lg_phrase_cancel_account_canceled","Tài khoản đã được hủy bỏ.");
define("lg_phrase_cancel_account_error","Có một lỗi bất ngờ không thể hủy bỏ tài khoản của bạn. Xin vui lòng liên lạc với web người chủ.");
define("lg_phrase_cancel_account_warning","Cảnh báo! Tài khoản của bạn không bao giờ có thể được phục hồi.");
define("lg_phrase_change_password","Nhập mật khẩu hiện tại của bạn, sau đó nhập mật khẩu mới của bạn.");
define("lg_phrase_confirm_empty","Các lĩnh vực xác nhận mật khẩu là trống rỗng, nhưng là bắt buộc. Xin hãy xác nhận lại mật khẩu.");
define("lg_phrase_confirm_title","Hãy xác nhận mật khẩu mong muốn của bạn. Lĩnh vực này là bắt buộc.");
define("lg_phrase_contact_body", "<p>Đây là trang của bạn liên hệ. Thông thường nó sẽ là một hình thức. Ở mức tối thiểu bạn nên cung cấp địa chỉ email của Webmaster.</p>")'
define("lg_phrase_contact_webmaster","Liên lạc với web người chủ.");
define("lg_phrase_contact_webmaster1","Xin vui lòng liên lạc với web người chủ để được hỗ trợ.");
define("lg_phrase_default_body1", "Trang web này được tạo ra để chứng minh tích hợp các hệ thống Đăng nhập vào trong thiết kế trang web của bạn.</p><p>Mỗi trang web có thể được dùng như một bản mẫu. phần thường của một trang web mẫu có thể bao gồm một biểu ngữ, chuyển hướng, nội dung một khu vực chính, và có thể footer một với các liên kết đến Điều khoản sử dụng, chi tiết Bản quyền, và Chính sách Bảo mật.</p><p>Khu vực nơi bạn đang đọc trong &quot;Nội dung chính Diện tích&quot; của trang này. Đây là khu vực nơi bạn sẽ chèn HTML hoặc XHTML đánh dấu các mẫu cho phép các hệ thống đăng nhập.</p><p>Khám phá nhà dự án trên Google Code tại:");
define("lg_phrase_default_body2", ".</p><p>Hoặc truy cập trang demo khác nhau trong một số ngôn ngữ trên thế giới tại");
define("lg_phrase_default_body3", "trình diễn và trang web thử nghiệm.</p>");
define("lg_phrase_delete_account","Xóa tài khoản");
define("lg_phrase_delete_already_verified","Tài khoản đã được xác minh và không thể xóa.");
define("lg_phrase_delete_deleted","Tài khoản đã bị xoá");
define("lg_phrase_email_empty","Trường thư điện tử là trống rỗng, nhưng là bắt buộc. Xin vui lòng nhập địa chỉ thư điện tử của bạn.");
define("lg_phrase_email_title","Hãy nhập địa chỉ thư điện tử của bạn. Lĩnh vực này là bắt buộc.");
define("lg_phrase_enter_set_new_password_token", "nhập mã số thiết lập mật khẩu mới");
define("lg_phrase_enter_unlock_code","Nhập mã số mở khóa");
define("lg_phrase_forbidden_body", "<p><h1>Bạn không có quyền truy cập vào tài nguyên đó.</h1></p><p>Liên hệ với quản trị trang web tại:");
define("lg_phrase_form_error_cookie", "Cookies được yêu cầu để đăng nhập. Xin vui lòng bảo đảm trình duyệt của bạn chấp nhận cookies từ website này.");
define("lg_phrase_form_error_time", "Hình thức quá hạn trước khi hoàn thành. Xin vui lòng điền vào mẫu trong chưa đầy 5 phút.");
define("lg_phrase_form_error_token", "Có một lỗi hình thức. Điều này có thể được gây ra bằng cách sử dụng trình duyệt của bạn trở lại nút để trở về một hình thức trước đây đã hoàn thành và gửi lại nó.");
define("lg_phrase_is_logged_in"," đã đăng nhập");
define("lg_phrase_issue_new_token","Nhập tên truy nhập và địa chỉ thư điện tử của bạn để nhận được một mã thông báo xác minh mới.");
define("lg_phrase_issue_new_token_error","Có một lỗi không mong muốn tạo ra mã xác minh của bạn. Xin vui lòng liên lạc với web người chủ.");
define("lg_phrase_issue_new_token_success","Mã xác minh mới sẽ được gửi đến địa chỉ thư điện tử của bạn.");
define("lg_phrase_logged_out","Bạn đang đăng xuất.");
define("lg_phrase_login_error","Có một lỗi. Vui lòng nhập lại tên truy nhập và mật khẩu của bạn.");
define("lg_phrase_login_error_token","Bạn phải xác nhận địa chỉ email của bạn bằng cách sử dụng mã thông báo bạn đã được gửi trước khi bạn có thể đăng nhập.");
define("lg_phrase_login_token_problem","Hoặc là mã xác minh đã được sử dụng, và bạn được xác minh; hoặc mã xác minh là không hợp lệ.");
define("lg_phrase_logout_continue","Nhấp vào đây để tiếp tục.");
define("lg_phrase_name_empty","Các trường tên là trống rỗng, nhưng là bắt buộc. Hãy nhập tên của bạn.");
define("lg_phrase_name_title","Hãy nhập tên của bạn. Lĩnh vực này là bắt buộc.");
define("lg_phrase_newpassword_empty","Mật khẩu mới là trống, nhưng là bắt buộc. Xin vui lòng nhập mật khẩu mới.");
define("lg_phrase_news","Bạn có muốn nhận định kỳ bằng thư điện tử khi những thay đổi trang web hoặc bài viết mới được đăng.");
define("lg_phrase_no_matching_registration"," Không có đăng ký được kết hợp với tên người dùng và địa chỉ email bạn đã nhập.");
define("lg_phrase_oldpassword_does_not_match","Mật khẩu hiện hành không phù hợp với mật khẩu của bạn được lưu trữ. Hãy thử lại.");
define("lg_phrase_oldpassword_empty"," Mật khẩu hiện tại là trống, nhưng là bắt buộc. Xin vui lòng nhập mật khẩu hiện tại của bạn.");
define("lg_phrase_oldpassword_title","Hãy nhập mật khẩu hiện tại của bạn. Lĩnh vực này là bắt buộc.");
define("lg_phrase_password_change_authorized","Nếu bạn không cho phép thay đổi này, xin vui lòng liên lạc với web người chủ.");
define("lg_phrase_password_changed","Mật khẩu của bạn đã được thay đổi.");
define("lg_phrase_password_changed_error","Có một lỗi bất ngờ. Mật khẩu này được không thay đổi. Xin vui lòng liên lạc với web người chủ.");
define("lg_phrase_password_changed_okay","thay đổi mật khẩu thành công.");
define("lg_phrase_password_changed_post","đã được thay đổi tại.");
define("lg_phrase_password_changed_pre","mật khẩu của bạn tại.");
define("lg_phrase_password_empty"," Lĩnh vực mật khẩu được yêu cầu nhưng bỏ trống. Hãy nhập mật khẩu của bạn.");
define("lg_phrase_password_new_title","Hãy nhập mật khẩu của bạn mong muốn. Lĩnh vực này là bắt buộc.");
define("lg_phrase_password_nomatch_confirm","The Mật khẩu không khớp với mật khẩu xác nhận. Vui lòng nhập lại.");
define("lg_phrase_password_title","Hãy nhập mật khẩu của bạn. Lĩnh vực này là bắt buộc.");
define("lg_phrase_password_too_soon", "Các mật khẩu Các trận đấu của bạn gần đây được sử dụng mật khẩu của bạn. Xin vui lòng chọn một mật khẩu khác nhau.");
define("lg_phrase_password_too_short", "Các mật khẩu có quá ngắn. Các chiều dài mật khẩu tối thiểu là:");
define("lg_phrase_password_too_short", "chữ cái, biểu tượng hoặc chữ số.");
define("lg_phrase_password_too_simple", "Các mật khẩu nhập vào là quá đơn giản. Xin vui lòng nhập một mật khẩu mà gồm ký tự ngẫu nhiên bao gồm một kết hợp chữ cái, biểu tượng hoặc chữ số.");
define("lg_phrase_recaptcha_error", "The reCAPTCHA wasn't entered correctly.");
define("lg_phrase_recover_password","Khôi phục mật khẩu");
define("lg_phrase_recover_password_error","Có một lỗi không mong muốn xử lý yêu cầu của bạn Xin vui lòng liên lạc với web người chủ.");
define("lg_phrase_recover_password_success","Yêu cầu khôi phục mật khẩu của bạn đã được xử lý thành công.<p>Hãy làm theo hướng dẫn trong thư điện tử gửi đến để thiết lập mật khẩu mới.</p>");
define("lg_phrase_recover_password2","Bạn có thể thiết lập một mật khẩu mới bằng cách nhấp vào liên kết bên dưới.");
define("lg_phrase_recover_password3","Đặt mật khẩu");
define("lg_phrase_recover_password4","Nếu bạn không yêu cầu để khôi phục mật khẩu của bạn, xin liên lạc với web người chủ bởi.");
define("lg_phrase_recover_password5","thư điện tử tại liên kết thư điện tử sau");
define("lg_phrase_register_delete_noemail ","Không có tài khoản phù hợp với địa chỉ thư điện tử bạn đã nhập.");
define("lg_phrase_registration_email_verify","Xác minh địa chỉ thư điện tử của bạn.");
define("lg_phrase_registration_email_verify_msg"," Một thư điện tử đã được gửi đến địa chỉ thư điện tử mà bạn cung cấp trong quá trình đăng ký. Nhấp vào liên kết trong thư điện tử đó hoặc sao chép và dán mã mở khóa vào trường mẫu dưới đây. Tài khoản của bạn sẽ không có sẵn cho đến khi nó đã được xác minh.");
define("lg_phrase_registration_error","Có một lỗi bất ngờ hoàn tất đăng ký của bạn. Xin vui lòng liên lạc với web người chủ.");
define("lg_phrase_registration_mail0","Ngày cấp mới đăng ký Mã xác nhận.");
define("lg_phrase_registration_mail1","Cảm ơn bạn đã đăng ký tại ");
define("lg_phrase_registration_mail2","Trước khi có thể đăng nhập, bạn cần phải.");
define("lg_phrase_registration_mail3","xác nhận địa chỉ  thư điện tử.");
define("lg_phrase_registration_mail4","Nhấn vào Đây Để Xác nhận");
define("lg_phrase_registration_mail5","Nếu liên kết ở trên không hoạt động, đi đến http://");
define("lg_phrase_registration_mail6","sao chép và dán mã thông báo dưới đây vào các biểu mẫu và bấm vào \" Đăng ký \"");
define("lg_phrase_registration_mail7","Nếu bạn chưa đăng ký, bấm vào");
define("lg_phrase_registration_mail8","liên kết này: <a href =\" http://");
define("lg_phrase_registration_mail9"," nếu bạn có bất kỳ câu hỏi nào xin <a href =\" http://");
define("lg_phrase_registration_success"," Đăng ký thành công.");
define("lg_phrase_remember_me_warning","Đừng chọn \" nhớ tôi\" nếu bạn đang sử dụng máy tính công cộng.");
define("lg_phrase_request_password1","Một yêu cầu đã được thực hiện để phục hồi mật khẩu của bạn tại");
define("lg_phrase_set_new_password_error","Có một lỗi bất ngờ trong hoàn thành yêu cầu của bạn.");
define("lg_phrase_set_new_password_good_token","Là mã thông báo của bạn hợp lệ. Nhập một mật khẩu mới.");
define("lg_phrase_set_new_password_success","Mật khẩu của bạn đã được thay đổi.");
define("lg_phrase_set_new_password_token_expired","Nhiều hơn 24 giờ đã trôi qua kể từ khi bạn yêu cầu một mật khẩu thu hồi mã thông báo.");
define("lg_phrase_user_registration","Đăng ký người dùng");
define("lg_phrase_userid_empty","Lĩnh vực tên truy nhập được yêu cầu nhưng bỏ trống. Hãy nhập tên truy nhập của bạn.");
define("lg_phrase_userid_inuse","Nhận dạng người dùng đang sử dụng hoặc không hợp lệ.");
define("lg_phrase_userid_new_title","Hãy nhập mong muốn của bạn Tên truy nhập lĩnh vực này là cần thiết.");
define("lg_phrase_userid_title","Hãy nhập userid của bạn. Lĩnh vực này là bắt buộc.");
define("lg_phrase_verify_expired","Hơn 24 hors đã trôi qua kể từ khi đăng ký của bạn.");
define("lg_phrase_verify_login","Bây giờ bạn có thể đăng nhập vào tài khoản của bạn.");
define("lg_phrase_verify_newtoken","Nhấp vào đây để tạo mới mở khóa mã");
define("lg_phrase_verify_verified","Bạn đã xác minh địa chỉ thư điện tử của bạn.");
define("lg_phrase_webmaster_may_be_contacted","Bộ quản trị web có thể liên lạc bằng thư điện tử bằng cách sử dụng liên kết này:");
define("lg_phrase_website_title","Hãy nhập địa chỉ trang web của bạn.");
define("lg_register_button_text","Đăng ký");
define("lg_term_at","tại");
define("lg_term_cancel","Hủy bỏ tài khoản");
define("lg_term_cancel_account","Hủy bỏ tài khoản");
define("lg_term_change_password","Thay đổi mật khẩu");
define("lg_term_change_password_button_text","Thay đổi mật khẩu");
define("lg_term_checkToken","checkToken");
define("lg_term_city","Thành phố");
define("lg_term_confirm","Đánh lại mật khẩu");
define("lg_term_contact", "Liên hệ");
define("lg_term_contact_form","Mẫu liên hệ");
define("lg_term_content_language", "<meta http-equiv=\"content-language\" content=\"vi-VN\" />");
define("lg_term_country","Quốc gia");
define("lg_term_current_password","Mật khẩu hiện tại");
define("lg_term_delete_account","Tài khoản xóa");
define("lg_term_do_registration","doRegistration");
define("lg_term_email","Thư điện tử");
define("lg_term_enter_information","Nhập thông tin");
define("lg_term_error_string","getPasshash");
define("lg_term_example","Ví dụ");
define("lg_term_fair", "KHÔNG TỐT");
define("lg_term_forbidden", "Tử Cấm");
define("lg_term_form_error", "cách tao nhã lỗi");
define("lg_term_get_name","getName");
define("lg_term_get_oldpassword","getOldPassword");
define("lg_term_guest","tôn vinh khách.");
define("lg_term_home", "Trang Chủ");
define("lg_term_immediately","ngay lập tức!");
define("lg_term_ip","IP");
define("lg_term_issue_verification_token","Lấy mã xác minh");
define("lg_term_language", "<meta name=\"language\" content=\"vi-VN\" />");
define("lg_term_log_out"," Đăng xuất");
define("lg_term_log_string","logLogin");
define("lg_term_logged_out","Thoát khỏi tài khoản");
define("lg_term_login","Đăng nhập");
define("lg_term_login_success","Thành công");
define("lg_term_medium", "KHÁ TỐT");
define("lg_term_name","Tên");
define("lg_term_new", "Mới");
define("lg_term_new_password","Mật khẩu mới");
define("lg_term_poor", "THIẾ́U THỐ́N");
define("lg_term_optional","tùy chọn");
define("lg_term_or","hoặc");
define("lg_term_password","Mật khẩu");
define("lg_term_please_login","Vui lòng đăng nhập");
define("lg_term_please_register","Hãy đăng ký");
define("lg_term_project_home_link", "<a title=\"Đăng nhập hệ thống trên Google Code\" href=\"http://code.google.com/p/loginsystem-rd/\">http://code.google.com/p/loginsystem-rd/</a>");
define("lg_term_recover_password","Khôi phục mật khẩu");
define("lg_term_region","Vùng");
define("lg_term_register","Đăng ký");
define("lg_term_register_confirmation","Xác nhận đăng ký");
define("lg_term_register_delete_enter_email","Nhập thư điện tử");
define("lg_term_registration","Đăng ký");
define("lg_term_registration_thankyou", "Cảm ơn bạn đã đăng ký.");
define("lg_term_registration_verification","Đăng ký xác nhận");
define("lg_term_remember", true);
define("lg_term_rememberme","Nhớ đăng nhập của tôi");
define("lg_term_remove_registration","Hủy bỏ đăng ký");
define("lg_term_required","Được yêu cầu");
define("lg_term_reset_password"," Mật khẩu sự chứa");
define("lg_term_set_new_password"," Tạo mật khẩu mới ");
define("lg_term_set_newpassword", "changePassword");
define("lg_term_strong", "RẤT TỐT");
define("lg_term_submit","Gửi");
define("lg_term_to","Đến");
define("lg_term_useragent","Useragent");
define("lg_term_userid","Tên truy nhập");
define("lg_term_via_email","bằng thư điện tử");
define("lg_term_webloginproject_link", "<a title=\"Đăng nhập Web dự án\" href=\"http://www.webloginproject.com/index.php\">Đăng nhập Web dự án</a>");
define("lg_term_website","Trang web");
define("lg_term_website_address","Địa chỉ website");
define("lg_term_welcome","Chào mừng");
define("lg_term_xhtml_xmlns", "<html xmlns=\"http://www.w3.org/1999/xhtml\" xml:lang=\"vi\" lang=\"vi\">");
?>


