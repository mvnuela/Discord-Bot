-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Wersja serwera:               10.5.6-MariaDB - mariadb.org binary distribution
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
  `Date` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `Place` varchar(90) DEFAULT NULL,
  `Category` enum('test','exam','exercises','temporary') DEFAULT NULL,
  PRIMARY KEY (`Id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli discordbot.classes: ~0 rows (około)
DELETE FROM `classes`;
/*!40000 ALTER TABLE `classes` DISABLE KEYS */;
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

-- Zrzucanie danych dla tabeli discordbot.classesusers: ~0 rows (około)
DELETE FROM `classesusers`;
/*!40000 ALTER TABLE `classesusers` DISABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli discordbot.events: ~4 rows (około)
DELETE FROM `events`;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`Id`, `Name`, `Date`, `Time`, `Place`, `HostId`) VALUES
	(3, 'kolokwium', '2022-01-10', '12:12:12', 'Wroclaw', NULL),
	(4, 'kolokwium', '2022-01-22', '12:12:12', 'Wroclaw', NULL),
	(6, 'Egzamin', '2022-01-16', '12:12:12', 'Wroclaw', NULL),
	(7, 'kolokwium', '2021-11-19', '12:00:00', 'c1', NULL);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

-- Zrzut struktury tabela discordbot.users
CREATE TABLE IF NOT EXISTS `users` (
  `Id` int(11) NOT NULL AUTO_INCREMENT,
  `Nick` varchar(90) NOT NULL,
  PRIMARY KEY (`Id`),
  UNIQUE KEY `Nick` (`Nick`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- Zrzucanie danych dla tabeli discordbot.users: ~0 rows (około)
DELETE FROM `users`;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
