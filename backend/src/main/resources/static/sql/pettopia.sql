-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.1

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pettopia`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin_users`
--
create database pettopia;
use pettopia;

    CREATE TABLE `admin_users` (
  `admin_id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Encrypted form of the default passwords: password1, password2, password3, etc. (based on admin_id)',
  `role` enum('admin','manager','staff') DEFAULT 'staff',
  `status` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `last_login` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `admin_users`
--

INSERT INTO `admin_users` (`admin_id`, `username`, `email`, `password_hash`, `role`, `status`, `created_at`, `updated_at`, `last_login`, `notes`) VALUES
(1, 'admin_jane', 'jane@pettopia.com', '$2a$10$ipz7vepCc0Cw8u0CaWcJZO1/X6PsgjQzitTDXOtTnshwm5/uRJPiy', 'admin', 'active', '2025-03-12 10:22:00', '2025-10-18 15:12:56', '2025-10-18 08:42:00', 'Super admin - full privileges'),
(2, 'mark_ops', 'mark@pettopia.com', '$2a$10$G4arZYCb1XfnKd3of5NeqeeEiuiBOAiOXXkKTT/rlufuihqYuGZIO', 'manager', 'active', '2025-04-09 14:15:00', '2025-10-18 15:12:57', '2025-10-16 10:55:00', 'Oversees order processing'),
(3, 'lucy_stock', 'lucy@pettopia.com', '$2a$10$gs9QDDg7xuzQswZB1N2c5.USaskweFb.plRdZAbm8ovdZEnTLroOC', 'staff', 'active', '2025-05-17 09:00:00', '2025-10-18 15:12:57', '2025-10-17 16:40:00', 'Manages warehouse inventory'),
(4, 'tom_support', 'tom@pettopia.com', '$2a$10$QfGt1fxAVDN72FjbkAX8p.pU9hMItlxrjsb/5EHur9JffCra2ibAe', 'staff', 'inactive', '2025-02-25 11:48:00', '2025-10-18 15:12:57', '2025-07-01 12:00:00', 'Temporarily on leave'),
(5, 'ella_marketing', 'ella@pettopia.com', '$2a$10$6H5bwNpFJzPQJa6NkS2H.OodWFohhjtZrWzLXOGy782TjCc/u1oe.', 'manager', 'active', '2025-06-06 13:32:00', '2025-10-18 15:12:57', '2025-10-17 11:10:00', 'Handles promotions and customer emails');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `category_id` int(11) NOT NULL,
  `name` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`category_id`, `name`) VALUES
(1, 'Dog Supplies'),
(2, 'Cat Supplies'),
(3, 'Bird Supplies'),
(4, 'Small Pet Supplies'),
(5, 'Aquarium Supplies'),
(6, 'Pet Food'),
(7, 'Pet Accessories'),
(8, 'Pet Toys'),
(9, 'Pet Grooming'),
(10, 'Pet Furniture'),
(11, 'Aquarium'),
(12, 'Pet Housing'),
(13, 'Pet Play'),
(14, 'Pet Travel'),
(15, 'General Pet Supplies');

-- --------------------------------------------------------

--
-- Table structure for table `customers`
--

CREATE TABLE `customers` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `country` varchar(50) DEFAULT NULL,
  `postcode` varchar(10) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `status` enum('active','inactive','banned') DEFAULT 'active',
  `notes` text DEFAULT NULL,
  `marketing_opt_in` tinyint(1) DEFAULT 0,
  `password_hash` varchar(255) DEFAULT NULL COMMENT 'Initial password is "password" + customer_id (e.g. password23)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customers`
--

INSERT INTO `customers` (`customer_id`, `first_name`, `last_name`, `email`, `phone`, `address`, `city`, `country`, `postcode`, `created_at`, `updated_at`, `status`, `notes`, `marketing_opt_in`, `password_hash`) VALUES
(1, 'John', 'Burke', 'jburke74@gmail.com', '0871234567', '123 Kildare Street', 'Dublin', 'Ireland', 'D01 AB23', '2025-05-24 14:20:53', '2025-10-18 17:00:22', 'active', NULL, 1, '$2a$10$0TUzyMdzbf/n3dWHlygy6.j495nD/ZqfCtOehWPBu5WKrp1YQL9ta'),
(2, 'Jane', 'Smith', 'janesmith@hotmail.com', '0869876543', '456 High Street', 'London', 'United Kingdom', 'W1B 2ES', '2025-09-09 14:20:53', '2025-10-18 17:00:22', 'active', NULL, 1, '$2a$10$BHzbbtL3ImFTzPNXoEL.WenKSMxiDHmNYmBOU.GL1ALONpCoF.dDe'),
(3, 'Mike', 'Jones', 'mjones@yahoo.com', '0856352532', '789 Park Avenue', 'Belfast', 'Northern Ireland', 'BT1 1AA', '2025-05-28 14:20:53', '2025-10-18 17:00:22', 'active', 'No response to marketing emails', 0, '$2a$10$yNYIYdIwH1t8lc/RIcam6.7rciEXQ/28EfL5rBZptHbHYW66Fj4Hy'),
(4, 'Sarah', 'Wilson', 'swilson@gmail.com', '0857854251', '321 Elm Street', 'Galway', 'Ireland', 'H91 XY12', '2025-09-22 14:20:53', '2025-10-18 17:00:22', 'active', 'Customer requested refund', 1, '$2a$10$uqDCvdsbJHWrWiO3wSiVE.KvkrzIVC03FB7UbL1cDfwX47p0Fej62'),
(5, 'Tom', 'Johnson', 'tjohnson@aol.com', '0832653685', '567 Oak Avenue', 'Cork', 'Ireland', 'T12 AB34', '2025-06-27 14:20:53', '2025-10-18 17:00:22', 'active', NULL, 1, '$2a$10$VmrEii9L5tclLc0jB62uvOdfYHmHAV1WNJuhFZWHuhYH5Vrt4Jm9S'),
(6, 'Emily', 'Brown', 'ebrown@hotmail.com', '0876654712', '901 Maple Road', 'Dublin', 'Ireland', 'D02 CD45', '2025-06-15 14:20:53', '2025-10-18 17:00:23', 'active', NULL, 1, '$2a$10$XlI60MaYnFgvVHA/W7AzquSUW4nf7dbQgb/36ltji8N7nkzTd4Acq'),
(7, 'David', 'Taylor', 'dtaylor@gmail.com', '0865758520', '234 Pine Street', 'Belfast', 'Northern Ireland', 'BT2 2BB', '2025-07-06 14:20:53', '2025-10-18 17:00:23', 'active', NULL, 1, '$2a$10$EvVA0e8UEuJyjyj/sDQQCe9ZuhOCju4soLuPtxG36vIyazAoauFuy'),
(8, 'Lucy', 'Clark', 'lclark@yahoo.com', '0875542636', '789 Birch Lane', 'Manchester', 'United Kingdom', 'M1 1AB', '2025-06-01 14:20:53', '2025-10-18 17:00:23', 'active', 'No response to marketing emails', 0, '$2a$10$2ERsWjhJ32DOuIH5FFPSdOOjaS9WD3XjpFcZDbQZiesKX1OsM0nN2'),
(9, 'Peter', 'Davis', 'pdavis@aol.com', '0856635258', '432 Cedar Court', 'Dublin', 'Ireland', 'D04 EF56', '2025-07-30 14:20:53', '2025-10-18 17:00:23', 'active', NULL, 0, '$2a$10$JIMdS/6plTSj1ucrSHA2W.7D2OHu6PPOJmEXFdEWql8waR3SI/TAy'),
(10, 'Anna', 'Roberts', 'aroberts@hotmail.com', '0878862514', '876 Oak Street', 'Cork', 'Ireland', 'T23 GH78', '2025-07-04 14:20:53', '2025-10-18 17:00:23', 'inactive', 'Reported delivery issue', 0, '$2a$10$CMN0LO66RAIA5aXODwzxo.phIS4gtiV394gNqPmn42SMb2jDuuRkG'),
(11, 'Emma', 'Murphy', 'emma.murphy@gmail.com', '086 789 0133', '123 Main Street', 'Cork', 'Ireland', 'C4X2K7', '2025-09-23 14:20:53', '2025-10-18 17:00:24', 'inactive', NULL, 1, '$2a$10$nbCzx4ybOPw.7RgOLQru/et9jDG/1Xr6gHf2dODn9MfIcVuUwJSmO'),
(12, 'David', 'Walsh', 'david.walsh@hotmail.com', '087 901 2741', '456 Park Avenue', 'Dublin', 'Ireland', 'D7Y3T1', '2025-08-06 14:20:53', '2025-10-18 17:00:24', 'inactive', NULL, 1, '$2a$10$I.Shp7dK7j8sDhsW4Fo9T.UCyEDaOL6rwmA0pu9MpAgVWp1UPHxHe'),
(13, 'Sarah', 'O\'Neill', 'sarah.oneill@yahoo.com', '089 567 8965', '789 Oak Drive', 'Galway', 'Ireland', 'G2Z9P6', '2025-07-22 14:20:53', '2025-10-18 17:00:24', 'active', NULL, 1, '$2a$10$RqDx8gp1i.3Kya4Ykhoec.NyMVUJdwBTkSB1uXDPTgjdsXsubc4r2'),
(14, 'John', 'Byrne', 'john.byrne@aol.com', '086 9823434', '321 Elm Street', 'Limerick', 'Ireland', 'L9X5F4', '2025-06-17 14:20:53', '2025-10-18 17:00:24', 'active', NULL, 0, '$2a$10$Ppd1dCEzx3TG9RUEDlzXouwxdDyU1ULh7/EOlUIuT8S2rZdF/hb42'),
(15, 'Aoife', 'Ryan', 'aoife.ryan@gmail.com', '086 345 6566', '456 Main Street', 'Waterford', 'Ireland', 'W1Y2T8', '2025-07-01 14:20:53', '2025-10-18 17:00:24', 'inactive', 'Customer requested refund', 0, '$2a$10$5hpHv0oGJXKEvZjL/v/Geek5zUURBRZEcW.kcHawEkorwhu2BsNwy'),
(16, 'Liam', 'Smith', 'liam.smith@hotmail.com', '085 123 4567', '54 Oakwood Avenue', 'London', 'UK', 'SW14 8AZ', '2025-08-18 14:20:53', '2025-10-18 17:00:24', 'active', 'Customer requested refund', 1, '$2a$10$KrNA8xN5rDq89ECPzoq/AedpAgaRIQHu8TSctDK6lYe0pBfvZwEUy'),
(17, 'Grace', 'Wilson', 'grace.wilson@gmail.com', '085 234 5678', '78 Maple Street', 'Birmingham', 'UK', 'B23 7KL', '2025-10-17 14:20:53', '2025-10-18 17:00:25', 'active', 'Customer requested refund', 0, '$2a$10$IKEUExQZWEqvvKMOSoHcrOrFGQ5lNey9O1bTRWoYhGu/3r0Frj3U.'),
(18, 'Seán', 'O\'Connor', 'sean.oconnor@yahoo.com', '086 345 6789', '42 South Terrace', 'Dublin', 'Ireland', 'D08 CX94', '2025-10-09 14:20:53', '2025-10-18 17:00:25', 'active', NULL, 0, '$2a$10$NLXP6iTRonibBYTHkC10QOk3u5kaud8tny3Eht8rQM1SWQNHOLImy'),
(19, 'Oliver', 'Davis', 'oliver.davis@hotmail.com', '083 456 7890', '15 Rosewood Drive', 'Galway', 'Ireland', 'H91 Y0F2', '2025-04-22 14:20:53', '2025-10-18 17:00:25', 'active', NULL, 0, '$2a$10$A6sFGuVZ.70AHEcoAq2wnu/kN9BgUqH1aZUdMVIwbRT8SivZeyPfW'),
(20, 'Sophie', 'Johnson', 'sophie.johnson@aol.com', '089 567 8901', '97 Elm Street', 'Cork', 'Ireland', 'T12 H3C9', '2025-07-21 14:20:53', '2025-10-18 17:00:25', 'active', NULL, 1, '$2a$10$BQGXeNl8lqWvRx3mbI4ZNOAg5Aj9CXr9ph2hi7tke9d/IzAdRMz4.'),
(21, 'Tom', 'Taylor', 'tom.taylor@hotmail.com', '085 678 9012', '22 Park View', 'Belfast', 'UK', 'BT9 6FR', '2025-08-04 14:20:53', '2025-10-18 17:00:25', 'active', NULL, 0, '$2a$10$v30jOikjvogV8XpHhTdk6OvS7mc5gHFjRv14.dh0paROP09I2Xm0e'),
(22, 'Amelia', 'Smith', 'amelia.smith@gmail.com', '086 789 0123', '51 Cedar Road', 'Dublin', 'Ireland', 'D07 W4E0', '2025-07-15 14:20:53', '2025-10-18 17:00:25', 'active', NULL, 0, '$2a$10$khLObRV7xSHEbNgWk3zXUOre.fTsbwpNUEVsTOZNzSW0xoWrUvgAC'),
(23, 'Jack', 'Williams', 'jack.williams@yahoo.com', '083 890 1234', '73 Ashwood Lane', 'Birmingham', 'UK', 'B17 9BN', '2025-09-01 14:20:53', '2025-10-18 17:00:25', 'active', 'No response to marketing emails', 0, '$2a$10$g7zKt05L9usrtkiO/O0c3.w.lIdxEbQPRzFPpAExpwETY8EDPp/8O'),
(24, 'Ava', 'Jones', 'ava.jones@hotmail.com', '087 901 2345', '16 Beach Road', 'Galway', 'Ireland', 'H91 F6W4', '2025-09-06 14:20:53', '2025-10-18 17:00:26', 'active', NULL, 1, '$2a$10$/NerV7bjj43o9DKlm4CnmuIY8jsSYA/lUpeGGNycTmC01mpegUdVi'),
(25, 'Finn', 'Davies', 'finn.davies@aol.com', '086 012 3456', '37 Beechwood Avenue', 'Cork', 'Ireland', 'T23 K9Y4', '2025-09-24 14:20:53', '2025-10-18 17:00:26', 'active', NULL, 0, '$2a$10$/2Hpkx7q8aitfCApKFltsOM/rAjIFkwPbqsspSBUMB07FelXFJeUy'),
(26, 'Freya', 'Brown', 'freya.brown@gmail.com', '085 123 4567', '98 Hilltop Road', 'London', 'UK', 'NW8 9HB', '2025-07-29 14:20:53', '2025-10-18 17:00:26', 'active', NULL, 0, '$2a$10$OoXmKDEJcVNOiR95RKrZ1O2ieC6kc9DNQUtgP1H1/oaFbtOfRxK3O'),
(27, 'Eoin', 'McCarthy', 'eoin.mccarthy@yahoo.com', '086 234 5678', '24 Glenmore Drive', 'Belfast', 'UK', 'BT8 7YX', '2025-08-15 14:20:53', '2025-10-18 17:00:26', 'active', 'Reported delivery issue', 1, '$2a$10$UGC3CHetU.xwPoDQSSKao.TrxaJoKd4wLpOdrt6iWNLFVUOZbXA0i'),
(28, 'Lilly', 'Wilson', 'lilly.wilson@hotmail.com', '083 345 6789', '62 Cedarwood Road', 'Dublin', 'Ireland', 'D09 P3E2', '2025-06-07 14:20:53', '2025-10-18 17:00:26', 'active', NULL, 1, '$2a$10$k5cjCR/n1Xt.oXM7m/sKGuiJdoQLjLyuyO.xxITqBbypHdQpxw2fq'),
(29, 'Harry', 'Kelly', 'harry.kelly@aol.com', '089 456 7890', '51 Rockfield Close', 'Galway', 'Ireland', 'H91 Y7V2', '2025-05-09 14:20:53', '2025-10-18 17:00:26', 'active', NULL, 1, '$2a$10$QZTtzswmd3wIaGiPiuAbNu4WArPuCxH2ufrDhW.o75j/WjoUEI1GK'),
(30, 'Mia', 'Robinson', 'mia.robinson@gmail.com', '085 567 8901', '19 Main Street', 'Birmingham', 'UK', 'B16 8HD', '2025-07-28 14:20:53', '2025-10-18 17:00:27', 'active', NULL, 1, '$2a$10$.2yF44erDUfje3Ps0hcGOe3WEsQM.1ggpVSpObZ9Mdgjz/B2KsMDe'),
(31, 'Ruth', 'Mullen', 'ruthmullen@yahoo.com', '0851234567', '12 Oak Drive', 'Limerick', 'Ireland', 'V94 7WT', '2025-07-02 14:20:53', '2025-10-18 17:00:27', 'active', NULL, 0, '$2a$10$eXlnPlxLpK60AxZ9RFVIS.2qBDGPI69RHPunjrIT5IjjfXjviYDhq'),
(32, 'Tina', 'Holland', 'tinaholland@hotmail.com', '0861234567', '10 Chestnut Avenue', 'London', 'UK', 'SW1A 2AA', '2025-08-16 14:20:53', '2025-10-18 17:00:27', 'inactive', 'Reported delivery issue', 0, '$2a$10$MmZOmMPnNDkyvG.GSJHrWe0Z82BFcRKv2DiH6R0WrLNVI7x9PAoBe'),
(33, 'Connor', 'Doyle', 'connordoyle@gmail.com', '0831234567', '5 Elm Street', 'Galway', 'Ireland', 'H91 5YF', '2025-09-06 14:20:53', '2025-10-18 17:00:27', 'active', NULL, 1, '$2a$10$Bt5RXSg0nbwJZmsVg9VbjuE9K8Vk7ZflDmQrb6Qj8brLBX0lO71hK'),
(34, 'Kerry', 'Brennan', 'kerrybrennan@aol.com', '0871234567', '15 High Street', 'Belfast', 'UK', 'BT1 2AA', '2025-08-16 14:20:53', '2025-10-18 17:00:27', 'active', 'Customer requested refund', 0, '$2a$10$t/HXPZ95KqDMtdzN8GlVU.ob1ETdo9U6sdA.UXP4DVmWS70PJtxAa'),
(35, 'Gerald', 'O\'Neill', 'geraldoneill@yahoo.com', '0851234567', '20 Maple Road', 'Dublin', 'Ireland', 'D02 X283', '2025-07-08 14:20:53', '2025-10-18 17:00:27', 'banned', 'VIP customer – frequent buyer', 0, '$2a$10$aISAPZw//0h9CniwbXVj5u1URm/JJ8VvquR5.eYekuzDM4ftLlMTi'),
(36, 'Sharon', 'Simpson', 'sharonsimpson@hotmail.com', '0861234567', '25 Oak Avenue', 'Edinburgh', 'UK', 'EH1 1AA', '2025-06-21 14:20:53', '2025-10-18 17:00:27', 'active', 'Reported delivery issue', 0, '$2a$10$36AIRrOWSt9jb0k7RCuxxOStf30bav5vuC9R/.ruSB/73QB566CRW'),
(37, 'David', 'Kelly', 'davidkelly@gmail.com', '0831234567', '7 Elm Street', 'Cork', 'Ireland', 'T12 6WT', '2025-07-28 14:20:53', '2025-10-18 17:00:27', 'active', 'No response to marketing emails', 0, '$2a$10$srw9W6HiFLzhksdbH7CHWuB9DJdWSnqZRJ4FIfRRBEmM5U6i64GJ2'),
(38, 'Mandy', 'Rogers', 'mandyrogers@aol.com', '0871234567', '30 Pine Drive', 'Cardiff', 'UK', 'CF10 1AA', '2025-06-10 14:20:53', '2025-10-18 17:00:28', 'active', 'No response to marketing emails', 0, '$2a$10$N5A5nz/l1ytBL.G6DiHquuKPMD16bdJMIdmBHPZm/EW3ws4LXKafe'),
(39, 'Sean', 'Walsh', 'seanwalsh@yahoo.com', '0851234567', '40 Oak Road', 'Birmingham', 'UK', 'B1 2AA', '2025-06-19 14:20:53', '2025-10-18 17:00:28', 'active', NULL, 1, '$2a$10$UBAp8MTN8KfPAZY2vlclMuwf/7R3BpmWVFPIljPH.lcQa.TaMJAHC'),
(40, 'Lisa', 'Daly', 'lisadaly@hotmail.com', '0861234567', '8 Maple Avenue', 'Dublin', 'Ireland', 'D08 HN3X', '2025-08-18 14:20:53', '2025-10-18 17:00:28', 'active', NULL, 1, '$2a$10$S5me.m589ZAglf10GB.6hOGl2sq7eiycBpmQ/Rr3HqoTTCJDmrhYK'),
(41, 'Grace', 'Byrne', 'gracebyrne@gmail.com', '0831234567', '9 Elm Street', 'Belfast', 'UK', 'BT2 7AP', '2025-08-06 14:20:53', '2025-10-18 17:00:28', 'active', NULL, 1, '$2a$10$r4F4LGaP7id9ksuOpew4uucjr4/a.j5m9FTuBXEPtP5yB3cfVPEm6'),
(42, 'Patrick', 'McNamara', 'patrickmcnamara@hotmail.com', '0871234567', '13 Chestnut Avenue', 'Manchester', 'UK', 'M1 1AA', '2025-06-26 14:20:53', '2025-10-18 17:00:28', 'active', NULL, 0, '$2a$10$vWg6P6VCX2Z71ijK3D8NPesV07DRGiK0mJTMr7g1IKhfxeVZ3Tp3S'),
(43, 'Ciara', 'O\'Sullivan', 'ciaraosullivan@aol.com', '0851234567', '17 Oak Drive', 'Dublin', 'Ireland', 'D04 C932', '2025-08-01 14:20:53', '2025-10-18 17:00:28', 'active', 'Reported delivery issue', 0, '$2a$10$VsQndyctkHSz0fZAs2Og8..9MiqTnXx6JkxQfzLKO.MeKYx2p5Zim'),
(44, 'Jack', 'O\'Connor', 'jackoconnor@yahoo.com', '0861234567', '22 Maple Road', 'Glasgow', 'UK', 'G1 1AA', '2025-07-19 14:20:53', '2025-10-18 17:00:29', 'active', NULL, 0, '$2a$10$IN1GtuP8ZNRxum/P2PDOPOuJbYhSBwiT6D1NMM1/7sGwVxEVFHAUu'),
(45, 'Aisling', 'Murphy', 'aislingmurphy@gmail.com', '0831234567', '3 Elm Street', 'Galway', 'Ireland', 'H91 892', '2025-05-26 14:20:53', '2025-10-18 17:00:29', 'inactive', 'No response to marketing emails', 0, '$2a$10$3knPtq3Sj/d.tAQmLUboMOj5nBfUtfdUBeGfuomI/YaJYnanBaj96'),
(46, 'Terry', 'Boyle', 'terboyle@gmail.com', '0871234567', '123 Dorset St', 'Dublin', 'Ireland', 'D01 AB12', '2025-06-09 14:20:53', '2025-10-18 17:00:29', 'active', NULL, 1, '$2a$10$0wFCerTcQMWO4A1rJq3GNuk3BycU8NR2F0C0NpAncGn/w.TW6KcDq'),
(47, 'Catherine', 'Lynch', 'catlyn@hotmail.com', '0869876543', '456 Patrick St', 'Cork', 'Ireland', 'T12 XY34', '2025-07-06 14:20:53', '2025-10-18 17:00:29', 'active', NULL, 0, '$2a$10$U5SEf/tz2Q2l7HG9MNzAfu0knaWVhJRVI9PJ6Y1rtv9Lp4Lxv8hBa'),
(48, 'Robert', 'Smith', 'bobsmith@aol.com', '0855555555', '789 Low St', 'Belfast', 'UK', 'BT1 1AB', '2025-08-02 14:20:53', '2025-10-18 17:00:29', 'active', NULL, 0, '$2a$10$0XS/8NLKiWKpj9jp6C.4COPHC.UkDWOmBPAL8NB8XGTUSKTrYgMyi'),
(49, 'Alan', 'Grimshaw', 'agrim@gmail.com', '0871234567', '123 Kildare St', 'Dublin', 'Ireland', 'D01 AB23', '2025-05-01 14:20:53', '2025-10-18 17:00:29', 'active', 'No response to marketing emails', 1, '$2a$10$0yUWWXYDwKb4sIedSf/i7uKwgWTZJB5aLM5/aBc7MTN.Y5JJZ3BHu'),
(50, 'Mary', 'Meehan', 'mm@hotmail.com', '0862345678', '456 Elm St', 'Belfast', 'UK', 'BT1 1AA', '2025-09-23 14:20:53', '2025-10-18 17:00:29', 'active', NULL, 0, '$2a$10$N96T8mfPHquGYwiBi.2eIO5Zhu57pblcbaqZHXVV4xc1MWgNbqHya'),
(51, 'Sarah', 'Murphy', 'sarahmurphy@yahoo.com', '0873456789', '789 Oak St', 'Cork', 'Ireland', 'T12 XY34', '2025-09-13 14:20:53', '2025-10-18 17:00:30', 'active', NULL, 1, '$2a$10$9UOwoYm9Z5XcQCKL1SSopO.nVOGp818IrZSDGgXn6fUa0poINv5Xy'),
(52, 'David', 'Smith', 'davidsmith@aol.com', '0834567890', '321 Maple St', 'Galway', 'Ireland', 'H91 ZY98', '2025-07-23 14:20:53', '2025-10-18 17:00:30', 'active', NULL, 1, '$2a$10$oWrGngLVGZUXO5SL2R4lJOtwM2uMYpqMQolnRR51UjrtEvrSRv1ge'),
(53, 'Emma', 'Jones', 'emmajones@gmail.com', '0855678901', '654 Birch St', 'London', 'UK', 'W1T 3JH', '2025-07-25 14:20:53', '2025-10-18 17:00:30', 'active', 'Reported delivery issue', 1, '$2a$10$1.2IVxmx6ph2mRhtvyKjCeDa/3MsboXDF8Tf4Eqn0zV9BgBvlrxnW'),
(54, 'Adam', 'Brown', 'adambrown@hotmail.com', '0866789012', '987 Cedar St', 'Manchester', 'UK', 'M1 1AB', '2025-06-29 14:20:53', '2025-10-18 17:00:30', 'active', 'Customer requested refund', 0, '$2a$10$USrWoDXyECMj2kj1WXO9KOZpWpd15btUYoTiCClVPvjo.CMKqjBr6'),
(55, 'Laura', 'Taylor', 'laurataylor@yahoo.com', '0877890123', '147 Pine St', 'Dublin', 'Ireland', 'D02 CD56', '2025-07-20 14:20:53', '2025-10-18 17:00:30', 'active', 'No response to marketing emails', 0, '$2a$10$c9tP3ZrCr.Auj9zQDIKo2ut9U.BLev.MXY7RuxQENRr6/BgHKKEoy'),
(56, 'Mark', 'Wilson', 'markwilson@aol.com', '0838901234', '258 Oak St', 'Belfast', 'UK', 'BT2 3CD', '2025-04-30 14:20:53', '2025-10-18 17:00:30', 'active', NULL, 1, '$2a$10$ntGKEi/8GfzkGe2V.Cbx1Oc6CeUJAPomLvksVrEYfbVn8wj4ZW3ni'),
(57, 'Clare', 'O\'Brien', 'clareobrien@gmail.com', '0869012345', '369 Elm St', 'Limerick', 'Ireland', 'V94 EF12', '2025-07-12 14:20:53', '2025-10-18 17:00:30', 'active', NULL, 1, '$2a$10$0bszYQUXwZxmmz8eYFAiGOkeNzNVbtTUJKA8QkOnWNxwEXozbajgS'),
(58, 'Michael', 'Johnson', 'michaeljohnson@hotmail.com', '0850123456', '753 Maple St', 'Edinburgh', 'UK', 'EH1 1QR', '2025-05-20 14:20:53', '2025-10-18 17:00:31', 'inactive', NULL, 1, '$2a$10$K7BP2ka778bsMHxs4K/jeu3KjuvqCZIr2yaGoj3YQKBwoGqOkqv7S'),
(59, 'Emily', 'Smith', 'emily.smith@hotmail.com', '+44 7912 345678', '45 Oak Street', 'Leeds', 'United Kingdom', 'LS2 7SU', '2025-10-04 14:20:53', '2025-10-18 17:00:31', 'active', 'No response to marketing emails', 0, '$2a$10$WrulXpqhXtoQXDnMpl44nOERn2k0tkXk8HvE3QIDATk8O35Shi3bW'),
(60, 'Mohammed', 'Ali', 'mohammed.ali@gmail.com', '+353 85 1234567', '27 Main Street', 'Dublin', 'Ireland', 'D01 X4C7', '2025-05-02 14:20:53', '2025-10-18 17:00:31', 'banned', 'Reported delivery issue', 1, '$2a$10$wPkus89BS1.WoHLedmsTDu8bEotRJCBggABfCzbe7V6mKVP5mTkr.'),
(61, 'Michael', 'Nguyen', 'michaelnguyen@gmail.com', '0421234567', '23 Beach Street', 'Sydney', 'Australia', '2000', '2025-09-16 14:20:53', '2025-10-18 17:00:31', 'active', NULL, 1, '$2a$10$Qi/ePk9NJfy2N1GECBb8cuU14GCchak3kAwYYzMkIQ.TzlcRJ2uii'),
(62, 'Jenny', 'Chen', 'jennychen@hotmail.com', '0431234567', '15 George Street', 'Auckland', 'New Zealand', '1010', '2025-04-30 14:20:53', '2025-10-18 17:00:31', 'active', NULL, 1, '$2a$10$nXvLdIP7XoqQWasSTuk.l.qvo30BKSCmePTXBUF.N6/nDcknCC9Mi'),
(63, 'Alex', 'Lee', 'alexlee@aol.com', '0451234567', '10 King Street', 'Melbourne', 'Australia', '3000', '2025-07-27 14:20:53', '2025-10-18 17:00:31', 'active', 'No response to marketing emails', 0, '$2a$10$ogJ2N/gMPXR/irC1GucDUe4Gi08U9y5HVjiYKE/5tnIvdvETVWew.'),
(64, 'Sarah', 'Wong', 'sarahwong@yahoo.com', '0471234567', '5 Queen Street', 'Wellington', 'New Zealand', '6011', '2025-08-28 14:20:53', '2025-10-18 17:00:31', 'active', NULL, 1, '$2a$10$Px2k9y1ZXLdqCvI5MGZLw.EK4jFrR9a4zlEyEUsIOaFShZfMUKFxe'),
(65, 'David', 'Kim', 'davidkim@gmail.com', '0441234567', '17 Ocean Road', 'Perth', 'Australia', '6000', '2025-09-03 14:20:53', '2025-10-18 17:00:31', 'active', NULL, 1, '$2a$10$ct20Z7Z3thstrRtUobyQ4.LvUlLi9EiBP7cYSXDnes5k8hY42i9gu'),
(66, 'Samantha', 'Chang', 'samanthachang@hotmail.com', '0431234567', '12 Beach Avenue', 'Sydney', 'Australia', '2000', '2025-09-02 14:20:53', '2025-10-18 17:00:32', 'active', NULL, 0, '$2a$10$QF5igLUsNPwOiechYN80Fe7h5weHKmF3T7iowoeBRjI7itlVdjFuC'),
(67, 'Tony', 'Zhang', 'tonyzhang@aol.com', '0451234567', '7 King Street', 'Brisbane', 'Australia', '4000', '2025-06-23 14:20:53', '2025-10-18 17:00:32', 'active', NULL, 1, '$2a$10$BPGnd74I4q1ad3AwVoltLOQhChI/8v0df9XEIKU3Ikd9u9XJ9i.Sm'),
(68, 'Emily', 'Chu', 'emilychu@yahoo.com', '0471234567', '20 Victoria Road', 'Auckland', 'New Zealand', '1010', '2025-10-11 14:20:53', '2025-10-18 17:00:32', 'inactive', NULL, 0, '$2a$10$iNkyAQzE.OKU6DOasU1qkO59q61u/L18CCylSV7Adx4GFOAbUuLjO'),
(69, 'Benjamin', 'Wong', 'benjaminwong@gmail.com', '0421234567', '25 Main Street', 'Melbourne', 'Australia', '3000', '2025-05-11 14:20:53', '2025-10-18 17:00:32', 'active', 'VIP customer – frequent buyer', 0, '$2a$10$zspZhEmms7mqZU9wtn2vduW.Wybs772mGToF2k8WksU.4F.PTDQ7C'),
(70, 'Lucy', 'Li', 'lucyli@hotmail.com', '0431234567', '30 Ocean Drive', 'Sydney', 'Australia', '2000', '2025-07-04 14:20:53', '2025-10-18 17:00:32', 'active', NULL, 0, '$2a$10$swTgyQ79LxXFAqh0M8k6c.k.1GW5rv6oEU11pUQKqTS4ZkzJbBbkC'),
(71, 'William', 'Chen', 'williamchen@yahoo.com', '0451234567', '35 Beach Street', 'Auckland', 'New Zealand', '1010', '2025-09-13 14:20:53', '2025-10-18 17:00:32', 'active', 'Reported delivery issue', 1, '$2a$10$IG5kBWGR6I9DeGAr3CDEo.cyHQSAU1Ont7KRJMDEKCkGSrknJ.f3W'),
(72, 'Jennifer', 'Tran', 'jennifertran@aol.com', '0471234567', '18 Queen Street', 'Perth', 'Australia', '6000', '2025-08-10 14:20:53', '2025-10-18 17:00:32', 'active', 'Reported delivery issue', 0, '$2a$10$p9X3BYJ.AKO7KB4vmV6sH.IGb7Olk5F.PEWwz5fCSA/sjiKsL4lga'),
(73, 'Joshua', 'Kim', 'joshuakim@gmail.com', '0421234567', '22 Ocean Road', 'Melbourne', 'Australia', '3000', '2025-07-07 14:20:53', '2025-10-18 17:00:32', 'active', NULL, 1, '$2a$10$9uTKMnSGR9z7uwOWfg8ueuM1deghCFmCAV5K5PNFZDIc0tuQtE9vm'),
(74, 'Grace', 'Park', 'gracepark@hotmail.com', '0431234567', '27 Main Street', 'Brisbane', 'Australia', '4000', '2025-08-02 14:20:53', '2025-10-18 17:00:33', 'active', NULL, 0, '$2a$10$NCWBzyHAapmJS8vSrfIiUO7o9iKjvgcQqlSaERPMq60yQ.v/qJIhC'),
(75, 'Daniel', 'Choi', 'danielchoi@yahoo.com', '0451234567', '5 George Street', 'Wellington', 'New Zealand', '6011', '2025-04-26 14:20:53', '2025-10-18 17:00:33', 'active', 'Reported delivery issue', 1, '$2a$10$35VzbFuc76keFS5F0kX2YOrlVfSV9psMUXcPCuIAl3.ddZ1NIT05a'),
(76, 'Olivia', 'Nguyen', 'olivianguyen@gmail.com', '0421234567', '8 King Street', 'Sydney', 'Australia', '2000', '2025-06-16 14:20:53', '2025-10-18 17:00:33', 'banned', NULL, 1, '$2a$10$yxrcNkzNrg.hZn3.a4yYnek44Ih5VZW5fTMAfLV7Sp989L8qNiTem'),
(77, 'Mary', 'Jones', 'mjones@gmail.com', '+3531234567', '1 Main St', 'Dublin', 'Ireland', 'D01 ABC1', '2025-08-12 14:20:53', '2025-10-18 17:00:33', 'active', 'No response to marketing emails', 0, '$2a$10$c/01fh7tMdA/FdT.EhDOLu2ZJnTodYhMiTUkirMNh26CNahMVMVsy'),
(78, 'John', 'Smith', 'john_smith@hotmail.com', '+4412345678', '2 High St', 'Manchester', 'UK', 'M1 1AB', '2025-05-04 14:20:53', '2025-10-18 17:00:33', 'active', NULL, 1, '$2a$10$HDvkDojErOds8rh6ELku7OplwnqfC19kqWvjdhoD54P6DZgIka3Ee'),
(79, 'Sarah', 'Brown', 'sbrown@aol.com', '+3532345678', '3 Park Rd', 'Cork', 'Ireland', 'T12 XYZ2', '2025-08-20 14:20:53', '2025-10-18 17:00:33', 'active', NULL, 0, '$2a$10$9tpbPnUMRjTDUxxTtLHJOOJi2T7S.Up6VRsq50W3sFbm8Lczh/G46'),
(80, 'David', 'Taylor', 'dtaylor@yahoo.com', '+4416324789', '4 Station Rd', 'London', 'UK', 'SW1A 1AA', '2025-05-11 14:20:53', '2025-10-18 17:00:33', 'active', NULL, 0, '$2a$10$Zw5jEK6dpgVIWdgUecZ6OOUHCIiPmlry0XvcX0Cdn0dtwT2tAvaxO'),
(81, 'Emma', 'Wilson', 'ewilson@gmail.com', '+3534567890', '5 Church St', 'Dublin', 'Ireland', 'D02 DEF3', '2025-05-02 14:20:53', '2025-10-18 17:00:34', 'active', NULL, 1, '$2a$10$1tEAxTr0YVfU/Llib6pp2Op8uheMrM8Pw0O4k9OqUG7Ga8EIkEr5i'),
(82, 'James', 'Thompson', 'jthompson@hotmail.com', '+4478901234', '6 Market Square', 'Manchester', 'UK', 'M2 2BC', '2025-05-18 14:20:53', '2025-10-18 17:00:34', 'active', NULL, 1, '$2a$10$hmRMfNq8yCvf2aEiXGSBPupfdnBMJ6F.TFfVPK7bZEFVfv6kybFqW'),
(83, 'Rachel', 'Johnson', 'rjohnson@aol.com', '+3535678901', '7 Bridge St', 'Galway', 'Ireland', 'H91 EFG4', '2025-06-02 14:20:53', '2025-10-18 17:00:34', 'active', 'No response to marketing emails', 0, '$2a$10$QHCS979pMjk6kW6kD/6RV.NOdsaFrDWzBOdzNiAwIVJhSJxvXMPqS'),
(84, 'Peter', 'Lee', 'plee@yahoo.com', '+4419234567', '8 Queen St', 'Birmingham', 'UK', 'B1 1AA', '2025-05-07 14:20:53', '2025-10-18 17:00:34', 'active', NULL, 0, '$2a$10$P.1HPV.9ykJz8/e2T9IGSeKoe2rh1drhrkuUsPooS3bkyBliS/Ev6'),
(85, 'Karen', 'Miller', 'kmiller@gmail.com', '+3537890123', '9 Main St', 'Limerick', 'Ireland', 'V94 GHI5', '2025-07-28 14:20:53', '2025-10-18 17:00:34', 'inactive', NULL, 1, '$2a$10$IuK8nTug/GwWUT6UsLjBFeE.I7gJZ0Dj3ywEQ9gZGmyQodN2mNKtC'),
(86, 'William', 'Walker', 'wwalker@hotmail.com', '+4476123456', '10 High St', 'Bristol', 'UK', 'BS1 1AA', '2025-07-20 14:20:53', '2025-10-18 17:00:34', 'active', 'No response to marketing emails', 0, '$2a$10$qlXti0VUJUVhs6yCRw7WDekNvXty.1GpicF7id04HFvOtcpe53Di.'),
(87, 'Oliver', 'Wilson', 'oliver.wilson@hotmail.com', '0859876543', '17 Green Road', 'Cork', 'Ireland', 'T12 XYZ', '2025-08-03 14:20:53', '2025-10-18 17:00:34', 'active', NULL, 1, '$2a$10$gklkin2bebf95SaRnlPCoOWRotKNO2SSrM/3vgHwYUuqaolHWFu5u'),
(88, 'Sophia', 'Brown', 'sophia.brown@yahoo.com', '0862468135', '12 High Street', 'Belfast', 'UK', 'BT1 2AB', '2025-07-14 14:20:53', '2025-10-18 17:00:35', 'active', NULL, 0, '$2a$10$f2WTI0cJIvEeyP1R5DjaQeo1/FXyijy.DAazW7J/9LcrTVfgt3QE6'),
(89, 'William', 'Johnson', 'william.johnson@gmail.com', '0834445556', '5 Park Avenue', 'London', 'UK', 'SE1 7TP', '2025-08-13 14:20:53', '2025-10-18 17:00:35', 'active', 'No response to marketing emails', 0, '$2a$10$LlHYRXubLrocOWrZytpdteHL0xADWOWhVvuQdJqehbYnJhUULi0xq'),
(90, 'Ava', 'Garcia', 'ava.garcia@hotmail.com', '0872223333', '27 Bridge Street', 'Dublin', 'Ireland', 'D08 KKK', '2025-09-05 14:20:53', '2025-10-18 17:00:35', 'active', NULL, 0, '$2a$10$/tYKzr27ELDVOEPs.aLpvucMUBbmFYF7dhtLklh637albDvaMHOsG'),
(91, 'Ethan', 'Miller', 'ethan.miller@aol.com', '0867778888', '10 Church Road', 'Galway', 'Ireland', 'H91 XYZ', '2025-09-11 14:20:53', '2025-10-18 17:00:35', 'inactive', 'Customer requested refund', 1, '$2a$10$AtICpE5DMepv2W/8n6A1BuRmRn4Htuy8QF0O29LJSuIyJ77qQds1y'),
(92, 'Isabella', 'Davis', 'isabella.davis@yahoo.com', '0859998888', '3 Hillside Avenue', 'Belfast', 'UK', 'BT2 3CD', '2025-05-25 14:20:53', '2025-10-18 17:00:35', 'inactive', NULL, 0, '$2a$10$Y1NvFa7z2yRCEJggdnZF4uhOIRfpjA1rxB6Dd50hbnbijDIVZ8n26'),
(93, 'James', 'Rodriguez', 'james.rodriguez@gmail.com', '0874445556', '15 Main Street', 'Cork', 'Ireland', 'T23 YYY', '2025-07-02 14:20:53', '2025-10-18 17:00:35', 'active', NULL, 0, '$2a$10$GvyAhLzbv4Am6KCMCQcy2evBgRSLoAl3RJ0V8PWwkS0DLNiZ/9Qfa'),
(94, 'Mia', 'Martinez', 'mia.martinez@hotmail.com', '0867779999', '9 Market Square', 'Belfast', 'UK', 'BT3 4EF', '2025-10-06 14:20:53', '2025-10-18 17:00:35', 'active', 'Reported delivery issue', 1, '$2a$10$T79CrBFittCLW7OnliigHeEi5mfYhkBthqeD1Ho8m0rmYkObuWvrK'),
(95, 'Benjamin', 'Clark', 'benjamin.clark@gmail.com', '0853334444', '11 Victoria Road', 'London', 'UK', 'SW1A 1AA', '2025-05-02 14:20:53', '2025-10-18 17:00:35', 'banned', 'Reported delivery issue', 1, '$2a$10$c3DCRr7Bjqi7SBy.BnR0tOlQWGHZkZogN24P6SiaO4/3D9tSCpiLa'),
(96, 'Emma', 'Smith', 'emma.smith@gmail.com', '0871234567', '23 Main Street', 'Dublin', 'Ireland', 'D01 ABC', '2025-08-26 14:20:53', '2025-10-18 17:00:36', 'active', NULL, 1, '$2a$10$RHX.lxBG72VQdaNHjqziaeWJD6sARSEl6HJ00UMAvcvoUyldnPtpy'),
(97, 'Tara', 'O\'Neill', 'tarao123@gmail.com', '+353-86-123-4567', '123 Main St', 'Dublin', 'Ireland', 'D01 AB12', '2025-09-18 14:20:53', '2025-10-18 17:00:36', 'inactive', NULL, 1, '$2a$10$Ghp7UM.6AaQ2Nfm08g/8h.3NHzhhjux4Of724NJFEKOC/sskDUPbe'),
(98, 'Tom', 'Williams', 'tomw123@hotmail.com', '+44-7712-345678', '456 Elm Ave', 'London', 'United Kingdom', 'SW1V 2ER', '2025-07-16 14:20:53', '2025-10-18 17:00:36', 'active', 'Reported delivery issue', 1, '$2a$10$APi/sX.iHDkpsoGUuh4Cre7TaeUA5WkOFs6CX5tTBbjqdWR1BpyMW'),
(99, 'Samantha', 'Smith', 'samanthas456@yahoo.com', '+44-7456-789123', '789 Oak Rd', 'Belfast', 'Northern Ireland', 'BT1 4GB', '2025-07-20 14:20:53', '2025-10-18 17:00:36', 'inactive', NULL, 1, '$2a$10$ElLjU5cLIM5nOiWM2zH3QO6zdX2b0qralNl6t5bSzPV8LA8ZgwadG'),
(100, 'Adam', 'Jones', 'adamj321@aol.com', '+353-87-987-6543', '234 Beech St', 'Cork', 'Ireland', 'T12 XY34', '2025-05-31 14:20:53', '2025-10-18 17:00:36', 'active', 'Reported delivery issue', 1, '$2a$10$1uDSesNxpiW2wonjOi9oJueXlYo3wwdjVF.b6YSJ/svwLFta5gB8i'),
(101, 'Jessica', 'Brown', 'jessicab987@yahoo.com', '+44-7812-345678', '567 Maple Dr', 'Glasgow', 'Scotland', 'G1 2AB', '2025-08-14 14:20:53', '2025-10-18 17:00:36', 'inactive', 'Reported delivery issue', 1, '$2a$10$Rao1Tsw4hmM4DujK4aU1ce3RmYalzNPdJTcFGtqFziD7gqMSMK7nG'),
(102, 'Emily', 'Davis', 'emilyd456@gmail.com', '+44-7456-123456', '890 Pine Blvd', 'Dublin', 'Ireland', 'D02 CD34', '2025-05-14 14:20:53', '2025-10-18 17:00:36', 'active', 'Customer requested refund', 1, '$2a$10$Frpb4dxAoWjjPtQwcxWxaOg8d2pVwn23xeB2EHZ0Jysgp5sRN3TFu'),
(103, 'David', 'Wilson', 'davidw789@hotmail.com', '+44-7712-345678', '123 Oak Rd', 'London', 'United Kingdom', 'NW1 2BC', '2025-08-18 14:20:53', '2025-10-18 17:00:36', 'active', NULL, 0, '$2a$10$r4bcLHAM5Ckq9vfFy0O09OgIC0S0LKxNLltTKBQVcWFejA2CJVEbS'),
(104, 'Aoife', 'Murphy', 'aoifem567@yahoo.com', '+353-87-789-0123', '456 Cherry Ave', 'Limerick', 'Ireland', 'V94 WX56', '2025-06-25 14:20:53', '2025-10-18 17:00:37', 'active', NULL, 1, '$2a$10$ZMNVQIH8GzC6.TneCIOALucMdwb7qOgkFLldus3XgNk2FDkFyOgBm'),
(105, 'Katie', 'Taylor', 'ktaylor321@aol.com', '+353-87-456-7890', '789 Walnut St', 'Dublin', 'Ireland', 'D04 EF56', '2025-10-02 14:20:53', '2025-10-18 17:00:37', 'active', NULL, 0, '$2a$10$/k7RxT5NMSqQYSjPrS0SR.dLIEOUbNuCJlRa8eFH.ywPwsqldu64K'),
(106, 'John', 'Johnson', 'johnj789@gmail.com', '+44-7812-345678', '234 Maple Ave', 'Manchester', 'United Kingdom', 'M1 1AB', '2025-04-29 14:20:53', '2025-10-18 17:00:37', 'active', 'Reported delivery issue', 0, '$2a$10$HnnSBTkMphIc0KRm0PPXd.9DB8ZvJwXYkoiqSFzN2jyNTaBeV2em.'),
(107, 'Lucy', 'Lee', 'lucyl123@hotmail.com', '+44-7456-789123', '567 Beech Rd', 'Edinburgh', 'Scotland', 'EH1 3AB', '2025-08-01 14:20:53', '2025-10-18 17:00:37', 'active', NULL, 0, '$2a$10$ATQkEx3vXtrkHmh.Pc.86.ZMTL.04UvxTrZvTBTqcLDCrPbwbUhoi'),
(108, 'James', 'Brown', 'jamesb456@yahoo.com', '+353-87-987-6543', '890 Elm St', 'Galway', 'Ireland', 'H91 AB12', '2025-06-22 14:20:53', '2025-10-18 17:00:37', 'inactive', NULL, 1, '$2a$10$jePQcHkyo.NpXK/nRl7k7e7IY2d./id/uDBbav5LWjw96JDOgG6IW'),
(109, 'Oliver', 'Davis', 'oliverd321@gmail.com', '+44-7712-345678', '123 Pine Ave', 'Belfast', 'Northern Ireland', 'BT1 2BC', '2025-07-15 14:20:53', '2025-10-18 17:00:37', 'active', NULL, 0, '$2a$10$Vcbrms886s4a/BrDF2KTXevqvrjRFDApK4RmQ1oS3DA6v4DWy0QWK'),
(110, 'Emma', 'Williams', 'emmaw789@yahoo.com', '+44-7812-345678', '456 Oak Rd', 'Dublin', 'Ireland', 'D04 CD34', '2025-09-10 14:20:53', '2025-10-18 17:00:37', 'active', NULL, 1, '$2a$10$o2Sr23bzh8Wg3Rily7SpcuG2B4VwWK5WUKgdMs6XJ/vuxAtbi2vB.'),
(111, 'Sophie', 'Jones', 'sophiej567@aol.com', '+353-87-789-0123', '789 Maple Blvd', 'Cork', 'Ireland', 'T12 XY56', '2025-08-26 14:20:53', '2025-10-18 17:00:37', 'active', NULL, 1, '$2a$10$IVB0OidYvi1KTFv1bZEkduOUVpmh.YHRr2ZhS0kbT321QHTqM4Ig.'),
(112, 'Oliver', 'Johnson', 'oliverjohnson@gmail.com', '083-123-4567', '123 Main St', 'Dublin', 'Ireland', 'D01 AB23', '2025-06-21 14:20:53', '2025-10-18 17:00:37', 'active', NULL, 0, '$2a$10$NiUsECNyB/btoobgvAavGeJBSyMyYyZxgV3TNucekMFcEenoWHkjC'),
(113, 'Sophia', 'Williams', 'sophiawilliams@hotmail.com', '087-234-5678', '456 High St', 'Galway', 'Ireland', 'H91 XY12', '2025-04-29 14:20:53', '2025-10-18 17:00:38', 'active', NULL, 1, '$2a$10$eq31Rnkhb77CD8WDdrjB6.yfLFCWH9Bejc0.xusnf0z6864jkt45e'),
(114, 'Jackson', 'Brown', 'jacksonbrown@yahoo.com', '086-345-6789', '789 Park Ave', 'London', 'UK', 'W1J 7BX', '2025-08-30 14:20:53', '2025-10-18 17:00:38', 'active', NULL, 0, '$2a$10$7qiAsdbH5aOtpTwfpkqaTepWkGJ5tJTRwz4XMG7Rh25WtGwQFCN6u'),
(115, 'Emma', 'Garcia', 'emmagarcia@aol.com', '089-456-7890', '321 Elm St', 'Manchester', 'UK', 'M1 1AB', '2025-07-02 14:20:53', '2025-10-18 17:00:38', 'active', NULL, 0, '$2a$10$M.8UJUKSX3ju2DrbiJe0QeP3HmctSVhn8mwqnsF8I3yxTaRFgzwLC'),
(116, 'Aiden', 'Taylor', 'aidentaylor@gmail.com', '085-567-8901', '567 4th St', 'Belfast', 'UK', 'BT1 3LP', '2025-04-27 14:20:53', '2025-10-18 17:00:38', 'active', NULL, 0, '$2a$10$wmLeA3UtL1kniwJ87xt85eQFa8tPdC9Th4RuxUQjldMlf96SYutyK'),
(117, 'Isabella', 'Martinez', 'isabellamartinez@hotmail.com', '087-678-9012', '890 5th Ave', 'Cork', 'Ireland', 'T12 XY34', '2025-04-24 14:20:53', '2025-10-18 17:00:38', 'active', NULL, 0, '$2a$10$8LxPILepWf3g1DuIiw86refBtQXSyMG9WmroP5vQ0bsqzz6u.ekMW'),
(118, 'Liam', 'Smith', 'liamsmith@yahoo.com', '086-789-0123', '432 Baker St', 'Dublin', 'Ireland', 'D02 CD45', '2025-10-11 14:20:53', '2025-10-18 17:00:38', 'active', NULL, 1, '$2a$10$DoyKEIEWigE66ouGNKwVe.UZ5F3yFsscPYfg4NghFOTGX3ES8hh/2'),
(119, 'Mia', 'Jones', 'miajones@aol.com', '083-890-1234', '765 2nd St', 'Edinburgh', 'UK', 'EH1 1AA', '2025-05-07 14:20:53', '2025-10-18 17:00:38', 'active', NULL, 1, '$2a$10$ndP2MVNllqsNFi6qCYw6rupGK.IkYix6HcVNGv2uZ28Ch7ddJrsEW'),
(120, 'Lucas', 'Gonzalez', 'lucasgonzalez@gmail.com', '089-012-3456', '234 Oak St', 'Liverpool', 'UK', 'L1 1AA', '2025-05-01 14:20:53', '2025-10-18 17:00:38', 'inactive', 'No response to marketing emails', 0, '$2a$10$H.PdeB5/gtPlxCS7U5dxKuSF/e/T7yGK4O9XTDBI/urCPZvdCol1O'),
(121, 'Avery', 'Davis', 'averydavis@hotmail.com', '087-123-4567', '678 Maple Ave', 'Belfast', 'UK', 'BT2 7ED', '2025-06-02 14:20:53', '2025-10-18 17:00:39', 'active', 'Reported delivery issue', 0, '$2a$10$tUoJUFSyIw/9gDB0lT5j2OanzTGuZHrYunfxbh2TO9YChqElTkS6m'),
(122, 'Emily', 'Jones', 'emilyjones@gmail.com', '07862 986754', '34 Cedar Avenue', 'Dublin', 'Ireland', 'D04 KX28', '2025-09-25 14:20:53', '2025-10-18 17:00:39', 'active', NULL, 1, '$2a$10$Ad8hTxyErp9coSbEMZ4DhuqrXF.PJGaDQ2.4RhWrsp5jqASsyZX8.'),
(123, 'Charlie', 'Smith', 'charliesmith@hotmail.com', '07742 675432', '22 Oak Road', 'Belfast', 'Northern Ireland', 'BT5 5DT', '2025-07-10 14:20:53', '2025-10-18 17:00:39', 'active', NULL, 0, '$2a$10$HAlwuZ.yafxGOuW01qnZYuYitxWKi2ORwxABe/T9DblJM.TH/5eRS'),
(124, 'Sophie', 'Wilson', 'sophiewilson@aol.com', '07593 347659', '12 Elm Close', 'Manchester', 'England', 'M14 6XQ', '2025-07-28 14:20:53', '2025-10-18 17:00:39', 'active', NULL, 0, '$2a$10$yMw8.ia7eHAxi1lu9bVCGusbIeX6lVb/1Mobwem6qWwKGjSLvp1Ni'),
(125, 'Benjamin', 'Brown', 'benjaminbrown@hotmail.com', '07732 876543', '87 High Street', 'Glasgow', 'Scotland', 'G1 1LE', '2025-06-29 14:20:53', '2025-10-18 17:00:39', 'active', 'Reported delivery issue', 1, '$2a$10$c80QKkZwnN36mT4lMe/bveeSlQXhve2CCcAV6cA/zO/OMi5P5o9Ke'),
(126, 'Grace', 'Davies', 'gracedavies@gmail.com', '07912 345678', '43 Victoria Road', 'Birmingham', 'England', 'B1 3JP', '2025-06-18 14:20:53', '2025-10-18 17:00:39', 'active', NULL, 1, '$2a$10$a80ssPtf7CUtkR3CZPZbDO3URIonK6MKS06D1B0IGCc01WtQO6RyO'),
(127, 'William', 'Evans', 'williamevans@yahoo.com', '07798 756432', '9 Park Street', 'Dublin', 'Ireland', 'D02 CF83', '2025-08-09 14:20:53', '2025-10-18 17:00:39', 'active', 'No response to marketing emails', 0, '$2a$10$ltOvAxgWvq8lWmIP/7yBtO8nax35fPE3yvbMnbWlCmEupVTaw9dni'),
(128, 'Chloe', 'Johnson', 'chloejohnson@hotmail.com', '07967 547896', '3 Station Road', 'Belfast', 'Northern Ireland', 'BT1 6PB', '2025-08-26 14:20:53', '2025-10-18 17:00:39', 'active', 'No response to marketing emails', 1, '$2a$10$lU7DYlWobNDsemz1GsLaA.ylneCqx6B5TiB/JYNT2HV3Hosxve2jG'),
(129, 'Edward', 'Miller', 'edwardmiller@aol.com', '07571 234567', '21 The Avenue', 'Liverpool', 'England', 'L1 2PN', '2025-09-23 14:20:53', '2025-10-18 17:00:39', 'active', NULL, 1, '$2a$10$Li.Kkpw1rx1PbHtddMHKQuC15jTMp9XV6G89CY8/IAiwBEYfEadE6'),
(130, 'Amelia', 'Davis', 'ameliadavis@gmail.com', '07852 976543', '16 Park View', 'Dublin', 'Ireland', 'D06 WV13', '2025-04-29 14:20:53', '2025-10-18 17:00:40', 'active', 'No response to marketing emails', 0, '$2a$10$e1uBn6KmgmO58B8slJfGFONUZNWS6IWDzxlzxTeUoAmGK2qjgsabC'),
(131, 'Jacob', 'Wilson', 'jacobwilson@hotmail.com', '07720 845672', '10 Main Street', 'Belfast', 'Northern Ireland', 'BT4 2BG', '2025-04-28 14:20:53', '2025-10-18 17:00:40', 'active', NULL, 1, '$2a$10$x1In2u0bmttYw4JW2gOekeOesk6u/BezmgNZnTJk5YeZ5T1oBozQi'),
(132, 'Emily', 'Jackson', 'emilyjackson@yahoo.com', '07761 758493', '67 Oak Road', 'Edinburgh', 'Scotland', 'EH4 2LW', '2025-06-10 14:20:53', '2025-10-18 17:00:40', 'active', 'Reported delivery issue', 1, '$2a$10$tG9aCKk1K77XjJqYAxE2sOhOSSk0490nk.HbGEoif28GrYYJJc3mG'),
(133, 'Daniel', 'White', 'danielwhite@aol.com', '07978 123456', '28 Victoria Street', 'Glasgow', 'Scotland', 'G2 1DH', '2025-10-13 14:20:53', '2025-10-18 17:00:40', 'active', NULL, 0, '$2a$10$Ktj3TrR3oxXWIG0sJPEvG.xxk4iwRiIOQ41ROh5e/vDnido6Q0GK2'),
(134, 'Mia', 'Clark', 'miaclark@hotmail.com', '07887 567890', '55 The Green', 'London', 'England', 'SW1A 2AA', '2025-09-25 14:20:53', '2025-10-18 17:00:40', 'active', 'Reported delivery issue', 0, '$2a$10$mJKD22eW/HKmHJilkWV./e0suP9bws7oHABP08J7RD2ZRpj0lXpMa'),
(135, 'William', 'Leeson', 'williamlee@gmail.com', '07543 789012', '18 Church Road', 'Birmingham', 'England', 'B17 9PW', '2025-09-16 14:20:53', '2025-10-18 17:00:40', 'active', NULL, 0, '$2a$10$MS1ZnT2zngiMQ6kQGd/EG.0ryixztDi.1X3Pa8OloKMOlHGGgNTGe'),
(142, 'Des', 'Chambers', 'des.chambers@tus.ie', '061 208208', '123 Fake St', 'Limerick', 'Ireland', 'V94 WW34', '2025-08-31 14:20:53', '2025-10-18 17:00:40', 'active', 'Customer requested refund', 0, '$2a$10$VTd1yjYD5N24v.7e6uwEE.xLHbddpn.Envz6lKBHPSBwJ/jXqe3tu'),
(143, 'William', 'Anderson', 'william.anderson@berge.com', '9583098913', '3002 Stoltenberg Ranch', 'Olsonburgh', 'Nauru', '48645-1606', '2025-07-15 14:20:53', '2025-10-18 17:00:40', 'active', NULL, 1, '$2a$10$BktYfUbqjEZxWdcnNpOupO2ze7VZps8lvZvHp0FNy1qtBLqexVNWu'),
(144, 'Krystal', 'Kuvalis', 'krystal.kuvalis@mayert.org', '9747120097', '58222 Librada Motorway', 'Port Bulah', 'Syrian Arab Republic', '73278', '2025-06-27 14:20:53', '2025-10-18 17:00:41', 'inactive', NULL, 0, '$2a$10$p0vFK5O022cqaElVmydnku8/wENNVRJmR3oGEfV457fHO1Ghb/URi'),
(145, 'Norberto', 'Schultz', 'norberto.schultz@schumm.org', '6004515101', '05086 Bahringer Stravenue', 'Cleliafurt', 'Palau', '71420', '2025-09-12 14:20:53', '2025-10-18 17:00:41', 'inactive', 'VIP customer – frequent buyer', 1, '$2a$10$G9zgTCm/EJFEZ9w5KwAeDes2KFGwP8idw9yAMAuYLCwBqXf.0vZW2'),
(146, 'Thomasine', 'Zieme', 'thomasine.zieme@schneider.org', '12120479035', '20751 Amos Flat', 'Mortontown', 'Slovakia (Slovak Republic)', '33868', '2025-09-15 14:20:53', '2025-10-18 17:00:41', 'active', 'Reported delivery issue', 1, '$2a$10$oCgNoh38ruVO5e5OhgPKoe0Vt0PwFwf.Yhk5JKQTFeO2SEusGJSL6'),
(147, 'Brett', 'Stanton', 'brett.stanton@tremblay.info', '1661406694', '99649 Galen Lodge', 'Lake Leeann', 'Jamaica', '26805', '2025-06-08 14:20:53', '2025-10-18 17:00:41', 'inactive', 'No response to marketing emails', 1, '$2a$10$2gB.cmwfb0w7q9bK6QL5o.aunLJS5sep7mWFKIs9YTSLGRNz/1Gai'),
(148, 'Ted', 'Jones', 'teddy@tus.ie', '9876543', '123 Fake St', 'Limerick', 'Ireland', 'V97TR45', '2025-08-23 14:20:53', '2025-10-18 17:00:41', 'active', NULL, 1, '$2a$10$fSm/ZHyzYbdgdJZsTygZIOg3psPBmJjzadHTCabkM2n1jOmy7.kV.'),
(149, 'Marketta', 'Satterfield', 'marketta.satterfield@schumm.io', '2803127656', '5112 McClure Stravenue', 'South Jermaine', 'Macedonia', '36800-8472', '2025-08-17 14:20:53', '2025-10-18 17:00:41', 'active', NULL, 1, '$2a$10$XObXdxje/pJbsZ2qvve9LesTtmT57oYuHUFI3yyHq9IidpXxfq7E6'),
(150, 'Oda', 'Swaniawski', 'oda.swaniawski@vandervort.com', '6936421914', '725 Theodore Key', 'Diannahaven', 'Kyrgyz Republic', '90562', '2025-06-09 14:20:53', '2025-10-18 17:00:41', 'active', 'No response to marketing emails', 1, '$2a$10$y9hFqxQ2PqPVbvRrYD/oluz5rG.rswigmDPvMVGiqcVgr7DxzG9Jm'),
(151, 'Jeanene', 'Wiza', 'jeanene.wiza@thiel.co', '6867116658', '107 Odette Manors', 'Lake Mauro', 'Nicaragua', '50717-3557', '2025-06-08 14:20:53', '2025-10-18 17:00:42', 'active', 'Reported delivery issue', 0, '$2a$10$Rf92N5QCqiLp80sQDpjDOuG1uzMcGedyyTnu6Gu6QWVWTrEtFKh4W'),
(152, 'Stefani', 'Altenwerth', 'stefani.altenwerth@west.biz', '8388846981', '342 Danial Street', 'East Rocky', 'Svalbard & Jan Mayen Islands', '12628', '2025-08-04 14:20:53', '2025-10-18 17:00:42', 'active', 'No response to marketing emails', 1, '$2a$10$xUs9WYF5wYlFO2pMY7cxa.O/O9d569kok3qlh.rJPVkBmsdUj3WdG'),
(153, 'Sal', 'Heaney', 'sal.heaney@durgan.biz', '2654197997', '89742 Jonell Squares', 'Lake Winston', 'Mauritius', '39153-0559', '2025-08-18 14:20:53', '2025-10-18 17:00:42', 'active', NULL, 1, '$2a$10$8iZnt3Hko3f5bWKF1UKBrO.SCEoam2VGBcFHxJK1utvVZDrhzShHy'),
(154, 'Bob', 'McCarthy', 'bob@tus.ie', '1876543', '123 Fake St', 'Limerick', 'Ireland', 'V98RT45', '2025-06-10 14:20:53', '2025-10-18 17:00:42', 'inactive', 'Reported delivery issue', 1, '$2a$10$j2dT9Q.B4UE7hxDjRYnGCOyVTcaigHmiGs20kvXrQUqKYREuXPjDe'),
(155, 'Jacquelynn', 'Herzog', 'jacquelynn.herzog@wisozk.net', '14031382334', '424 Wuckert Stream', 'East Charles', 'Estonia', '55269', '2025-06-15 14:20:53', '2025-10-18 17:00:42', 'active', 'Reported delivery issue', 1, '$2a$10$TQGUbe/1nhcjioZ1E.zDkeG6fWqUjKm1HVj6eLAi5/R5DFwtr0nIa'),
(156, 'Adriana', 'Feest', 'adriana.feest@oconner.com', '9022326664', '209 Sharen Wall', 'East Lavinia', 'Djibouti', '27494', '2025-06-18 14:20:53', '2025-10-18 17:00:42', 'inactive', NULL, 0, '$2a$10$58CvN6SmHtRUHwyvqqZ4HuDH0iPzPWZYOe0qjObOiIP3fWneBZyIO'),
(157, 'Chrystal', 'Jacobi', 'chrystal.jacobi@mertz.info', '7483645768', '6528 Gino Trace', 'Heaneyport', 'El Salvador', '92545', '2025-06-20 14:20:53', '2025-10-18 17:00:42', 'inactive', 'Reported delivery issue', 1, '$2a$10$wI711VrPJNUA6TJig1ipGu3wEjVUWfr5uI4VR3TVJZUU7RdjtayuW'),
(158, 'Jessie', 'Keeling', 'jessie.keeling@williamson.biz', '7285345359', '50787 Johnston Loop', 'Mickeyland', 'Niue', '72644', '2025-07-02 14:20:53', '2025-10-18 17:00:42', 'active', NULL, 0, '$2a$10$WuMze5XJD.TH./ricejDAee1ayDOISJ8TR0cX/HRxbrVh6kla1JAC'),
(159, 'Curtis', 'Ratke', 'curtis.ratke@rohan.biz', '1869850040', '2222 McDermott Extension', 'Fabianburgh', 'Burkina Faso', '20262-9908', '2025-08-11 14:20:53', '2025-10-18 17:00:43', 'active', NULL, 1, '$2a$10$0EUKDZEUwk4QXs3nnWXJmuxPGAOpJOzEAALDeYHkFV.achB89jym.'),
(160, 'Odis', 'Hudson', 'odis.hudson@oberbrunner.biz', '3029829349', '11028 Streich Route', 'South Verlene', 'Zimbabwe', '45498', '2025-05-29 14:20:53', '2025-10-18 17:00:43', 'active', 'VIP customer – frequent buyer', 0, '$2a$10$9m9rZCrRah89RXXEPPxGDu6HUwuDdqtwTpGdmsfsAjAPsRHveMYma');

-- --------------------------------------------------------

--
-- Table structure for table `db_metadata`
--

CREATE TABLE `db_metadata` (
  `id` int(11) NOT NULL,
  `notice` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `db_metadata`
--

INSERT INTO `db_metadata` (`id`, `notice`, `created_at`) VALUES
(1, 'This database is proprietary. Do not use or distribute without permission from alan.ryan@tus.ie', '2025-10-18 10:08:23'),
(2, 'This database is intended solely for use by students enrolled in the B.Sc. in Software Development (Year 4) and the B.Sc. in Mobile and Web Computing (Year 4) programmes, for the purpose of coursework related to Enterprise Application Development and API Design and Development', '2025-10-18 13:51:19');

-- --------------------------------------------------------

--
-- Table structure for table `discount_codes`
--

CREATE TABLE `discount_codes` (
  `discount_id` int(11) NOT NULL,
  `code` varchar(50) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `discount_type` enum('percentage','fixed') DEFAULT 'percentage',
  `discount_value` decimal(10,2) NOT NULL,
  `start_date` date DEFAULT NULL,
  `expiry_date` date DEFAULT NULL,
  `usage_limit` int(11) DEFAULT NULL,
  `used_count` int(11) DEFAULT 0,
  `active` tinyint(1) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `discount_codes`
--

INSERT INTO `discount_codes` (`discount_id`, `code`, `description`, `discount_type`, `discount_value`, `start_date`, `expiry_date`, `usage_limit`, `used_count`, `active`, `created_at`, `updated_at`) VALUES
(1, 'PETLOVE10', '10% off all pet supplies – general promo', 'percentage', '10.00', '2025-01-01', '2025-12-31', 500, 0, 1, '2025-07-17 14:40:39', '2025-07-24 14:40:39'),
(2, 'BOWHAUS5', '€5 off any Bowhaus brand product', 'fixed', '5.00', '2025-06-01', '2026-01-31', NULL, 0, 1, '2025-06-15 14:40:39', '2025-10-18 14:41:05'),
(3, 'FIRSTORDER15', '15% off first-time customer orders', 'percentage', '15.00', '2025-01-01', '2026-12-31', NULL, 0, 1, '2025-07-07 14:40:39', '2025-07-27 14:40:39'),
(4, 'SUMMER2025', '20% off summer sale items', 'percentage', '20.00', '2025-06-01', '2025-08-31', 1000, 0, 0, '2025-06-24 14:40:39', '2025-10-18 14:40:58'),
(5, 'LOYALTY25', 'Exclusive 25% off for returning customers', 'percentage', '25.00', '2025-03-01', '2026-03-01', 250, 0, 1, '2025-10-01 14:40:39', '2025-10-27 14:40:39');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `order_id` int(11) NOT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `order_date` datetime DEFAULT NULL,
  `total` decimal(10,2) DEFAULT NULL,
  `order_status_id` int(11) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `discount_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`order_id`, `customer_id`, `order_date`, `total`, `order_status_id`, `payment_method`, `discount_id`) VALUES
(1, 123, '2022-05-01 12:30:00', '1114.71', 1, 'Credit Card', NULL),
(2, 129, '2022-06-03 11:45:00', '1570.18', 2, 'Credit Card', NULL),
(3, 107, '2022-06-07 15:20:00', '2938.07', 3, 'Credit Card', NULL),
(4, 135, '2022-06-10 10:15:00', '1730.65', 1, 'Credit Card', NULL),
(5, 135, '2022-06-15 14:00:00', '1873.11', 4, 'Bank Transfer', NULL),
(6, 111, '2022-06-20 09:30:00', '3079.28', 2, 'PayPal', NULL),
(7, 85, '2022-06-22 16:45:00', '1280.28', 3, 'Credit Card', NULL),
(8, 45, '2022-07-01 10:00:00', '3359.92', 1, 'PayPal', NULL),
(9, 1, '2022-07-05 12:15:00', '1526.22', 2, 'Credit Card', NULL),
(10, 24, '2022-07-10 11:00:00', '1672.29', 3, 'Credit Card', NULL),
(11, 40, '2022-07-11 09:30:00', '1305.27', 1, 'Bank Transfer', NULL),
(12, 130, '2022-07-14 14:20:00', '1212.77', 2, 'PayPal', NULL),
(13, 100, '2022-07-18 17:30:00', '753.40', 3, 'Bank Transfer', NULL),
(14, 105, '2022-08-01 10:45:00', '3821.68', 1, 'Credit Card', NULL),
(15, 8, '2022-08-05 11:15:00', '1089.35', 2, 'Credit Card', NULL),
(16, 15, '2022-08-10 15:00:00', '3371.69', 3, 'Bank Transfer', NULL),
(17, 24, '2022-08-15 09:30:00', '3143.35', 1, 'Credit Card', NULL),
(18, 26, '2022-08-22 12:45:00', '1164.63', 2, 'Credit Card', NULL),
(19, 65, '2022-09-01 14:00:00', '3215.61', 3, 'Bank Transfer', NULL),
(20, 65, '2022-09-07 10:30:00', '2302.91', 1, 'PayPal', NULL),
(21, 128, '2022-11-01 10:00:00', '3755.43', 3, 'PayPal', NULL),
(22, 122, '2022-11-02 11:30:00', '1946.52', 3, 'Credit Card', NULL),
(23, 130, '2022-11-03 09:45:00', '2044.84', 1, 'Bank Transfer', NULL),
(24, 124, '2022-11-04 14:15:00', '1116.27', 3, 'Bank Transfer', NULL),
(25, 131, '2022-11-05 16:30:00', '1821.79', 2, 'Bank Transfer', NULL),
(26, 127, '2022-11-06 13:45:00', '825.05', 3, 'Bank Transfer', NULL),
(27, 134, '2022-11-07 09:00:00', '4193.46', 1, 'Credit Card', NULL),
(28, 133, '2022-11-08 12:00:00', '1054.32', 3, 'PayPal', NULL),
(29, 126, '2022-11-09 15:30:00', '2560.14', 3, 'Bank Transfer', NULL),
(30, 123, '2022-11-10 17:15:00', '349.99', 2, 'PayPal', NULL),
(31, 129, '2022-11-11 11:30:00', '89.99', 3, 'PayPal', NULL),
(32, 125, '2022-11-12 14:45:00', '72.97', 1, 'PayPal', NULL),
(33, 132, '2022-11-13 10:15:00', '119.99', 3, 'PayPal', NULL),
(34, 128, '2022-11-14 11:30:00', '79.98', 3, 'Credit Card', NULL),
(35, 122, '2022-11-15 09:00:00', '202.77', 2, 'Bank Transfer', NULL),
(36, 130, '2022-11-16 12:30:00', '235.07', 3, 'PayPal', NULL),
(37, 124, '2022-11-17 15:15:00', '326.58', 1, 'Bank Transfer', NULL),
(38, 131, '2022-11-18 10:45:00', '166.71', 3, 'Credit Card', NULL),
(39, 127, '2022-11-19 14:00:00', '458.70', 3, 'Credit Card', NULL),
(40, 134, '2022-11-20 16:45:00', '497.22', 2, 'PayPal', NULL),
(41, 87, '2022-09-03 10:35:12', '48.40', 3, 'Credit Card', NULL),
(42, 129, '2022-09-04 11:24:08', '233.85', 1, 'Bank Transfer', NULL),
(43, 124, '2022-09-04 13:47:23', '1199.64', 3, 'Credit Card', NULL),
(44, 92, '2022-09-05 15:02:41', '119.97', 2, 'Bank Transfer', NULL),
(45, 117, '2022-09-06 09:18:57', '194.58', 3, 'Bank Transfer', NULL),
(46, 104, '2022-09-06 14:52:11', '194.96', 1, 'Bank Transfer', NULL),
(47, 127, '2022-09-07 16:03:49', '135.83', 3, 'PayPal', NULL),
(48, 107, '2022-09-08 08:20:02', '86.52', 2, 'Bank Transfer', NULL),
(49, 133, '2022-09-09 12:35:46', '452.40', 3, 'Bank Transfer', NULL),
(50, 102, '2022-09-09 14:55:08', '566.56', 1, 'Bank Transfer', NULL),
(51, 1, '2022-09-10 17:21:17', '696.88', 3, 'Bank Transfer', NULL),
(52, 115, '2022-09-11 10:44:33', '655.00', 2, 'Credit Card', NULL),
(53, 112, '2022-09-11 12:52:09', '117.00', 3, 'PayPal', NULL),
(54, 95, '2022-09-12 13:22:54', '1359.50', 1, 'Credit Card', NULL),
(55, 108, '2022-09-13 14:38:21', '842.17', 3, 'Credit Card', NULL),
(56, 126, '2022-09-14 09:05:46', '91.08', 2, 'Credit Card', NULL),
(57, 131, '2022-09-14 11:16:39', '511.19', 3, 'Bank Transfer', NULL),
(58, 122, '2022-09-15 12:45:07', '109.99', 1, 'PayPal', NULL),
(59, 125, '2022-09-16 13:58:33', '1057.96', 3, 'Bank Transfer', NULL),
(60, 110, '2022-09-17 15:05:52', '443.34', 2, 'PayPal', NULL),
(61, 119, '2022-09-18 16:12:18', '59.99', 3, 'Bank Transfer', NULL),
(62, 131, '2022-09-18 17:56:44', '635.60', 1, 'Bank Transfer', NULL),
(63, 118, '2022-09-19 10:24:19', '448.80', 3, 'Bank Transfer', NULL),
(64, 98, '2022-09-20 12:05:03', '19.98', 2, 'PayPal', NULL),
(65, 103, '2022-09-21 13:46:57', '145.18', 3, 'Credit Card', NULL),
(66, 63, '2022-12-10 14:35:00', '131.50', 3, 'Bank Transfer', NULL),
(67, 131, '2022-12-11 16:20:00', '32.50', 1, 'Bank Transfer', NULL),
(68, 124, '2022-12-12 09:45:00', '980.20', 2, 'Bank Transfer', NULL),
(69, 129, '2022-12-14 11:15:00', '27.50', 3, 'Credit Card', NULL),
(70, 86, '2022-12-15 17:30:00', '359.98', 1, 'Bank Transfer', NULL),
(71, 120, '2022-12-16 14:55:00', '25.98', 3, 'PayPal', NULL),
(72, 125, '2022-12-18 09:20:00', '230.66', 2, 'Credit Card', NULL),
(73, 132, '2022-12-19 12:40:00', '477.14', 1, 'Bank Transfer', NULL),
(74, 26, '2022-12-20 15:10:00', '12.99', 3, 'Bank Transfer', NULL),
(75, 125, '2022-12-22 10:45:00', '230.09', 2, 'PayPal', NULL),
(76, 17, '2022-12-23 13:55:00', '18.99', 3, 'Bank Transfer', NULL),
(77, 128, '2022-12-24 16:30:00', '556.08', 1, 'PayPal', NULL),
(78, 130, '2022-12-26 11:00:00', '816.31', 3, 'PayPal', NULL),
(79, 134, '2022-12-27 14:20:00', '1389.35', 2, 'PayPal', NULL),
(80, 123, '2022-12-28 17:40:00', '246.65', 3, 'Credit Card', NULL),
(81, 14, '2022-12-30 12:15:00', '7.99', 1, 'PayPal', NULL),
(82, 122, '2022-12-31 15:25:00', '590.94', 3, 'Credit Card', NULL),
(83, 135, '2023-01-02 10:50:00', '66.00', 2, 'Bank Transfer', NULL),
(84, 133, '2023-01-03 13:10:00', '1231.70', 3, 'PayPal', NULL),
(85, 16, '2023-01-05 16:30:00', '367.35', 1, 'Bank Transfer', NULL),
(86, 127, '2022-11-05 09:23:41', '40.09', 3, 'PayPal', NULL),
(87, 110, '2022-12-11 14:56:29', '114.31', 2, 'Credit Card', NULL),
(88, 124, '2022-12-18 11:07:02', '488.33', 5, 'Bank Transfer', NULL),
(89, 128, '2023-01-06 16:45:12', '110.61', 1, 'Credit Card', NULL),
(90, 120, '2023-01-08 08:32:59', '42.00', 3, 'PayPal', NULL),
(91, 131, '2023-01-12 10:17:41', '86.75', 3, 'Credit Card', NULL),
(92, 127, '2023-01-16 17:29:12', '3337.03', 2, 'PayPal', NULL),
(93, 118, '2023-01-18 13:45:55', '440.65', 3, 'PayPal', NULL),
(94, 123, '2023-01-23 19:01:04', '822.72', 1, 'Credit Card', NULL),
(95, 132, '2023-01-25 08:15:23', '19.21', 3, 'PayPal', NULL),
(96, 120, '2023-01-29 14:37:51', '536.06', 3, 'Bank Transfer', NULL),
(97, 125, '2023-02-01 10:55:34', '29.99', 2, 'Credit Card', NULL),
(98, 125, '2023-02-03 16:08:49', '16.99', 1, 'Credit Card', NULL),
(99, 128, '2023-02-06 20:23:12', '1431.66', 5, 'Bank Transfer', NULL),
(100, 129, '2023-02-08 12:45:22', '119.95', 3, 'PayPal', NULL),
(101, 134, '2023-02-11 11:07:14', '119.98', 3, 'Credit Card', NULL),
(102, 120, '2023-02-15 15:28:43', '856.04', 2, 'PayPal', NULL),
(103, 129, '2023-02-18 09:46:31', '225.00', 3, 'PayPal', NULL),
(104, 122, '2023-02-22 12:55:44', '181.96', 3, 'PayPal', NULL),
(105, 127, '2023-02-24 17:07:05', '119.98', 1, 'PayPal', NULL),
(106, 125, '2022-11-17 09:30:00', '510.23', 5, 'PayPal', NULL),
(107, 121, '2022-10-22 13:15:00', '319.99', 2, 'Bank Transfer', NULL),
(108, 130, '2022-10-27 11:45:00', '85.00', 1, 'PayPal', NULL),
(109, 126, '2022-12-01 16:20:00', '106.32', 5, 'Credit Card', NULL),
(110, 129, '2022-11-05 14:30:00', '726.69', 2, 'Credit Card', NULL),
(111, 123, '2022-11-28 10:00:00', '140.50', 1, 'PayPal', NULL),
(112, 127, '2023-01-12 15:45:00', '16.92', 5, 'Bank Transfer', NULL),
(113, 131, '2023-02-08 18:00:00', '44.59', 2, 'Bank Transfer', NULL),
(114, 128, '2023-01-22 12:30:00', '554.00', 1, 'Credit Card', NULL),
(115, 132, '2022-10-16 17:00:00', '912.30', 5, 'PayPal', NULL),
(116, 124, '2022-12-18 14:15:00', '122.96', 2, 'Credit Card', NULL),
(117, 129, '2022-12-10 09:00:00', '336.42', 1, 'Bank Transfer', NULL),
(118, 122, '2023-01-08 15:30:00', '233.04', 5, 'PayPal', NULL),
(119, 131, '2022-11-11 16:45:00', '94.04', 2, 'Bank Transfer', NULL),
(120, 133, '2022-10-25 11:00:00', '419.49', 1, 'PayPal', NULL),
(121, 128, '2023-01-19 10:00:00', '674.91', 5, 'Credit Card', NULL),
(122, 126, '2022-12-20 14:15:00', '372.05', 2, 'PayPal', NULL),
(123, 125, '2022-10-28 16:30:00', '197.28', 1, 'Bank Transfer', NULL),
(124, 130, '2022-11-02 09:45:00', '383.09', 5, 'PayPal', NULL),
(125, 123, '2022-11-24 12:00:00', '214.50', 2, 'Bank Transfer', NULL),
(126, 131, '2023-01-16 14:45:00', '64.38', 1, 'Credit Card', NULL),
(127, 124, '2022-12-14 18:30:00', '478.90', 5, 'Bank Transfer', NULL),
(128, 126, '2022-10-18 11:00:00', '63.00', 2, 'Credit Card', NULL),
(129, 122, '2022-10-29 14:15:00', '825.37', 1, 'Credit Card', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `order_item_id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL COMMENT 'Unit price at time of purchase (copied from products table when order is created)'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`order_item_id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 17, 26, 7, '12.07'),
(2, 37, 13, 2, '74.35'),
(3, 6, 32, 6, '39.12'),
(4, 3, 11, 2, '11.97'),
(5, 24, 34, 10, '10.99'),
(6, 14, 11, 10, '69.58'),
(7, 21, 17, 1, '12.52'),
(8, 5, 24, 6, '12.01'),
(9, 18, 32, 3, '90.83'),
(10, 21, 31, 9, '92.62'),
(11, 1, 15, 9, '22.01'),
(12, 9, 33, 5, '73.53'),
(13, 7, 37, 2, '91.26'),
(14, 2, 21, 6, '7.75'),
(15, 17, 28, 10, '41.74'),
(16, 7, 34, 8, '32.67'),
(17, 3, 23, 7, '58.76'),
(18, 25, 18, 8, '53.51'),
(19, 7, 24, 5, '34.84'),
(20, 8, 13, 9, '41.99'),
(21, 10, 18, 3, '16.20'),
(22, 21, 6, 7, '89.12'),
(23, 13, 17, 9, '21.40'),
(24, 6, 17, 6, '50.67'),
(25, 22, 13, 4, '91.62'),
(26, 13, 15, 6, '82.33'),
(27, 10, 6, 8, '37.71'),
(28, 14, 11, 1, '21.87'),
(29, 41, 34, 8, '6.05'),
(30, 26, 13, 1, '42.22'),
(31, 21, 15, 8, '51.03'),
(32, 8, 34, 7, '49.62'),
(33, 14, 37, 4, '84.45'),
(34, 5, 13, 2, '82.44'),
(35, 17, 19, 7, '88.16'),
(36, 11, 11, 3, '25.87'),
(37, 15, 29, 4, '47.23'),
(38, 6, 24, 6, '68.57'),
(39, 25, 8, 5, '54.32'),
(40, 11, 8, 9, '87.67'),
(41, 21, 33, 2, '44.93'),
(42, 17, 11, 10, '68.64'),
(43, 19, 6, 9, '74.79'),
(44, 5, 25, 8, '73.23'),
(45, 12, 31, 9, '86.08'),
(46, 21, 37, 7, '57.40'),
(47, 21, 33, 2, '11.77'),
(48, 29, 29, 9, '76.29'),
(49, 10, 17, 2, '62.75'),
(50, 14, 23, 5, '72.51'),
(51, 5, 17, 8, '47.39'),
(52, 29, 22, 10, '89.44'),
(53, 49, 28, 6, '75.40'),
(54, 28, 22, 10, '21.73'),
(55, 28, 8, 2, '40.39'),
(56, 8, 8, 3, '54.10'),
(57, 27, 38, 3, '14.55'),
(58, 26, 2, 6, '64.78'),
(59, 16, 27, 10, '69.52'),
(60, 16, 23, 4, '96.88'),
(61, 24, 5, 3, '73.91'),
(62, 28, 25, 3, '50.20'),
(63, 17, 14, 2, '47.57'),
(64, 28, 13, 9, '19.93'),
(65, 9, 3, 4, '63.92'),
(66, 1, 12, 4, '99.02'),
(67, 24, 7, 4, '26.13'),
(68, 3, 29, 5, '17.37'),
(69, 7, 30, 2, '64.96'),
(70, 17, 38, 2, '95.96'),
(71, 8, 14, 1, '31.92'),
(72, 6, 5, 10, '66.56'),
(73, 8, 11, 7, '35.39'),
(74, 21, 25, 1, '27.32'),
(75, 3, 28, 4, '69.72'),
(76, 9, 16, 2, '64.60'),
(77, 19, 10, 4, '5.79'),
(78, 29, 37, 8, '7.70'),
(79, 24, 37, 4, '13.57'),
(80, 8, 1, 4, '64.49'),
(81, 4, 27, 2, '51.20'),
(82, 3, 1, 9, '11.78'),
(83, 26, 6, 2, '12.05'),
(84, 3, 5, 5, '69.66'),
(85, 6, 32, 6, '48.56'),
(86, 16, 13, 1, '16.73'),
(87, 16, 15, 3, '25.49'),
(88, 8, 24, 4, '96.41'),
(89, 21, 25, 2, '60.12'),
(90, 18, 9, 4, '12.31'),
(91, 10, 17, 2, '43.38'),
(92, 18, 32, 4, '36.97'),
(93, 17, 32, 5, '72.18'),
(94, 7, 38, 3, '31.80'),
(95, 20, 21, 7, '49.92'),
(96, 16, 10, 7, '38.39'),
(97, 27, 19, 8, '29.48'),
(98, 2, 17, 1, '93.35'),
(99, 24, 29, 3, '16.44'),
(100, 43, 17, 9, '98.44'),
(101, 6, 9, 6, '33.25'),
(102, 21, 25, 2, '60.15'),
(103, 18, 9, 4, '8.14'),
(104, 5, 24, 7, '33.95'),
(105, 19, 12, 6, '86.03'),
(106, 19, 22, 10, '88.01'),
(107, 19, 23, 1, '64.15'),
(108, 43, 15, 4, '78.42'),
(109, 21, 8, 9, '66.04'),
(110, 20, 20, 5, '79.53'),
(111, 16, 15, 3, '10.99'),
(112, 18, 32, 4, '12.53'),
(113, 14, 4, 1, '11.33'),
(114, 4, 17, 8, '46.66'),
(115, 29, 20, 8, '5.23'),
(116, 26, 13, 1, '34.49'),
(117, 11, 35, 4, '29.83'),
(118, 4, 34, 1, '54.15'),
(119, 14, 32, 8, '30.88'),
(120, 3, 24, 9, '54.80'),
(121, 39, 11, 6, '76.45'),
(122, 6, 27, 10, '52.71'),
(123, 22, 10, 1, '36.24'),
(124, 18, 37, 10, '16.76'),
(125, 19, 30, 1, '82.54'),
(126, 29, 17, 3, '93.25'),
(127, 27, 28, 10, '53.35'),
(128, 22, 4, 4, '37.47'),
(129, 21, 23, 8, '5.35'),
(130, 23, 32, 9, '60.13'),
(131, 14, 24, 8, '75.28'),
(132, 16, 15, 4, '75.05'),
(133, 16, 20, 10, '99.51'),
(134, 8, 13, 10, '51.85'),
(135, 23, 12, 4, '58.12'),
(136, 26, 30, 3, '84.47'),
(137, 14, 33, 9, '67.34'),
(138, 22, 31, 8, '34.50'),
(139, 10, 27, 5, '40.27'),
(140, 12, 32, 10, '23.48'),
(141, 6, 13, 2, '65.58'),
(142, 24, 4, 1, '98.62'),
(143, 23, 35, 3, '39.36'),
(144, 5, 27, 1, '26.73'),
(145, 27, 37, 1, '19.79'),
(146, 23, 13, 4, '88.80'),
(147, 9, 30, 1, '94.27'),
(148, 16, 31, 5, '86.33'),
(149, 27, 1, 4, '54.24'),
(150, 20, 29, 8, '47.80'),
(151, 26, 21, 2, '7.04'),
(152, 21, 17, 1, '13.38'),
(153, 6, 29, 2, '53.92'),
(154, 4, 1, 7, '49.15'),
(155, 7, 30, 3, '72.80'),
(156, 27, 20, 8, '18.63'),
(157, 16, 8, 4, '41.78'),
(158, 45, 24, 9, '21.62'),
(159, 14, 31, 7, '65.17'),
(160, 11, 32, 2, '12.10'),
(161, 1, 37, 7, '37.14'),
(162, 46, 35, 2, '97.48'),
(163, 14, 17, 8, '52.40'),
(164, 7, 22, 2, '30.68'),
(165, 23, 2, 9, '35.14'),
(166, 27, 26, 6, '93.81'),
(167, 27, 27, 9, '95.33'),
(168, 10, 28, 8, '43.22'),
(169, 25, 2, 7, '99.13'),
(170, 3, 21, 4, '29.27'),
(171, 5, 2, 7, '40.01'),
(172, 22, 27, 2, '72.66'),
(173, 3, 14, 6, '46.58'),
(174, 20, 3, 4, '46.69'),
(175, 6, 27, 9, '10.92'),
(176, 40, 1, 6, '82.87'),
(177, 11, 15, 9, '14.59'),
(178, 37, 15, 1, '26.94'),
(179, 28, 1, 3, '9.39'),
(180, 18, 32, 4, '20.17'),
(181, 47, 25, 8, '6.28'),
(182, 50, 14, 8, '70.82'),
(183, 6, 36, 1, '57.98'),
(184, 17, 7, 2, '22.26'),
(185, 36, 36, 2, '17.32'),
(186, 3, 2, 10, '79.30'),
(187, 28, 16, 2, '77.49'),
(188, 7, 31, 4, '39.28'),
(189, 22, 25, 10, '97.26'),
(190, 27, 26, 6, '89.49'),
(191, 21, 35, 5, '43.27'),
(192, 21, 16, 9, '19.03'),
(193, 4, 5, 3, '5.92'),
(194, 27, 34, 7, '66.61'),
(195, 8, 16, 2, '73.11'),
(196, 2, 2, 2, '40.49'),
(197, 17, 27, 9, '12.86'),
(198, 26, 8, 4, '14.81'),
(199, 15, 3, 3, '74.49'),
(200, 38, 25, 3, '55.57'),
(201, 2, 5, 5, '5.24'),
(202, 18, 38, 2, '60.80'),
(203, 19, 14, 9, '31.89'),
(204, 24, 11, 9, '53.10'),
(205, 28, 9, 3, '74.95'),
(206, 42, 37, 3, '56.70'),
(207, 26, 28, 1, '8.83'),
(208, 2, 7, 7, '76.05'),
(209, 47, 28, 3, '28.53'),
(210, 11, 4, 4, '40.95'),
(211, 27, 17, 5, '73.60'),
(212, 12, 34, 2, '7.89'),
(213, 23, 29, 5, '96.33'),
(214, 14, 20, 2, '30.80'),
(215, 25, 18, 8, '31.37'),
(216, 6, 6, 2, '25.15'),
(217, 20, 29, 8, '31.33'),
(218, 8, 21, 10, '88.44'),
(219, 20, 30, 9, '81.78'),
(220, 17, 15, 3, '10.58'),
(221, 17, 25, 6, '70.98'),
(222, 27, 16, 4, '50.66'),
(223, 12, 18, 3, '62.49'),
(224, 13, 11, 1, '66.82'),
(225, 35, 37, 9, '22.53'),
(226, 25, 37, 3, '59.08'),
(227, 29, 7, 10, '34.37'),
(228, 19, 10, 4, '92.07'),
(229, 18, 8, 2, '34.73'),
(230, 2, 10, 2, '15.42'),
(231, 1, 29, 8, '32.57'),
(232, 10, 29, 8, '66.52'),
(233, 42, 21, 1, '63.75'),
(234, 36, 31, 3, '66.81'),
(235, 19, 6, 10, '13.10'),
(236, 21, 9, 1, '56.03'),
(237, 17, 7, 2, '36.05'),
(238, 5, 28, 2, '63.38'),
(239, 18, 10, 5, '34.60'),
(240, 10, 24, 2, '15.24'),
(241, 37, 16, 2, '75.47'),
(242, 4, 17, 9, '72.49'),
(243, 4, 20, 3, '62.20'),
(244, 9, 27, 7, '97.06'),
(245, 29, 3, 4, '63.06'),
(246, 28, 38, 1, '18.27'),
(247, 48, 32, 2, '43.26'),
(248, 15, 9, 8, '84.62'),
(249, 2, 31, 9, '84.44'),
(250, 19, 23, 2, '95.04'),
(251, 65, 25, 7, '20.74'),
(252, 127, 14, 10, '47.89'),
(253, 92, 11, 9, '46.15'),
(254, 96, 24, 4, '99.02'),
(255, 124, 7, 4, '41.89'),
(256, 113, 32, 7, '6.37'),
(257, 129, 36, 7, '51.19'),
(258, 87, 34, 1, '63.63'),
(259, 122, 26, 7, '34.55'),
(260, 93, 31, 5, '71.27'),
(261, 66, 35, 10, '13.15'),
(262, 92, 16, 5, '91.83'),
(263, 73, 28, 8, '56.07'),
(264, 86, 27, 1, '40.09'),
(265, 95, 29, 1, '19.21'),
(266, 88, 38, 5, '41.13'),
(267, 89, 14, 3, '36.87'),
(268, 116, 7, 4, '30.74'),
(269, 72, 23, 2, '77.17'),
(270, 88, 5, 3, '65.72'),
(271, 96, 37, 2, '69.99'),
(272, 55, 11, 2, '90.09'),
(273, 54, 24, 10, '80.36'),
(274, 63, 18, 8, '56.10'),
(275, 77, 5, 6, '29.88'),
(276, 124, 38, 7, '30.79'),
(277, 84, 13, 4, '92.04'),
(278, 84, 16, 7, '30.88'),
(279, 72, 24, 3, '25.44'),
(280, 85, 22, 5, '73.47'),
(281, 62, 25, 8, '79.45'),
(282, 104, 3, 4, '45.49'),
(283, 60, 16, 6, '73.89'),
(284, 119, 8, 4, '23.51'),
(285, 122, 36, 10, '13.02'),
(286, 88, 6, 4, '21.38'),
(287, 120, 34, 8, '32.46'),
(288, 56, 20, 4, '22.77'),
(289, 121, 35, 9, '74.99'),
(290, 129, 29, 8, '58.38'),
(291, 92, 37, 2, '10.72'),
(292, 109, 22, 6, '17.72'),
(293, 128, 19, 6, '10.50'),
(294, 112, 28, 3, '5.64'),
(295, 77, 28, 6, '62.80'),
(296, 80, 4, 3, '18.79'),
(297, 120, 38, 3, '53.27'),
(298, 102, 29, 8, '55.81'),
(299, 83, 19, 2, '33.00'),
(300, 52, 11, 4, '80.00'),
(301, 115, 27, 10, '91.23'),
(302, 93, 37, 3, '28.10'),
(303, 92, 35, 10, '88.58'),
(304, 102, 24, 2, '11.16'),
(305, 110, 22, 6, '98.98'),
(306, 78, 30, 9, '9.98'),
(307, 99, 35, 8, '84.61'),
(308, 53, 28, 5, '23.40'),
(309, 94, 7, 3, '56.86'),
(310, 57, 31, 8, '57.40'),
(311, 78, 6, 7, '96.42'),
(312, 110, 35, 3, '44.27'),
(313, 82, 30, 7, '84.42'),
(314, 73, 38, 1, '28.58'),
(315, 59, 32, 8, '43.72'),
(316, 106, 13, 6, '70.51'),
(317, 114, 4, 10, '55.40'),
(318, 111, 10, 10, '14.05'),
(319, 94, 20, 9, '72.46'),
(320, 51, 37, 8, '87.11'),
(321, 55, 30, 7, '94.57'),
(322, 125, 36, 5, '42.90'),
(323, 102, 5, 6, '49.18'),
(324, 102, 33, 4, '23.04'),
(325, 117, 33, 7, '48.06'),
(326, 87, 37, 4, '12.67'),
(327, 68, 36, 10, '98.02'),
(328, 52, 9, 10, '33.50'),
(329, 92, 29, 2, '60.72'),
(330, 84, 15, 6, '87.10'),
(331, 92, 2, 7, '90.82'),
(332, 106, 32, 1, '87.17'),
(333, 57, 33, 1, '51.99'),
(334, 84, 27, 2, '62.39'),
(335, 99, 12, 7, '17.51'),
(336, 118, 33, 8, '29.13'),
(337, 123, 2, 4, '49.32'),
(338, 80, 20, 4, '47.57'),
(339, 54, 36, 6, '92.65'),
(340, 126, 1, 3, '21.46'),
(341, 59, 3, 10, '70.82'),
(342, 92, 22, 3, '64.39'),
(343, 75, 28, 7, '32.87'),
(344, 79, 38, 8, '99.62'),
(345, 99, 4, 7, '85.37'),
(346, 78, 9, 1, '51.55'),
(347, 79, 14, 8, '58.67'),
(348, 99, 17, 3, '11.54'),
(349, 92, 17, 7, '86.42'),
(350, 79, 11, 3, '41.01');

-- --------------------------------------------------------

--
-- Table structure for table `order_status`
--

CREATE TABLE `order_status` (
  `order_status_id` int(11) NOT NULL,
  `status` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `order_status`
--

INSERT INTO `order_status` (`order_status_id`, `status`) VALUES
(1, 'Shipped'),
(2, 'Delivered'),
(3, 'Processing'),
(4, 'Cancelled'),
(5, 'Pending');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `product_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `categogy_id` int(11) NOT NULL,
  `date_added` date DEFAULT NULL,
  `stock_quantity` int(11) DEFAULT NULL,
  `discount_price` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `discontinued` tinyint(1) DEFAULT 0,
  `image_gallery` text DEFAULT NULL,
  `thumb_url` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`product_id`, `name`, `description`, `price`, `categogy_id`, `date_added`, `stock_quantity`, `discount_price`, `is_active`, `discontinued`, `image_gallery`, `thumb_url`) VALUES
(1, 'Bowhaus Dog Food', 'Premium quality dog food', '49.99', 1, '2025-05-01', 50, '42.49', 1, 0, '[\"/images/large/1/1.jpg\", \"/images/large/1/1_2.jpg\", \"/images/large/1/1_3.jpg\", \"/images/large/1/1_4.jpg\", \"/images/large/1/1_5.jpg\"]\r\n', '/images/thumbs/1/1.jpg'),
(2, 'Weight Control Cat Food', 'Healthy cat food', '39.99', 2, '2025-09-21', 65, '33.99', 1, 0, '[\"/images/large/2/2.jpg\"]', '/images/thumbs/2/2.jpg'),
(3, 'Bird Cage', 'Large bird cage', '199.99', 3, '2025-05-04', 73, '159.99', 1, 0, '[\"/images/large/3/3.jpg\"]', '/images/thumbs/3/3.jpg'),
(4, 'Hamster Wheel', 'Silent hamster wheel', '9.99', 4, '2025-09-16', 70, '8.49', 1, 0, '[\"/images/large/4/4.jpg\"]', '/images/thumbs/4/4.jpg'),
(5, 'Fontaines Fish Food', 'Nutritious fish food', '14.99', 5, '2025-09-25', 30, '13.49', 1, 0, '[\"/images/large/5/5.jpg\", \"/images/large/5/5_2.jpg\", \"/images/large/5/5_3.jpg\"]', '/images/thumbs/5/5.jpg'),
(6, 'Dog Collar', 'Leather dog collar', '24.99', 1, '2025-09-30', 31, '22.49', 1, 0, '[\"/images/large/6/6.jpg\", \"/images/large/6/6_2.jpg\"]', '/images/thumbs/6/6.jpg'),
(7, 'Cat Litter', 'Odor control cat litter', '29.99', 2, '2025-09-25', 62, '25.49', 1, 0, '[\"/images/large/7/7.jpg\", \"/images/large/7/7_2.jpg\"]', '/images/thumbs/7/7.jpg'),
(8, 'Bird Food', 'Premium bird food', '19.99', 3, '2025-08-20', 19, '17.99', 1, 0, '[\"/images/large/8/8.jpg\", \"/images/large/8/8_2.jpg\", \"/images/large/8/8_3.jpg\"]', '/images/thumbs/8/8.jpg'),
(9, 'Monk Rabbit Hutch', 'Outdoor rabbit hutch', '399.99', 4, '2025-09-02', 97, '339.99', 1, 0, '[\"/images/large/9/9.jpg\"]', '/images/thumbs/9/9.jpg'),
(10, 'Dog Leash', 'Retractable dog leash', '34.99', 1, '2025-08-23', 39, '31.49', 1, 0, '[\"/images/large/10/10.jpg\", \"/images/large/10/10_2.jpg\", \"/images/large/10/10_3.jpg\"]', '/images/thumbs/10/10.jpg'),
(11, 'Cat Tree', 'Large cat tree', '179.99', 2, '2025-05-31', 91, '161.99', 1, 0, '[\"/images/large/11/11.jpg\"]', '/images/thumbs/11/11.jpg'),
(12, 'Bird Toys', 'Assorted bird toys', '9.99', 3, '2025-04-25', 48, '8.99', 1, 0, '[\"/images/large/12/12.jpg\", \"/images/large/12/12_2.jpg\", \"/images/large/12/12_3.jpg\"]', '/images/thumbs/12/12.jpg'),
(13, 'Guinea Pig Food', 'Healthy guinea pig food', '12.99', 4, '2025-07-13', 57, '11.04', 1, 0, '[\"/images/large/13/13.jpg\", \"/images/large/13/13_2.jpg\"]', '/images/thumbs/13/13.jpg'),
(14, 'Dog Bed', 'Orthopedic dog bed', '89.99', 1, '2025-06-02', 40, '71.99', 1, 0, '[\"/images/large/14/14.jpg\", \"/images/large/14/14_2.jpg\"]', '/images/thumbs/14/14.jpg'),
(15, 'Cat Toys', 'Interactive cat toys', '7.99', 2, '2025-09-06', 27, '7.19', 1, 0, '[\"/images/large/15/15.jpg\"]', '/images/thumbs/15/15.jpg'),
(16, 'Bird Perch', 'Wooden bird perch', '6.99', 3, '2025-05-17', 8, '6.29', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(17, 'Hamster Cage', 'Multi-level hamster cage', '59.99', 4, '2025-07-06', 50, '47.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(18, 'Dog Treats', 'All-natural dog treats', '12.99', 1, '2025-08-19', 29, '10.39', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(19, 'Cat Bed', 'Cozy cat bed', '39.99', 2, '2025-05-04', 87, '33.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(20, 'Bird Bath', 'Ceramic bird bath', '29.99', 3, '2025-06-24', 58, '26.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(21, 'Gerbil Food', 'Premium gerbil food mix', '7.99', 4, '2025-07-31', 21, '7.19', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(22, 'Kellogs Organic Cat Food', 'High-quality, organic cat food made with all-natural ingredients.', '14.99', 6, '2025-09-02', 24, '12.74', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(23, 'Harper Dog Collar', 'A premium, durable nylon collar with reinforced stitching. Stylish and durable collar for your furry friend.', '9.99', 7, '2025-04-25', 54, '8.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(24, 'Cat Toy Set', 'Assorted set of cat toys to keep your feline entertained.', '19.99', 8, '2025-09-27', 98, '16.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(25, 'Poochy Dog Shampoo', 'Gentle, all-natural dog shampoo to keep your pooch clean and smelling fresh.', '12.99', 9, '2025-06-20', 35, '11.04', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(26, 'Pet Bed', 'Cozy and comfortable pet bed for your furry friend to rest in.', '29.99', 10, '2025-04-25', 67, '25.49', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(27, 'Fish Tank', 'Stylish and spacious fish tank for your aquatic pets.', '99.99', 11, '2025-05-11', 34, '79.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(28, 'Bronze Bird Cage', 'Large and sturdy bird cage for your feathered friend.', '49.99', 12, '2025-07-18', 60, '39.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(29, 'Small Animal Playpen', 'Spacious playpen for your small pets to play in.', '39.99', 13, '2025-05-12', 99, '31.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(30, 'Plastic Hamster Wheel', 'Fun and colorful hamster wheel for your furry friend to exercise in.', '7.99', 8, '2025-05-08', 20, '7.19', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(31, 'Cat Scratching Post', 'Durable and fun cat scratching post to keep your felines claws in shape.', '24.99', 10, '2025-05-15', 88, '21.24', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(32, 'Leather Dog Leash', 'Stylish and sturdy dog leash for your pooch.', '12.99', 7, '2025-06-27', 87, '11.69', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(33, 'Pet Carrier', 'Comfortable and spacious pet carrier for travel.', '34.99', 14, '2025-07-15', 69, '29.74', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(34, 'Reptile Heat Lamp', 'High-quality premium heat lamp for your reptile.', '19.99', 15, '2025-06-02', 82, '16.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(35, 'Rabbit Hutch', 'Large and sturdy hutch for your furry friend.', '89.99', 12, '2025-09-03', 7, '71.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(36, 'Fishy Fish Food', 'Nutritious fish food for your aquatic pets.', '7.99', 6, '2025-04-30', 73, '6.39', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(37, 'Dog Brush', 'Gentle and effective dog brush to keep your pooch well-groomed.', '9.99', 9, '2025-04-22', 49, '8.99', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg'),
(38, 'Birdy Bird Food', 'Premium bird food for your feathered friend.', '12.99', 6, '2025-09-23', 21, '10.39', 1, 0, '[\"/images/no-image.jpg\"]', '/images/no-image.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `review_id` int(11) NOT NULL,
  `product_id` int(11) DEFAULT NULL,
  `customer_id` int(11) DEFAULT NULL,
  `rating` int(11) DEFAULT NULL,
  `comment` text DEFAULT NULL,
  `review_date` date DEFAULT NULL,
  `is_flagged` tinyint(1) DEFAULT 0,
  `ip_address` varchar(45) DEFAULT NULL,
  `flag_reason` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `reviews`
--

INSERT INTO `reviews` (`review_id`, `product_id`, `customer_id`, `rating`, `comment`, `review_date`, `is_flagged`, `ip_address`, `flag_reason`) VALUES
(0, 33, 15, 1, 'I purchased the Pettopia Pet Carrier under the delusion that it would provide comfort and luxury for Madame Fluff, an esteemed lady of refined taste and impeccable fur. Instead, what arrived looked like something cobbled together from rejected parachute fabric and despair. The “plush interior” felt like sandpaper wrapped in regret, and the zippers screeched like banshees every time I dared open them.\r\n\r\nThe moment I placed Her Ladyship inside, the carrier collapsed slightly — as if bowing before her, which I suppose is fitting, since it certainly wasn’t functioning as a structural object. By the time we reached the vet, Madame Fluff had clawed her way halfway through the side and was emerging like a furry Houdini, eyes blazing with the righteous fury of a wronged monarch.\r\n\r\nThe Pettopia Pet Carrier now resides in the garage, where it belongs — a monument to false advertising and feline vengeance. Madame Fluff refuses to even look at it. Frankly, I can’t blame her. If my little Fluff could file a lawsuit, Pettopia would already be in court.', '2025-05-29', 1, '192.48.80.32', 'Suspicious low rating'),
(1, 23, 98, 1, 'I rarely write reviews, but the Harper Dog Collar has earned the dubious honour of being one of the worst purchases I’ve made for my Fluffy in years. I honestly don’t know how this product made it past even a basic quality check, because everything about it screams cheap and careless.\r\n\r\nLet’s start with the materials. The listing described it as “premium, durable nylon with reinforced stitching.” What arrived felt like the kind of flimsy strap you’d find on a dollar-store duffel bag. Within two weeks, the stitching started to fray, and by the end of the month, the collar had stretched so badly that my dog could slip right out of it — a terrifying realization during a walk near traffic. So much for “secure and reliable.”\r\n\r\nThe buckle? A brittle piece of plastic masquerading as hardware. It jammed constantly and eventually cracked clean in half during a mild tug. I’ve had cheap off-brand collars from gas stations that held up better than this thing. The metal D-ring for the leash isn’t any better — it’s thin, soft, and already showing rust after minimal use. For a supposedly “weather-resistant” collar, it couldn’t even handle a few drizzles.\r\n\r\nThen there’s the sizing. Whoever designed the size chart must have been guessing. I ordered according to my dog’s exact neck measurement, and yet the collar arrived so stiff and oversized it looked like something out of a medieval torture museum. Even when adjusted to the smallest setting, it hung loose enough to slip over my dog’s head. But when I exchanged for the next size down, that one was so short it barely fit around his neck at all.\r\n\r\nAnd don’t get me started on comfort. The inner lining is rough and abrasive — my poor dog started scratching at his neck nonstop after just a couple hours of wearing it. When I checked, there were visible red marks where the edge of the collar had rubbed against his skin. “Gentle on fur”? Try “sandpaper chic.”\r\n\r\nAesthetically, it looks fine out of the box — sleek enough to fool you for about five minutes. But after a few walks, the colour faded unevenly, the logo peeled off, and it generally started looking like something dragged out of a gutter.\r\n\r\nCustomer service was the final insult. When I reached out, I was met with a robotic email chain that might as well have been written by an actual robot. No accountability, no empathy — just a copy-paste response about “wear and tear not being covered under warranty.”\r\n\r\nIn short: if you value your dog’s safety, comfort, or your own sanity, do not buy this collar. It’s a perfect example of a company more focused on aesthetics and marketing buzzwords than actually making a product that works. Save yourself the frustration and go with literally any other reputable brand — your dog deserves better than the Harper collar’s shoddy excuse for craftsmanship.', '2025-09-27', 1, '192.71.43.85', 'Possible bot'),
(2, 25, 101, 5, 'My pet loves it and smells great. The best shampoo I have used', '2025-09-06', 0, '192.182.8.142', NULL),
(3, 27, 106, 2, 'Leaked faster than my will to keep fish — congratulations, it’s now a very expensive puddle', '2025-05-24', 0, '192.113.119.237', NULL),
(4, 29, 112, 2, 'Disappointing quality. My dog chewed through it in no time', '2025-08-11', 0, '192.81.49.97', NULL),
(5, 31, 124, 1, 'Let me preface this by saying Sir Whiskerton is not a picky feline. This is a cat who joyfully sits in cardboard boxes, sleeps in the laundry basket, and considers a crumpled receipt to be a top-tier toy. So when he turns his aristocratic little nose up at something, it means the product has truly failed on every possible level.\r\n\r\nEnter: the Cat Scratching Post from Pettopia, or as it’s known in our home now, The Tower of Regret.\r\n\r\nWhen it first arrived, I was cautiously optimistic. The pictures made it look sturdy, elegant, perhaps even enriching — like something that would complement both my cat’s natural instincts and my living room aesthetic. What I unboxed, however, looked like it had been designed by a sleep-deprived raccoon with a glue gun.\r\n\r\nThe base wobbled like a drunk flamingo. The fabric covering (a term I use loosely) felt like someone had repurposed an old bathmat. And the “natural sisal rope”? More like stiff twine that frayed faster than my patience. Within 48 hours, little pieces of string were shedding across the floor like tumbleweeds in a ghost town.\r\n\r\nSir Whiskerton approached it cautiously at first — sniffed, tapped it once with his paw, and then looked at me with the same expression I imagine he’d use if I served him lukewarm canned peas for dinner. He then turned around, strutted over to my actual couch, and began a majestic, full-bodied scratch that said, “I will not suffer inferior craftsmanship.”\r\n\r\nThe scratching post now serves primarily as a warning to others. It sits in the corner, lopsided and dusty, like a fallen monument to bad decisions. Occasionally, Sir Whiskerton will use it as a back-scratch prop or a place to vomit near, which feels poetic — a fitting metaphor for what this product deserves.\r\n\r\nTo add insult to injury, the assembly process was a comedy of errors. The instructions were written in what I can only assume was Google Translated from the language of pain. The included Allen wrench bent halfway through the job, and the screws seemed designed specifically not to fit the pre-drilled holes. By the end, I was sitting on the floor surrounded by loose bolts and regret, while Sir Whiskerton looked on, judging me like a disappointed landlord.\r\n\r\nIn short: if you enjoy wasting your money, cursing at inanimate objects, and disappointing your cat, this scratching post will bring you hours of entertainment. Otherwise, do yourself (and your furniture) a favour and skip it.\r\n\r\nSir Whiskerton rates it 1 star out of 5, with the lone star awarded for being flammable — which, frankly, might be its best use at this point.', '2025-07-31', 1, '192.17.163.71', 'Contains possible spam language'),
(6, 33, 131, 2, 'If disappointment came with handles, it would look exactly like this carrier. The Pettopia Pet Carrier promised comfort and durability — instead, it delivered the structural integrity of a soggy paper bag. My dog, Puffy, shifted her weight once and the whole thing folded like a lawn chair at a barbecue. The zippers have commitment issues, the “padded interior” feels like it was stuffed with broken dreams, and the ventilation holes somehow manage to trap every odour except dignity. By the time we reached the vet, Daisy looked traumatized and I looked like I’d lost a wrestling match with polyester. In short: this isn’t a carrier — it’s a cry for help with a shoulder strap.', '2025-10-05', 0, '192.22.166.204', NULL),
(7, 35, 128, 3, 'Not quite what I was expecting.', '2025-10-09', 0, '192.165.201.147', NULL),
(8, 36, 132, 4, 'Very pleased with my purchase.', '2025-10-13', 0, '192.59.239.223', NULL),
(9, 37, 122, 5, 'Amazing quality and my pet loves it.', '2025-04-23', 0, '192.197.17.33', NULL),
(10, 37, 104, 4, 'Good product overall, would recommend.', '2025-05-16', 0, '192.39.227.199', NULL),
(11, 24, 124, 5, 'I love this toy set! It\'s the best one I\'ve found so far.', '2025-08-17', 0, '192.17.163.71', NULL),
(12, 26, 130, 4, 'Pretty good product, but there are some things that could be improved like comfort for starters', '2025-09-22', 0, '192.239.93.185', NULL),
(13, 28, 127, 3, 'It\'s an average product. Nothing too special, but it gets the job done.', '2025-06-16', 0, '192.128.128.128', NULL),
(14, 30, 121, 2, 'Not very impressed with this product. It didn\'t work as well as I expected.', '2025-10-17', 0, '192.160.198.14', NULL),
(15, 32, 133, 5, 'I would highly recommend this product to anyone. It\'s amazing!', '2025-04-27', 0, '192.96.58.242', NULL),
(16, 34, 118, 1, 'Bought the Pettopia Reptile Heat Lamp to keep my bearded dragon cozy — instead, it’s giving “romantic mood lighting at a morgue” vibes. Within two days, the bulb fizzled out like my enthusiasm for this brand. My poor lizard, Mortimer, spent the night colder than my heart after dealing with customer service, who suggested I “make sure it’s plugged in.” Genius advice for a lamp that costs more than it warms. If I wanted a dim, lifeless glow and false promises, I’d just text my ex.', '2025-05-24', 1, '192.49.233.211', 'Suspicious low rating'),
(17, 36, 129, 3, 'It\'s an okay product. I\'ve tried better ones, but this one isn\'t bad.', '2025-09-13', 0, '192.202.20.166', NULL),
(18, 37, 132, 2, 'I was disappointed with this brush. It didn\'t live up to the hype.', '2025-07-14', 0, '192.59.239.223', NULL),
(19, 23, 123, 5, 'This product is a game changer! I can\'t imagine using anything else.', '2025-10-05', 0, '192.234.90.52', NULL),
(20, 35, 125, 4, 'Overall, I\'m pretty happy with this product. It does what it\'s supposed to do.', '2025-06-02', 0, '192.54.236.90', NULL),
(21, 18, 110, 4, 'My pet loves this toy! It has held up well so far.', '2025-06-29', 0, '192.7.157.59', NULL),
(22, 14, 129, 3, 'My pet likes it but the quality could be better.', '2025-05-28', 0, '192.202.20.166', NULL),
(23, 26, 124, 5, 'Great product, my pet is much happier since I started using it.', '2025-09-27', 0, '192.17.163.71', NULL),
(24, 31, 92, 4, 'Great value, my pet loves it.', '2025-09-12', 0, '192.103.113.225', NULL),
(25, 11, 128, 2, 'Not the best quality. I hope you all die', '2025-06-20', 0, '192.165.201.147', NULL),
(26, 17, 123, 5, 'One happy pet and owner\" Thanks Pettopia.', '2025-06-09', 0, '192.234.90.52', NULL),
(27, 35, 109, 4, 'Rubbish. Do not purchase', '2025-06-23', 0, '192.224.84.40', NULL),
(28, 29, 102, 3, 'Decent product, but could be better.', '2025-10-06', 0, '192.219.81.161', NULL),
(29, 7, 122, 5, 'Happy with this', '2025-08-09', 0, '192.197.17.33', NULL),
(30, 29, 8, 2, 'Not what I hoped', '2025-06-08', 0, '192.43.77.153', NULL),
(31, 27, 103, 4, 'Not worth it', '2025-07-18', 0, '192.2.154.180', NULL),
(32, 22, 131, 5, 'This is a hit with my pet!', '2025-08-17', 0, '192.22.166.204', NULL),
(33, 8, 121, 4, 'Good quality.', '2025-09-11', 0, '192.160.198.14', NULL),
(34, 25, 119, 3, 'Not what I thought it would be.', '2025-10-18', 0, '192.86.52.230', NULL),
(35, 6, 100, 5, 'Great product, my pet loves it.', '2025-08-10', 0, '192.145.189.123', NULL),
(36, 36, 95, 4, 'Ideal', '2025-05-04', 0, '192.214.78.28', NULL),
(37, 8, 120, 4, 'My pet loves this!', '2025-07-21', 0, '192.123.125.249', NULL),
(38, 6, 131, 5, 'Great product, my pet is so happy!', '2025-06-18', 0, '192.22.166.204', NULL),
(39, 13, 95, 3, 'Not the best quality, but my hamster seems to like it.', '2025-05-08', 0, '192.214.78.28', NULL),
(40, 22, 87, 4, 'Good value for money, my pet is enjoying it.', '2025-07-21', 0, '192.172.2.130', NULL),
(41, 17, 101, 5, 'Amazing product, my pet loves it!', '2025-06-02', 0, '192.182.8.142', NULL),
(42, 26, 118, 2, 'Not suitable for larger pets.', '2025-08-16', 0, '192.49.233.211', NULL),
(43, 3, 126, 4, 'Nice design, my cat is enjoying it.', '2025-07-28', 0, '192.91.55.109', NULL),
(44, 12, 104, 3, 'Product arrived damaged but customer service was helpful.', '2025-09-07', 0, '192.39.227.199', NULL),
(45, 25, 115, 5, 'My pet cant get enough of this!', '2025-06-02', 0, '192.192.14.154', NULL),
(46, 10, 128, 4, 'Great!!', '2025-09-21', 0, '192.165.201.147', NULL),
(47, 29, 97, 2, 'Not the best quality, but it is cheap.', '2025-07-28', 0, '192.34.224.66', NULL),
(48, 7, 132, 5, 'Excellent product, my pet is very happy!', '2025-05-21', 0, '192.59.239.223', NULL),
(49, 15, 123, 3, 'Not very durable, but my pet seems to like it.', '2025-05-28', 0, '192.234.90.52', NULL),
(50, 20, 100, 4, 'Good product, my pet is enjoying it.', '2025-07-25', 0, '192.145.189.123', NULL),
(51, 9, 125, 5, 'Great value for money, my pet is very happy!', '2025-04-25', 0, '192.54.236.90', NULL),
(52, 20, 117, 5, 'Looks great but a little bit flimsy', '2025-07-25', 0, '192.12.160.192', NULL),
(53, 32, 124, 3, 'It serves its purpose.', '2025-07-29', 0, '192.17.163.71', NULL),
(54, 18, 130, 4, 'Rubbish', '2025-05-24', 0, '192.239.93.185', NULL),
(55, 23, 120, 2, 'I was disappointed in the quality of this.', '2025-06-07', 0, '192.123.125.249', NULL),
(56, 27, 129, 5, 'Would reccommend', '2025-09-02', 0, '192.202.20.166', NULL),
(57, 5, 111, 4, 'My pet is a fan!!', '2025-10-06', 0, '192.44.230.78', NULL),
(58, 35, 126, 5, 'Exactly what I was looking for.', '2025-07-07', 0, '192.91.55.109', NULL),
(59, 30, 112, 1, 'This plastic hamster wheel is hands down one of the worst products I’ve ever bought for a pet. I purchased it in the hope of giving my hamster a fun, safe way to exercise. Instead, this flimsy, poorly thought-out wheel turned out to be nothing short of a nightmare. If you love your hamster, steer clear of this disaster.', '2025-06-20', 1, '192.81.49.97', 'Contains possible spam language'),
(60, 14, 118, 3, 'The quality is not what I hoped for', '2025-06-30', 0, '192.49.233.211', NULL),
(61, 17, 133, 5, 'Very durable and looks great.', '2025-10-05', 0, '192.96.58.242', NULL),
(62, 8, 125, 4, 'Perfect', '2025-07-17', 0, '192.54.236.90', NULL),
(63, 1, 131, 2, 'I was not impressed with this', '2025-08-12', 0, '192.22.166.204', NULL),
(64, 3, 121, 5, 'Great quality. One happy customer and pet.', '2025-08-20', 0, '192.160.198.14', NULL),
(65, 7, 123, 4, 'Well-made and priced just about right.', '2025-07-18', 0, '192.234.90.52', NULL),
(66, 10, 127, 4, 'My pet loved this.', '2025-07-07', 0, '192.128.128.128', NULL),
(67, 3, 8, 1, 'About as useful as a pair of sunglasses to a man with one ear. Muffin was able to open the door of the cage herself and fly out the window. I HOPE YOU ALL DIE.', '2025-08-18', 1, '192.43.77.153', 'Potential duplicate content'),
(68, 20, 1, 1, 'I purchased this bird bath hoping to create a small haven for the birds in my garden. But little did I know that this flimsy, poorly designed piece of garbage would be nothing more than an overpriced lawn ornament. The manufacturer has clearly never seen a bird in real life, let alone designed a bird bath that’s actually useful to them. If you’re looking to throw your money down the drain, then maybe, just maybe, this is the product for you.In Summary...this bird bath is a waste of plastic, money, and time. If you’re in the market for something that will sit in your yard, do absolutely nothing, and actively repel birds, then by all means, buy this. But if you actually want a functional bird bath, do yourself a favor and skip this one.', '2025-04-27', 1, '192.38.74.20', 'Suspicious low rating'),
(69, 31, 1, 1, 'This scratching post is a disaster. It’s flimsy, poorly made, and my cat despises it. I’ve ended up with a useless piece of junk that takes up space and does absolutely nothing. Save yourself the headache and the mess – buy a quality scratching post that your cat will actually want to use! This one belongs in the bin, and that’s exactly where it’s going.', '2025-05-21', 1, '192.38.74.20', 'Potential duplicate content'),
(70, 33, 15, 1, 'I am on my way over to torch Pettopia HQ right now. I HATE YOU ALL.', '2025-09-02', 1, '192.48.80.32', 'Contains possible spam language');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_users`
--
ALTER TABLE `admin_users`
  ADD PRIMARY KEY (`admin_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`category_id`);

--
-- Indexes for table `customers`
--
ALTER TABLE `customers`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `db_metadata`
--
ALTER TABLE `db_metadata`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `discount_codes`
--
ALTER TABLE `discount_codes`
  ADD PRIMARY KEY (`discount_id`),
  ADD UNIQUE KEY `code` (`code`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `order_status_id` (`order_status_id`),
  ADD KEY `orders_ibfk_1` (`customer_id`),
  ADD KEY `discount_id` (`discount_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `order_status`
--
ALTER TABLE `order_status`
  ADD PRIMARY KEY (`order_status_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`product_id`),
  ADD KEY `categogy_id` (`categogy_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`review_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `reviews_ibfk_2` (`customer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_users`
--
ALTER TABLE `admin_users`
  MODIFY `admin_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `customers`
--
ALTER TABLE `customers`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=161;

--
-- AUTO_INCREMENT for table `db_metadata`
--
ALTER TABLE `db_metadata`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `discount_codes`
--
ALTER TABLE `discount_codes`
  MODIFY `discount_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `fk_orders_order_status_id` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`order_status_id`),
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`),
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`order_status_id`) REFERENCES `order_status` (`order_status_id`),
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`discount_id`) REFERENCES `discount_codes` (`discount_id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`order_id`),
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`);

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`categogy_id`) REFERENCES `categories` (`category_id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`product_id`),
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`customer_id`) REFERENCES `customers` (`customer_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
