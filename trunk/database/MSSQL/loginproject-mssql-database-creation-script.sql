CREATE DATABASE [loginproject]
GO
USE [loginproject]
GO

CREATE TABLE dbo.logins
(id int Identity(1,1) not null primary key clustered,date datetime,userid varchar(50),ip varchar(32),useragent varchar(255))
 
GO

CREATE TABLE
dbo.loginAttempts
(id int Identity(1,1) not null primary key clustered,loginAttemptUserID nvarchar(50),loginAttemptNumber int,loginAttemptDate datetime,
loginAttemptIP nvarchar(32), loginAttemptLocked char(1) Default 0)

GO

CREATE TABLE
dbo.questions
(id int Identity(1,1) not null primary key clustered,userid int not null,question nvarchar(255),answer  nvarchar(255))

GO

CREATE TABLE
dbo.securityQuestions (id int Identity(1,1) not null primary key clustered,question nvarchar(255))

GO

CREATE TABLE
dbo.users (id int Identity(1,1) not null primary key clustered ,dateRegistered datetime not null,userid  nvarchar(50) not null,
password nvarchar(255) not null, name nvarchar(100) not null,email nvarchar(100) not null,ip nvarchar(32),
region nvarchar(50),city nvarchar(50),country nvarchar(50),useragent nvarchar(255),website nvarchar(100),
news nvarchar(3),locked char(1) Default 1,dateLocked  datetime,token nvarchar(64),deleted char(1) Default 0,
dateDeleted  datetime)

GO

create nonclustered index idx_users_email on users(email asc)
GO

INSERT INTO securityQuestions VALUES ('What was your childhood nickname?');
INSERT INTO securityQuestions VALUES ('In what city or town was your first job?');
INSERT INTO securityQuestions VALUES ('In what city does your nearest sibling live?');
INSERT INTO securityQuestions VALUES ('In what city or town did your mother and father meet?');
INSERT INTO securityQuestions VALUES ('What is your oldest sibling''s middle name?');
INSERT INTO securityQuestions VALUES ('What school did you attend for sixth grade?');
INSERT INTO securityQuestions VALUES ('What is the name of your favorite childhood friend?');
INSERT INTO securityQuestions VALUES ('In what city did you meet your spouse/significant other?');
INSERT INTO securityQuestions VALUES ('What was your first automobile?');
INSERT INTO securityQuestions VALUES ('What pet have you wanted but never had?');
INSERT INTO securityQuestions VALUES ('What was your rival High School?');
INSERT INTO securityQuestions VALUES ('In what city would you like to visit on vacation?');
INSERT INTO securityQuestions VALUES ('What was the worst present you received for a birthday?');
INSERT INTO securityQuestions VALUES ('Where were you when you had your first kiss?');
INSERT INTO securityQuestions VALUES ('What is your maternal grandmother''s maiden name?');
INSERT INTO securityQuestions VALUES ('What was your job title at your first paying job?');
INSERT INTO securityQuestions VALUES ('What animal would you never want as a pet?');
INSERT INTO securityQuestions VALUES ('How old were you when you learned to swim?');
INSERT INTO securityQuestions VALUES ('What was the last name of your first love?');
INSERT INTO securityQuestions VALUES ('What was your least favorite vegetable as a child?');

