The Register Delete Page

# Introduction #

As discussed in the [The Login Process](http://code.google.com/p/loginsystem-rd/wiki/TheLoginProcess) a malicious person could register for an account using false credentials and another person's e-mail address.


# Details #

If a user registers an account and uses another person's email address, either by accident or with malicious intent, the normal process of registration will send the owner of the email address a registration confirmation email with instructions on how to activate the account using the verification token.

The email will also contain instructions for canceling the registration in the event the owner of the email account did not register for an account.

The Cancel Registration page takes the email address as input and deletes the registration information from the user table in the database.

Future implementations may include an option in the Login System's Globals file to mark a record as deleted and not actually remove the information.


[Home](http://code.google.com/p/loginsystem-rd/wiki/WikiHome) | [PREV](http://code.google.com/p/loginsystem-rd/wiki/RegistrationVerification) | [NEXT](http://code.google.com/p/loginsystem-rd/wiki/CancelDelete)