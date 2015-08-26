The preliminary specification for the authentication system

# Introduction #

Developer Comments are required


# Details #

Table Users
  * id		autonumber integer/long integer size 4 byte
  * dateRegistered	Date/Time
  * userid		Text 50
  * password	        Text 255 to allow pass phrases
  * name		Screen name
  * email		Text/Varchar 100
  * ip		        Text/Varchar 32 remote IP, silent addition
  * region		Text/Varchar 50 geo-location silent addition
  * city		Text/Varchar 50 geo-location silent addition
  * country		Text/Varchar 50 geo-location silent addition
  * useragent	        Text/Varchar 255 silent addition
  * website		Text/Varchar 100 user input
  * news		Text/Varchar 3 user input - wants to opt in to site news
  * locked		Text/Char/Tinyint 1
  * dateLoced	        Date/Time
  * token		Text/varchar 64 temproral token 40 byte sha1 64 bytes SHA256
  * deleted		Text/Char/Tinyint 1
  * dateDeleted	        Date/Time

Table logins (log file)
  * id		        autonumber integer/long integer size 4 byte
  * date		Date/Time
  * useragent	        Text/varchar 50
  * ip		        Text/varchar 32
  * useragent	        Text/varchar 255