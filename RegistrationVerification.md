The Registration Verification Page

# Introduction #

The registration verification page is meant to receive the one time use verification token sent to the user via email at registration.


# Details #

The page can receive the token as a URL parameter from a link provided in the email sent to the user, or the user may copy and paste the token into the field provided on the Registration Verification page.

If a correct token is presented, the Registration Verification page will change the user's database record to show locked=0, and will replace the stored token and token issue date fields to Null.  The user's account will then be active, but the user will still be required to login with the userid and password entered at registration. This is to prevent someone who may have received the email (man in the middle attack) from gaining access just from the verification token.

The user will then be:

  * Given a link to the page designated by the web developer, or
  * Given a link to any destination page saved when the user first attempted access, or
  * Given a link to the login page.

[HOME](http://code.google.com/p/loginsystem-rd/wiki/WikiHome) | [PREV: Registration Verification Page](http://code.google.com/p/loginsystem-rd/wiki/RegistrationVerification) | [NEXT:Issue New Token](http://code.google.com/p/loginsystem-rd/wiki/IssueNewToken)