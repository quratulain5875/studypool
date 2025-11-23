-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3307:3307
-- Generation Time: Dec 25, 2024 at 11:08 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `studypool_clone`
--

-- --------------------------------------------------------

--
-- Table structure for table `answers`
--

CREATE TABLE `answers` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `answer_text` text DEFAULT NULL,
  `attachment_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `answers`
--

INSERT INTO `answers` (`id`, `question_id`, `tutor_id`, `answer_text`, `attachment_url`, `created_at`) VALUES
(1, 4, 25, 'To register a limited liability company (LLC) in Pakistan, you\'ll need to submit the following documents to the Registrar of Companies in SECP:\r\nMemorandum of Association (MOA): A legal document that outlines the company\'s constitution and scope of activities', 'uploads/answer.txt', '2024-12-25 08:41:43');

-- --------------------------------------------------------

--
-- Table structure for table `bids`
--

CREATE TABLE `bids` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `bid_amount` decimal(10,2) NOT NULL,
  `proposed_deadline` date NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `book_guides`
--

CREATE TABLE `book_guides` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `attachment_url` varchar(255) DEFAULT NULL,
  `tutor_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `book_guides`
--

INSERT INTO `book_guides` (`id`, `title`, `description`, `price`, `attachment_url`, `tutor_id`) VALUES
(1, 'Guide to Biology', 'Comprehensive guide covering basic and advanced topics in biology.', '50.00', NULL, 0),
(2, 'Mastering Algebra', 'Step-by-step algebra problems and solutions for beginners.', '30.00', NULL, 0),
(3, 'Physics Simplified', 'An easy-to-follow guide for understanding the fundamentals of physics.', '45.00', NULL, 0),
(4, 'World History Overview', 'A detailed guide on significant historical events.', '40.00', NULL, 0),
(6, 'Computer Networks', 'Computer Networks: A Systems Approach, 3e. Larry L. Peterson and Bruce S. Davie. Network Architecture, Analysis, and Design, 2e. James D. McCabe.\r\n838 pages', '60.00', 'uploads/guides/Computer Networks.pdf', 25);

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `notes`
--

CREATE TABLE `notes` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` text NOT NULL,
  `user_id` int(11) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `subject` varchar(100) NOT NULL,
  `fee` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `notes`
--

INSERT INTO `notes` (`id`, `title`, `content`, `user_id`, `created_at`, `subject`, `fee`) VALUES
(1, 'Introduction to Biology', 'Detailed notes covering basic concepts of biology.', 22, '2024-12-21 22:29:39', 'Biology', '50.00'),
(2, 'Advanced Chemistry', 'Comprehensive notes on organic and inorganic chemistry.', 22, '2024-12-21 22:29:39', 'Chemistry', '70.00'),
(3, 'Mathematics: Algebra Basics', 'Step-by-step guide to solving algebra problems.', 22, '2024-12-21 22:29:39', 'Mathematics', '30.00'),
(4, 'Physics: Mechanics and Waves', 'Detailed explanation of mechanics and wave theory.', 22, '2024-12-21 22:29:39', 'Physics', '60.00'),
(5, 'History of World War II', 'Insightful notes on events and impacts of WWII.', 22, '2024-12-21 22:29:39', 'History', '40.00'),
(6, 'Database design', 'Database content refers to the data and information stored in a database. The content of a database can include datasets, libraries, impacts, and LCA-models. \r\nHere are some types of databases and their characteristics:\r\nRelational databases\r\nAlso known as SQL databases, these databases organize data into tables with rows and columns. Relational database management systems (RDBMS) use SQL to manage and query data. Some examples of relational databases include MySQL, PostgreSQL, and SQL Server. \r\nNoSQL databases\r\nAlso known as non-relational databases, these databases are designed to accommodate a variety of data models. They are useful for large sets of distributed data, and can handle big data performance issues better than relational databases. Some examples of NoSQL databases include MongoDB, CouchDB, and Redis. \r\nObject-oriented databases\r\nThese databases store and manipulate complex data structures called \"objects\". Objects are organized into hierarchical classes that can inherit properties from higher classes. \r\nCloud databases\r\nThese databases store and execute data over the cloud, and are accessible through a hybrid or cloud environment. Users can build their own cloud database or pay for a service to get started. \r\nOpen source databases\r\nThese databases have open source source code.', 25, '2024-12-25 14:03:34', 'DBMS', '20.00'),
(7, 'Web Content', '\' Web content may include webpage document pages, information, software data and applications, e-services, images, audio and video files, personal Web pages, archived e-mail messages stored on email servers, and more.\r\nHere are some examples of web technologies:\r\nHTML: A markup language used to design the front end of a website. HTML is used to define the structure of a web page and the links between pages. \r\nCSS: A programming language used to create the style, layout, fonts, and colors of a web page. \r\nJavaScript: The native programming language of the web. \r\nPHP: A server-side scripting language designed for web development. \r\nNode.js: An open-source runtime environment for executing JavaScript code outside of a browser. \r\nWebAssembly: Allows programs written in other languages to run on the web. \r\nHTTP: The fundamental protocol used to fetch resources over the web, such as images, videos, stylesheets, and documents. \r\nSVG: Scalable Vector Graphics, which allows users to create images that can scale to any size. \r\nMathML: Allows users to display mathematical notation on the web. \r\nURI: Uniform Resource Identifiers, which are used to identify resources in various ways. \r\nWebDriver: A browser-automation mechanism that allows users to remotely control a browser.', 25, '2024-12-25 14:05:59', 'Web Technologies', '25.00');

-- --------------------------------------------------------

--
-- Table structure for table `questions`
--

CREATE TABLE `questions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `category` varchar(100) DEFAULT NULL,
  `question_text` text NOT NULL,
  `attachment_url` varchar(255) DEFAULT NULL,
  `budget` decimal(10,2) DEFAULT NULL,
  `status` enum('open','answered','closed') DEFAULT 'open',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `school` varchar(255) DEFAULT NULL,
  `course` varchar(255) DEFAULT NULL,
  `delivery_time` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `questions`
