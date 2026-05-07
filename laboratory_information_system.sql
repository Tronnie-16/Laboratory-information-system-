-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 07, 2026 at 06:04 AM
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
-- Database: `laboratory_information_system`
--

-- --------------------------------------------------------

--
-- Table structure for table `department`
--

CREATE TABLE `department` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(100) NOT NULL,
  `description` text DEFAULT NULL,
  `head_staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `department`
--

INSERT INTO `department` (`department_id`, `department_name`, `description`, `head_staff_id`) VALUES
(1, 'Haematology', 'Blood analysis', 1),
(2, 'Microbiology', 'Microorganism testing', 3),
(3, 'Chemistry', 'Biochemical tests', 4),
(4, 'Parasitology', 'Parasite detection', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `doctor`
--

CREATE TABLE `doctor` (
  `doctor_id` int(11) NOT NULL,
  `doctor_name` varchar(50) NOT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `doctor`
--

INSERT INTO `doctor` (`doctor_id`, `doctor_name`, `phone`, `department_id`) VALUES
(1, 'Dr. Okello', '0712345678', 1),
(2, 'Dr. Namara', '0723456789', 2);

-- --------------------------------------------------------

--
-- Table structure for table `lab_tech`
--

CREATE TABLE `lab_tech` (
  `staff_id` int(11) NOT NULL,
  `tech_name` varchar(50) NOT NULL,
  `role` enum('Scientist','Technician','Manager') DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `lab_tech`
--

INSERT INTO `lab_tech` (`staff_id`, `tech_name`, `role`, `department_id`) VALUES
(1, 'Dr. Alice', 'Scientist', 1),
(2, 'John Tech', 'Technician', 1),
(3, 'Mary Bio', 'Scientist', 2),
(4, 'Peter Chem', 'Manager', 3);

-- --------------------------------------------------------

--
-- Table structure for table `order_test_item`
--

CREATE TABLE `order_test_item` (
  `order_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_test_item`
--

INSERT INTO `order_test_item` (`order_id`, `test_id`) VALUES
(1, 1),
(1, 2),
(2, 3),
(3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `patient`
--

CREATE TABLE `patient` (
  `patient_id` int(11) NOT NULL,
  `patient_name` varchar(50) NOT NULL,
  `date_of_birth` date NOT NULL,
  `gender` enum('M','F','O') DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `national_id` varchar(20) DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `patient`
--

INSERT INTO `patient` (`patient_id`, `patient_name`, `date_of_birth`, `gender`, `phone`, `address`, `national_id`, `blood_group`) VALUES
(1, 'James Mugisha', '1995-06-15', 'M', '0700123456', 'Mbarara', 'CM95061501', 'O+'),
(2, 'Sarah Aine', '2000-03-22', 'F', '0700456789', 'Bushenyi', 'CF00032202', 'A+'),
(3, 'David Kato', '1988-11-10', 'M', '0700789123', 'Kampala', 'CM88111003', 'B+');

-- --------------------------------------------------------

--
-- Table structure for table `report`
--

CREATE TABLE `report` (
  `report_id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `generated_by` int(11) DEFAULT NULL,
  `generated_datetime` datetime DEFAULT current_timestamp(),
  `delivery_method` enum('Print','Email','Portal') DEFAULT NULL,
  `status` enum('Draft','Final','Amended') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `report`
--

INSERT INTO `report` (`report_id`, `order_id`, `generated_by`, `generated_datetime`, `delivery_method`, `status`) VALUES
(1, 1, 1, '2026-05-05 16:45:49', 'Print', 'Final'),
(2, 2, 3, '2026-05-05 16:45:49', 'Email', 'Draft'),
(3, 3, 4, '2026-05-05 16:45:49', 'Print', 'Final');

-- --------------------------------------------------------

--
-- Table structure for table `result`
--

