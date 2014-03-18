/*
Navicat MySQL Data Transfer

Source Server         : Local
Source Server Version : 50534
Source Host           : localhost:3306
Source Database       : videos

Target Server Type    : MYSQL
Target Server Version : 50534
File Encoding         : 65001

Date: 2014-03-18 22:44:01
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for apis
-- ----------------------------
DROP TABLE IF EXISTS `apis`;
CREATE TABLE `apis` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `youtubeAPI` varchar(255) DEFAULT NULL,
  `truveoAPI` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of apis
-- ----------------------------
INSERT INTO `apis` VALUES ('1', '0', '1');

-- ----------------------------
-- Table structure for badwords
-- ----------------------------
DROP TABLE IF EXISTS `badwords`;
CREATE TABLE `badwords` (
  `badword` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of badwords
-- ----------------------------

-- ----------------------------
-- Table structure for banners
-- ----------------------------
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `bannertop` varchar(255) DEFAULT NULL,
  `bannerright` varchar(255) DEFAULT NULL,
  `bannerbottom` varchar(255) DEFAULT NULL,
  `squarebanner` varchar(255) DEFAULT NULL,
  `enablebanner` varchar(255) DEFAULT NULL,
  `bannerID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`bannerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of banners
-- ----------------------------

-- ----------------------------
-- Table structure for bans
-- ----------------------------
DROP TABLE IF EXISTS `bans`;
CREATE TABLE `bans` (
  `ban_IP` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of bans
-- ----------------------------

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `catID` int(11) NOT NULL AUTO_INCREMENT,
  `catname` varchar(255) DEFAULT NULL,
  `catdesc` varchar(255) DEFAULT NULL,
  `active` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`catID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of categories
-- ----------------------------

-- ----------------------------
-- Table structure for displaysettings
-- ----------------------------
DROP TABLE IF EXISTS `displaysettings`;
CREATE TABLE `displaysettings` (
  `header` varchar(255) DEFAULT NULL,
  `headerImage` varchar(255) DEFAULT NULL,
  `displayID` int(11) NOT NULL AUTO_INCREMENT,
  `usethis` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`displayID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of displaysettings
-- ----------------------------

-- ----------------------------
-- Table structure for extra
-- ----------------------------
DROP TABLE IF EXISTS `extra`;
CREATE TABLE `extra` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `showtags` varchar(255) DEFAULT NULL,
  `showcategories` varchar(255) DEFAULT NULL,
  `Showsubcategories` varchar(255) DEFAULT NULL,
  `ShowTagClouds` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of extra
-- ----------------------------
INSERT INTO `extra` VALUES ('1', 'Yes', 'Yes', 'No', 'Yes');

-- ----------------------------
-- Table structure for mailsettings
-- ----------------------------
DROP TABLE IF EXISTS `mailsettings`;
CREATE TABLE `mailsettings` (
  `mID` bigint(100) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `msendusername` varchar(255) DEFAULT NULL,
  `alais` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `MailServer` varchar(255) DEFAULT NULL,
  `Port` varchar(100) DEFAULT NULL,
  `err` varchar(255) DEFAULT NULL,
  `usethis` int(10) DEFAULT '0',
  PRIMARY KEY (`mID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of mailsettings
-- ----------------------------

-- ----------------------------
-- Table structure for search_terms
-- ----------------------------
DROP TABLE IF EXISTS `search_terms`;
CREATE TABLE `search_terms` (
  `term` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of search_terms
-- ----------------------------

-- ----------------------------
-- Table structure for sitethemes
-- ----------------------------
DROP TABLE IF EXISTS `sitethemes`;
CREATE TABLE `sitethemes` (
  `themeid` int(11) NOT NULL AUTO_INCREMENT,
  `themename` varchar(255) DEFAULT NULL,
  `themebgcolor` varchar(255) DEFAULT NULL,
  `themefntcolor` varchar(255) DEFAULT NULL,
  `themelnkcolor` varchar(255) DEFAULT NULL,
  `themelnkaction` varchar(255) DEFAULT NULL,
  `themehvraction` varchar(255) DEFAULT NULL,
  `themeMenuColor` varchar(255) DEFAULT NULL,
  `themetopcell` varchar(255) DEFAULT NULL,
  `themebtmcell` varchar(255) DEFAULT NULL,
  `themebrdcolor` varchar(255) DEFAULT NULL,
  `themebrdsize` double DEFAULT NULL,
  `themefoldername` varchar(255) DEFAULT NULL,
  `themeinfo` varchar(255) DEFAULT NULL,
  `boximagecolorbottom` varchar(255) DEFAULT NULL,
  `boximagecolor` varchar(255) DEFAULT NULL,
  `themedefault` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`themeid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of sitethemes
-- ----------------------------

-- ----------------------------
-- Table structure for subcategories
-- ----------------------------
DROP TABLE IF EXISTS `subcategories`;
CREATE TABLE `subcategories` (
  `subcatID` int(11) NOT NULL AUTO_INCREMENT,
  `catID` int(11) DEFAULT NULL,
  `subcatDesc` varchar(255) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`subcatID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of subcategories
-- ----------------------------

-- ----------------------------
-- Table structure for tagging
-- ----------------------------
DROP TABLE IF EXISTS `tagging`;
CREATE TABLE `tagging` (
  `tagname` varchar(255) DEFAULT NULL,
  `parentID` int(11) DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of tagging
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `emailaddress` varchar(255) DEFAULT NULL,
  `nusername` varchar(255) DEFAULT NULL,
  `npwd` varchar(255) DEFAULT NULL,
  `role` varchar(255) DEFAULT NULL,
  `valid` int(11) DEFAULT NULL,
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('gavy@jatt.com', 'admin', 'admin', '1', '1', '1');

-- ----------------------------
-- Table structure for websitesettings
-- ----------------------------
DROP TABLE IF EXISTS `websitesettings`;
CREATE TABLE `websitesettings` (
  `site_id` int(11) NOT NULL AUTO_INCREMENT,
  `site_title` varchar(255) DEFAULT NULL,
  `site_email` varchar(255) DEFAULT NULL,
  `site_ip` varchar(100) DEFAULT NULL,
  `site_desc` longtext,
  `site_keys` longtext,
  `site_publisher` varchar(255) DEFAULT NULL,
  `site_generator` varchar(255) DEFAULT NULL,
  `site_copyright` varchar(255) DEFAULT NULL,
  `site_revisit` varchar(255) DEFAULT NULL,
  `site_enable` varchar(100) DEFAULT 'Yes',
  `site_aboutme` longtext,
  `site_contact` longtext,
  `site_footer` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`site_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of websitesettings
-- ----------------------------
