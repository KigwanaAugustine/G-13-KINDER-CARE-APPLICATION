-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 25, 2022 at 07:34 AM
-- Server version: 10.4.22-MariaDB
-- PHP Version: 7.4.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `kindercare_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `activationrequest`
--

CREATE TABLE `activationrequest` (
  `requestNumber` int(11) NOT NULL,
  `userName` varchar(25) NOT NULL,
  `userCode` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `assignmentID` int(11) NOT NULL,
  `assignmentName` varchar(50) NOT NULL,
  `characterArray` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`characterArray`)),
  `startTime` datetime(6) NOT NULL,
  `endTime` datetime(6) NOT NULL,
  `userName` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `assignmentcharacter`
--

CREATE TABLE `assignmentcharacter` (
  `assignmentID` int(11) NOT NULL,
  `character` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `character`
--

CREATE TABLE `character` (
  `character` varchar(1) NOT NULL,
  `characterPositions` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`characterPositions`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `marks`
--

CREATE TABLE `marks` (
  `userCode` varchar(10) NOT NULL,
  `assignmentID` int(11) NOT NULL,
  `score` int(11) NOT NULL,
  `comment` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `pupil`
--

CREATE TABLE `pupil` (
  `userCode` varchar(10) NOT NULL,
  `firstName` varchar(15) NOT NULL,
  `lastName` varchar(15) NOT NULL,
  `phoneNumber` varchar(10) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `userName` varchar(25) NOT NULL,
  `assignmentID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `teacher`
--

CREATE TABLE `teacher` (
  `userName` varchar(25) NOT NULL,
  `fname` varchar(15) NOT NULL,
  `lname` varchar(15) NOT NULL,
  `passWord` varchar(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activationrequest`
--
ALTER TABLE `activationrequest`
  ADD PRIMARY KEY (`requestNumber`),
  ADD KEY `userName` (`userName`),
  ADD KEY `userCode` (`userCode`);

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`assignmentID`),
  ADD KEY `userName` (`userName`);

--
-- Indexes for table `assignmentcharacter`
--
ALTER TABLE `assignmentcharacter`
  ADD KEY `assignmentID` (`assignmentID`),
  ADD KEY `character` (`character`);

--
-- Indexes for table `character`
--
ALTER TABLE `character`
  ADD PRIMARY KEY (`character`);

--
-- Indexes for table `marks`
--
ALTER TABLE `marks`
  ADD PRIMARY KEY (`userCode`),
  ADD KEY `userCode` (`userCode`),
  ADD KEY `assignmentID` (`assignmentID`);

--
-- Indexes for table `pupil`
--
ALTER TABLE `pupil`
  ADD PRIMARY KEY (`userCode`),
  ADD KEY `userName` (`userName`),
  ADD KEY `assignmentID` (`assignmentID`);

--
-- Indexes for table `teacher`
--
ALTER TABLE `teacher`
  ADD PRIMARY KEY (`userName`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activationrequest`
--
ALTER TABLE `activationrequest`
  MODIFY `requestNumber` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `assignment`
--
ALTER TABLE `assignment`
  MODIFY `assignmentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activationrequest`
--
ALTER TABLE `activationrequest`
  ADD CONSTRAINT `pupilRequest` FOREIGN KEY (`userCode`) REFERENCES `pupil` (`userCode`),
  ADD CONSTRAINT `teacherRequest` FOREIGN KEY (`userName`) REFERENCES `teacher` (`userName`);

--
-- Constraints for table `assignment`
--
ALTER TABLE `assignment`
  ADD CONSTRAINT `teacherAssignment` FOREIGN KEY (`userName`) REFERENCES `teacher` (`userName`);

--
-- Constraints for table `assignmentcharacter`
--
ALTER TABLE `assignmentcharacter`
  ADD CONSTRAINT `assignmentCharacter1` FOREIGN KEY (`assignmentID`) REFERENCES `assignment` (`assignmentID`),
  ADD CONSTRAINT `assignmentCharacter2` FOREIGN KEY (`character`) REFERENCES `character` (`character`);

--
-- Constraints for table `marks`
--
ALTER TABLE `marks`
  ADD CONSTRAINT `assignmentMark` FOREIGN KEY (`assignmentID`) REFERENCES `assignment` (`assignmentID`),
  ADD CONSTRAINT `pupilMark` FOREIGN KEY (`userCode`) REFERENCES `pupil` (`userCode`);

--
-- Constraints for table `pupil`
--
ALTER TABLE `pupil`
  ADD CONSTRAINT `pupilAssignment` FOREIGN KEY (`assignmentID`) REFERENCES `assignment` (`assignmentID`),
  ADD CONSTRAINT `teacherPupil` FOREIGN KEY (`userName`) REFERENCES `teacher` (`userName`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