--

INSERT INTO `questions` (`id`, `user_id`, `category`, `question_text`, `attachment_url`, `budget`, `status`, `created_at`, `school`, `course`, `delivery_time`) VALUES
(1, 1, 'Mathematics', 'What is the purpose of 0?', NULL, '2.00', 'open', '2024-12-21 08:44:03', NULL, NULL, NULL),
(3, 20, 'Computer', 'what is ROM?', NULL, '3.00', 'open', '2024-12-21 13:01:36', NULL, NULL, NULL),
(4, 20, 'Business', 'What are the documents that should be submitted to the registrar of companies for the registration of a limited liability company?', NULL, '5.00', 'open', '2024-12-21 16:43:14', 'Summit Grove School.', 'Business and Analysis', '2025-01-03 00:00:00');

-- --------------------------------------------------------

--
-- Table structure for table `question_history`
--

CREATE TABLE `question_history` (
  `id` int(11) NOT NULL,
  `question_id` int(11) NOT NULL,
  `status` enum('open','answered','closed') NOT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings_reviews`
--

CREATE TABLE `ratings_reviews` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `tutor_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` between 1 and 5),
  `review` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ratings_reviews`
--

INSERT INTO `ratings_reviews` (`id`, `user_id`, `tutor_id`, `rating`, `review`, `created_at`) VALUES
(1, 1, 22, 3, 'Great Teacher', '2024-12-22 14:20:08'),
(2, 1, 22, 3, 'Great Teacher', '2024-12-22 14:24:07');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `type` enum('deposit','withdrawal','payment','earning') DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `status` enum('pending','completed','failed') DEFAULT 'pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tutors`
--

CREATE TABLE `tutors` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(50) DEFAULT NULL,
  `last_name` varchar(50) DEFAULT NULL,
  `verification_status` enum('approved','pending','rejected') DEFAULT 'pending',
  `photo_path` varchar(255) DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `phone_number` varchar(15) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `subject_specialization` varchar(255) DEFAULT NULL,
  `years_of_experience` int(11) DEFAULT NULL,
  `education_level` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tutors`
--

INSERT INTO `tutors` (`id`, `email`, `password`, `first_name`, `last_name`, `verification_status`, `photo_path`, `bio`, `phone_number`, `location`, `subject_specialization`, `years_of_experience`, `education_level`, `created_at`, `updated_at`) VALUES
(1, 'abc@gmail.com', '$2y$10$chY8.ISU8a1WkGvRNvtqtuPUr85IOlXD6hLmIAXCTkv/JEBRHsWCW', 'abc', 'def', 'approved', 'uploads/id.jpg', 'Experienced tutor in Mathematics', '123-456-7890', 'New York, NY', 'Mathematics', 5, 'Bachelor\'s', '2024-12-24 13:09:16', '2024-12-24 13:09:16');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('student','tutor') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `verification_status` varchar(20) DEFAULT 'pending'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `username`, `password`, `role`, `created_at`, `verification_status`) VALUES
(1, 'Shahneelaiqbal@outlook.com', '', '$2y$10$Rk1Q9aQjuWxkYKJweP78zO.KUdglSk1LNCiFrT1A0uyTMhu/QQCvu', 'student', '2024-12-21 08:43:03', 'pending'),
(20, 'noor@gmail.com', 'noor', '$2y$10$e7JrGPW0V49eKIFTeSbKYO9xmWnl93hfnjVA.IriETZdyW6MSRgbK', 'student', '2024-12-21 12:22:52', 'pending'),
(22, 'ashna@gmail.com', 'ashna', '$2y$10$2eJQsy9gUdA46O4YymYeQeGSCvXs1oBU/V9k17KgH50JQ2ZMH4h2i', 'tutor', '2024-12-21 12:43:04', 'pending'),
(23, 'Shahneelaiqbal1@gmail.com', 'fazeela', '$2y$10$4e46.cRNeNAtJTHyTN4QPecuUe.NHOOHsQv4TihuRbblIQEn1FLnK', 'tutor', '2024-12-22 09:40:37', 'pending'),
(25, 'abc@gmail.com', 'abc', '$2y$10$chY8.ISU8a1WkGvRNvtqtuPUr85IOlXD6hLmIAXCTkv/JEBRHsWCW', 'tutor', '2024-12-24 09:11:48', 'approved');

-- --------------------------------------------------------

--
-- Table structure for table `user_settings`
--

CREATE TABLE `user_settings` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `notebank_id` varchar(255) NOT NULL,
  `school` varchar(255) NOT NULL,
  `course` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_settings`
--

INSERT INTO `user_settings` (`id`, `user_id`, `notebank_id`, `school`, `course`) VALUES
(1, 20, '1', 'UET', 'DB');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `answers`
--
ALTER TABLE `answers`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `tutor_id` (`tutor_id`);

--
-- Indexes for table `bids`
--
ALTER TABLE `bids`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`),
  ADD KEY `tutor_id` (`tutor_id`);

--
-- Indexes for table `book_guides`
--
ALTER TABLE `book_guides`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sender_id` (`sender_id`),
  ADD KEY `receiver_id` (`receiver_id`);

--
-- Indexes for table `notes`
--
ALTER TABLE `notes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `questions`
--
ALTER TABLE `questions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `question_history`
--
ALTER TABLE `question_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `question_id` (`question_id`);

--
-- Indexes for table `ratings_reviews`
--
ALTER TABLE `ratings_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `tutor_id` (`tutor_id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `tutors`
--
ALTER TABLE `tutors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `answers`
--
ALTER TABLE `answers`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `bids`
--
ALTER TABLE `bids`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `book_guides`
--
ALTER TABLE `book_guides`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `notes`
--
ALTER TABLE `notes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `questions`
--
ALTER TABLE `questions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `question_history`
--
ALTER TABLE `question_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings_reviews`
--
ALTER TABLE `ratings_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tutors`
--
ALTER TABLE `tutors`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `user_settings`
--
ALTER TABLE `user_settings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `answers`
--
ALTER TABLE `answers`
  ADD CONSTRAINT `answers_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `answers_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `bids`
--
ALTER TABLE `bids`
  ADD CONSTRAINT `bids_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `bids_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `documents`
--
ALTER TABLE `documents`
  ADD CONSTRAINT `documents_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `notes`
--
ALTER TABLE `notes`
  ADD CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `questions`
--
ALTER TABLE `questions`
  ADD CONSTRAINT `questions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `question_history`
--
ALTER TABLE `question_history`
  ADD CONSTRAINT `question_history_ibfk_1` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `ratings_reviews`
--
ALTER TABLE `ratings_reviews`
  ADD CONSTRAINT `ratings_reviews_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `ratings_reviews_ibfk_2` FOREIGN KEY (`tutor_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `user_settings`
--
ALTER TABLE `user_settings`
  ADD CONSTRAINT `user_settings_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
