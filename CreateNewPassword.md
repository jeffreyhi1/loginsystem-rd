Create New Password Page

# Introduction #

A user having received a recover password token must visit this page to change their password.


# Details #

A user requesting the recovery of their password can not be sent their existing password via email.

  * The password is hashed and unknown to the system.
  * The password should not be sent in an email which may potentially be read by others.

The user having supplied their email address and userid on the [Recover Password](http://code.google.com/p/loginsystem-rd/wiki/RecoverPassword) page, they will be sent a temporal token to the email account used at registration.

Upon receiving the token the user may either click a link in the email to the Create New Password page, or they may visit that page and enter the token in a form field provided.

If the token is valid and not expired, the user will be allowed to enter a new password and enter a confirmation of the new password.

Upon success, an email will be sent to the account owner with contact information for the webmaster in case they did not initiate the password change.

An option in the login system configuration would allow a link the user can follow to lock the account until the webmaster investigates the issue.

[Home](http://code.google.com/p/loginsystem-rd/wiki/WikiHome) | [PREV](http://code.google.com/p/loginsystem-rd/wiki/RecoverPassword) | [NEXT](http://code.google.com/p/loginsystem-rd/wiki/LockAccount)