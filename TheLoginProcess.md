Examination Of The Login Process

# Introduction #

At a casual glance, the login process seems very simple.  It is very common for a new web developer to ask for a login page for his or her web site.  But a deeper understanding shows **just** a login page is insufficient.

Unless every user is using the same credentials, (obviously a bad practice,) you need a place to store user information, e.g. nominally a database.

Examining the code of login pages made by many developers reveals a lack of input filtering, potential or known SQL injections and CSRF vulnerabilities.

A web developer should not have to write a login system from scratch and face the possibility of repeating common mistakes, but should have access to code reviewed by many, tested and proven in practice to be secure and sufficient.

That does not imply that one system fits all situations, but those functions which are common among most situations should be vetted and made available to developers who can choose which functions they want to include in the web site they are developing.

# Details #

At a minimum, best practices **demand** any input from any web form must be filtered to prevent malicious input. It is also generally considered best practice that filtering should be against a white list of known good input with all other input discarded.  Prior to filtering canonization of the input may be required.

SQL commands necessary to interact with the user database must be secure to avoid SQL injection attacks, which generally requires the use of Parametrized SQL or prepared statements, (although these can be vulnerable if improperly implemented.)

Finally, temporal one time use tokens should be included in web forms to help prevent CSRF attacks. This also requires no XSS vulnerabilities exist on those pages.

When the form in question is a login form, extra care must be taken to ensure only authorized users may authenticate and that their login credentials are kept safe. One way to ensure these requirements are met is to never echo the userid to web pages after login, (information leakage,) and to only store a hash of the users password in the back-end database.

## A Realistic View Of The Login Process ##

For a person to login, that person must first obtain login credentials, usually a User ID and password.  It is seldom practical to hand deliver these credentials to web site users so immediately we recognize that in addition to a login page, we will need to provide a registration page for a user to obtain their login credentials.

As we previously stated we should not echo the userid on any web page we will also need to ask for the user's name or desired "screen name" during registration.

Best practices for transactional web sites require the registered user be emailed when any significant transaction occurs. Therefore, the registration page must not only ask for a new registrant's email address, but that address must be validated so it is known the user can be notified of any significant transactions involving his or her account.

Therefor we will need a method of email verification.  Unless the web site has unusually high security requirements, (a banking site for example,) we can send a temporal cryptographic random token to the e-mail address provided at registration and keep the new account in a locked state until that token has been verified by the user.

Therefore we need a email verification page to validate registration tokens. To avoid replay attacks, used tokens must be saved and new tokens checked to ensure they were not previously used. (There may be a time limit specified in the login system's configuration to keep the used token file from growing out of control.)

That is the very minimum needed for a login system:

  * A registration page,
  * A email verification page, and
  * A login page

Those pages can very well require:

  * A success page for verifying a email token, and
  * A success page for a successful login.

We are at five pages already, but savvy web users will expect more. They will want the ability to change at a minimum their password and email, (if not other registration details.) They may also want to be able to cancel their account with the web site.

Not mentioned earlier, there are people who have been known to register accounts at web sites using another person's identity and email. The motivation for this can be varied, but some examples might be a person registering another person at a web site that the other person might consider embarrassing, contrary to their political or religious views, or for the purpose of making the other person a victim of fraud.  When a new user registration email is sent by the registration page, an option to cancel the registration should be included in that email.

Thus the need for a cancel registration page. So we will add to our system:

  * A Change password page,
  * A change e-mail page,
  * A cancel account page, and
  * A cancel registration page.

Email is not always reliable. It is not uncommon for email from a new website to end up in a user's SPAM folder, or system failures may result in a message not being delivered.  Thus a new user may not receive their verification token, or may not notice it until the lifetime of the token has expired.

It may then be desirable to offer users the ability to request a new email verification token be sent. So we add:

  * A request new token page.

If we allow the user to log in, we should offer a page to log out.  This means killing any session variables in use and/or deleting any cookies. This generally requires that the user be redirected past that page as in most cases the session variables and cookies will not actually be deleted until the user leaves the page that destroys them.  Thus we need:

  * A log out page, and
  * A logged out page (alternatively we could redirect to the home page of the web site.)

While not implemented in the early phases of this project, it can be anticipated that some web site developers may want to take advantage of federated identity solutions, so at a minimum, support for OpenID should be added in post release versions of this system.

Finally, we can be assured that some user will forget their login credentials, and provide a method to recover the password and/or the user id and password.  If implemented, we should require the user to set a new password upon login. So finally:

  * A password recovery page, and
  * A create new password page, and (if desired)

This begs the question of how we verify a user is entitled to recover a forgotten password. In the alpha version of code we will simply accept the userid and email of the user, lock the account, and send a temporal unlock token to the registered account owner's email address.

In future versions we will may decide to determine a method to recover a forgotten userid which will probably require a page to set questions and answers for the user to prove their identity and a page to display some random number of questions which must be answered correctly before a userid or password unlock code is sent. Future Add:

  * A page to set questions and answers for a user, and
  * A page to display questions that must be answered for User ID and/or Password recovery, and therefore
  * A User ID and Password recovery page.

The web is international, so will be this login system. All terms and phrases will be represented by constants located in a language file. There is also the need to store configuration information, such as the database access string and webmaster preferences, such as logging all user logins.  These will be combined into one file;

  * The login system globals file.

[Home](http://code.google.com/p/loginsystem-rd/wiki/WikiHome) [Next:Login Page](http://code.google.com/p/loginsystem-rd/wiki/LoginPage)