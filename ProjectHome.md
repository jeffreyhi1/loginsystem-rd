> Необходимость русский переводчик

10-27-2009

Any bugs or vulnerabilities should be reported to security@webloginproject.com.  If you have programmed any enhancements, please share those with the community. Make notice to webmaster@webloginproject.com.

Versions now include Dansk - Danish, Français - French, Έλληνες - Greek, Deutsch - German, हिन्दी - Hindi, Español - Spanish, Polski - Polish, Россию - Russian, Svenska - Swedish, and of course English (US and UK).  Any person translating the system to another language should contact webmaster@webloginproject.com.


6-29-2010

The PHP code uses function arguments which are by "reference" and which assigned as arrays. This requires PHP 5.x or greater according to http://www.php.net/manual/en/language.types.array.php

Changing the values of the array directly is possible _**since PHP 5 by passing them by reference.** Before that, a workaround is necessary._


5-22-2010

alpha 0.5a to alpha 0.5a (Bug fixes)

Password strength meter is a field. It could get focus and accept user input. Changed to readonly and added tabindex to the page's form fields to bypass meter.

issue-verification-token needed a "Click here to continue" link to the home page.
New Registration EMail (ASP) failed to properly display hyperlink to contact the webmaster.
issue-verification-token.php Addressing the verification e-mail to  which does not exist, needs to be changed to lg\_term\_register\_confirmation.
login.php was not modified to accept $_POST["password"] therefore would not work with strong passwords.
cancel-account.php was not set to accept $_POST["password"] therefore could not handle strong passwords.
cancel-account.asp had no "Click to continue link."
cancel-account.php, change-password.php, register.php, set-new-password.php All were set to substr($_POST["password"],0,255); and should have been substr($_POST["password"],0,254);

5-21-2010

All code packages updated to include strong password control or password minimum lengths.

4-25-2010

All code packages have been updated to correct file path errors, add lg\_term\_log\_out to the PHP code, and correct the debug out message markup in the PHP files.

4-23-2010

Anyone downloading code should visit http://www.webloginproject.com/forum/index.php and subscribe to the General Discussion and [code](your.md) branch forums for any late breaking news or reports of bugs, updates or security issues.

4-20-2010

The Login System has reached its initial code release.  Code is available in ASP and PHP with support for MS Access, MS SQL Server and MySQL.

It is meant to be included into existing web site page templates and inherit the style of the parent site.

The system will be offered first in ASP and PHP code. .NET code should follow soon.

The system was designed to be internationalized with terms and phrases included in a separate language file. In addition to English, it currently has been translated into Dansk/Danish, Deutsch/German, Espanol/Spanish (Mexican), Français /French, Ελληνικά/Greek, Polski/Polish, Svenska/Swedish, and Tiếng Việt/Vietnamese.  Hindi translation is in progress (machine translations do exist if needed for a starting point.)

The current system is in alpha 0.1 release in ASP and PHP and has shown to be stable, robust and functional at this point.

Code is maintained in subversion, but all available downloads will be listed under the downloads tab of this site.

Links to various demonstration sites, actually using the currently released code are listed on the project home page.

See the Wiki for an overall introduction, or for a detailed introduction, design considerations, and implementation details you may read the three articles below.

[Introduction](http://www.experts-exchange.com/articles/Web_Development/Miscellaneous/A-Better-Website-Login-System-the-EE-Collaborative-Login-System.html)
[Design Philosophy and Considerations](http://www.experts-exchange.com/articles/Web_Development/Miscellaneous/The-EE-Collaborative-Login-System-Part-Two-Design-Considerations.html), and
[Implementation](http://www.experts-exchange.com/articles/Web_Development/Miscellaneous/The-EE-Collaborative-Login-System-Part-Three-Implementation.html)

Lock Icon was distributed as free software and obtained at Wikipedia Commons: ![http://commons.wikimedia.org/wiki/File:Crystal_Clear_action_lock.png](http://commons.wikimedia.org/wiki/File:Crystal_Clear_action_lock.png)