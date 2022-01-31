-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Wersja serwera:               10.5.8-MariaDB - mariadb.org binary distribution
-- Serwer OS:                    Win64
-- HeidiSQL Wersja:              11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Zrzut struktury bazy danych discordbot
CREATE DATABASE IF NOT EXISTS `discordbot` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `discordbot`;

-- Zrzut struktury procedura discordbot.addClasses
DELIMITER //
CREATE PROCEDURE `addClasses`(
	IN `n` VARCHAR(90),
	IN `d` DATE,
	IN `ts` TIME,
	IN `te` TIME,
	IN `p` VARCHAR(90),
	IN `c` ENUM('temporary','test','exam','exercises')
)
BEGIN
INSERT INTO classes(NAME,DATE,TIMESTART,TIMEEND,PLACE,CATEGORY) VALUES (n,d,ts,te,p,c);
END//
DELIMITER ;

-- Zrzut struktury procedura discordbot.addClasUser
DELIMITER //
CREATE PROCEDURE `addClasUser`(
	IN `cid` INT,
	IN `uid` INT
)
BEGIN
INSERT INTO classesusers(ClassID,UserId) VALUES (cid,uid);
END//
DELIMITER ;

-- Zrzut struktury procedura discordbot.addUser
DELIMITER //
CREATE PROCEDURE `addUser`(
	IN `name` VARCHAR(90)
)
BEGIN
INSERT INTO users (Nick) VALUES(NAME);
END//
DELIMITER ;

-- Zrzut struktury funkcja discordbot.checkIfClassIsTemporary
DELIMITER //
CREATE FUNCTION `checkIfClassIsTemporary`(classId int) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	IF (SELECT Category FROM classes WHERE Id = classId) = 'temporary' THEN
		RETURN 1;
	ELSE 
		RETURN 0;
	END IF;
END//
DELIMITER ;

-- Zrzut struktury funkcja discordbot.checkIfHostOfEvent
DELIMITER //
CREATE FUNCTION `checkIfHostOfEvent`(userId int, eventId int) RETURNS tinyint(4)
    DETERMINISTIC
BEGIN
	IF (SELECT Id FROM events WHERE Id = eventId AND HostId = userId) IS NULL THEN
		RETURN 0;
	ELSE 
		RETURN 1;
	END IF;
END//
DELIMITER ;

