-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 19, 2025 at 12:24 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `skillswaphub`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `adminID` varchar(255) NOT NULL,
  `adminName` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `announcement`
--

CREATE TABLE `announcement` (
  `announcementID` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `adminID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `authprovider`
--

CREATE TABLE `authprovider` (
  `authProviderID` int(11) NOT NULL,
  `providerName` varchar(255) NOT NULL,
  `providerUserID` varchar(255) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `badge`
--

CREATE TABLE `badge` (
  `badgeID` int(11) NOT NULL,
  `badgeName` varchar(255) NOT NULL,
  `badgeLevel` int(11) NOT NULL,
  `badgeDescription` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `challenge`
--

CREATE TABLE `challenge` (
  `challengeID` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `rewardXP` int(11) NOT NULL,
  `skillID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE `comments` (
  `commentID` int(11) NOT NULL,
  `content` text NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `contextType` enum('Post','Thread') NOT NULL,
  `contextID` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `connectionrequest`
--

CREATE TABLE `connectionrequest` (
  `userID` int(11) NOT NULL,
  `touserID` int(11) NOT NULL,
  `status` enum('Pending','Accepted','Rejected') NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `emailverification`
--

CREATE TABLE `emailverification` (
  `eVerifyID` int(11) NOT NULL,
  `eToken` varchar(255) NOT NULL,
  `isVerified` tinyint(1) DEFAULT 0,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `group`
--

CREATE TABLE `group` (
  `groupID` int(11) NOT NULL,
  `groupName` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `groupPhoto` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `groupmember`
--

CREATE TABLE `groupmember` (
  `groupID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `role` enum('Teacher','Learner','Admin') NOT NULL,
  `joinedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `approved` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `loginhistory`
--

CREATE TABLE `loginhistory` (
  `loginHistoryID` int(11) NOT NULL,
  `loginTimestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `ipAddress` varchar(255) NOT NULL,
  `deviceInfo` varchar(255) NOT NULL,
  `isSuccessful` tinyint(1) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notification`
--

CREATE TABLE `notification` (
  `notificationID` int(11) NOT NULL,
  `content` text NOT NULL,
  `sentAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `isRead` tinyint(1) DEFAULT 0,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notificationmute`
--

CREATE TABLE `notificationmute` (
  `muteID` int(11) NOT NULL,
  `isMute` tinyint(1) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `contextType` varchar(255) NOT NULL,
  `contextID` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `passreset`
--

CREATE TABLE `passreset` (
  `passResetID` int(11) NOT NULL,
  `resetToken` varchar(255) NOT NULL,
  `RequestedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `ExpiresAt` datetime NOT NULL,
  `resetStatus` tinyint(1) DEFAULT 0,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `post`
--

CREATE TABLE `post` (
  `postID` int(11) NOT NULL,
  `content` text NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `groupID` int(11) NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `reportID` int(11) NOT NULL,
  `reportType` enum('Spam','Harassment','Abuse','Other') NOT NULL,
  `ContentID` int(11) NOT NULL,
  `status` enum('Pending','Reviewed','Resolved') NOT NULL,
  `contentContext` text NOT NULL,
  `userID` int(11) NOT NULL,
  `adminID` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resource`
--

CREATE TABLE `resource` (
  `resourceID` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `contentType` int(11) NOT NULL,
  `description` text NOT NULL,
  `uploadAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `adminID` varchar(255) NOT NULL,
  `categoryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `resourcecategory`
--

CREATE TABLE `resourcecategory` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE `session` (
  `sessionID` int(11) NOT NULL,
  `scheduledAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `sessionLink` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `duration` int(11) NOT NULL,
  `status` enum('Scheduled','Completed','Cancelled') NOT NULL,
  `title` varchar(255) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `updatedAt` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessionfeedback`
--

CREATE TABLE `sessionfeedback` (
  `rating` int(11) NOT NULL,
  `comment` text NOT NULL,
  `submittedAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `userID` int(11) NOT NULL,
  `sessionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessionparticipant`
--

CREATE TABLE `sessionparticipant` (
  `userID` int(11) NOT NULL,
  `sessionID` int(11) NOT NULL,
  `role` enum('Participant','Instructor') NOT NULL,
  `joinedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessionskill`
--

CREATE TABLE `sessionskill` (
  `skillID` int(11) NOT NULL,
  `sessionID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skill`
--

CREATE TABLE `skill` (
  `skillID` int(11) NOT NULL,
  `SkillName` varchar(255) NOT NULL,
  `categoryID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `skillcategory`
--

CREATE TABLE `skillcategory` (
  `categoryID` int(11) NOT NULL,
  `categoryName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tag`
--

CREATE TABLE `tag` (
  `tagID` int(11) NOT NULL,
  `tagName` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `thread`
--

CREATE TABLE `thread` (
  `threadID` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `thread_tag`
--

CREATE TABLE `thread_tag` (
  `threadID` int(11) NOT NULL,
  `tagID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userID` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `dp` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `phone` varchar(20) NOT NULL,
  `country` varchar(100) NOT NULL,
  `division` varchar(100) NOT NULL,
  `district` varchar(100) NOT NULL,
  `bio` text DEFAULT NULL,
  `dob` date NOT NULL,
  `isPublic` tinyint(1) DEFAULT 0,
  `isVerified` tinyint(1) DEFAULT 0,
  `currentRating` decimal(3,2) DEFAULT 0.00,
  `lastActiveAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userbadge`
--

CREATE TABLE `userbadge` (
  `userID` int(11) NOT NULL,
  `badgeID` int(11) NOT NULL,
  `earnedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userchallenge`
--

CREATE TABLE `userchallenge` (
  `challengeID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `completedAt` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `userskill`
--

CREATE TABLE `userskill` (
  `skillID` int(11) NOT NULL,
  `userID` int(11) NOT NULL,
  `levelAchieved` int(11) NOT NULL,
  `currentXP` int(11) NOT NULL,
  `lastUpdated` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vote`
--

CREATE TABLE `vote` (
  `voteID` int(11) NOT NULL,
  `createdAt` timestamp NOT NULL DEFAULT current_timestamp(),
  `contextID` int(11) NOT NULL,
  `contextType` enum('Post','Thread') NOT NULL,
  `userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`adminID`);

--
-- Indexes for table `announcement`
--
ALTER TABLE `announcement`
  ADD PRIMARY KEY (`announcementID`),
  ADD KEY `adminID` (`adminID`);

--
-- Indexes for table `authprovider`
--
ALTER TABLE `authprovider`
  ADD PRIMARY KEY (`authProviderID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `badge`
--
ALTER TABLE `badge`
  ADD PRIMARY KEY (`badgeID`);

--
-- Indexes for table `challenge`
--
ALTER TABLE `challenge`
  ADD PRIMARY KEY (`challengeID`),
  ADD KEY `skillID` (`skillID`);

--
-- Indexes for table `comments`
--
ALTER TABLE `comments`
  ADD PRIMARY KEY (`commentID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `connectionrequest`
--
ALTER TABLE `connectionrequest`
  ADD PRIMARY KEY (`userID`,`touserID`),
  ADD KEY `touserID` (`touserID`);

--
-- Indexes for table `emailverification`
--
ALTER TABLE `emailverification`
  ADD PRIMARY KEY (`eVerifyID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `group`
--
ALTER TABLE `group`
  ADD PRIMARY KEY (`groupID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `groupmember`
--
ALTER TABLE `groupmember`
  ADD PRIMARY KEY (`groupID`,`userID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `loginhistory`
--
ALTER TABLE `loginhistory`
  ADD PRIMARY KEY (`loginHistoryID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `notification`
--
ALTER TABLE `notification`
  ADD PRIMARY KEY (`notificationID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `notificationmute`
--
ALTER TABLE `notificationmute`
  ADD PRIMARY KEY (`muteID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `passreset`
--
ALTER TABLE `passreset`
  ADD PRIMARY KEY (`passResetID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `post`
--
ALTER TABLE `post`
  ADD PRIMARY KEY (`postID`),
  ADD KEY `groupID` (`groupID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`reportID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `adminID` (`adminID`);

--
-- Indexes for table `resource`
--
ALTER TABLE `resource`
  ADD PRIMARY KEY (`resourceID`),
  ADD KEY `adminID` (`adminID`),
  ADD KEY `categoryID` (`categoryID`);

--
-- Indexes for table `resourcecategory`
--
ALTER TABLE `resourcecategory`
  ADD PRIMARY KEY (`categoryID`);

--
-- Indexes for table `session`
--
ALTER TABLE `session`
  ADD PRIMARY KEY (`sessionID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `sessionfeedback`
--
ALTER TABLE `sessionfeedback`
  ADD PRIMARY KEY (`userID`,`sessionID`),
  ADD KEY `sessionID` (`sessionID`);

--
-- Indexes for table `sessionparticipant`
--
ALTER TABLE `sessionparticipant`
  ADD PRIMARY KEY (`userID`,`sessionID`),
  ADD KEY `sessionID` (`sessionID`);

--
-- Indexes for table `sessionskill`
--
ALTER TABLE `sessionskill`
  ADD PRIMARY KEY (`skillID`,`sessionID`),
  ADD KEY `sessionID` (`sessionID`);

--
-- Indexes for table `skill`
--
ALTER TABLE `skill`
  ADD PRIMARY KEY (`skillID`),
  ADD KEY `categoryID` (`categoryID`);

--
-- Indexes for table `skillcategory`
--
ALTER TABLE `skillcategory`
  ADD PRIMARY KEY (`categoryID`);

--
-- Indexes for table `tag`
--
ALTER TABLE `tag`
  ADD PRIMARY KEY (`tagID`),
  ADD UNIQUE KEY `tagName` (`tagName`);

--
-- Indexes for table `thread`
--
ALTER TABLE `thread`
  ADD PRIMARY KEY (`threadID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `thread_tag`
--
ALTER TABLE `thread_tag`
  ADD PRIMARY KEY (`threadID`,`tagID`),
  ADD KEY `tagID` (`tagID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `phone` (`phone`);

--
-- Indexes for table `userbadge`
--
ALTER TABLE `userbadge`
  ADD PRIMARY KEY (`userID`,`badgeID`),
  ADD KEY `badgeID` (`badgeID`);

--
-- Indexes for table `userchallenge`
--
ALTER TABLE `userchallenge`
  ADD PRIMARY KEY (`challengeID`,`userID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `userskill`
--
ALTER TABLE `userskill`
  ADD PRIMARY KEY (`skillID`,`userID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `vote`
--
ALTER TABLE `vote`
  ADD PRIMARY KEY (`voteID`),
  ADD KEY `userID` (`userID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `announcement`
--
ALTER TABLE `announcement`
  MODIFY `announcementID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `authprovider`
--
ALTER TABLE `authprovider`
  MODIFY `authProviderID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `comments`
--
ALTER TABLE `comments`
  MODIFY `commentID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `emailverification`
--
ALTER TABLE `emailverification`
  MODIFY `eVerifyID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `group`
--
ALTER TABLE `group`
  MODIFY `groupID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `loginhistory`
--
ALTER TABLE `loginhistory`
  MODIFY `loginHistoryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notification`
--
ALTER TABLE `notification`
  MODIFY `notificationID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notificationmute`
--
ALTER TABLE `notificationmute`
  MODIFY `muteID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `passreset`
--
ALTER TABLE `passreset`
  MODIFY `passResetID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `post`
--
ALTER TABLE `post`
  MODIFY `postID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `reportID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resource`
--
ALTER TABLE `resource`
  MODIFY `resourceID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `resourcecategory`
--
ALTER TABLE `resourcecategory`
  MODIFY `categoryID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tag`
--
ALTER TABLE `tag`
  MODIFY `tagID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `thread`
--
ALTER TABLE `thread`
  MODIFY `threadID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vote`
--
ALTER TABLE `vote`
  MODIFY `voteID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `announcement`
--
ALTER TABLE `announcement`
  ADD CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON DELETE CASCADE;

--
-- Constraints for table `authprovider`
--
ALTER TABLE `authprovider`
  ADD CONSTRAINT `authprovider_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `challenge`
--
ALTER TABLE `challenge`
  ADD CONSTRAINT `challenge_ibfk_1` FOREIGN KEY (`skillID`) REFERENCES `skill` (`skillID`);

--
-- Constraints for table `comments`
--
ALTER TABLE `comments`
  ADD CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `connectionrequest`
--
ALTER TABLE `connectionrequest`
  ADD CONSTRAINT `connectionrequest_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE,
  ADD CONSTRAINT `connectionrequest_ibfk_2` FOREIGN KEY (`touserID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `emailverification`
--
ALTER TABLE `emailverification`
  ADD CONSTRAINT `emailverification_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `group`
--
ALTER TABLE `group`
  ADD CONSTRAINT `group_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `groupmember`
--
ALTER TABLE `groupmember`
  ADD CONSTRAINT `groupmember_ibfk_1` FOREIGN KEY (`groupID`) REFERENCES `group` (`groupID`) ON DELETE CASCADE,
  ADD CONSTRAINT `groupmember_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `loginhistory`
--
ALTER TABLE `loginhistory`
  ADD CONSTRAINT `loginhistory_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `notification`
--
ALTER TABLE `notification`
  ADD CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `notificationmute`
--
ALTER TABLE `notificationmute`
  ADD CONSTRAINT `notificationmute_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `passreset`
--
ALTER TABLE `passreset`
  ADD CONSTRAINT `passreset_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `post`
--
ALTER TABLE `post`
  ADD CONSTRAINT `post_ibfk_1` FOREIGN KEY (`groupID`) REFERENCES `group` (`groupID`) ON DELETE CASCADE,
  ADD CONSTRAINT `post_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE,
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON DELETE CASCADE;

--
-- Constraints for table `resource`
--
ALTER TABLE `resource`
  ADD CONSTRAINT `resource_ibfk_1` FOREIGN KEY (`adminID`) REFERENCES `admin` (`adminID`) ON DELETE CASCADE,
  ADD CONSTRAINT `resource_ibfk_2` FOREIGN KEY (`categoryID`) REFERENCES `resourcecategory` (`categoryID`) ON DELETE CASCADE;

--
-- Constraints for table `session`
--
ALTER TABLE `session`
  ADD CONSTRAINT `session_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `sessionfeedback`
--
ALTER TABLE `sessionfeedback`
  ADD CONSTRAINT `sessionfeedback_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  ADD CONSTRAINT `sessionfeedback_ibfk_2` FOREIGN KEY (`sessionID`) REFERENCES `session` (`sessionID`);

--
-- Constraints for table `sessionparticipant`
--
ALTER TABLE `sessionparticipant`
  ADD CONSTRAINT `sessionparticipant_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  ADD CONSTRAINT `sessionparticipant_ibfk_2` FOREIGN KEY (`sessionID`) REFERENCES `session` (`sessionID`);

--
-- Constraints for table `sessionskill`
--
ALTER TABLE `sessionskill`
  ADD CONSTRAINT `sessionskill_ibfk_1` FOREIGN KEY (`skillID`) REFERENCES `skill` (`skillID`),
  ADD CONSTRAINT `sessionskill_ibfk_2` FOREIGN KEY (`sessionID`) REFERENCES `session` (`sessionID`);

--
-- Constraints for table `skill`
--
ALTER TABLE `skill`
  ADD CONSTRAINT `skill_ibfk_1` FOREIGN KEY (`categoryID`) REFERENCES `skillcategory` (`categoryID`);

--
-- Constraints for table `thread`
--
ALTER TABLE `thread`
  ADD CONSTRAINT `thread_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;

--
-- Constraints for table `thread_tag`
--
ALTER TABLE `thread_tag`
  ADD CONSTRAINT `thread_tag_ibfk_1` FOREIGN KEY (`threadID`) REFERENCES `thread` (`threadID`) ON DELETE CASCADE,
  ADD CONSTRAINT `thread_tag_ibfk_2` FOREIGN KEY (`tagID`) REFERENCES `tag` (`tagID`) ON DELETE CASCADE;

--
-- Constraints for table `userbadge`
--
ALTER TABLE `userbadge`
  ADD CONSTRAINT `userbadge_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`),
  ADD CONSTRAINT `userbadge_ibfk_2` FOREIGN KEY (`badgeID`) REFERENCES `badge` (`badgeID`);

--
-- Constraints for table `userchallenge`
--
ALTER TABLE `userchallenge`
  ADD CONSTRAINT `userchallenge_ibfk_1` FOREIGN KEY (`challengeID`) REFERENCES `challenge` (`challengeID`),
  ADD CONSTRAINT `userchallenge_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`);

--
-- Constraints for table `userskill`
--
ALTER TABLE `userskill`
  ADD CONSTRAINT `userskill_ibfk_1` FOREIGN KEY (`skillID`) REFERENCES `skill` (`skillID`),
  ADD CONSTRAINT `userskill_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`);

--
-- Constraints for table `vote`
--
ALTER TABLE `vote`
  ADD CONSTRAINT `vote_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `user` (`userID`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
