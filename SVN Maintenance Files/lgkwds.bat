@ECHO OFF
REM $Id$

SETLOCAL ENABLEDELAYEDEXPANSION
PUSHD .
CD /D "D:\Checkouts\loginsystem-rd"

FOR /F "tokens=1-6 delims=.-/: " %%A IN ("%DATE% %TIME%") DO (
	FOR /F "tokens=2-4 skip=1 delims=(.-/)" %%G IN ('VER^|DATE') DO (
		SET %%G=%%A
		SET %%H=%%B
		SET %%I=%%C
		SET hh=%%D
		SET ii=%%E
		SET ss=%%F
	)
)

ECHO Id Rev Revision Date LastChangedDate LastChangedRevision Author LastChangedBy HeadURL URL > %TEMP%\SVNKeywords.txt

IF "%1"=="" (
	ECHO Updating LoginSystem-RD
	SVN update .
)

ECHO Collecting ASP, PHP, SQL, BAT and VB filenames.
FOR /R . %%X in (*.ASP *.PHP *.SQL *.BAT *.VB) DO (
	SET LSRD_Filename=%%~nX
	IF NOT "!LSRD_Filename:~0,9!"=="entities." (
		ECHO %%~X >> "%TEMP%\svnxml_%YY%_%MM%_%DD%_%HH%_%II%_%SS%.LST"
	) ELSE (
		ECHO Ignoring %%~X
	)
)

ECHO Setting svn:keywords
SVN propset svn:keywords -F %TEMP%\SVNKeywords.txt --targets "%TEMP%\svnxml_%YY%_%MM%_%DD%_%HH%_%II%_%SS%.LST" 1>NUL 2>CON

DEL "%TEMP%\svnxml_%YY%_%MM%_%DD%_%HH%_%II%_%SS%.LST
DEL "%TEMP%\SVNKeywords.txt"

POPD
