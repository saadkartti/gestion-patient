-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Sep 24, 2025 at 01:52 AM
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
-- Database: `medicore_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `doctors`
--

CREATE TABLE `doctors` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `specialty` varchar(255) NOT NULL,
  `department_code` varchar(50) NOT NULL,
  `photo_path` varchar(500) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctors`
--

INSERT INTO `doctors` (`id`, `name`, `specialty`, `department_code`, `photo_path`) VALUES
(1, 'Dr. Jennifer Roberts', 'Pediatrics', 'A-9587', 'assets/images/doctors/jennifer_roberts.jpg'),
(2, 'Dr. Michael Sullivan', 'Cardiology', 'A-9565', 'assets/images/doctors/michael_sullivan.jpg'),
(3, 'Dr. Emily Harris', 'Ophthalmology', 'A-9587', 'assets/images/doctors/emily_harris.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `patients`
--

CREATE TABLE `patients` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `mob` varchar(20) NOT NULL,
  `appointment_date` datetime NOT NULL,
  `doctor_name` varchar(255) NOT NULL,
  `department` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Dumping data for table `patients`
--

INSERT INTO `patients` (`id`, `name`, `mob`, `appointment_date`, `doctor_name`, `department`) VALUES
(1, 'Omar Al-Farouqe', '(212) 600-1235', '2023-09-06 10:00:00', 'Dr. Aisha Ben Ali', 'Pediatrics (A-9987)'),
(2, 'Hassan Al-Mansouri', '(212) 600-5678', '2023-08-06 10:30:00', 'Dr. Khalid Al-Amrani', 'Cardiology (A-9645)'),
(4, 'saad kartti', '0688527396', '2025-09-24 22:31:00', 'DR HASSAN BENYAHYA', 'Neurology (A-9820)'),
(5, 'mohcine metouali', '0623531010', '2025-09-23 23:04:00', 'DR HASSAN BENYAHYA', 'Cardiology (A-9645)');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `doctors`
--
ALTER TABLE `doctors`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `patients`
--
ALTER TABLE `patients`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `doctors`
--
ALTER TABLE `doctors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `patients`
--
ALTER TABLE `patients`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
