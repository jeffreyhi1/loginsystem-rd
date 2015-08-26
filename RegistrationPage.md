Discussion Of The Registration Process

# Introduction #

It is impractical to personally deliver authentication credentials to web users.  A method of online registration is needed to capture necessary information from the user. Care must be taken not to obtain personally identifying information from a user of which the web site has no legitimate need. That would add an unnecessary risk for the web site owner to keep that information private and prevent unauthorized access.

The Internet allows people a certain amount of anonymity and some web users may misrepresent their true identity when completing web based registration forms. At a minimum the registration process should verify the validity of the email address presented at registration. While not proof of identity, a valid email address allows the web application a known way to communicate with the user.


# Details #

The login system provides the HTML markup and server side code to facilitate the registration of new users. The form nominally provides entry of a userid, password, name, website address, and a checkbox to allow the user to opt in to any messages or news sent on behalf of the web site. The form is extensible as needed by the web developer.

In the process of registration, the user's chosen password must be confirmed by a second entry to ensure the user has entered the correct password and not made a typographical error. This is necessary because the password entry field is obscured and the user can not see what has been entered.

After completion of the registration form, the new account will be flagged as locked. This accomplished by Computing a crytographically randon one use token, then updating the user account record in the database:

  * Setting the locked field to 1,
  * Setting the token field to contain the generated token, and
  * Setting the dateIssued field to the current date and time.

An email with the random one time use token will be sent to the entered email address.  The email contains instructions on how to activate (unlock) the new account by either:

  * Clicking the link provided which contains the token as a URL variable, or
  * Copying and Pasting the token into the Registration Verification page.

The userid and password will not be included in the email.

As written, the login system provides a lifetime of 24 hours for the token sent. If the user does not activate the account within 24 hours, the token will be deemed expired.  This time limit is currently hard coded into the source code. In future versions this can be changed to allow the token lifetime to be specified in the login systems global configuration file.

The option exists for the web developer to deploy the "Issue Verification Token" page so that a user may request a new token be sent. As email is not 100% reliable and mail from a new sender (the web site) may end up in a user's SPAM folder, it is probably beneficial to deploy that page.

The current registration form does not use CAPTCHA. This can be added by the web developer if desired. Future versions will include the option to use the [ReCAPTCHA](http://recaptcha.net/) code.

[HOME](http://code.google.com/p/loginsystem-rd/wiki/WikiHome) | [PREV: Login Page](http://code.google.com/p/loginsystem-rd/wiki/LoginPage) | [NEXT: Registration Verification Page](http://code.google.com/p/loginsystem-rd/wiki/RegistrationVerification)