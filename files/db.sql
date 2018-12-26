DROP DATABASE IF EXISTS `challenges`;
CREATE DATABASE `challenges` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE challenges;
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(16) NULL,
  `password` varchar(32) NULL,
  `profile` text NULL,
  PRIMARY KEY (`username`)
);