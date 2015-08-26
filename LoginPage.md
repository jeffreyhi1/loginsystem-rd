An Examination Of The Logic Of The Login Page

# Introduction #

Our system assumes the use of a userid and password for authentication.  If the nauture of the web site requires more robust authentication, it may be possible to extend the code offered her, (to accept input from a cryptographic token, for example.)

There are two basic ways to maintain the state of being **logged in**.

  1. Using Session variables, and/or
  1. Using Cookies.

This system offers the use of both, however a developer can easily disable one or the other depending on the needs of the site under development.  Some developers may allow the user to set a permanent cookie to maintain logged-in status between visits.  Some web sites may have the need to log all user logins for various reasons, such as non-repudiation.

There are two common paths by which a user lands on a login page:

  1. The user arrives by direct link, or
  1. The user is redirected to the login page from a protected destination page.

These consideration will be taken into account in our login page logic.

# Details #

**Psuedo Code**

If HTTP\_METHOD = "GET"
> check for redirection and save the destination page if any
> If permanent cookies are allowed
> > check for the login cookie(s)
> > If found log the user in setting session state if used
> > > If logging, then log the user's access
> > > If we have a saved destination page redirect to that page
> > > Else show login success page
> > > Else redirect to a predetermined page, such as a forum

> Else
> > set Session and/or cookies to the logged out state, and
> > create a cryptographic one time use token (nonce)
> > present the login form with the nonce

> End If
Else (form posted)
> check for a valid nonce
> if valid
> > retrieve and filter the userid and password fields
> > If they are not empty
> > > create a hash of the password using the userid as a salt
> > > retrieve the password hash from the database for the userid
> > > compare hashes
> > > If they match
> > > > log the user in setting session state and/or cookies
> > > > if permanent cookies are allowed and requested by the user -
> > > > > set the cookies

> > > > if logging, then log the user's access
> > > > If we have a saved destination page redirect to that page
> > > > Else show login success page
> > > > Else redirect to a predetermined page, such as a forum

> > > End If

> > Else
> > > redisplay the form with an error message

> Else
> > redirect to Forbidden page.

> End If
End If


NOTE: The next version of login needs to establish a predetermined number of attempts allowed, count failure attempts, and lock the user's account and send the user an e-mail advising that the account has been locked.

This implys the need to unlock an account. In the early phase of this process we will send an unlock token to the registered e-mail address as is done at registration.  Future version may offer other methods but will remain backwards compatible with this function choice.



[HOME](http://code.google.com/p/loginsystem-rd/wiki/WikiHome) | [PREV:Login Process](http://code.google.com/p/loginsystem-rd/wiki/TheLoginProcess) | [NEXT](http://code.google.com/p/loginsystem-rd/wiki/LoginSuccess)