CREATE TABLE `result` (
  `result_id` int(11) NOT NULL,
  `sample_id` int(11) NOT NULL,
  `test_id` int(11) NOT NULL,
  `result_value` varchar(100) DEFAULT NULL,
  `flag` enum('Normal','High','Low','Critical') DEFAULT NULL,
  `result_datetime` datetime DEFAULT current_timestamp(),
  `validated_by` int(11) DEFAULT NULL,
  `comments` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `result`
--

INSERT INTO `result` (`result_id`, `sample_id`, `test_id`, `result_value`, `flag`, `result_datetime`, `validated_by`, `comments`) VALUES
(1, 1, 1, 'Normal', 'Normal', '2026-05-05 16:45:26', 1, 'All values within range'),
(2, 1, 2, 'Positive', 'Critical', '2026-05-05 16:45:26', 3, 'Malaria detected'),
(3, 2, 3, '5.6 mmol/L', 'Normal', '2026-05-05 16:45:26', 1, 'Normal blood sugar'),
(4, 3, 3, '11.2 mmol/L', 'High', '2026-05-05 16:45:26', 4, 'Elevated sugar levels');

-- --------------------------------------------------------

--
-- Table structure for table `sample`
--

CREATE TABLE `sample` (
  `sample_id` int(11) NOT NULL,
  `accession_number` varchar(20) DEFAULT NULL,
  `order_id` int(11) NOT NULL,
  `sample_type` varchar(50) DEFAULT NULL,
  `collection_datetime` datetime DEFAULT NULL,
  `collected_by` int(11) DEFAULT NULL,
  `condition` enum('Acceptable','Haemolysed','Insufficient','Mislabelled') DEFAULT NULL,
  `received_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sample`
--

INSERT INTO `sample` (`sample_id`, `accession_number`, `order_id`, `sample_type`, `collection_datetime`, `collected_by`, `condition`, `received_datetime`) VALUES
(1, 'ACC001', 1, 'Blood', '2026-05-05 16:44:47', 2, 'Acceptable', '2026-05-05 16:44:47'),
(2, 'ACC002', 2, 'Blood', '2026-05-05 16:44:47', 1, 'Acceptable', '2026-05-05 16:44:47'),
(3, 'ACC003', 3, 'Blood', '2026-05-05 16:44:47', 2, 'Acceptable', '2026-05-05 16:44:47');

-- --------------------------------------------------------

--
-- Table structure for table `test`
--

CREATE TABLE `test` (
  `test_id` int(11) NOT NULL,
  `test_name` varchar(100) NOT NULL,
  `sample_type` varchar(50) DEFAULT NULL,
  `cost` decimal(10,2) DEFAULT NULL,
  `department_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test`
--

INSERT INTO `test` (`test_id`, `test_name`, `sample_type`, `cost`, `department_id`) VALUES
(1, 'Full Blood Count', 'Blood', 20000.00, 1),
(2, 'Malaria Test', 'Blood', 10000.00, 4),
(3, 'Blood Sugar (FBS)', 'Blood', 15000.00, 3);

-- --------------------------------------------------------

--
-- Table structure for table `test_order`
--

CREATE TABLE `test_order` (
  `order_id` int(11) NOT NULL,
  `patient_id` int(11) NOT NULL,
  `doctor_id` int(11) NOT NULL,
  `order_date` datetime DEFAULT current_timestamp(),
  `status` enum('Pending','In Progress','Completed','Cancelled') DEFAULT NULL,
  `clinical_notes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `test_order`
--

INSERT INTO `test_order` (`order_id`, `patient_id`, `doctor_id`, `order_date`, `status`, `clinical_notes`) VALUES
(1, 1, 1, '2026-05-05 16:43:51', 'Pending', 'Fever and weakness'),
(2, 2, 2, '2026-05-05 16:43:51', 'In Progress', 'Routine checkup'),
(3, 3, 1, '2026-05-05 16:43:51', 'Completed', 'Suspected diabetes');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `department`
--
ALTER TABLE `department`
  ADD PRIMARY KEY (`department_id`),
  ADD KEY `fk_head_staff` (`head_staff_id`);

--
-- Indexes for table `doctor`
--
ALTER TABLE `doctor`
  ADD PRIMARY KEY (`doctor_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `lab_tech`
--
ALTER TABLE `lab_tech`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `order_test_item`
--
ALTER TABLE `order_test_item`
  ADD PRIMARY KEY (`order_id`,`test_id`),
  ADD KEY `test_id` (`test_id`);

--
-- Indexes for table `patient`
--
ALTER TABLE `patient`
  ADD PRIMARY KEY (`patient_id`),
  ADD UNIQUE KEY `national_id` (`national_id`);

--
-- Indexes for table `report`
--
ALTER TABLE `report`
  ADD PRIMARY KEY (`report_id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `generated_by` (`generated_by`);

--
-- Indexes for table `result`
--
ALTER TABLE `result`
  ADD PRIMARY KEY (`result_id`),
  ADD KEY `sample_id` (`sample_id`),
  ADD KEY `test_id` (`test_id`),
  ADD KEY `validated_by` (`validated_by`);

--
-- Indexes for table `sample`
--
ALTER TABLE `sample`
  ADD PRIMARY KEY (`sample_id`),
  ADD UNIQUE KEY `accession_number` (`accession_number`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `collected_by` (`collected_by`);

--
-- Indexes for table `test`
--
ALTER TABLE `test`
  ADD PRIMARY KEY (`test_id`),
  ADD KEY `department_id` (`department_id`);

--
-- Indexes for table `test_order`
--
ALTER TABLE `test_order`
  ADD PRIMARY KEY (`order_id`),
  ADD KEY `patient_id` (`patient_id`),
  ADD KEY `doctor_id` (`doctor_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `department`
--
ALTER TABLE `department`
  MODIFY `department_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `doctor`
--
ALTER TABLE `doctor`
  MODIFY `doctor_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `lab_tech`
--
ALTER TABLE `lab_tech`
  MODIFY `staff_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `patient`
--
ALTER TABLE `patient`
  MODIFY `patient_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `report`
--
ALTER TABLE `report`
  MODIFY `report_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `result`
--
ALTER TABLE `result`
  MODIFY `result_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `sample`
--
ALTER TABLE `sample`
  MODIFY `sample_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `test`
--
ALTER TABLE `test`
  MODIFY `test_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `test_order`
--
ALTER TABLE `test_order`
  MODIFY `order_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `department`
--
ALTER TABLE `department`
  ADD CONSTRAINT `fk_head_staff` FOREIGN KEY (`head_staff_id`) REFERENCES `lab_tech` (`staff_id`);

--
-- Constraints for table `doctor`
--
ALTER TABLE `doctor`
  ADD CONSTRAINT `doctor_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`);

--
-- Constraints for table `lab_tech`
--
ALTER TABLE `lab_tech`
  ADD CONSTRAINT `lab_tech_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`);

--
-- Constraints for table `order_test_item`
--
ALTER TABLE `order_test_item`
  ADD CONSTRAINT `order_test_item_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `test_order` (`order_id`),
  ADD CONSTRAINT `order_test_item_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`test_id`);

--
-- Constraints for table `report`
--
ALTER TABLE `report`
  ADD CONSTRAINT `report_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `test_order` (`order_id`),
  ADD CONSTRAINT `report_ibfk_2` FOREIGN KEY (`generated_by`) REFERENCES `lab_tech` (`staff_id`);

--
-- Constraints for table `result`
--
ALTER TABLE `result`
  ADD CONSTRAINT `result_ibfk_1` FOREIGN KEY (`sample_id`) REFERENCES `sample` (`sample_id`),
  ADD CONSTRAINT `result_ibfk_2` FOREIGN KEY (`test_id`) REFERENCES `test` (`test_id`),
  ADD CONSTRAINT `result_ibfk_3` FOREIGN KEY (`validated_by`) REFERENCES `lab_tech` (`staff_id`);

--
-- Constraints for table `sample`
--
ALTER TABLE `sample`
  ADD CONSTRAINT `sample_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `test_order` (`order_id`),
  ADD CONSTRAINT `sample_ibfk_2` FOREIGN KEY (`collected_by`) REFERENCES `lab_tech` (`staff_id`);

--
-- Constraints for table `test`
--
ALTER TABLE `test`
  ADD CONSTRAINT `test_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`);

--
-- Constraints for table `test_order`
--
ALTER TABLE `test_order`
  ADD CONSTRAINT `test_order_ibfk_1` FOREIGN KEY (`patient_id`) REFERENCES `patient` (`patient_id`),
  ADD CONSTRAINT `test_order_ibfk_2` FOREIGN KEY (`doctor_id`) REFERENCES `doctor` (`doctor_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
