Main Page

# Introduction #

The purpose of this project is to release proven secure code for a web site login.  While some languages, such as .NET have pre-built secure components, other languages do not.  As a result an examination of web site login systems will often reveal XSS, SQL Injection and/or CSRF vulnerabilities.

# Details #

This system will be offered first in Classic ASP and PHP.  The intent is to provide valid modular (X)HTML mark-up which can be inserted in the body of a web page from any site.  In other words, all of an existing sites banner, menus, navigation and style would exist and just the form portion of the login system pages would need to be added to the existing markup at whatever location the webmaster desires.  (The web developer can create their own (X)HTML mark up, but will need to follow certain coding conventions.)

While some basic CSS is used in the pages of this login system, that is meant to be replaced by the web developer with styles to match the parent web site.

The code which processes the forms and performs the functions of the login system can generally be cut and pasted into the head of the web page where it will be used.


**[Prerequisites](http://code.google.com/p/loginsystem-rd/wiki/Prerequisites)**

**Requirements [The Login Process](http://code.google.com/p/loginsystem-rd/wiki/TheLoginProcess)**

**Design [Login Page](http://code.google.com/p/loginsystem-rd/wiki/LoginPage)**
