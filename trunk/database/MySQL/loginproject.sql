-- phpMyAdmin SQL Dump
-- version 2.8.0.1
-- http://www.phpmyadmin.net
-- 
-- Generation Time: Apr 19, 2010 at 11:02 AM
-- Server version: 5.0.45
-- PHP Version: 4.4.9
-- 
-- Database: `loginproject`
-- 
DROP DATABASE `loginproject`;
CREATE DATABASE `loginproject` DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;
USE `loginproject`;

-- --------------------------------------------------------

-- 
-- Table structure for table `loginAttempts`
-- 

DROP TABLE IF EXISTS `loginAttempts`;
CREATE TABLE `loginAttempts` (
  `id` int(4) NOT NULL auto_increment,
  `loginAttemptUserID` varchar(50) collate utf8_unicode_ci default NULL,
  `loginAttemptNumber` int(4) default '0',
  `loginAttemptDate` datetime default NULL,
  `loginAttemptIP` varchar(32) collate utf8_unicode_ci default NULL,
  `loginAttemptLocked` char(1) collate utf8_unicode_ci default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;


-- --------------------------------------------------------

-- 
-- Table structure for table `logins`
-- 

DROP TABLE IF EXISTS `logins`;
CREATE TABLE `logins` (
  `id` int(4) NOT NULL auto_increment,
  `date` datetime NOT NULL,
  `userid` varchar(50) collate utf8_unicode_ci NOT NULL,
  `ip` varchar(32) collate utf8_unicode_ci NOT NULL,
  `useragent` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

-- 
-- Table structure for table `questions`
-- 

DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `id` int(4) NOT NULL auto_increment,
  `userid` varchar(50) collate utf8_unicode_ci NOT NULL,
  `question` varchar(255) collate utf8_unicode_ci NOT NULL,
  `answer` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `questions`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `securityQuestions`
-- 

DROP TABLE IF EXISTS `securityQuestions`;
CREATE TABLE `securityQuestions` (
  `id` int(4) NOT NULL auto_increment,
  `question` varchar(255) collate utf8_unicode_ci NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=21 ;

-- 
-- Dumping data for table `securityQuestions`
-- 

INSERT INTO `securityQuestions` VALUES (1, 'What was your childhood nickname?');
INSERT INTO `securityQuestions` VALUES (2, 'In what city or town was your first job?');
INSERT INTO `securityQuestions` VALUES (3, 'In what city does your nearest sibling live?');
INSERT INTO `securityQuestions` VALUES (4, 'In what city or town did your mother and father meet?');
INSERT INTO `securityQuestions` VALUES (5, 'What is your oldest sibling''s middle name?');
INSERT INTO `securityQuestions` VALUES (6, 'What school did you attend for sixth grade?');
INSERT INTO `securityQuestions` VALUES (7, 'What is the name of your favorite childhood friend?');
INSERT INTO `securityQuestions` VALUES (8, 'In what city did you meet your spouse/significant other?');
INSERT INTO `securityQuestions` VALUES (9, 'What was your first automobile?');
INSERT INTO `securityQuestions` VALUES (10, 'What pet have you wanted but never had?');
INSERT INTO `securityQuestions` VALUES (11, 'What was your rival High School?');
INSERT INTO `securityQuestions` VALUES (12, 'In what city would you like to visit on vacation?');
INSERT INTO `securityQuestions` VALUES (13, 'What was the worst present you received for a birthday?');
INSERT INTO `securityQuestions` VALUES (14, 'Where were you when you had your first kiss?');
INSERT INTO `securityQuestions` VALUES (15, 'What is your maternal grandmother''s maiden name?');
INSERT INTO `securityQuestions` VALUES (16, 'What was your job title at your first paying job?');
INSERT INTO `securityQuestions` VALUES (17, 'What animal would you never want as a pet?');
INSERT INTO `securityQuestions` VALUES (18, 'How old were you when you learned to swim?');
INSERT INTO `securityQuestions` VALUES (19, 'What was the last name of your first love?');
INSERT INTO `securityQuestions` VALUES (20, 'What was your least favorite vegetable as a child?');

-- --------------------------------------------------------

-- 
-- Table structure for table `users`
-- 

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(4) NOT NULL auto_increment,
  `dateRegistered` datetime NOT NULL,
  `userid` varchar(50) collate utf8_unicode_ci NOT NULL,
  `password` varchar(64) collate utf8_unicode_ci NOT NULL,
  `name` varchar(100) collate utf8_unicode_ci NOT NULL,
  `email` varchar(100) collate utf8_unicode_ci NOT NULL,
  `ip` varchar(32) collate utf8_unicode_ci default NULL,
  `region` varchar(50) collate utf8_unicode_ci default NULL,
  `city` varchar(50) collate utf8_unicode_ci default NULL,
  `country` varchar(50) collate utf8_unicode_ci default NULL,
  `useragent` varchar(255) collate utf8_unicode_ci default NULL,
  `website` varchar(100) collate utf8_unicode_ci default NULL,
  `news` varchar(3) collate utf8_unicode_ci default NULL,
  `locked` varchar(1) collate utf8_unicode_ci default '1',
  `dateLocked` datetime default NULL,
  `token` varchar(64) collate utf8_unicode_ci default NULL,
  `deleted` varchar(1) collate utf8_unicode_ci default '0',
  `dateDeleted` datetime default NULL,
  `userRoles` varchar(255) collate utf8_unicode_ci NOT NULL default 'Guest',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`,`email`)
) ENGINE=MyISAM AUTO_INCREMENT=1 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;