-- Zrzut struktury tabela discordbot.classes
CREATE TABLE IF NOT EXISTS `classes` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(90) DEFAULT NULL,
  `Date` date NOT NULL DEFAULT '0000-00-00',
  `TimeStart` time NOT NULL DEFAULT '00:00:00',
  `TimeEnd` time NOT NULL DEFAULT '00:00:00',
  `Place` varchar(90) DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB AUTO_INCREMENT=162 DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli discordbot.classes: ~161 rows (około)
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
INSERT INTO `classes` (`Id`, `Name`, `Date`, `TimeStart`, `TimeEnd`, `Place`) VALUES
	(1, 'Wprowadzenie do Teorii Grafow', '2021-12-13', '13:15:00', '15:00:00', 'C-1'),
	(2, 'Wprowadzenie do Teorii Grafow', '2021-12-13', '17:05:00', '18:45:00', 'C-5'),
	(3, 'Jezyki Formalne i teoria trans', '2021-12-21', '17:05:00', '18:45:00', 'C-5'),
	(4, 'Wprowadzenie do sztucznej Inteligencji', '2021-12-14', '17:05:00', '18:45:00', 'C-5'),
	(5, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-10-04', '06:15:00', '09:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(6, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-10-04', '11:15:00', '13:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(7, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-10-04', '15:05:00', '16:45:00', 'C-5\\\\, s.3\\r\\n'),
	(8, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-10-04', '16:55:00', '18:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(9, ' Obliczenia naukowe\\r\\nT', '2021-10-05', '09:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(10, ' Obliczenia naukowe\\r\\nT', '2021-10-05', '12:15:00', '13:00:00', 'C-16\\\\, s.D1.2\\r\\n'),
	(11, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-05', '13:15:00', '14:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(12, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-10-05', '16:55:00', '18:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(13, ' Obliczenia naukowe\\r\\nT', '2021-10-06', '09:15:00', '10:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(14, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-06', '10:15:00', '11:00:00', 'D-1\\\\, s.317.3\\r\\n'),
	(15, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-10-07', '05:30:00', '07:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(16, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-07', '07:15:00', '08:00:00', 'C-5\\\\, s.1\\r\\n'),
	(17, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-10-08', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(18, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-10-11', '06:15:00', '09:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(19, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-10-11', '11:15:00', '13:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(20, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-10-11', '15:05:00', '16:45:00', 'C-5\\\\, s.3\\r\\n'),
	(21, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-10-11', '16:55:00', '18:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(22, ' Obliczenia naukowe\\r\\nT', '2021-10-12', '09:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(23, ' Obliczenia naukowe\\r\\nT', '2021-10-12', '11:15:00', '13:00:00', 'C-16\\\\, s.D1.2\\r\\n'),
	(24, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-12', '13:15:00', '14:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(25, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-10-12', '16:55:00', '18:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(26, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-13', '09:15:00', '11:00:00', 'D-1\\\\, s.317.3\\r\\n'),
	(27, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-10-14', '05:30:00', '07:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(28, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-10-15', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(29, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-10-18', '06:15:00', '09:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(30, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-10-18', '11:15:00', '13:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(31, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-10-18', '15:05:00', '16:45:00', 'C-5\\\\, s.3\\r\\n'),
	(32, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-10-18', '16:55:00', '18:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(33, ' Obliczenia naukowe\\r\\nT', '2021-10-19', '09:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(34, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-19', '13:15:00', '14:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(35, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-10-19', '16:55:00', '18:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(36, ' Obliczenia naukowe\\r\\nT', '2021-10-20', '09:15:00', '11:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(37, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-10-21', '05:30:00', '07:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(38, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-21', '07:15:00', '09:00:00', 'C-5\\\\, s.1\\r\\n'),
	(39, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-10-22', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(40, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-10-25', '06:15:00', '09:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(41, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-10-25', '11:15:00', '13:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(42, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-10-25', '15:05:00', '16:45:00', 'C-5\\\\, s.3\\r\\n'),
	(43, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-10-25', '16:55:00', '18:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(44, ' Obliczenia naukowe\\r\\nT', '2021-10-26', '09:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(45, ' Obliczenia naukowe\\r\\nT', '2021-10-26', '11:15:00', '13:00:00', 'C-16\\\\, s.D1.2\\r\\n'),
	(46, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-26', '13:15:00', '14:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(47, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-10-26', '16:55:00', '18:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(48, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-10-27', '09:15:00', '11:00:00', 'D-1\\\\, s.317.3\\r\\n'),
	(49, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-10-28', '05:30:00', '07:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(50, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-10-29', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(51, ' Obliczenia naukowe\\r\\nT', '2021-11-02', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(52, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-02', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(53, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-11-02', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(54, ' Obliczenia naukowe\\r\\nT', '2021-11-03', '10:15:00', '12:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(55, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-11-04', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(56, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-04', '08:15:00', '10:00:00', 'C-5\\\\, s.1\\r\\n'),
	(57, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-11-05', '08:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(58, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-11-08', '07:15:00', '10:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(59, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-11-08', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(60, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-11-08', '16:05:00', '17:45:00', 'C-5\\\\, s.3\\r\\n'),
	(61, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-11-08', '17:55:00', '19:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(62, ' Obliczenia naukowe\\r\\nT', '2021-11-09', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(63, ' Obliczenia naukowe\\r\\nT', '2021-11-09', '12:15:00', '14:00:00', 'C-16\\\\, s.D1.2\\r\\n'),
	(64, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-09', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(65, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-11-09', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(66, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-10', '10:15:00', '12:00:00', 'D-1\\\\, s.317.3\\r\\n'),
	(67, ' Obliczenia naukowe\\r\\nT', '2021-11-16', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(68, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-16', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(69, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-11-16', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(70, ' Obliczenia naukowe\\r\\nT', '2021-11-17', '10:15:00', '12:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(71, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-11-18', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(72, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-18', '08:15:00', '10:00:00', 'C-5\\\\, s.1\\r\\n'),
	(73, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-11-19', '08:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(74, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-11-22', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(75, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-11-22', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(76, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-11-22', '16:05:00', '17:45:00', 'C-5\\\\, s.3\\r\\n'),
	(77, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-11-22', '17:55:00', '19:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(78, ' Obliczenia naukowe\\r\\nT', '2021-11-23', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(79, ' Obliczenia naukowe\\r\\nT', '2021-11-23', '12:15:00', '14:00:00', 'C-16\\\\, s.D1.2\\r\\n'),
	(80, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-23', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(81, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-11-23', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(82, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-24', '10:15:00', '12:00:00', 'D-1\\\\, s.317.3\\r\\n'),
	(83, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-11-25', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(84, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-11-26', '08:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(85, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-11-29', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(86, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-11-29', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(87, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-11-29', '16:05:00', '17:45:00', 'C-5\\\\, s.3\\r\\n'),
	(88, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-11-29', '17:55:00', '19:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(89, ' Obliczenia naukowe\\r\\nT', '2021-11-30', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(90, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-11-30', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(91, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-11-30', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(92, ' Obliczenia naukowe\\r\\nT', '2021-12-01', '10:15:00', '12:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(93, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-12-02', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(94, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-12-02', '08:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(95, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-12-03', '08:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(96, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-12-06', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(97, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-12-06', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(98, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-12-06', '16:05:00', '17:45:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(99, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-12-06', '17:55:00', '19:35:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(100, ' Obliczenia naukowe\\r\\nT', '2021-12-07', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(101, ' Obliczenia naukowe\\r\\nT', '2021-12-07', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(102, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-12-07', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(103, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-12-07', '17:55:00', '19:35:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(104, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-12-08', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(105, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-12-09', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(106, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-12-10', '08:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(107, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-12-13', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(108, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-12-13', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(109, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-12-13', '16:05:00', '17:45:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(110, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-12-13', '17:55:00', '19:35:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(111, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-12-14', '08:15:00', '11:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(112, ' Metody wytwarzania oprogramowa\\r\\nT', '2021-12-15', '07:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(113, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-12-15', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(114, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2021-12-15', '16:05:00', '17:45:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(115, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-12-15', '17:55:00', '19:35:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(116, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-12-16', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(117, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2021-12-20', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(118, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-12-20', '08:15:00', '10:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(119, ' Obliczenia naukowe\\r\\nT', '2021-12-21', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(120, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2021-12-21', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(121, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2021-12-21', '17:55:00', '19:35:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(122, ' Obliczenia naukowe\\r\\nT', '2021-12-22', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(123, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-03', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(124, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-03', '16:05:00', '17:45:00', 'C-5\\\\, s.3\\r\\n'),
	(125, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-03', '17:55:00', '19:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(126, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-04', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(127, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-10', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(128, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-10', '16:05:00', '17:45:00', 'C-5\\\\, s.3\\r\\n'),
	(129, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-10', '17:55:00', '19:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(130, ' Obliczenia naukowe\\r\\nT', '2022-01-11', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(131, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2022-01-11', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(132, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2022-01-11', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(133, ' Obliczenia naukowe\\r\\nT', '2022-01-12', '10:15:00', '12:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(134, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-13', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(135, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2022-01-13', '08:15:00', '10:00:00', 'C-5\\\\, s.1\\r\\n'),
	(136, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-17', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(137, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-17', '16:05:00', '17:45:00', 'C-5\\\\, s.3\\r\\n'),
	(138, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-17', '17:55:00', '19:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(139, ' Obliczenia naukowe\\r\\nT', '2022-01-18', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(140, ' Obliczenia naukowe\\r\\nT', '2022-01-18', '12:15:00', '14:00:00', 'C-16\\\\, s.D1.2\\r\\n'),
	(141, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2022-01-18', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(142, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2022-01-18', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(143, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2022-01-19', '10:15:00', '12:00:00', 'D-1\\\\, s.317.3\\r\\n'),
	(144, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-20', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(145, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-24', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(146, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-24', '16:05:00', '17:45:00', 'C-5\\\\, s.3\\r\\n'),
	(147, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-24', '17:55:00', '19:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(148, ' Obliczenia naukowe\\r\\nT', '2022-01-25', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(149, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2022-01-25', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(150, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2022-01-25', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(151, ' Obliczenia naukowe\\r\\nT', '2022-01-26', '10:15:00', '12:00:00', 'D-1\\\\, s.317.2\\r\\n'),
	(152, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-27', '06:30:00', '08:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(153, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2022-01-27', '08:15:00', '10:00:00', 'C-5\\\\, s.1\\r\\n'),
	(154, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-31', '12:15:00', '14:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(155, ' Wprowadzenie do teorii graf\\xc3\\xb3w\\r\\nT', '2022-01-31', '16:05:00', '17:45:00', 'C-5\\\\, s.3\\r\\n'),
	(156, ' Bezpiecze\\xc5\\x84stwo komputerowe\\r\\nT', '2022-01-31', '17:55:00', '19:35:00', 'D-1\\\\, s.317.2\\r\\n'),
	(157, ' Obliczenia naukowe\\r\\nT', '2022-02-01', '10:15:00', '12:00:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(158, ' Obliczenia naukowe\\r\\nT', '2022-02-01', '12:15:00', '14:00:00', 'C-16\\\\, s.D1.2\\r\\n'),
	(159, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2022-02-01', '14:15:00', '15:55:00', 'C-1\\\\, s.sala wirtualna\\r\\n'),
	(160, ' Programowanie zespo\\xc5\\x82owe\\r\\nT', '2022-02-01', '17:55:00', '19:35:00', 'D-1\\\\, s.317.3\\r\\n'),
	(161, ' J\\xc4\\x99zyki formalne i teoria trans\\r\\nT', '2022-02-02', '10:15:00', '12:00:00', 'D-1\\\\, s.317.3\\r\\n');
/*!40000 ALTER TABLE `classes` ENABLE KEYS */;

-- Zrzut struktury tabela discordbot.classesusers
CREATE TABLE IF NOT EXISTS `classesusers` (
  `ClassId` int(11) DEFAULT NULL,
  `UserId` int(11) DEFAULT NULL,
  KEY `ClassId` (`ClassId`),
  KEY `UserId` (`UserId`),
  CONSTRAINT `classesusers_ibfk_1` FOREIGN KEY (`ClassId`) REFERENCES `classes` (`Id`) ON DELETE CASCADE,
  CONSTRAINT `classesusers_ibfk_2` FOREIGN KEY (`UserId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli discordbot.classesusers: ~16 rows (około)
/*!40000 ALTER TABLE `classesusers` DISABLE KEYS */;
INSERT INTO `classesusers` (`ClassId`, `UserId`) VALUES
	(1, 1),
	(3, 1),
	(4, 1),
	(2, 1),
	(1, 2),
	(3, 2),
	(5, 2),
	(6, 2),
	(7, 2),
	(8, 2),
	(18, 1),
	(20, 1),
	(25, 1),
	(18, 2),
	(19, 2),
	(26, 2);
/*!40000 ALTER TABLE `classesusers` ENABLE KEYS */;

-- Zrzut struktury tabela discordbot.events
CREATE TABLE IF NOT EXISTS `events` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(90) DEFAULT NULL,
  `Date` date NOT NULL DEFAULT '0000-00-00',
  `Time` time NOT NULL DEFAULT '00:00:00',
  `Place` varchar(90) DEFAULT NULL,
  `HostId` int(11) DEFAULT NULL,
  PRIMARY KEY (`Id`),
  KEY `HostId` (`HostId`),
  CONSTRAINT `events_ibfk_1` FOREIGN KEY (`HostId`) REFERENCES `users` (`Id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli discordbot.events: ~4 rows (około)
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`Id`, `Name`, `Date`, `Time`, `Place`, `HostId`) VALUES
	(3, 'kolokwium', '2022-01-10', '12:12:12', 'Wroclaw', NULL),
	(4, 'kolokwium', '2022-01-22', '12:12:12', 'Wroclaw', NULL),
	(7, 'kolokwium', '2021-11-19', '12:00:00', 'c1', NULL),
	(8, 'kolokwium', '2022-01-15', '13:00:00', 'C-1', NULL),
	(9, 'kolokwium', '2022-02-01', '10:00:00', 'online', NULL),
	(10, 'egzamin', '2022-02-02', '10:00:00', 'online', NULL),
	(11, 'egzamin', '2022-02-03', '13:00:00', 'online', NULL);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

-- Zrzut struktury procedura discordbot.showDay
DELIMITER //
CREATE PROCEDURE `showDay`(
	IN `d` DATE,
	IN `id` INT
)
BEGIN

SELECT classes.Name,  classes.Date, classes.TimeStart, classes.TimeEnd, classes.Place
FROM classes INNER JOIN classesusers 
	ON classesusers.ClassId = classes.Id 
INNER JOIN users ON
	users.Id = classesusers.UserId
WHERE classes.Date = d AND users.Id = id;

END//
DELIMITER ;

-- Zrzut struktury procedura discordbot.showDaysWithClasses
DELIMITER //
CREATE PROCEDURE `showDaysWithClasses`(
	IN `firstd` DATE,
	IN `lastd` DATE,
	IN `id` INT
)
BEGIN

SELECT DISTINCT classes.Date
FROM classes INNER JOIN classesusers 
	ON classesusers.ClassId = classes.Id 
INNER JOIN users ON
	users.Id = classesusers.UserId
WHERE classes.Date >= firstd AND classes.Date <= lastd AND users.Id = id;


END//
DELIMITER ;

-- Zrzut struktury procedura discordbot.showWeek
DELIMITER //
CREATE PROCEDURE `showWeek`(
	IN `d` DATE,
	IN `id` INT
)
BEGIN

SELECT classes.Name,  classes.Date, classes.TimeStart, classes.TimeEnd, classes.Place
FROM classes INNER JOIN classesusers 
	ON classesusers.ClassId = classes.Id 
INNER JOIN users ON
	users.Id = classesusers.UserId
WHERE classes.Date >= d AND classes.Date <= d+7 AND users.Id = id;


END//
DELIMITER ;

-- Zrzut struktury procedura discordbot.showWeekForFew
DELIMITER //
CREATE PROCEDURE `showWeekForFew`(
	IN `d` DATE,
	IN `somestring` VARCHAR(255)
)
BEGIN

	 SELECT DISTINCT classes.Name,  classes.Date, classes.TimeStart, classes.TimeEnd, classes.Place
	 	FROM classes INNER JOIN classesusers 
	 		ON classesusers.ClassId = classes.Id 
	 	INNER JOIN users ON
			users.Id = classesusers.UserId 
	 	WHERE classes.Date >= d AND classes.Date <= d+7 AND FIND_IN_SET (users.Id ,somestring);

END//
DELIMITER ;

-- Zrzut struktury tabela discordbot.users
CREATE TABLE IF NOT EXISTS `users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nick` varchar(90) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Nick` (`Nick`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli discordbot.users: ~2 rows (około)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`Id`, `Nick`) VALUES
	(1, 'Cybulski'),
	(2, 'malgi');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
