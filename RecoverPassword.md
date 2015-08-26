The recover password page

# Introduction #

A method to acquire a lost or forgotten user password.


# Details #

While future versions could require security questions and answers, research has shown this is not neccessarily a good practice; especially if the questions are of a nature that the answers could be easily guessed or found in a user's public profile (e.g. Social networking posts, etc.)

At registration the user had to provide their name, userid, and email address to obtain login credentials. The email address was verified before the account was enabled.

Then if a user can provide their email address and userid, that is no less than they provided at registration and we can send a temporal password unlock token to the email address provided at registration.

  * Some risk exists if the user's email has been compromised but this is not a failure of the login system.
  * This is not secure if the userid has been displayed on other pages (information leakage) which we already agreed would not be done.

Upon receiving the temporal login token, the user can be directed to a create new password page which will verify the token before allowing the user to access their account.



[Home](http://code.google.com/p/loginsystem-rd/wiki/WikiHome) | [PREV](http://code.google.com/p/loginsystem-rd/wiki/ChangePassword) | [NEXT](http://code.google.com/p/loginsystem-rd/wiki/CreateNewPassword)