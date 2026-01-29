-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Jul 01, 2025 at 07:56 AM
-- Server version: 10.11.6-MariaDB-log
-- PHP Version: 8.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `new_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

-- --------------------------------------------------------

--
-- Table structure for table `ads`
--

CREATE TABLE `ads` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `shortcode` varchar(255) NOT NULL,
  `code` longtext DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `ads`
--

INSERT INTO `ads` (`id`, `name`, `shortcode`, `code`, `status`, `created_at`, `updated_at`) VALUES
(1, 'header left ad ', 'header_left', '<img src=\"https://placehold.co/250x250\" >', 1, NULL, '2024-10-07 00:57:31'),
(3, 'header right ad ', 'header_right', '<img src=\"https://placehold.co/250x250\" >', 1, NULL, '2024-10-07 00:57:36'),
(4, 'header bottom ad ', 'header_bottom', '<img src=\"https://placehold.co/720x90\" >', 1, NULL, '2024-10-07 03:15:58'),
(5, 'mailbox left ad ', 'mailbox_left', '<img src=\"https://placehold.co/200x660\" >', 1, NULL, '2024-10-07 03:16:10'),
(6, 'mailbox right ad ', 'mailbox_right', '<img src=\"https://placehold.co/200x660\" >', 1, NULL, '2024-10-07 03:19:42'),
(7, 'mailbox top ad ', 'mailbox_top', '<img src=\"https://placehold.co/720x90\" >', 1, NULL, '2024-10-07 03:16:21'),
(9, 'mailbox bottom ad ', 'mailbox_bottom', '<img src=\"https://placehold.co/720x90\" >', 1, NULL, '2024-10-07 03:16:26'),
(10, 'Post top ad ', 'post_top', '<img src=\"https://placehold.co/720x90\" >', 1, NULL, '2024-10-07 03:16:32'),
(11, 'Post bottom ad ', 'post_bottom', '<img src=\"https://placehold.co/720x90\" >', 1, NULL, '2024-10-07 03:16:36'),
(12, 'Post sidebar ad ', 'post_sidebar', '<img src=\"https://placehold.co/350x350\" >', 1, NULL, '2024-10-07 03:16:49'),
(13, 'sticky ad', 'sticky_ad', '<img src=\"https://placehold.co/720x90\" >', 1, NULL, '2024-10-07 16:49:02');

-- --------------------------------------------------------

--
-- Table structure for table `blog_categories`
--

CREATE TABLE `blog_categories` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `lang` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `blog_posts`
--

CREATE TABLE `blog_posts` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext NOT NULL,
  `image` varchar(255) DEFAULT NULL,
  `small_image` varchar(255) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `views` int(11) NOT NULL DEFAULT 0,
  `meta_description` text DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `lang` varchar(255) NOT NULL,
  `category_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupons`
--

CREATE TABLE `coupons` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `usage` int(11) NOT NULL DEFAULT 0,
  `limit` int(11) NOT NULL DEFAULT -1 COMMENT 'Maximum usage limit. -1 means unlimited.',
  `type` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1: Percentage, 0: Fixed Price',
  `value` decimal(10,2) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `expired_at` timestamp NULL DEFAULT NULL,
  `applies_to_all` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `coupon_plan`
--

CREATE TABLE `coupon_plan` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` bigint(20) UNSIGNED NOT NULL,
  `coupon_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `domains`
--

CREATE TABLE `domains` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `domain` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_templates`
--

CREATE TABLE `email_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `alias` varchar(255) NOT NULL,
  `subject` varchar(255) NOT NULL,
  `shortcodes` text DEFAULT NULL,
  `body` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_templates`
--

INSERT INTO `email_templates` (`id`, `alias`, `subject`, `shortcodes`, `body`, `status`, `created_at`, `updated_at`) VALUES
(1, 'email_verification', 'Verify Your Email Address', '{\"{{link}}\": \"The verification link the user must click\",\n  \"{{website_name}}\": \"The name of the website\",\n  \"{{website_url}}\": \"The URL of the website\"\n}', '<h5><strong>Hello!</strong></h5><p>Please click the link below to verify your email address.</p><p style=\"text-align:center;\"><a href=\"{{link}}\" target=\"_blank\" rel=\"noopener noreferrer\">Verify Email Address</a></p><p>If you did not create an account, no further action is required.</p><p>Regards,</p><p>{{website_name}}<br>{{website_url}}</p><hr><p>If you\'re having trouble clicking the \"Verify Email Address\" button, copy and paste the URL below into your web browser:<br><a href=\"{{link}}\">{{link}}</a></p>', 1, '2024-09-25 01:38:57', '2024-09-30 00:38:17'),
(2, 'reset_password', 'Reset Your Password', '{\n  \"{{link}}\": \"The password reset link\",\n  \"{{expiry_time}}\": \"The expiration time of the password reset link\",\n  \"{{website_name}}\": \"The name of the website\",\n  \"{{website_url}}\": \"The URL of the website\"\n}', '<h3><strong>Hello!</strong></h3><p>You are receiving this email because we received a password reset request for your account.</p><p style=\"text-align:center;\"><a href=\"{{link}}\">Reset Password</a></p><p>This password reset link will expire in {{expiry_time}} minutes.</p><p>If you did not request a password reset, no further action is required.</p><p>Regards,</p><p>{{website_name}}<br>{{website_url}}</p>', 1, '2024-09-25 01:38:57', '2024-09-26 00:39:09'),
(3, 'contact_us', 'New Message from {{fullname}} via Contact Us Form', '{\r\n  \"{{fullname}}\": \"Sender\'s name\",\r\n  \"{{email}}\": \"Sender\'s email\",\r\n  \"{{message}}\": \"Submitted message\",\r\n  \"{{subject}}\": \"Submitted subject\",\r\n  \"{{ip}}\": \"Sender\'s IP address\",\r\n  \"{{country}}\": \"Sender\'s country\",\r\n  \"{{user_agent}}\": \"Sender\'s browser and device information\",\r\n  \"{{user_id}}\": \"Logged-in user\'s ID (if applicable)\",\r\n  \"{{website_name}}\": \"Website name\",\r\n  \"{{website_url}}\": \"Website URL\"\r\n}', '<p>Hello Admin, <br><br>You have received a new message from the contact us form. Here are the details:</p><p><br><strong>Full Name:</strong> {{fullname}} <br><strong>Email:</strong> {{email}} <br><strong>Subject:</strong> {{subject}} <br><strong>Message:</strong><br>{{message}} <br><strong>IP Address:</strong> {{ip}} <br><strong>Country:</strong> {{country}} <br><strong>User ID:</strong> {{user_id}} <br><strong>Browser/Device Info:</strong> {{user_agent}}</p><p><br><br>This message was sent from <a href=\"{{website_url}}\"><strong>{{website_name}}</strong></a> .<br><br>Please respond as soon as possible.</p><p> </p>', 1, '2024-09-25 01:38:57', '2024-09-26 01:41:49'),
(4, 'user_added_domain', 'New Domain Added by {{user_fullname}}', '{   \"{{user_fullname}}\": \"The name of the user who added the domain\",   \"{{user_email}}\": \"The email address of the user who added the domain\",   \"{{domain_name}}\": \"The newly added domain name\",   \"{{domain_url}}\": \"The URL of the newly added domain\",   \"{{admin_panel_url}}\": \"The URL of the admin panel for reviewing the domain\",   \"{{website_name}}\": \"The name of the website\",   \"{{website_url}}\": \"The URL of the website\" }', '<p>Hello Admin, <br><br>A user has added a new domain. Please review the details below: <br><br><strong>User Name:</strong> {{user_fullname}} <br><strong>User Email:</strong> {{user_email}} <br><strong>Domain Name:</strong> {{domain_name}} <br><strong>Domain URL:</strong> <a href=\"{{domain_url}}\">{{domain_url}}</a> <br><br>You can check the details in the admin panel: <a href=\"{{admin_panel_url}}\">{{admin_panel_url}}</a>.<br><br>This message was sent from <strong>{{website_name}}</strong> (<a href=\"{{website_url}}\">{{website_url}}</a>).<br><br>Thank you!</p>', 1, '2024-09-30 00:31:32', '2024-09-30 01:04:58'),
(5, 'domain_accepted', 'Your Domain {{domain_name}} has been Accepted', '{\n            \"{{user_fullname}}\": \"The name of the user who added the domain\",\n            \"{{domain_name}}\": \"The newly added domain name\",\n            \"{{domain_url}}\": \"The URL of the newly added domain\",\n            \"{{status}}\": \"The status of the domain (Accepted or Rejected)\",\n            \"{{website_name}}\": \"The name of the website\",\n            \"{{website_url}}\": \"The URL of the website\"\n          }', '<p>Hello {{user_fullname}}, <br><br>We are pleased to inform you that your domain has been accepted. Please find the details below: <br><br><strong>Domain Name:</strong> {{domain_name}} <br><strong>Domain URL:</strong> <a href=\"{{domain_url}}\">{{domain_url}}</a> <br><br>You can now use your domain with our services. If you have any questions, feel free to contact us. <br><br>This message was sent from <strong>{{website_name}}</strong> (<a href=\"{{website_url}}\">{{website_url}}</a>).<br><br>Thank you!</p>', 1, '2024-09-30 00:31:32', '2024-09-30 01:05:15'),
(6, 'domain_rejected', 'Your Domain {{domain_name}} has been Rejected', '{\n            \"{{user_fullname}}\": \"The name of the user who added the domain\",\n            \"{{domain_name}}\": \"The newly added domain name\",\n            \"{{domain_url}}\": \"The URL of the newly added domain\",\n            \"{{status}}\": \"The status of the domain (Accepted or Rejected)\",\n            \"{{website_name}}\": \"The name of the website\",\n            \"{{website_url}}\": \"The URL of the website\"\n          }', '<p>Hello {{user_fullname}}, <br><br>We regret to inform you that your domain submission has been rejected. Please review the details below: <br><br><strong>Domain Name:</strong> {{domain_name}} <br><strong>Domain URL:</strong> <a href=\"{{domain_url}}\">{{domain_url}}</a> <br><br><strong>Reason:</strong>  Unfortunately, your domain did not meet our criteria. Please review our guidelines.  <strong>    </strong><br><br>If you have any questions or would like to know more, please contact us. <br><br>This message was sent from <strong>{{website_name}}</strong> (<a href=\"{{website_url}}\">{{website_url}}</a>).<br><br>Thank you!</p><p> </p>', 1, '2024-09-30 00:31:32', '2024-09-30 01:07:38'),
(7, 'user_plan_expiry_reminder', 'Reminder: Your {{plan_name}} Plan is Expiring Soon', '{\n  \"{{user_fullname}}\": \"The full name of the user\",\n  \"{{plan_name}}\": \"The name of the subscription plan\",\n  \"{{expiry_date}}\": \"The date when the current plan will expire\",\n  \"{{renewal_url}}\": \"The URL where the user can renew their plan\",\n  \"{{website_name}}\": \"The name of the website\",\n            \"{{website_url}}\": \"The URL of the website\"\n}', '<p>Hello {{user_fullname}},<br><br>\r\nWe wanted to remind you that your current subscription plan is about to expire soon.<br><br>\r\n<strong>Plan Name:</strong> {{plan_name}}<br>\r\n<strong>Expiry Date:</strong> {{expiry_date}}<br>\r\n<strong>Renewal Link:</strong> <a href=\"{{renewal_url}}\">{{renewal_url}}</a><br><br>\r\nTo avoid interruption in your services, please renew your plan before the expiry date.<br><br>\r\nThis message was sent from <strong>{{website_name}}</strong> (<a href=\"{{website_url}}\">{{website_url}}</a>).<br><br>\r\nThank you!\r\n</p>', 1, '2024-09-30 00:31:32', '2024-09-30 01:07:38'),
(8, 'user_payment_confirmation', 'Payment Received Successfully – Thank You!', '{\r\n  \"{{user_fullname}}\": \"The full name of the user\",\r\n  \"{{payment_amount}}\": \"The amount the user paid\",\r\n  \"{{transaction_id}}\": \"The ID of the transaction\",\r\n  \"{{plan_name}}\": \"The name of the plan the user paid for\",\r\n  \"{{payment_date}}\": \"The date when the payment was made\",\r\n  \r\n  \"{{website_name}}\": \"The name of the website\",\r\n  \"{{website_url}}\": \"The URL of the website\"\r\n}', '<p>Hello {{user_fullname}},<br><br>We’ve received your payment successfully. Below are the payment details:<br><br><strong>Payment Amount:</strong> {{payment_amount}}<br><strong>Transaction ID:</strong> {{transaction_id}}<br><strong>Plan Name:</strong> {{plan_name}}<br><strong>Payment Date:</strong> {{payment_date}}<br><br><br>This message was sent from <strong>{{website_name}}</strong> (<a href=\"{{website_url}}\">{{website_url}}</a>).<br><br>Thank you for your payment!</p>', 1, NULL, '2025-04-26 13:24:58'),
(12, 'user_plan_expired', 'Your {{plan_name}} Plan Has Expired', '{\n  \"{{user_fullname}}\": \"The full name of the user\",\n  \"{{plan_name}}\": \"The name of the subscription plan\",\n  \"{{expiry_date}}\": \"The date when the current plan will expire\",\n  \"{{renewal_url}}\": \"The URL where the user can renew their plan\",\n  \"{{website_name}}\": \"The name of the website\",\n            \"{{website_url}}\": \"The URL of the website\"\n}', '<p>Hello {{user_fullname}},<br><br>\r\nWe wanted to inform you that your subscription plan has expired.<br><br>\r\n<strong>Plan Name:</strong> {{plan_name}}<br>\r\n<strong>Expired On:</strong> {{expiry_date}}<br>\r\n<strong>Renewal Link:</strong> <a href=\"{{renewal_url}}\">{{renewal_url}}</a><br><br>\r\nYour services have been paused. To resume access, please renew your plan at your earliest convenience.<br><br>\r\nThis message was sent from <strong>{{website_name}}</strong> (<a href=\"{{website_url}}\">{{website_url}}</a>).<br><br>\r\nThank you!\r\n</p>', 1, '2024-09-30 00:31:32', '2024-09-30 01:07:38'),
(13, 'user_trial_expiry_reminder', 'Your Trial is Ending Soon', '{\n  \"{{user_fullname}}\": \"The full name of the user\",\n  \"{{plan_name}}\": \"The name of the subscription plan\",\n  \"{{expiry_date}}\": \"The date when the current plan will expire\",\n  \"{{upgrade_url}}\": \"The URL where the user can upgrade their plan\",\n  \"{{website_name}}\": \"The name of the website\",\n            \"{{website_url}}\": \"The URL of the website\"\n}', '<p>Hello {{user_fullname}},<br><br>\r\nYour free trial is about to end soon. Don’t lose access to your account features!<br><br>\r\n<strong>Trial Ends On:</strong> {{expiry_date}}<br>\r\n<strong>Upgrade Link:</strong> <a href=\"{{upgrade_url}}\">{{upgrade_url}}</a><br><br>\r\nChoose a plan that best fits your needs and continue enjoying our services without interruption.<br><br>\r\nThis message was sent from <strong>{{website_name}}</strong> (<a href=\"{{website_url}}\">{{website_url}}</a>).<br><br>\r\nThank you!\r\n</p>', 1, '2024-09-30 00:31:32', '2024-09-30 01:07:38'),
(14, 'user_trial_expired', 'Your Free Trial Has Expired', '{\r\n  \"{{user_fullname}}\": \"The full name of the user\",\r\n  \"{{plan_name}}\": \"The name of the subscription plan\",\r\n  \"{{expiry_date}}\": \"The date when the current plan will expire\",\r\n  \"{{upgrade_url}}\": \"The URL where the user can upgrade their plan\",\r\n  \"{{website_name}}\": \"The name of the website\",\r\n            \"{{website_url}}\": \"The URL of the website\"\r\n}', '<p>Hello {{user_fullname}},<br><br>\r\nYour free trial has ended and your account is currently inactive.<br><br>\r\n<strong>Trial Expired On:</strong> {{expiry_date}}<br>\r\n<strong>Choose a Plan:</strong> <a href=\"{{upgrade_url}}\">{{upgrade_url}}</a><br><br>\r\nTo continue using our services, please select a subscription plan and activate your account.<br><br>\r\nThis message was sent from <strong>{{website_name}}</strong> (<a href=\"{{website_url}}\">{{website_url}}</a>).<br><br>\r\nThank you!\r\n</p>', 1, '2024-09-30 00:31:32', '2024-09-30 01:07:38');

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `faqs`
--

CREATE TABLE `faqs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `content` longtext DEFAULT NULL,
  `lang` varchar(255) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `translate_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `faqs`
--

INSERT INTO `faqs` (`id`, `title`, `content`, `lang`, `position`, `created_at`, `updated_at`, `translate_id`) VALUES
(1, 'What is a temporary email address?', 'A temporary email address is a disposable, short-term email that allows you to receive messages without exposing your personal email. It\'s perfect for signing up for websites or services without worrying about spam', 'en', 0, '2024-12-09 02:46:51', '2024-12-09 02:46:51', '17ad66a8467ca'),
(2, 'How long does a temporary email address last?', 'The lifespan of a temporary email address varies. Typically, it lasts between 10 minutes to a few hours, but some services allow you to extend its duration.', 'en', 0, '2024-12-09 02:47:16', '2024-12-09 02:47:16', '67ad69a8467ca'),
(3, 'Is it safe to use a temporary email address?', 'Yes, temporary emails are designed to protect your privacy. They prevent spam and phishing attempts from reaching your personal inbox and don’t store your data.', 'en', 0, '2024-12-09 02:47:39', '2024-12-09 02:47:39', '67ad66a8467c8'),
(4, 'Can I use a temporary email address for attachments?', 'Absolutely! Temporary email addresses support receiving attachments. You can securely download files sent to your temp email.', 'en', 0, '2024-12-09 02:47:56', '2024-12-09 02:47:56', '67ad66a8467cq'),
(5, 'Do I need to register to use the service?', 'No registration is required. Temporary email services are designed to be quick, anonymous, and hassle-free.', 'en', 0, '2024-12-09 02:48:35', '2024-12-09 02:48:35', '67ad66a8467cn'),
(6, 'Can I send emails from my temporary address?', 'Our service is designed for receiving emails only. This helps prevent abuse of our platform for sending spam. Its primary purpose is to act as a shield for your real inbox', 'en', 0, '2025-07-04 03:03:53', '2025-07-04 03:03:53', '686736896f15b'),
(7, 'Are the attachments I receive scanned for viruses?', 'Yes. We perform a basic scan on all incoming attachments for common viruses and malware. However, we still strongly advise you to exercise caution and use your own antivirus software as a second layer of defense before opening any downloaded files.', 'en', 0, '2025-07-04 03:04:07', '2025-07-04 03:04:07', '686736973f29d');

-- --------------------------------------------------------

--
-- Table structure for table `features`
--

CREATE TABLE `features` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  `content` longtext DEFAULT NULL,
  `lang` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `translate_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `features`
--

INSERT INTO `features` (`id`, `title`, `icon`, `content`, `lang`, `created_at`, `updated_at`, `translate_id`) VALUES
(1, '100% Safe', '<i class=\"fas fa-lock\"></i>', 'Protect your privacy by keeping spam and unwanted emails out of your personal inbox', 'en', '2024-12-09 02:38:41', '2024-12-09 02:38:41', '67fd66cb38fff'),
(2, 'Instant Access', '<i class=\"fas fa-bolt\"></i>', 'Receive emails instantly with real-time inbox updates—no delays, no refresh required.', 'en', '2024-12-09 02:39:45', '2024-12-09 02:39:45', '67ad66cb30ff0'),
(3, 'Custom Domains', '<i class=\"fas fa-globe\"></i>', 'Choose from multiple email domains to create a unique and secure temporary email address.', 'en', '2024-12-09 02:40:27', '2024-12-09 02:40:27', '67af66cb38ff0'),
(4, 'Simple & Free', '<i class=\"fas fa-envelope\"></i>', 'Create temporary email addresses in just a few clicks. No registration required, and it’s always free to use!', 'en', '2024-12-09 02:41:29', '2024-12-09 02:41:29', '6aad66cb38ff0'),
(5, 'Unlimited Usage', '<i class=\"fa-solid fa-infinity\"></i>', 'Create as many temporary emails as you need—no limits, no hidden fees, and no restrictions on usage.', 'en', '2024-12-09 02:43:56', '2024-12-09 02:45:59', '67ad63cb38ff0'),
(6, 'Favorites Feature', '<i class=\"fa-solid fa-star\"></i>', 'Save important messages to your favorites for quick and easy access whenever you need them.', 'en', '2024-12-09 02:44:42', '2025-02-16 23:56:55', '67ad66cb38ff1'),
(7, 'Multiple Languages', '<i class=\"fas fa-language\"></i>', 'Available in several languages so users around the world can use the service comfortably.', 'en', '2025-07-04 02:50:50', '2025-07-04 02:50:50', '6867337adb436'),
(8, 'Mobile-Friendly', '<i class=\"fas fa-mobile-alt\"></i>', 'Access your temporary inbox anytime, anywhere. Fully responsive design works on all devices.', 'en', '2025-07-04 03:01:47', '2025-07-04 03:02:50', '6867360b88f0d'),
(9, 'Auto-Cleanup', '<i class=\"fas fa-broom\"></i>', 'Old emails are automatically deleted to keep your inbox clean and clutter-free—no manual cleanup needed.', 'en', '2025-07-04 03:02:16', '2025-07-04 03:02:16', '686736288f090');

-- --------------------------------------------------------

--
-- Table structure for table `imaps`
--

CREATE TABLE `imaps` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tag` varchar(255) NOT NULL,
  `host` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `encryption` varchar(255) DEFAULT NULL,
  `validate_certificates` int(11) DEFAULT NULL,
  `port` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `imaps`
--

INSERT INTO `imaps` (`id`, `tag`, `host`, `username`, `password`, `encryption`, `validate_certificates`, `port`, `created_at`, `updated_at`) VALUES
(1, 'main', NULL, NULL, NULL, 'ssl', 0, 993, NULL, '2025-02-24 15:36:03');

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `code` varchar(255) NOT NULL,
  `direction` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `direction`, `created_at`, `updated_at`) VALUES
(1, 'english', 'en', 0, NULL, '2024-10-18 16:36:37');

-- --------------------------------------------------------

--
-- Table structure for table `logs`
--

CREATE TABLE `logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `lang` varchar(255) NOT NULL,
  `position` int(11) NOT NULL DEFAULT 0,
  `parent` int(11) NOT NULL DEFAULT 0,
  `type` int(11) NOT NULL DEFAULT 0,
  `is_external` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `message_id` varchar(255) NOT NULL,
  `from_email` longtext DEFAULT NULL,
  `subject` longtext DEFAULT NULL,
  `from` longtext DEFAULT NULL,
  `to` longtext DEFAULT NULL,
  `receivedAt` varchar(255) NOT NULL,
  `source` varchar(255) NOT NULL,
  `attachments` longtext DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(4, '0001_01_01_000000_create_users_table', 1),
(5, '0001_01_01_000001_create_cache_table', 1),
(6, '0001_01_01_000002_create_jobs_table', 1),
(7, '2023_09_20_214006_create_admins_table', 1),
(8, '2023_09_20_235600_create_settings_table', 1),
(9, '2023_09_20_171537_create_languages_table', 2),
(10, '2023_09_20_214159_create_blog_categories_table', 2),
(12, '2023_09_20_214259_create_features_table', 2),
(13, '2023_09_20_214310_create_faqs_table', 2),
(14, '2023_09_20_214341_create_plugins_table', 2),
(15, '2023_09_20_214414_create_translates_table', 2),
(16, '2023_09_20_214437_create_menus_table', 2),
(17, '2023_09_20_214556_create_themes_table', 2),
(18, '2023_09_20_214605_create_seo_table', 2),
(19, '2023_09_20_214739_create_ads_table', 2),
(21, '2023_09_20_214208_create_blog_posts_table', 3),
(22, '2023_09_20_214128_create_domains_table', 4),
(30, '2023_09_28_231827_create_plans_table', 5),
(31, '2023_09_28_231828_create_plan_features_table', 5),
(32, '2023_09_28_231829_create_plan_subscriptions_table', 5),
(33, '2023_09_28_231831_create_plan_subscription_usage_table', 5),
(34, '2023_10_11_150843_create_trash_mails_table', 5),
(35, '2023_11_13_011144_create_imaps_table', 5),
(38, '2023_09_20_214539_create_sections_table', 6),
(40, '2023_09_20_214509_create_messages_table', 7),
(41, '2024_08_16_180603_create_licenses_table', 8),
(42, '2024_08_16_190927_create_products_table', 8),
(47, '2024_09_15_161222_create_notifications_table', 9),
(48, '2024_09_25_021652_create_email_templates_table', 10),
(49, '2023_09_21_004358_create_pages_table', 11),
(50, '2024_10_03_231402_create_statistics_table', 12),
(51, '2024_12_17_010041_create_personal_access_tokens_table', 13),
(54, '2025_01_25_050733_create_logs_table', 14),
(55, '2025_02_12_175910_create_translation_jobs_table', 15),
(58, '2025_02_13_041759_add_translate_id_to_features_table', 16),
(59, '2025_02_13_041816_add_translate_id_to_faqs_table', 16);

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `to_admin` tinyint(1) NOT NULL DEFAULT 0,
  `message` text NOT NULL,
  `icon` varchar(255) DEFAULT NULL,
  `is_read` tinyint(1) NOT NULL DEFAULT 0,
  `action` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `notifications`
--

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `slug` varchar(255) NOT NULL,
  `content` longtext DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_title` varchar(255) DEFAULT NULL,
  `views` int(11) NOT NULL DEFAULT 0,
  `lang` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plans`
--


CREATE TABLE `plans` (
  `id` int UNSIGNED NOT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `signup_fee` decimal(8,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trial_period` smallint UNSIGNED NOT NULL DEFAULT '0',
  `trial_interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'day',
  `trial_mode` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'outside',
  `grace_period` smallint UNSIGNED NOT NULL DEFAULT '0',
  `grace_interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'day',
  `invoice_period` smallint UNSIGNED NOT NULL DEFAULT '1',
  `invoice_interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `tier` mediumint UNSIGNED NOT NULL DEFAULT '0',
  `is_lifetime` tinyint(1) NOT NULL DEFAULT '0',
  `is_featured` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plans`
--

INSERT INTO `plans` (`id`, `tag`, `name`, `description`, `is_active`, `price`, `signup_fee`, `currency`, `trial_period`, `trial_interval`, `trial_mode`, `grace_period`, `grace_interval`, `invoice_period`, `invoice_interval`, `tier`, `is_lifetime`, `is_featured`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'guest', 'Guest Plan', 'For small businesses', 1, '0.00', '0.00', 'USD', 0, 'day', 'outside', 0, 'day', 1, 'year', 1, 1, 0, '2023-09-28 20:23:16', '2023-09-28 20:23:16', NULL),
(2, 'free', 'Free Plan', 'Great for quick and anonymous email use with limited access', 1, '0.00', '0.00', 'USD', 0, 'day', 'outside', 0, 'day', 1, 'year', 1, 1, 0, '2023-09-28 20:26:40', '2025-07-01 01:37:04', NULL),
(4, 'pro', 'Basic Plan', 'A solid step up with more features, fewer limitations, and a smoother experience', 1, '5.99', '0.00', 'USD', 15, 'day', 'outside', 0, 'day', 1, 'month', 0, 0, 0, '2025-07-01 00:05:50', '2025-07-01 02:28:57', NULL),
(5, 'pro-plan', 'Pro Plan', 'Full access to premium features, power, and flexibility', 1, '49.99', '0.00', 'USD', 0, 'day', 'outside', 0, 'day', 1, 'year', 3, 0, 0, '2025-07-01 01:09:05', '2025-07-01 01:32:28', NULL),
(6, 'pro-plan-2', 'Pro Plan', 'Full access to premium features, power, and flexibility', 1, '9.99', '0.00', 'USD', 0, 'day', 'outside', 0, 'day', 1, 'month', 0, 0, 0, '2025-07-01 01:09:45', '2025-07-01 01:09:45', NULL),
(7, 'basic-plan', 'Basic Plan', 'A solid step up with more features, fewer limitations, and a smoother experience', 1, '29.98', '0.00', 'USD', 14, 'day', 'outside', 0, 'day', 1, 'year', 2, 0, 0, '2025-07-01 01:12:23', '2025-07-01 02:29:00', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `plan_features`
--

CREATE TABLE `plan_features` (
  `id` int UNSIGNED NOT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `plan_id` int UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_unlimited` tinyint(1) NOT NULL DEFAULT '0',
  `resettable_period` smallint UNSIGNED NOT NULL DEFAULT '0',
  `resettable_interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `sort_order` mediumint UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plan_features`
--

INSERT INTO `plan_features` (`id`, `tag`, `plan_id`, `name`, `description`, `value`, `is_unlimited`, `resettable_period`, `resettable_interval`, `sort_order`, `created_at`, `updated_at`) VALUES
(8, 'domains', 1, 'Custom domains', NULL, '-1', 0, 0, 'month', 0, '2023-10-04 16:11:48', '2023-10-04 16:11:48'),
(10, 'history', 1, 'History size', NULL, '2', 0, 0, 'month', 0, '2023-10-04 16:11:48', '2025-07-01 01:29:14'),
(11, 'messages', 1, 'Favorite Messages', NULL, '0', 0, 0, 'month', 0, '2023-10-04 16:11:48', '2023-10-04 16:11:48'),
(12, 'ads', 1, 'No Ads', NULL, '0', 0, 0, 'month', 0, '2023-10-04 16:11:48', '2025-07-01 01:29:05'),
(13, 'attachments', 1, 'See Attachments', NULL, 'false', 0, 0, 'month', 0, '2023-10-04 16:11:48', '2025-07-01 01:29:14'),
(14, 'premium_domains', 1, 'Premium Domains', NULL, 'false', 0, 0, 'month', 0, '2023-10-04 16:11:48', '2025-07-01 01:29:14'),
(15, 'domains', 2, 'Custom domains', NULL, '0', 0, 0, 'month', 0, '2023-10-04 16:12:10', '2025-07-01 01:16:17'),
(17, 'history', 2, 'History size', NULL, '5', 0, 0, 'month', 0, '2023-10-04 16:12:10', '2025-07-01 01:16:17'),
(18, 'messages', 2, 'Favorite Messages', NULL, '5', 0, 0, 'month', 0, '2023-10-04 16:12:10', '2025-07-01 01:16:17'),
(19, 'ads', 2, 'No Ads', NULL, '0', 0, 0, 'month', 0, '2023-10-04 16:12:10', '2025-07-01 01:36:33'),
(20, 'attachments', 2, 'See Attachments', NULL, 'false', 0, 0, 'month', 0, '2023-10-04 16:12:10', '2025-07-01 01:16:23'),
(21, 'premium_domains', 2, 'Premium Domains', NULL, 'false', 0, 0, 'month', 0, '2023-10-04 16:12:10', '2025-07-01 01:16:17'),
(28, 'domains', 4, 'Custom domains', NULL, '1', 0, 0, 'month', 0, '2025-07-01 00:05:50', '2025-07-01 01:10:51'),
(29, 'history', 4, 'History size', NULL, '10', 0, 0, 'month', 0, '2025-07-01 00:05:50', '2025-07-01 00:05:50'),
(30, 'messages', 4, 'Favorite Messages', NULL, '10', 0, 0, 'month', 0, '2025-07-01 00:05:50', '2025-07-01 00:05:50'),
(31, 'ads', 4, 'No Ads', NULL, '1', 0, 0, 'month', 0, '2025-07-01 00:05:50', '2025-07-01 00:05:50'),
(32, 'attachments', 4, 'See Attachments', NULL, 'true', 0, 0, 'month', 0, '2025-07-01 00:05:50', '2025-07-01 00:05:50'),
(33, 'premium_domains', 4, 'Premium Domains', NULL, 'true', 0, 0, 'month', 0, '2025-07-01 00:05:50', '2025-07-01 00:05:50'),
(34, 'domains', 5, 'Custom domains', NULL, '-1', 0, 0, 'month', 0, '2025-07-01 01:09:05', '2025-07-01 01:09:05'),
(35, 'history', 5, 'History size', NULL, '-1', 0, 0, 'month', 0, '2025-07-01 01:09:05', '2025-07-01 01:09:05'),
(36, 'messages', 5, 'Favorite Messages', NULL, '-1', 0, 0, 'month', 0, '2025-07-01 01:09:05', '2025-07-01 01:09:05'),
(37, 'ads', 5, 'No Ads', NULL, '1', 0, 0, 'month', 0, '2025-07-01 01:09:05', '2025-07-01 01:32:28'),
(38, 'attachments', 5, 'See Attachments', NULL, 'true', 0, 0, 'month', 0, '2025-07-01 01:09:05', '2025-07-01 01:09:05'),
(39, 'premium_domains', 5, 'Premium Domains', NULL, 'true', 0, 0, 'month', 0, '2025-07-01 01:09:05', '2025-07-01 01:09:05'),
(40, 'domains', 6, 'Custom domains', NULL, '-1', 0, 0, 'month', 0, '2025-07-01 01:09:45', '2025-07-01 01:09:45'),
(41, 'history', 6, 'History size', NULL, '-1', 0, 0, 'month', 0, '2025-07-01 01:09:45', '2025-07-01 01:09:45'),
(42, 'messages', 6, 'Favorite Messages', NULL, '-1', 0, 0, 'month', 0, '2025-07-01 01:09:45', '2025-07-01 01:09:45'),
(43, 'ads', 6, 'No Ads', NULL, '1', 0, 0, 'month', 0, '2025-07-01 01:09:45', '2025-07-01 01:35:26'),
(44, 'attachments', 6, 'See Attachments', NULL, 'true', 0, 0, 'month', 0, '2025-07-01 01:09:45', '2025-07-01 01:09:45'),
(45, 'premium_domains', 6, 'Premium Domains', NULL, 'true', 0, 0, 'month', 0, '2025-07-01 01:09:45', '2025-07-01 01:09:45'),
(46, 'domains', 7, 'Custom domains', NULL, '1', 0, 0, 'month', 0, '2025-07-01 01:12:23', '2025-07-01 01:12:23'),
(47, 'history', 7, 'History size', NULL, '10', 0, 0, 'month', 0, '2025-07-01 01:12:23', '2025-07-01 01:12:23'),
(48, 'messages', 7, 'Favorite Messages', NULL, '10', 0, 0, 'month', 0, '2025-07-01 01:12:23', '2025-07-01 01:12:23'),
(49, 'ads', 7, 'No Ads', NULL, '1', 0, 0, 'month', 0, '2025-07-01 01:12:23', '2025-07-01 01:12:23'),
(50, 'attachments', 7, 'See Attachments', NULL, 'true', 0, 0, 'month', 0, '2025-07-01 01:12:23', '2025-07-01 01:12:23'),
(51, 'premium_domains', 7, 'Premium Domains', NULL, 'true', 0, 0, 'month', 0, '2025-07-01 01:12:23', '2025-07-01 01:12:23');

-- --------------------------------------------------------

--
-- Table structure for table `plan_subscriptions`
--

CREATE TABLE `plan_subscriptions` (
  `id` int UNSIGNED NOT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscriber_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscriber_id` bigint UNSIGNED NOT NULL,
  `plan_id` int UNSIGNED DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` decimal(8,2) NOT NULL DEFAULT '0.00',
  `currency` varchar(3) COLLATE utf8mb4_unicode_ci NOT NULL,
  `trial_period` smallint UNSIGNED NOT NULL DEFAULT '0',
  `trial_interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'day',
  `grace_period` smallint UNSIGNED NOT NULL DEFAULT '0',
  `grace_interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'day',
  `invoice_period` smallint UNSIGNED NOT NULL DEFAULT '1',
  `invoice_interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `payment_method` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT 'free',
  `tier` mediumint UNSIGNED NOT NULL DEFAULT '0',
  `trial_ends_at` timestamp NULL DEFAULT NULL,
  `starts_at` timestamp NULL DEFAULT NULL,
  `ends_at` timestamp NULL DEFAULT NULL,
  `cancels_at` timestamp NULL DEFAULT NULL,
  `canceled_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `notify` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plan_subscription_features`
--

CREATE TABLE `plan_subscription_features` (
  `id` int UNSIGNED NOT NULL,
  `plan_subscription_id` int UNSIGNED NOT NULL,
  `plan_feature_id` int UNSIGNED DEFAULT NULL,
  `tag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `resettable_period` smallint UNSIGNED NOT NULL DEFAULT '0',
  `resettable_interval` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'month',
  `sort_order` mediumint UNSIGNED NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plan_subscription_usage`
--

CREATE TABLE `plan_subscription_usage` (
  `id` int UNSIGNED NOT NULL,
  `plan_subscription_feature_id` int UNSIGNED NOT NULL,
  `used` int UNSIGNED NOT NULL,
  `valid_until` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

CREATE TABLE `plugins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `unique_name` varchar(255) NOT NULL,
  `tag` varchar(255) DEFAULT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `code` longtext DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `license` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `is_featured` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plugins`
--

INSERT INTO `plugins` (`id`, `name`, `unique_name`, `tag`, `logo`, `url`, `description`, `action`, `code`, `version`, `license`, `status`, `is_featured`, `created_at`, `updated_at`) VALUES
(1, 'hCaptcha', 'hcaptcha', 'security', 'assets/img/plugins/hcaptcha.png', 'https://www.lobage.com/hcaptcha', 'Protect forms from spam using hCaptcha\'s advanced bot-detection technology', NULL, '{\"hcaptcha_site_key\":{\"title\":\"Site Key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true},\"hcaptcha_secret_key\":{\"title\":\"Secret Key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true}}', '1.0', NULL, 0, 0, NULL, '2025-02-17 16:00:52'),
(2, 'ReCaptcha', 'recaptcha', 'security', 'assets/img/plugins/recaptcha.png', 'https://www.google.com/recaptcha/admin/create', 'Google\'s ReCaptcha secures forms by distinguishing between bots and humans', NULL, '{\"RECAPTCHA_SITE_KEY\":{\"title\":\"Site Key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true},\"RECAPTCHA_SECRET_KEY\":{\"title\":\"Secret Key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true}}', '1.0', NULL, 0, 0, NULL, '2024-10-12 03:19:26'),
(3, 'Facebook Login', 'facebook_login', 'auth', 'assets/img/plugins/facebook_login.png', 'https://developers.facebook.com/', 'Allow users to log in to your site using their Facebook credentials', NULL, '{\"facebook_app_id\":{\"title\":\"Facebook App ID\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true},\"facebook_app_secret\":{\"title\":\"Facebook App Secret\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true},\"facebook_redirect\":{\"title\":\"Callback URL\",\"route_name\":\"social.callback\",\"route_params\":[\"facebook\"],\"type\":\"input\",\"placeholder\":\"\",\"env\":true,\"disabled\":true,\"is_route\":true,\"value\":\"https:\\/\\/test.lobage.com\\/auth\\/facebook\\/callback\"}}', '1.0', NULL, 0, 0, NULL, '2025-02-28 00:36:43'),
(4, 'Google Login', 'google_login', 'auth', 'assets/img/plugins/google_login.png', 'https://console.cloud.google.com/apis/dashboard', 'Integrate Google login for secure and convenient user authentication', NULL, '{\"google_app_id\":{\"title\":\"Google App ID\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true},\"google_app_secret\":{\"title\":\"Google App Secret\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true},\"google_redirect\":{\"title\":\"Callback URL\",\"route_name\":\"social.callback\",\"route_params\":[\"google\"],\"type\":\"input\",\"placeholder\":\"\",\"disabled\":true,\"is_route\":true,\"env\":true,\"value\":\"https:\\/\\/test.lobage.com\\/auth\\/google\\/callback\"}}', '1.0', NULL, 0, 0, NULL, '2025-02-28 00:46:55'),
(5, 'Disqus Comments ', 'disqus', 'others', 'assets/img/plugins/disqus.png', 'https://disqus.com/admin/', 'Embed Disqus to let users engage and comment on your content', NULL, '{\"shortname\":{\"title\":\"Your Disqus Shortname\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":false}}', '1.0', NULL, 0, 0, NULL, '2024-10-12 12:25:05'),
(6, 'Facebook Comments', 'facebook_comments', 'others', 'assets/img/plugins/facebook_comments.png', 'https://developers.facebook.com/docs/plugins/comments/', 'Allow users to comment on your site using their Facebook profiles', NULL, '{\"app_id\":{\"title\":\"APP ID\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":false},\"number_of_comment\":{\"title\":\"Number of Comments\",\"value\":\"5\",\"type\":\"input\",\"placeholder\":\"5\",\"env\":false}}', '1.0', NULL, 0, 0, NULL, '2024-10-12 12:25:07'),
(7, 'Trustip', 'trustip', 'security', 'assets/img/plugins/trustip.png', 'https://www.lobage.com/trustip', 'Analyze IP addresses to detect fraud, spam, VPNs, proxies, and TOR for enhanced security\n', NULL, '{\"TRUSTIP_API_KEY\":{\"title\":\"Your trustip Key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true}}', '1.0', NULL, 0, 0, NULL, '2025-03-01 01:25:55'),
(8, 'Contact Form', 'contact', 'support', 'assets/img/plugins/contact.png', 'https://www.lobage.com/jotform', 'Easy-to-use contact form to receive messages directly on your email', NULL, '{\n  \"type\": {\n    \"title\": \"Form Type\",\n    \"value\": \"default\",\n    \"type\": \"select\",\n    \n    \"options\": [\n      {\n        \"title\": \"Default\",\n        \"value\": \"default\"\n      },\n      {\n        \"title\": \"Iframe\",\n        \"value\": \"iframe\"\n      }\n    ]\n  },\n  \n  \"iframe\": {\n    \"title\": \"Iframe Code\",\n    \"value\": null,\n    \"type\": \"textarea\",\n    \"placeholder\": \"Only required if \'Iframe\' type is selected\",\n    \"env\": false,\n    \"skip_validation\": true,\n    \"info\": \"Paste the contents of your contact iframe code here.\",\n    \"alert\": \"If you select \'Default\', you need to set up the SMTP settings.\",\n    \"alert_type\": \"info\"\n  }\n}\n', '1.0', NULL, 0, 0, NULL, '2024-10-15 01:58:00'),
(9, 'Google analytics', 'google_analytics', 'analytics', 'assets/img/plugins/google_analytics.png', 'https://analytics.google.com/analytics/web/', 'Track and analyze website traffic and user behavior with Google Analytics', NULL, '{\"measurement_id\":{\"title\":\"Measurement Id\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"G-XXXXXXXXXX\",\"env\":false}}', '1.0', NULL, 0, 0, NULL, '2024-10-12 12:26:14'),
(10, 'Google Tag Manager', 'google_tag', 'analytics', 'assets/img/plugins/google_tag.png', 'https://tagmanager.google.com/', 'Manage marketing tags without modifying code through Google Tag Manager', NULL, '{\"container_id\":{\"title\":\"Container Id\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"GTM-XXXXXXX\",\"env\":false,\"info\":\"In Google Tag Manager, click <strong>Workspace<\\/strong>. Your Container ID will appear near the top of the window, formatted as <strong>GTM-XXXXXX<\\/strong>.\"}}', '1.0', NULL, 0, 0, NULL, '2025-03-01 01:16:36'),
(11, 'Custom Code\r\n', 'custom_code', 'others', 'assets/img/plugins/custom_code.png', NULL, ' Add custom code snippets to your site, injected directly into the header', NULL, '{\"custom_code\":{\"title\":\"Custom Code\",\"value\":null,\"type\":\"textarea\",\"placeholder\":\"\",\"env\":false,\"skip_validation\":true,\"info\":\"Paste the snippet of code provided by the tool or service above, and it will be injected into the <strong>&lt;head&gt;<\\/strong> section of your website.\"}}', '1.0', NULL, 0, 0, NULL, '2025-03-02 05:25:24'),
(12, 'Google AdSense', 'google_adsense', 'marketing', 'assets/img/plugins/google_adsense.png', 'https://adsense.google.com/start/', 'Integrate AdSense to manage advertising directly on your website', NULL, '{\"adsense\":{\"title\":\"Content \",\"value\":null,\"type\":\"textarea\",\"placeholder\":\"\",\"env\":false,\"skip_validation\":true,\"info\":\"Paste the contents of your ads.txt file with the publisher ID in the box above to manage the sellers that are allowed to advertize on your site.\",\"alert\":\"To verify that you published your file correctly, check that you successfully see your file\'s content when you access the ads.txt URL (https:\\/\\/example.com\\/ads.txt) in your web browser.\",\"alert_type\":\"info\"}}', '1.0', NULL, 0, 0, NULL, '2025-03-02 05:40:20'),
(13, 'Robots.txt', 'robots', 'marketing', 'assets/img/plugins/robots.png', 'https://www.lobage.com/seranking', 'Customize how search engines crawl your site using the Robots.txt file', NULL, '{\"robots\":{\"title\":\"Robots.txt Content\",\"value\":\"User-agent: *\\r\\nAllow: \\/\\r\\n\\r\\nSitemap: https:\\/\\/your-site.com\\/sitemap.xml\",\"type\":\"textarea\",\"placeholder\":\"Enter your robots.txt content here...\",\"env\":false,\"info\":\"Paste the contents of your robots.txt file in the box above to control how search engines crawl your site.\",\"alert\":\"To verify that your robots.txt file is published correctly, check that you can access it at https:\\/\\/example.com\\/robots.txt in your web browser.\",\"skip_validation\":true,\"alert_type\":\"info\"}}', '1.0', NULL, 0, 0, NULL, '2025-03-02 05:24:00'),
(14, 'Sitemap', 'sitemap', 'marketing', 'assets/img/plugins/sitemap.png', 'https://www.xml-sitemaps.com/', 'Generate and manage an XML sitemap for better search engine indexing', NULL, NULL, '1.0', NULL, 0, 0, NULL, '2025-02-09 23:43:35'),
(15, 'Hotjar', 'hotjar', 'analytics', 'assets/img/plugins/hotjar.png', 'https://www.lobage.com/hotjar', 'Collect heatmaps and feedback to improve your site\'s user experience', NULL, '{\"site_id\":{\"title\":\"Site Id\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"1234567\",\"env\":false}}', '1.0', NULL, 0, 0, NULL, '2024-10-12 14:55:27'),
(16, 'ReCaptcha invisible', 'recaptcha_invisible', 'security', 'assets/img/plugins/recaptcha_invisible.png', 'https://www.google.com/recaptcha/admin/create', 'Secure mailbox with Google\'s invisible ReCaptcha, detecting bots silently', NULL, '{\"ROCAPTCHA_SITEKEY_INVISIBLE\":{\"title\":\"Site Key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true},\"ROCAPTCHA_SECRET_INVISIBLE\":{\"title\":\"Secret Key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":true}}', '1.0', NULL, 0, 0, NULL, '2024-11-28 07:40:31'),
(17, 'Tawk.to', 'tawk', 'support', 'assets/img/plugins/tawk.png', 'https://www.tawk.to/', 'Free live chat tool to communicate with site visitors in real time', NULL, '{\"property_id\":{\"title\":\"Property ID\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"1234567\",\"env\":false}}', '1.0', NULL, 0, 0, NULL, '2025-03-01 01:31:22'),
(18, 'Graph Comment', 'graphcomment', 'others', 'assets/img/plugins/graphcomment.png', 'https://www.graphcomment.com/en', 'Engage users with social discussions using the GraphComment platform', NULL, '{\"unique_id\":{\"title\":\"Your Unique id\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"\",\"env\":false}}', '1.0', NULL, 0, 0, NULL, '2025-02-09 23:48:58'),
(19, 'Instant Translation', 'translate', 'marketing', 'assets/img/notifications/translate.png', 'https://www.lobage.com/instant-translation', 'Enhance your website’s accessibility and reach a global audience with our instant translation', NULL, '{\"translate_key\":{\"title\":\"Your License Key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"XXXX-XXXXX-XXXXX-XXXXX\",\"env\":true,\"info\":\"You need to buy a plan ,and enter your license key\"}}', '1.0', NULL, 0, 1, NULL, '2025-06-29 22:17:54'),
(100, 'Paypal', 'paypal', 'gateways', 'assets/img/plugins/paypal.png', 'https://developer.paypal.com/', 'Integrate PayPal to accept secure online payments from users worldwide.\n\n', NULL, '{\n  \"client_id\": {\n    \"title\": \"Client ID\",\n    \"value\": \"\",\n    \"type\": \"input\",\n    \"placeholder\": \"Client ID\",\n    \"env\": false\n  },\n  \"secret\": {\n    \"title\": \"Secret\",\n    \"value\": \"\",\n    \"type\": \"input\",\n    \"placeholder\": \"Secret\",\n    \"env\": false\n  },\n  \"webhookId\": {\n    \"title\": \"Webhook ID\",\n    \"value\": \"\",\n    \"type\": \"input\",\n    \"placeholder\": \"Webhook ID\",\n    \"env\": false\n  },\n  \"mode\": {\n    \"title\": \"Mode\",\n    \"value\": \"sendbox\",\n    \"type\": \"select\",\n    \"options\": [\n      {\n        \"title\": \"Sendbox\",\n        \"value\": \"sendbox\"\n      },\n      {\n        \"title\": \"Live\",\n        \"value\": \"live\"\n      }\n    ]\n  }\n  ,\n    \"paypal_webhook\": {\n    \"title\": \"Webhook URL\",\n    \"route_name\": \"webhooks\",\n    \"route_params\": [\n      \"paypal\"\n    ],\n    \"type\": \"input\",\n    \"placeholder\": \"\",\n    \"env\": false,\n    \"disabled\": true,\n    \"is_route\": true,\n    \"value\": \"\"\n  }\n}', '1.0', NULL, 0, 0, NULL, '2025-04-16 06:10:19'),
(101, 'Stripe', 'stripe', 'gateways', 'assets/img/plugins/stripe.png', 'https://stripe.com/', 'Enable fast and secure payments with Stripe, supporting credit cards, wallets, and more.\r\n\r\n', NULL, '{\"secret\":{\"title\":\"Secret key\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"Secret key\",\"env\":false},\"endpoint_secret\":{\"title\":\"Signing Secret\",\"value\":\"\",\"type\":\"input\",\"placeholder\":\"Signing Secret\",\"env\":false},\"stripe_webhook\":{\"title\":\"Webhook URL\",\"route_name\":\"webhooks\",\"route_params\":[\"stripe\"],\"type\":\"input\",\"placeholder\":\"\",\"env\":false,\"disabled\":true,\"is_route\":true,\"value\":\"http:\\/\\/trashmails-saas.lobage.com\\/webhooks\\/stripe\"}}', '1.0', NULL, 0, 0, NULL, '2025-06-29 22:29:49');

-- --------------------------------------------------------

--
-- Table structure for table `sections`
--

CREATE TABLE `sections` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `title` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `position` int(11) NOT NULL DEFAULT 0,
  `type` varchar(255) DEFAULT NULL,
  `content` longtext DEFAULT NULL,
  `lang` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sections`
--

INSERT INTO `sections` (`id`, `name`, `title`, `status`, `position`, `type`, `content`, `lang`, `created_at`, `updated_at`) VALUES
(4, 'features', 'Features', 1, 1, 'theme', NULL, 'en', NULL, '2025-06-30 21:46:50'),
(5, 'faqs', 'Faqs', 1, 3, 'theme', NULL, 'en', NULL, '2025-06-30 21:46:56'),
(6, 'posts', 'Posts', 1, 4, 'theme', NULL, 'en', NULL, '2025-06-30 21:46:56'),
(13, 'get_in_touch', 'Call to action', 1, 5, 'theme', NULL, 'en', '2024-09-23 00:25:21', '2025-02-17 00:05:01'),
(14, 'plans', 'Plans', 1, 2, 'theme', NULL, 'en', '2024-09-23 00:25:21', '2025-06-30 21:46:56');

-- --------------------------------------------------------

--
-- Table structure for table `seo`
--

CREATE TABLE `seo` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `keyword` text DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `lang` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `seo`
--

INSERT INTO `seo` (`id`, `title`, `description`, `keyword`, `author`, `image`, `lang`, `created_at`, `updated_at`) VALUES
(1, 'Trash Mails', 'Trash Mails Description', 'Trash Mails,temp', 'Lobage', NULL, 'en', '2024-07-09 03:57:17', '2025-02-17 00:22:54');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `settings`
--

CREATE TABLE `settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `settings`
--

INSERT INTO `settings` (`id`, `key`, `value`, `created_at`, `updated_at`) VALUES
(1, 'site_name', 'test', NULL, '2025-06-29 22:12:46'),
(2, 'site_url', 'http://trashmails-saas.lobage.com', NULL, '2025-06-29 22:12:46'),
(3, 'logo', 'assets/themes/basic/img/logo.png?t=1740191850', NULL, '2025-02-22 02:37:30'),
(4, 'dark_logo', 'assets/themes/basic/img/dark_logo.png?t=1740191850', NULL, '2025-02-22 02:37:30'),
(5, 'favicon', 'assets/themes/basic/img/favicon.png?t=1731802180', NULL, '2024-11-17 02:09:40'),
(6, 'version', '1.0', NULL, NULL),
(7, 'theme', 'basic', NULL, NULL),
(8, 'license_key', '', NULL, NULL),
(9, 'date_format', '', NULL, NULL),
(10, 'timezone', 'Africa/Casablanca', NULL, '2025-02-08 21:54:40'),
(11, 'main_color', '#000000', NULL, NULL),
(12, 'secondary_color', '#000000', NULL, NULL),
(13, 'colors', '{\"primary_color\":\"#793ef1\",\"secondary_color\":\"#ff4d12\",\"text_color\":\"#212121\",\"background_color\":\"#f9f9f9\"}', NULL, '2025-02-22 02:36:57'),
(14, 'https_force', '0', NULL, NULL),
(15, 'enable_registration', '1', NULL, '2024-10-03 21:28:08'),
(16, 'enable_verification', '0', NULL, '2024-10-03 01:29:42'),
(17, 'enable_cookie', '1', NULL, '2025-02-16 21:56:34'),
(18, 'default_currency', 'USD', NULL, NULL),
(19, 'default_language', 'en', NULL, '2024-08-26 02:06:23'),
(20, 'mail_mailer', 'smtp', NULL, '2025-01-14 22:37:30'),
(21, 'mail_host', 'your-smtp.host', NULL, NULL),
(22, 'mail_port', '587', NULL, NULL),
(23, 'mail_username', 'smtp-username', NULL, NULL),
(24, 'mail_password', 'password', NULL, NULL),
(25, 'mail_encryption', 'ssl', NULL, '2024-07-08 21:42:40'),
(26, 'mail_from_address', 'admin@yoursite.com', NULL, '2024-10-15 01:51:51'),
(27, 'mail_from_name', 'Your Site Name', NULL, '2024-07-08 21:42:40'),
(28, 'hide_default_lang', '1', NULL, '2024-10-03 21:28:22'),
(29, 'enable_preloader', '1', NULL, NULL),
(30, 'privacy_policy', 'https://lobage.com/', NULL, '2025-02-08 21:54:40'),
(31, 'terms_of_service', 'https://lobage.com/', NULL, '2025-02-08 21:54:40'),
(32, 'cookie_policy', 'https://lobage.com/', NULL, '2025-02-08 21:54:40'),
(33, 'captcha', 'none', NULL, '2025-02-06 13:25:03'),
(34, 'captcha_login', '1', NULL, '2024-09-07 01:20:32'),
(35, 'captcha_register', '1', NULL, '2024-09-26 19:38:28'),
(36, 'captcha_contact', '1', NULL, '2024-09-24 20:58:09'),
(37, 'captcha_rest_password', '1', NULL, '2024-09-26 19:38:28'),
(38, 'captcha_admin', '0', NULL, '2025-02-04 16:47:05'),
(39, 'forbidden_ids', 'admin', NULL, '2024-12-22 03:09:20'),
(40, 'allowed_files', 'txt,sql,png,zip,jpg,pdf,doc,docx,xls,xlsx,ppt,pptx,xps,dxf,ai,psd,eps,ps,svg,ttf,rar,tar,gzip,mp3,mpeg,wav,ogg,jpeg,gif,bmp,tif,webm,mpeg4,3gpp,mov,avi,mpegs,wmv,flx', NULL, '2025-02-24 14:50:52'),
(41, 'fetch_messages', '5', NULL, '2025-02-24 14:45:13'),
(42, 'email_length', '5', NULL, '2024-10-17 01:19:23'),
(43, 'fake_emails', '0', NULL, '2024-10-17 01:19:23'),
(44, 'fake_messages', '0', NULL, '2024-10-17 01:19:23'),
(45, 'api_key', 'V5Pr7VKGZ77zDuIfYIL4XwiFrsyqdt', NULL, '2025-06-29 22:12:46'),
(46, 'time_unit', 'day', '2024-08-31 18:02:19', '2024-10-17 01:19:23'),
(47, 'email_lifetime', '5', '2024-08-31 18:02:19', '2025-02-17 02:51:30'),
(48, 'history_retention_days', '2', '2024-08-31 18:02:19', '2024-10-17 01:19:23'),
(49, 'enable_blog', '1', '2024-09-04 01:24:03', '2024-12-16 21:36:19'),
(50, 'popular_post_order_by', 'views', '2024-09-04 01:24:03', '2024-12-16 21:40:25'),
(51, 'total_popular_posts_home', '3', '2024-09-04 01:24:03', '2024-12-16 21:39:44'),
(52, 'total_posts_per_page', '6', '2024-09-04 01:24:03', '2024-12-16 21:36:48'),
(53, 'cronjob_key', 'BhmGEs1Cc6OPx1TyUGb4a2LGSZePuU', '2024-10-04 23:03:19', '2025-06-29 22:12:46'),
(54, 'cronjob_last_time', '', '2024-10-04 23:03:19', '2025-02-21 06:03:43'),
(55, 'imap_retention_days', '5', '2024-10-04 23:03:19', '2024-10-17 01:19:23'),
(56, 'mail_to_address', 'contact@gmail.com', '2024-10-04 23:03:19', '2024-10-15 01:51:51'),
(57, 'imap_messages', '42', '2024-10-13 23:42:33', '2024-10-14 21:59:16'),
(58, 'call_to_action', 'https://lobage.com/', '2024-11-04 16:10:51', '2025-02-08 21:54:40'),
(59, 'enable_api', '0', '2025-01-06 03:30:11', '2025-01-06 04:01:55'),
(60, 'is_support_expired', '0', '2025-02-06 10:24:15', '2025-02-23 21:38:39'),
(61, 'last_logo_upload', '0', '2025-02-20 00:17:00', '2025-02-20 00:17:00'),
(62, 'enable_maintenance', 'true', '2025-03-06 15:13:18', '2025-03-06 17:45:09'),
(63, 'maintenance_title', 'Site Under Maintenance', '2025-03-06 15:13:18', '2025-03-06 15:58:39'),
(64, 'maintenance_message', 'We are currently performing scheduled maintenance to improve our services. We apologize for any inconvenience this may cause and thank you for your understanding. Please check back shortly!', '2025-03-06 15:13:18', '2025-03-06 15:58:39'),
(65, 'currency_code', 'USD', '2025-03-06 15:13:18', '2025-04-29 18:53:30'),
(66, 'currency_symbol', '$', '2025-03-06 15:13:18', '2025-04-29 13:06:18'),
(67, 'user_plan_expiry_reminder', '10', '2025-03-06 15:13:18', '2025-04-25 21:21:46'),
(68, 'auto_delete_unverified_users', '10', '2025-03-06 15:13:18', '2025-04-25 21:21:46'),
(69, 'default_plan', 'none', '2025-03-06 15:13:18', '2025-04-25 21:21:55');

-- --------------------------------------------------------

--
-- Table structure for table `statistics`
--

CREATE TABLE `statistics` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `key` varchar(255) NOT NULL,
  `value` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `taxes`
--

CREATE TABLE `taxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `country` varchar(255) NOT NULL,
  `rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `themes`
--

CREATE TABLE `themes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `unique_name` varchar(255) NOT NULL,
  `logo` varchar(255) DEFAULT NULL,
  `dark_logo` varchar(255) DEFAULT NULL,
  `favicon` varchar(255) DEFAULT NULL,
  `version` varchar(255) DEFAULT NULL,
  `demo` varchar(255) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `custom_css` longtext DEFAULT NULL,
  `custom_js` longtext DEFAULT NULL,
  `colors` longtext DEFAULT NULL,
  `images` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `themes`
--

INSERT INTO `themes` (`id`, `name`, `unique_name`, `logo`, `dark_logo`, `favicon`, `version`, `demo`, `description`, `image`, `status`, `custom_css`, `custom_js`, `colors`, `images`, `created_at`, `updated_at`) VALUES
(1, 'Basic', 'basic', 'assets/themes/basic/img/logo.png?t=1740191850', 'assets/themes/basic/img/dark_logo.png?t=1740191850', 'assets/themes/basic/img/favicon.png?t=1731802180', '1.0', NULL, 'Basic Theme', 'https://ik.imagekit.io/FiverrQuickView/trashmails.webp', 1, NULL, NULL, '{\"primary_color\":\"#793ef1\",\"primary_opacity\":\"#44189a\",\"secondary_color\":\"#ff4d12\",\"text_color\":\"#212121\",\"background_color\":\"#f9f9f9\",\"footer_background_color\":\"#192132\",\"secondary_text_color\":\"#ffffff\"}', NULL, NULL, '2025-02-24 14:27:12');

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `plan_id` int(10) UNSIGNED NOT NULL,
  `payment_id` varchar(255) DEFAULT NULL,
  `transaction_id` varchar(255) DEFAULT NULL,
  `payer_id` varchar(255) DEFAULT NULL,
  `gateway` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `plan_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `coupon_code` varchar(255) DEFAULT NULL,
  `fees` decimal(10,2) NOT NULL DEFAULT 0.00,
  `currency` varchar(3) DEFAULT NULL,
  `interval` varchar(255) DEFAULT NULL COMMENT 'e.g., month, year, one-time',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: Pending, 1: Completed, 2: Failed, 3: Refunded',
  `tax_name` varchar(255) DEFAULT NULL,
  `tax_rate` decimal(5,2) NOT NULL DEFAULT 0.00,
  `tax_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_proof` varchar(255) DEFAULT NULL COMMENT 'e.g., path to bank transfer receipt',
  `ip_address` varchar(45) DEFAULT NULL,
  `cancellation_reason` text DEFAULT NULL,
  `payment_link` varchar(255) DEFAULT NULL,
  `paid_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transactions`
--


-- --------------------------------------------------------

--
-- Table structure for table `translates`
--

CREATE TABLE `translates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `collection` varchar(255) NOT NULL DEFAULT 'general',
  `key` text NOT NULL,
  `value` longtext DEFAULT NULL,
  `type` tinyint(1) NOT NULL DEFAULT 0,
  `lang` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `translates`
--



INSERT INTO `translates` (`id`, `collection`, `key`, `value`, `type`, `lang`, `created_at`, `updated_at`) VALUES
(1, 'general', 'New', 'New', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(2, 'general', 'Back', 'Back', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(3, 'general', 'Save', 'Save', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(4, 'general', 'Delete Item', 'Delete Item', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(5, 'general', 'Are you sure you want to delete this item? This action cannot be undone', 'Are you sure you want to delete this item? This action cannot be undone', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(6, 'general', 'Cancel', 'Cancel', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(7, 'general', 'Delete', 'Delete', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(8, 'general', 'Unauthorized', 'Unauthorized', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(9, 'general', 'Sorry, you are not authorized to access this page.', 'Sorry, you are not authorized to access this page.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(10, 'general', 'Payment Required', 'Payment Required', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(11, 'general', 'Payment is required to access this resource.', 'Payment is required to access this resource.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(12, 'general', 'Forbidden', 'Forbidden', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(13, 'general', 'Sorry, you do not have permission to access this page.', 'Sorry, you do not have permission to access this page.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(14, 'general', 'Not Found', 'Not Found', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(15, 'general', 'The page you are looking for could not be found.', 'The page you are looking for could not be found.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(16, 'general', 'Page Expired', 'Page Expired', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(17, 'general', 'The page has expired. Please refresh and try again.', 'The page has expired. Please refresh and try again.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(18, 'general', 'Too Many Requests', 'Too Many Requests', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(19, 'general', 'You have made too many requests. Please wait and try again later.', 'You have made too many requests. Please wait and try again later.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(20, 'general', 'Server Error', 'Server Error', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(21, 'general', 'Whoops, something went wrong on our servers.', 'Whoops, something went wrong on our servers.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(22, 'general', 'Service Unavailable', 'Service Unavailable', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(23, 'general', 'The service is currently unavailable. Please try again later.', 'The service is currently unavailable. Please try again later.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(24, 'general', 'Go Home', 'Go Home', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(25, 'general', 'Search Results for', 'Search Results for', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(26, 'general', 'Blog', 'Blog', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(27, 'general', 'No results found for', 'No results found for', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(28, 'general', 'No posts available.', 'No posts available.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(29, 'general', 'Published on', 'Published on', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(30, 'general', 'Category', 'Category', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(31, 'general', 'views', 'views', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(32, 'general', 'Tags:', 'Tags:', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(33, 'general', 'Check this out!', 'Check this out!', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(34, 'general', 'Share this page', 'Share this page', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(35, 'general', 'Facebook', 'Facebook', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(36, 'general', 'Twitter', 'Twitter', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(37, 'general', 'LinkedIn', 'LinkedIn', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(38, 'general', 'WhatsApp', 'WhatsApp', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(39, 'general', 'Email', 'Email', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(40, 'general', 'Comments:', 'Comments:', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(41, 'general', 'Please enable JavaScript to view the comments', 'Please enable JavaScript to view the comments', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(42, 'general', 'Search...', 'Search...', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(43, 'general', 'Popular Posts', 'Popular Posts', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(44, 'general', 'Categories', 'Categories', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(45, 'general', 'Contact Us', 'Contact Us', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(46, 'general', 'Contact Title', 'Get in Touch with Our Team', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:36:25'),
(47, 'general', 'Contact Description', 'Need help or have a question? Our support team is ready to assist you! Contact us now and we’ll respond quickly to ensure you get the help you need.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:36:25'),
(48, 'general', 'Full Name', 'Full Name', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(49, 'general', 'Subject', 'Subject', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(50, 'general', 'Message', 'Message', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(51, 'general', 'Send Your Message', 'Send Your Message', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(52, 'html', 'Contact Us Content', 'Contact Us Content', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(53, 'general', 'landing', 'landing', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(54, 'general', 'Not found emails with', 'Not found emails with', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(55, 'general', 'History is empty', 'History is empty', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(56, 'general', 'Active', 'Active', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(57, 'general', 'Current', 'Current', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(58, 'general', 'Choose', 'Choose', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(59, 'alerts', 'The Email has been successfully updated', 'The Email has been successfully updated', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(60, 'alerts', 'The Email has been removed', 'The Email has been removed', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(61, 'general', 'Remove from favorites', 'Remove from favorites', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(62, 'general', 'Add to favorites', 'Add to favorites', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(63, 'general', 'Please Wait', 'Please Wait', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(64, 'alerts', 'Too many requests, Please slow down', 'Too many requests, Please slow down', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(65, 'general', 'Error', 'Error', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(66, 'general', 'Success', 'Success', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(67, 'general', 'Do you accept cookies?', 'Do you accept cookies?', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(68, 'general', 'We use cookies to enhance your browsing experience. By using this site, you consent to our cookie policy.', 'We use cookies to enhance your browsing experience. By using this site, you consent to our cookie policy.', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(69, 'general', 'I Accept', 'I Accept', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(70, 'general', 'More', 'More', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(71, 'general', 'copyright', '{{site_name}} © {{copyright_year}} – All Rights Reserved', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:36:25'),
(72, 'general', 'Dashboard', 'Dashboard', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(73, 'general', 'Register', 'Register', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(74, 'general', 'Login', 'Login', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(75, 'general', 'Change Email', 'Change Email', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(76, 'general', 'Email Alias', 'Email Alias', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(77, 'general', 'Random Name', 'Random Name', 0, 'en', '2025-07-04 04:29:22', '2025-07-04 04:29:22'),
(78, 'general', 'Domain', 'Domain', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(79, 'general', 'My Domains', 'My Domains', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(80, 'general', 'Premium Domains', 'Premium Domains', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(81, 'general', 'Free Domains', 'Free Domains', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(82, 'general', 'Update Email Address', 'Update Email Address', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(83, 'general', 'Faqs', 'Faqs', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(84, 'general', 'Faqs Title', 'Frequently Asked Questions', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(85, 'general', 'Faqs Description', 'Find answers to common questions about our temporary email service and how to use it effectively', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(86, 'general', 'Features', 'Features', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(87, 'general', 'Features Title', 'Why Choose Our Temp Mail?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(88, 'general', 'Features Description', 'Explore the features that make our temporary email service fast, secure, and easy to use', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(89, 'general', 'Sign Up Now', 'Ready to Take Back Control?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(90, 'general', 'Sign Up to Get Access to Exclusive Features', 'Create your free, disposable email address in seconds. No strings attached.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(91, 'general', 'Register Now', 'Get Your Free Inbox Now', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(92, 'general', 'Email History', 'Email History', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(93, 'general', 'View your email history', 'View your email history', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(94, 'general', 'Type to search ... ', 'Type to search ...', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(95, 'general', 'Emails in History', 'Emails in History', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(96, 'general', 'Homepage Title', 'Get a free, temporary, anonymous, and secure email at {{site_name}}', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(97, 'general', 'Homepage first description', 'Get a free, anonymous, and disposable email address to protect your personal inbox from spam, data breaches, and unwanted newsletters.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(98, 'general', 'Refresh', 'Refresh', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(99, 'general', 'QR Code', 'QR Code', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(100, 'general', 'History', 'History', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(101, 'general', 'Change', 'Change', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(102, 'general', 'Homepage second description', 'Say goodbye to spam, unwanted ads, data breaches, and bots. Keep your personal inbox safe and clutter-free. Trash Mails gives you a free, secure, anonymous, and disposable email address instantly.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(103, 'general', 'Emails Created', 'Emails Created', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(104, 'general', 'Messages Received', 'Messages Received', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(105, 'general', 'MailBox', 'MailBox', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(106, 'general', 'MailBox Title', 'Your Live Mailbox', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(107, 'general', 'MailBox Description', 'Emails sent to your temporary address will show up here instantly.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(108, 'general', 'Sender', 'Sender', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(109, 'general', 'Time', 'Time', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(110, 'general', 'Your inbox is empty', 'Your inbox is empty', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(111, 'general', 'Waiting for incoming emails', 'Waiting for incoming emails', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(112, 'general', 'Need to save email address, custom domain and more ?', 'Need to save email address, custom domain and more ?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(113, 'general', 'Plans', 'Plans', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(114, 'general', 'Plans Title', 'Find the Plan That\'s Right For You', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:37:35'),
(115, 'general', 'Plans Description', 'Start for free, and upgrade anytime for more power and permanent features', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:37:35'),
(116, 'general', 'Monthly', 'Monthly', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(117, 'general', 'Yearly', 'Yearly', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(118, 'general', 'Lifetime', 'Lifetime', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(119, 'general', 'Special Offers', 'Special Offers', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(120, 'plans', 'Free', 'Free', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(121, 'general', 'Get Started', 'Get Started', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(122, 'general', 'Unlimited', 'Unlimited', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(123, 'general', 'Start free trial', 'Start free trial', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(124, 'general', 'Popular Posts Text', 'Our Latest News', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(125, 'general', 'Popular Posts Description ', 'Explore our latest articles to learn more about staying safe and anonymous online', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(126, 'general', 'Scan the QR Code', 'Scan the QR Code', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(127, 'general', 'Use this QR code to quickly open your inbox on any compatible device', 'Use this QR code to quickly open your inbox on any compatible device', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(128, 'general', 'Back to Inbox', 'Back to Inbox', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(129, 'general', 'Back To Home', 'Back To Home', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(130, 'general', 'Delete Message', 'Delete Message', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(131, 'general', 'Upgrade to download attachments', 'Upgrade to download attachments', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(132, 'general', 'Upgrade', 'Upgrade', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(133, 'general', 'Sign up to download attachments', 'Sign up to download attachments', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(134, 'general', 'Download', 'Download', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(135, 'auth', 'Welcome Back!', 'Welcome Back!', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(136, 'auth', 'Please log in to your account to continue.', 'Please log in to your account to continue.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(137, 'auth', 'Email Address', 'Email Address', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(138, 'auth', 'Password', 'Password', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(139, 'auth', 'Remember Me', 'Remember Me', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(140, 'auth', 'Forgot Password?', 'Forgot Password?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(141, 'auth', 'Log In', 'Log In', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(142, 'auth', 'Or log in with', 'Or log in with', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(143, 'auth', 'Continue with Facebook', 'Continue with Facebook', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(144, 'auth', 'Continue with Google', 'Continue with Google', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(145, 'auth', 'Don’t have an account?', 'Don’t have an account?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(146, 'auth', 'Sign up now', 'Sign up now', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(147, 'auth', 'Reset Your Password', 'Reset Your Password', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(148, 'auth', 'Please enter your email address and new password.', 'Please enter your email address and new password.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(149, 'auth', 'New Password', 'New Password', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(150, 'auth', 'Confirm New Password', 'Confirm New Password', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(151, 'auth', 'Update Password', 'Update Password', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(152, 'auth', 'Create Your Account', 'Create Your Account', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(153, 'auth', 'Please fill in the details below to create your account.', 'Please fill in the details below to create your account.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(154, 'auth', 'First Name', 'First Name', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(155, 'auth', 'Last Name', 'Last Name', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(156, 'auth', 'Register', 'Register', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(157, 'auth', 'Or sign up with', 'Or sign up with', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(158, 'auth', 'Already have an account?', 'Already have an account?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(159, 'auth', 'Log in here', 'Log in here', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(160, 'auth', 'sign up agreement', 'By creating an account you agree to our {{terms}}  and {{privacy}}', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(161, 'auth', 'Terms of Service', 'Terms of Service', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(162, 'auth', 'Privacy Policy', 'Privacy Policy', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(163, 'auth', 'Enter your email address and we will send you a link to reset your password.', 'Enter your email address and we will send you a link to reset your password.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(164, 'auth', 'Send Password Reset Link', 'Send Password Reset Link', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(165, 'auth', 'Remembered your password?', 'Remembered your password?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(166, 'auth', 'Email Verification Required', 'Email Verification Required', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(167, 'auth', 'Please verify your email address to continue.', 'Please verify your email address to continue.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(168, 'auth', 'A fresh verification link has been sent to your email address.', 'A fresh verification link has been sent to your email address.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(169, 'auth', 'Didn’t receive the email?', 'Didn’t receive the email?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(170, 'auth', 'request another', 'request another', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(171, 'auth', 'You want to ', 'You want to', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(172, 'auth', 'logout?', 'logout?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(173, 'general', 'Checkout', 'Checkout', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(174, 'general', 'Account information', 'Account information', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(175, 'auth', 'Email', 'Email', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(176, 'general', 'Payment Methods', 'Payment Methods', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(177, 'general', 'Order Summary', 'Order Summary', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(178, 'general', 'Plan', 'Plan', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(179, 'general', 'Interval', 'Interval', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(180, 'general', 'Price', 'Price', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(181, 'fantastic', 'Discount', 'Discount', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(182, 'fantastic', 'VAT', 'VAT', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(183, 'fantastic', 'Discount Code', 'Discount Code', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(184, 'fantastic', 'Submit', 'Submit', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(185, 'general', 'Have a discount code?', 'Have a discount code?', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(186, 'general', 'Checkout btn', 'Checkout btn', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(187, 'general', 'Checkout Policy', 'Checkout Policy', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(188, 'auth', 'Refund Policy', 'Refund Policy', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(189, 'general', 'Popular', 'Popular', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(190, 'general', 'Forever', 'Forever', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(191, 'general', 'Choose Plan', 'Choose Plan', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(192, 'general', 'Subscribe Now', 'Subscribe Now', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(193, 'general', 'Renew', 'Renew', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(194, 'general', 'Change Plan', 'Change Plan', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(195, 'general', 'Plan Name', 'Plan Name', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(196, 'general', 'Trial Ends At', 'Trial Ends At', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(197, 'general', 'Subscription expiration date', 'Subscription expiration date', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(198, 'general', 'Recent Transactions', 'Recent Transactions', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(199, 'general', 'Transaction ID', 'Transaction ID', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(200, 'general', 'Plan (Interval)', 'Plan (Interval)', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(201, 'general', 'Amount', 'Amount', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(202, 'general', 'Payment Method', 'Payment Method', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(203, 'general', 'Date', 'Date', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(204, 'general', 'Status', 'Status', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(205, 'general', 'Showing', 'Showing', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(206, 'general', 'to', 'to', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(207, 'general', 'of', 'of', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(208, 'general', 'entries', 'entries', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(209, 'general', 'Processing Your Payment', 'Processing Your Payment', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(210, 'general', 'Please wait while we securely confirm your payment. This should only take a moment.', 'Please wait while we securely confirm your payment. This should only take a moment.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(211, 'general', 'You will be redirected automatically once completed.', 'You will be redirected automatically once completed.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(212, 'general', 'Preparing your payment...', 'Preparing your payment...', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(213, 'general', 'Favorite Messages', 'Favorite Messages', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(214, 'general', 'Domains', 'Domains', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(215, 'general', 'Emails Created By You', 'Emails Created By You', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(216, 'general', 'Last Email History', 'Last Email History', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(217, 'general', 'Add New Domain', 'Add New Domain', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(218, 'general', 'Domain Name', 'Domain Name', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(219, 'general', 'Add Domain Without ', 'Add Domain Without', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(220, 'html', 'How To Setup A Custom Domain', 'How To Setup A Custom Domain', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(221, 'general', 'Created At', 'Created At', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(222, 'general', 'Actions', 'Actions', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(223, 'general', 'No Domains Available', 'No Domains Available', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(224, 'general', 'It looks like there are no domains to display. Please check back later.', 'It looks like there are no domains to display. Please check back later.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(225, 'general', 'Initializing payment process...', 'Initializing payment process...', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(226, 'general', 'Contacting secure server...', 'Contacting secure server...', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(227, 'general', 'Verifying your information...', 'Verifying your information...', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(228, 'general', 'Processing payment...', 'Processing payment...', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(229, 'general', 'Finalizing transaction...', 'Finalizing transaction...', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(230, 'general', 'Redirecting to your billing page...', 'Redirecting to your billing page...', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(231, 'general', 'Messages', 'Messages', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(232, 'general', 'From', 'From', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(233, 'general', 'received At', 'received At', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(234, 'general', 'Crafted with', 'Crafted with ❤️ by {{site_name}}', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:36:25'),
(235, 'general', 'Account Settings', 'Account Settings', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(236, 'general', 'Logout', 'Logout', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(237, 'general', 'Billing', 'Billing', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(238, 'general', 'My Inbox', 'My Inbox', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(239, 'general', 'Settings', 'Settings', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(240, 'auth', 'Profile', 'Profile', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(241, 'auth', 'Avatar', 'Avatar', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(242, 'auth', 'Click to Upload', 'Click to Upload', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(243, 'auth', 'Security', 'Security', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(244, 'auth', 'Current Password', 'Current Password', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(245, 'auth', 'Confirm Password', 'Confirm Password', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(246, 'general', 'es', 'es', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(247, 'seo', 'Blog', 'Blog', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(248, 'seo', 'Billing', 'Billing', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(249, 'seo', 'Plans', 'Plans', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(250, 'alerts', 'You are currently using more domains than allowed in the selected plan. Please delete some domains before switching.', 'You are currently using more domains than allowed in the selected plan. Please delete some domains before switching.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(251, 'alerts', 'You are currently using more favorite messages than allowed in the selected plan. Please delete some messages before switching.', 'You are currently using more favorite messages than allowed in the selected plan. Please delete some messages before switching.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(252, 'alerts', 'You have successfully subscribed', 'You have successfully subscribed', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(253, 'alerts', 'You are already subscribed to the free plan', 'You are already subscribed to the free plan', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(254, 'alerts', 'No payment method available at the moment', 'No payment method available at the moment', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(255, 'alerts', 'Please Complete your Profile', 'Please Complete your Profile', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(256, 'alerts', 'An unexpected error occurred', 'An unexpected error occurred', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(257, 'fantastic', 'Checkout', 'Checkout', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(258, 'seo', 'Processing Your Payment', 'Processing Your Payment', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(259, 'seo', 'Contact Us', 'Contact Us', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(260, 'alerts', 'Thank you for reaching out to us! Your message has been received, and we will get back to you shortly', 'Thank you for reaching out to us! Your message has been received, and we will get back to you shortly', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(261, 'general', 'Cron Job executed successfully', 'Cron Job executed successfully', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(262, 'general', 'Welcome back,{{user}} 👋', 'Welcome back,{{user}} 👋', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(263, 'seo', 'Dashboard', 'Dashboard', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(264, 'seo', 'Domains', 'Domains', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(265, 'seo', 'Add New Domain', 'Add New Domain', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(266, 'alerts', 'You do not have access,Please upgrade your account', 'You do not have access,Please upgrade your account', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(267, 'alerts', 'The domain has been added successfully', 'The domain has been added successfully', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(268, 'alerts', 'The domain has been deleted successfully', 'The domain has been deleted successfully', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(269, 'seo', 'Messages', 'Messages', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(270, 'alerts', 'The Message removed successfully from Favorite', 'The Message removed successfully from Favorite', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(271, 'alerts', 'You have reached the limit for favoriting messages', 'You have reached the limit for favoriting messages', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(272, 'alerts', 'The Message added successfully to Favorite.', 'The Message added successfully to Favorite.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(273, 'alerts', 'An error occurred. Please reload the page and try again', 'An error occurred. Please reload the page and try again', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(274, 'alerts', 'Please log in to continue', 'Please log in to continue', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(275, 'alerts', 'The message has been deleted successfully', 'The message has been deleted successfully', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(276, 'seo', 'Profile', 'Profile', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(277, 'alerts', 'Your profile has been updated successfully!', 'Your profile has been updated successfully!', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(278, 'alerts', 'Current password does not match!', 'Current password does not match!', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(279, 'alerts', 'Your Password has been updated successfully!', 'Your Password has been updated successfully!', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(280, 'alerts', 'Recaptcha verification failed, please try again later', 'Recaptcha verification failed, please try again later', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(281, 'alerts', 'Captcha response is missing, please try again', 'Captcha response is missing, please try again', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(282, 'alerts', 'Something went wrong please try again', 'Something went wrong please try again', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(283, 'alerts', 'please try again', 'please try again', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(284, 'alerts', 'Your account has been suspended or banned. Please contact support for further assistance.', 'Your account has been suspended or banned. Please contact support for further assistance.', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(285, 'alerts', 'We could not complete the process, please try again letter', 'We could not complete the process, please try again letter', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(286, 'alerts', 'Coupon code is invalid', 'Coupon code is invalid', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(287, 'alerts', 'Discount code is required', 'Discount code is required', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(288, 'alerts', 'Coupon usage limit has been reached', 'Coupon usage limit has been reached', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(289, 'alerts', 'The coupon has expired', 'The coupon has expired', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(290, 'general', 'Draft', 'Draft', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(291, 'general', 'Published', 'Published', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(292, 'general', 'Complete', 'Complete', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(293, 'general', 'Pending', 'Pending', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(294, 'general', 'Canceled', 'Canceled', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(295, 'general', 'Rejected', 'Rejected', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(296, 'general', 'Subscribed', 'Subscribed', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(297, 'general', 'Not Subscribed', 'Not Subscribed', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(298, 'general', 'Inactive', 'Inactive', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(299, 'general', 'Approved', 'Approved', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(300, 'general', 'Unknown', 'Unknown', 0, 'en', '2025-07-04 04:29:23', '2025-07-04 04:29:23'),
(301, 'plans', 'Free Plan', 'Free Plan', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(302, 'plans', 'Great for quick and anonymous email use with limited access', 'Great for quick and anonymous email use with limited access', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(303, 'plans', 'Custom domains', 'Custom domains', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(304, 'plans', 'History size', 'History size', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(305, 'plans', 'Favorite Messages', 'Favorite Messages', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(306, 'plans', 'No Ads', 'No Ads', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(307, 'plans', 'See Attachments', 'See Attachments', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(308, 'plans', 'Premium Domains', 'Premium Domains', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(309, 'plans', 'Basic Plan', 'Basic Plan', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(310, 'plans', 'A solid step up with more features, fewer limitations, and a smoother experience', 'A solid step up with more features, fewer limitations, and a smoother experience', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(311, 'plans', 'Pro Plan', 'Pro Plan', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(312, 'plans', 'Full access to premium features, power, and flexibility', 'Full access to premium features, power, and flexibility', 0, 'en', '2025-07-04 04:29:48', '2025-07-04 04:40:01'),
(313, 'alerts', 'Updated successfully', 'Updated successfully', 0, 'en', '2025-07-04 04:36:25', '2025-07-04 04:40:01'),
(314, 'alerts', 'Deleted successfully.', 'Deleted successfully.', 0, 'en', '2025-07-04 04:36:26', '2025-07-04 04:40:01'),
(315, 'alerts', 'Added successfully', 'Added successfully', 0, 'en', '2025-07-04 04:36:26', '2025-07-04 04:40:01'),
(316, 'alerts', 'These credentials do not match our records.', 'These credentials do not match our records.', 0, 'en', '2025-07-04 04:48:40', '2025-07-04 04:48:40'),
(317, 'alerts', 'The provided password is incorrect.', 'The provided password is incorrect.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(318, 'alerts', 'Too many login attempts. Please try again in :seconds seconds.', 'Too many login attempts. Please try again in :seconds seconds.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(319, 'alerts', 'Your password has been reset.', 'Your password has been reset.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(320, 'alerts', 'We have emailed your password reset link.', 'We have emailed your password reset link.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(321, 'alerts', 'Please wait before retrying.', 'Please wait before retrying.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(322, 'alerts', 'This password reset token is invalid.', 'This password reset token is invalid.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(323, 'general', 'We can', 'We can', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(324, 'validation', 'The :attribute field must be accepted.', 'The :attribute field must be accepted.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(325, 'validation', 'The :attribute field must be accepted when :other is :value.', 'The :attribute field must be accepted when :other is :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(326, 'validation', 'The :attribute field must be a valid URL.', 'The :attribute field must be a valid URL.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(327, 'validation', 'The :attribute field must be a date after :date.', 'The :attribute field must be a date after :date.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(328, 'validation', 'The :attribute field must be a date after or equal to :date.', 'The :attribute field must be a date after or equal to :date.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(329, 'validation', 'The :attribute field must only contain letters.', 'The :attribute field must only contain letters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(330, 'validation', 'The :attribute field must only contain letters, numbers, dashes, and underscores.', 'The :attribute field must only contain letters, numbers, dashes, and underscores.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(331, 'validation', 'The :attribute field must only contain letters and numbers.', 'The :attribute field must only contain letters and numbers.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(332, 'validation', 'The :attribute field must be an array.', 'The :attribute field must be an array.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(333, 'validation', 'The :attribute field must only contain single-byte alphanumeric characters and symbols.', 'The :attribute field must only contain single-byte alphanumeric characters and symbols.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(334, 'validation', 'The :attribute field must be a date before :date.', 'The :attribute field must be a date before :date.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(335, 'validation', 'The :attribute field must be a date before or equal to :date.', 'The :attribute field must be a date before or equal to :date.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(336, 'validation', 'The :attribute field must have between :min and :max items.', 'The :attribute field must have between :min and :max items.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(337, 'validation', 'The :attribute field must be between :min and :max kilobytes.', 'The :attribute field must be between :min and :max kilobytes.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(338, 'validation', 'The :attribute field must be between :min and :max.', 'The :attribute field must be between :min and :max.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(339, 'validation', 'The :attribute field must be between :min and :max characters.', 'The :attribute field must be between :min and :max characters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(340, 'validation', 'The :attribute field must be true or false.', 'The :attribute field must be true or false.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(341, 'validation', 'The :attribute field contains an unauthorized value.', 'The :attribute field contains an unauthorized value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(342, 'validation', 'The :attribute field confirmation does not match.', 'The :attribute field confirmation does not match.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(343, 'validation', 'The :attribute field is missing a required value.', 'The :attribute field is missing a required value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(344, 'validation', 'The password is incorrect.', 'The password is incorrect.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(345, 'validation', 'The :attribute field must be a valid date.', 'The :attribute field must be a valid date.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(346, 'validation', 'The :attribute field must be a date equal to :date.', 'The :attribute field must be a date equal to :date.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(347, 'validation', 'The :attribute field must match the format :format.', 'The :attribute field must match the format :format.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(348, 'validation', 'The :attribute field must have :decimal decimal places.', 'The :attribute field must have :decimal decimal places.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(349, 'validation', 'The :attribute field must be declined.', 'The :attribute field must be declined.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(350, 'validation', 'The :attribute field must be declined when :other is :value.', 'The :attribute field must be declined when :other is :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(351, 'validation', 'The :attribute field and :other must be different.', 'The :attribute field and :other must be different.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(352, 'validation', 'The :attribute field must be :digits digits.', 'The :attribute field must be :digits digits.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(353, 'validation', 'The :attribute field must be between :min and :max digits.', 'The :attribute field must be between :min and :max digits.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(354, 'validation', 'The :attribute field has invalid image dimensions.', 'The :attribute field has invalid image dimensions.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(355, 'validation', 'The :attribute field has a duplicate value.', 'The :attribute field has a duplicate value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(356, 'validation', 'The :attribute field must not end with one of the following: :values.', 'The :attribute field must not end with one of the following: :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(357, 'validation', 'The :attribute field must not start with one of the following: :values.', 'The :attribute field must not start with one of the following: :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(358, 'validation', 'The :attribute field must be a valid email address.', 'The :attribute field must be a valid email address.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(359, 'validation', 'The :attribute field must end with one of the following: :values.', 'The :attribute field must end with one of the following: :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(360, 'validation', 'The selected :attribute is invalid.', 'The selected :attribute is invalid.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(361, 'validation', 'The :attribute field must have one of the following extensions: :values.', 'The :attribute field must have one of the following extensions: :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(362, 'validation', 'The :attribute field must be a file.', 'The :attribute field must be a file.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(363, 'validation', 'The :attribute field must have a value.', 'The :attribute field must have a value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(364, 'validation', 'The :attribute field must have more than :value items.', 'The :attribute field must have more than :value items.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(365, 'validation', 'The :attribute field must be greater than :value kilobytes.', 'The :attribute field must be greater than :value kilobytes.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(366, 'validation', 'The :attribute field must be greater than :value.', 'The :attribute field must be greater than :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(367, 'validation', 'The :attribute field must be greater than :value characters.', 'The :attribute field must be greater than :value characters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(368, 'validation', 'The :attribute field must have :value items or more.', 'The :attribute field must have :value items or more.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(369, 'validation', 'The :attribute field must be greater than or equal to :value kilobytes.', 'The :attribute field must be greater than or equal to :value kilobytes.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(370, 'validation', 'The :attribute field must be greater than or equal to :value.', 'The :attribute field must be greater than or equal to :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(371, 'validation', 'The :attribute field must be greater than or equal to :value characters.', 'The :attribute field must be greater than or equal to :value characters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(372, 'validation', 'The :attribute field must be a valid hexadecimal color.', 'The :attribute field must be a valid hexadecimal color.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(373, 'validation', 'The :attribute field must be an image.', 'The :attribute field must be an image.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(374, 'validation', 'The :attribute field must exist in :other.', 'The :attribute field must exist in :other.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(375, 'validation', 'The :attribute field must be an integer.', 'The :attribute field must be an integer.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(376, 'validation', 'The :attribute field must be a valid IP address.', 'The :attribute field must be a valid IP address.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(377, 'validation', 'The :attribute field must be a valid IPv4 address.', 'The :attribute field must be a valid IPv4 address.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(378, 'validation', 'The :attribute field must be a valid IPv6 address.', 'The :attribute field must be a valid IPv6 address.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(379, 'validation', 'The :attribute field must be a valid JSON string.', 'The :attribute field must be a valid JSON string.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41');
INSERT INTO `translates` (`id`, `collection`, `key`, `value`, `type`, `lang`, `created_at`, `updated_at`) VALUES
(380, 'validation', 'The :attribute field must be a list.', 'The :attribute field must be a list.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(381, 'validation', 'The :attribute field must be lowercase.', 'The :attribute field must be lowercase.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(382, 'validation', 'The :attribute field must have less than :value items.', 'The :attribute field must have less than :value items.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(383, 'validation', 'The :attribute field must be less than :value kilobytes.', 'The :attribute field must be less than :value kilobytes.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(384, 'validation', 'The :attribute field must be less than :value.', 'The :attribute field must be less than :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(385, 'validation', 'The :attribute field must be less than :value characters.', 'The :attribute field must be less than :value characters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(386, 'validation', 'The :attribute field must not have more than :value items.', 'The :attribute field must not have more than :value items.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(387, 'validation', 'The :attribute field must be less than or equal to :value kilobytes.', 'The :attribute field must be less than or equal to :value kilobytes.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(388, 'validation', 'The :attribute field must be less than or equal to :value.', 'The :attribute field must be less than or equal to :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(389, 'validation', 'The :attribute field must be less than or equal to :value characters.', 'The :attribute field must be less than or equal to :value characters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(390, 'validation', 'The :attribute field must be a valid MAC address.', 'The :attribute field must be a valid MAC address.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(391, 'validation', 'The :attribute field must not have more than :max items.', 'The :attribute field must not have more than :max items.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(392, 'validation', 'The :attribute field must not be greater than :max kilobytes.', 'The :attribute field must not be greater than :max kilobytes.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(393, 'validation', 'The :attribute field must not be greater than :max.', 'The :attribute field must not be greater than :max.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(394, 'validation', 'The :attribute field must not be greater than :max characters.', 'The :attribute field must not be greater than :max characters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(395, 'validation', 'The :attribute field must not have more than :max digits.', 'The :attribute field must not have more than :max digits.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(396, 'validation', 'The :attribute field must be a file of type: :values.', 'The :attribute field must be a file of type: :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(397, 'validation', 'The :attribute field must have at least :min items.', 'The :attribute field must have at least :min items.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(398, 'validation', 'The :attribute field must be at least :min kilobytes.', 'The :attribute field must be at least :min kilobytes.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(399, 'validation', 'The :attribute field must be at least :min.', 'The :attribute field must be at least :min.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(400, 'validation', 'The :attribute field must be at least :min characters.', 'The :attribute field must be at least :min characters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(401, 'validation', 'The :attribute field must have at least :min digits.', 'The :attribute field must have at least :min digits.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(402, 'validation', 'The :attribute field must be missing.', 'The :attribute field must be missing.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(403, 'validation', 'The :attribute field must be missing when :other is :value.', 'The :attribute field must be missing when :other is :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(404, 'validation', 'The :attribute field must be missing unless :other is :value.', 'The :attribute field must be missing unless :other is :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(405, 'validation', 'The :attribute field must be missing when :values is present.', 'The :attribute field must be missing when :values is present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(406, 'validation', 'The :attribute field must be missing when :values are present.', 'The :attribute field must be missing when :values are present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(407, 'validation', 'The :attribute field must be a multiple of :value.', 'The :attribute field must be a multiple of :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(408, 'validation', 'The :attribute field format is invalid.', 'The :attribute field format is invalid.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(409, 'validation', 'The :attribute field must be a number.', 'The :attribute field must be a number.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(410, 'validation', 'The :attribute field must contain at least one letter.', 'The :attribute field must contain at least one letter.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(411, 'validation', 'The :attribute field must contain at least one uppercase and one lowercase letter.', 'The :attribute field must contain at least one uppercase and one lowercase letter.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(412, 'validation', 'The :attribute field must contain at least one number.', 'The :attribute field must contain at least one number.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(413, 'validation', 'The :attribute field must contain at least one symbol.', 'The :attribute field must contain at least one symbol.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(414, 'validation', 'The given :attribute has appeared in a data leak. Please choose a different :attribute.', 'The given :attribute has appeared in a data leak. Please choose a different :attribute.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(415, 'validation', 'The :attribute field must be present.', 'The :attribute field must be present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(416, 'validation', 'The :attribute field must be present when :other is :value.', 'The :attribute field must be present when :other is :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(417, 'validation', 'The :attribute field must be present unless :other is :value.', 'The :attribute field must be present unless :other is :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(418, 'validation', 'The :attribute field must be present when :values is present.', 'The :attribute field must be present when :values is present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(419, 'validation', 'The :attribute field must be present when :values are present.', 'The :attribute field must be present when :values are present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(420, 'validation', 'The :attribute field is prohibited.', 'The :attribute field is prohibited.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(421, 'validation', 'The :attribute field is prohibited when :other is :value.', 'The :attribute field is prohibited when :other is :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(422, 'validation', 'The :attribute field is prohibited unless :other is in :values.', 'The :attribute field is prohibited unless :other is in :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(423, 'validation', 'The :attribute field prohibits :other from being present.', 'The :attribute field prohibits :other from being present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(424, 'validation', 'The :attribute field is required.', 'The :attribute field is required.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(425, 'validation', 'The :attribute field must contain entries for: :values.', 'The :attribute field must contain entries for: :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(426, 'validation', 'The :attribute field is required when :other is :value.', 'The :attribute field is required when :other is :value.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(427, 'validation', 'The :attribute field is required when :other is accepted.', 'The :attribute field is required when :other is accepted.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(428, 'validation', 'The :attribute field is required when :other is declined.', 'The :attribute field is required when :other is declined.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(429, 'validation', 'The :attribute field is required unless :other is in :values.', 'The :attribute field is required unless :other is in :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(430, 'validation', 'The :attribute field is required when :values is present.', 'The :attribute field is required when :values is present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(431, 'validation', 'The :attribute field is required when :values are present.', 'The :attribute field is required when :values are present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(432, 'validation', 'The :attribute field is required when :values is not present.', 'The :attribute field is required when :values is not present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(433, 'validation', 'The :attribute field is required when none of :values are present.', 'The :attribute field is required when none of :values are present.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(434, 'validation', 'The :attribute field must match :other.', 'The :attribute field must match :other.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(435, 'validation', 'The :attribute field must contain :size items.', 'The :attribute field must contain :size items.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(436, 'validation', 'The :attribute field must be :size kilobytes.', 'The :attribute field must be :size kilobytes.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(437, 'validation', 'The :attribute field must be :size.', 'The :attribute field must be :size.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(438, 'validation', 'The :attribute field must be :size characters.', 'The :attribute field must be :size characters.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(439, 'validation', 'The :attribute field must start with one of the following: :values.', 'The :attribute field must start with one of the following: :values.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(440, 'validation', 'The :attribute field must be a string.', 'The :attribute field must be a string.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(441, 'validation', 'The :attribute field must be a valid timezone.', 'The :attribute field must be a valid timezone.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(442, 'validation', 'The :attribute has already been taken.', 'The :attribute has already been taken.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(443, 'validation', 'The :attribute failed to upload.', 'The :attribute failed to upload.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(444, 'validation', 'The :attribute field must be uppercase.', 'The :attribute field must be uppercase.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(445, 'validation', 'The :attribute field must be a valid ULID.', 'The :attribute field must be a valid ULID.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(446, 'validation', 'The :attribute field must be a valid UUID.', 'The :attribute field must be a valid UUID.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(447, 'validation', 'Please verify that you are not a robot.', 'Please verify that you are not a robot.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(448, 'validation', 'Captcha error! try again later or contact site admin.', 'Captcha error! try again later or contact site admin.', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(449, 'validation', 'full name', 'full name', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(450, 'validation', 'username', 'username', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(451, 'validation', 'email address', 'email address', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(452, 'validation', 'first name', 'first name', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(453, 'validation', 'last name', 'last name', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(454, 'validation', 'password', 'password', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(455, 'validation', 'password confirmation', 'password confirmation', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(456, 'validation', 'subject', 'subject', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(457, 'validation', 'message', 'message', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(458, 'validation', 'key', 'key', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(459, 'validation', 'avatar', 'avatar', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(460, 'validation', 'current password', 'current password', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(461, 'validation', 'domain', 'domain', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(462, 'validation', 'city', 'city', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(463, 'validation', 'country', 'country', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(464, 'validation', 'address', 'address', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(465, 'validation', 'phone', 'phone', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(466, 'validation', 'mobile', 'mobile', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(467, 'validation', 'age', 'age', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(468, 'validation', 'sex', 'sex', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(469, 'validation', 'gender', 'gender', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(470, 'validation', 'day', 'day', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(471, 'validation', 'month', 'month', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(472, 'validation', 'year', 'year', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(473, 'validation', 'hour', 'hour', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(474, 'validation', 'minute', 'minute', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(475, 'validation', 'second', 'second', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(476, 'validation', 'title', 'title', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(477, 'validation', 'content', 'content', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(478, 'validation', 'description', 'description', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(479, 'validation', 'excerpt', 'excerpt', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(480, 'validation', 'date', 'date', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(481, 'validation', 'time', 'time', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(482, 'validation', 'available', 'available', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41'),
(483, 'validation', 'size', 'size', 0, 'en', '2025-07-04 04:48:41', '2025-07-04 04:48:41');


-- --------------------------------------------------------

--
-- Table structure for table `translation_jobs`
--

CREATE TABLE `translation_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `job_id` varchar(255) NOT NULL,
  `total_chunks` int(11) NOT NULL DEFAULT 0,
  `processed_chunks` int(11) NOT NULL DEFAULT 0,
  `success_count` int(11) NOT NULL DEFAULT 0,
  `error_count` int(11) NOT NULL DEFAULT 0,
  `total_characters` int(11) NOT NULL DEFAULT 0,
  `results` longtext DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trash_mails`
--

CREATE TABLE `trash_mails` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `domain` varchar(255) NOT NULL,
  `ip` varchar(255) DEFAULT NULL,
  `fingerprint` varchar(255) DEFAULT NULL,
  `expire_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `lastname` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `avatar` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `facebook_id` varchar(255) DEFAULT NULL,
  `google_id` varchar(255) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--


--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`);

--
-- Indexes for table `ads`
--
ALTER TABLE `ads`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ads_shortcode_unique` (`shortcode`);

--
-- Indexes for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blog_categories_slug_unique` (`slug`),
  ADD KEY `blog_categories_lang_foreign` (`lang`);

--
-- Indexes for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `blog_posts_slug_unique` (`slug`),
  ADD KEY `blog_posts_lang_foreign` (`lang`),
  ADD KEY `blog_posts_category_id_foreign` (`category_id`);

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `coupons`
--
ALTER TABLE `coupons`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `coupons_code_unique` (`code`),
  ADD KEY `coupons_is_active_index` (`is_active`);

--
-- Indexes for table `coupon_plan`
--
ALTER TABLE `coupon_plan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `domains`
--
ALTER TABLE `domains`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `domains_domain_unique` (`domain`),
  ADD KEY `domains_user_id_foreign` (`user_id`);

--
-- Indexes for table `email_templates`
--
ALTER TABLE `email_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_templates_alias_unique` (`alias`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `faqs`
--
ALTER TABLE `faqs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `faqs_lang_foreign` (`lang`);

--
-- Indexes for table `features`
--
ALTER TABLE `features`
  ADD PRIMARY KEY (`id`),
  ADD KEY `features_lang_foreign` (`lang`);

--
-- Indexes for table `imaps`
--
ALTER TABLE `imaps`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `imaps_tag_unique` (`tag`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `languages_code_unique` (`code`);

--
-- Indexes for table `logs`
--
ALTER TABLE `logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `menus`
--
ALTER TABLE `menus`
  ADD PRIMARY KEY (`id`),
  ADD KEY `menus_lang_foreign` (`lang`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `messages_user_id_foreign` (`user_id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pages_slug_unique` (`slug`),
  ADD KEY `pages_lang_foreign` (`lang`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);



--
-- Indexes for table `plans`
--
ALTER TABLE `plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plans_tag_unique` (`tag`);

--
-- Indexes for table `plan_features`
--
ALTER TABLE `plan_features`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plan_features_tag_plan_id_unique` (`tag`,`plan_id`),
  ADD KEY `plan_features_plan_id_foreign` (`plan_id`);

--
-- Indexes for table `plan_subscriptions`
--
ALTER TABLE `plan_subscriptions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_plan_subscription` (`tag`,`subscriber_id`,`subscriber_type`),
  ADD KEY `plan_subscriptions_subscriber_type_subscriber_id_index` (`subscriber_type`,`subscriber_id`),
  ADD KEY `plan_subscriptions_plan_id_foreign` (`plan_id`);

--
-- Indexes for table `plan_subscription_features`
--
ALTER TABLE `plan_subscription_features`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plan_subscription_features_plan_subscription_id_tag_unique` (`plan_subscription_id`,`tag`),
  ADD KEY `plan_subscription_features_plan_feature_id_foreign` (`plan_feature_id`);

--
-- Indexes for table `plan_subscription_usage`
--
ALTER TABLE `plan_subscription_usage`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plan_subscription_usage_plan_subscription_feature_id_unique` (`plan_subscription_feature_id`);

--
-- Indexes for table `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sections`
--
ALTER TABLE `sections`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sections_lang_foreign` (`lang`);

--
-- Indexes for table `seo`
--
ALTER TABLE `seo`
  ADD PRIMARY KEY (`id`),
  ADD KEY `seo_lang_foreign` (`lang`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `settings`
--
ALTER TABLE `settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `statistics`
--
ALTER TABLE `statistics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `taxes`
--
ALTER TABLE `taxes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `taxes_country_unique` (`country`);

--
-- Indexes for table `themes`
--
ALTER TABLE `themes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `themes_unique_name_unique` (`unique_name`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transactions_user_id_index` (`user_id`),
  ADD KEY `transactions_plan_id_index` (`plan_id`),
  ADD KEY `transactions_payment_id_index` (`payment_id`),
  ADD KEY `transactions_transaction_id_index` (`transaction_id`),
  ADD KEY `transactions_payer_id_index` (`payer_id`),
  ADD KEY `transactions_gateway_index` (`gateway`),
  ADD KEY `transactions_status_index` (`status`);

--
-- Indexes for table `translates`
--
ALTER TABLE `translates`
  ADD PRIMARY KEY (`id`),
  ADD KEY `translates_lang_foreign` (`lang`);

--
-- Indexes for table `translation_jobs`
--
ALTER TABLE `translation_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `translation_jobs_job_id_unique` (`job_id`);

--
-- Indexes for table `trash_mails`
--
ALTER TABLE `trash_mails`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `ads`
--
ALTER TABLE `ads`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `blog_categories`
--
ALTER TABLE `blog_categories`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `blog_posts`
--
ALTER TABLE `blog_posts`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupons`
--
ALTER TABLE `coupons`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `coupon_plan`
--
ALTER TABLE `coupon_plan`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `domains`
--
ALTER TABLE `domains`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_templates`
--
ALTER TABLE `email_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `faqs`
--
ALTER TABLE `faqs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `features`
--
ALTER TABLE `features`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `imaps`
--
ALTER TABLE `imaps`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `logs`
--
ALTER TABLE `logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;



--
-- AUTO_INCREMENT for table `plans`
--
ALTER TABLE `plans`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `plan_features`
--
ALTER TABLE `plan_features`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `plan_subscriptions`
--
ALTER TABLE `plan_subscriptions`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plan_subscription_features`
--
ALTER TABLE `plan_subscription_features`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plan_subscription_usage`
--
ALTER TABLE `plan_subscription_usage`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT;



--
-- AUTO_INCREMENT for table `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `sections`
--
ALTER TABLE `sections`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `seo`
--
ALTER TABLE `seo`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `settings`
--
ALTER TABLE `settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=70;

--
-- AUTO_INCREMENT for table `statistics`
--
ALTER TABLE `statistics`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `taxes`
--
ALTER TABLE `taxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `themes`
--
ALTER TABLE `themes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `translates`
--
ALTER TABLE `translates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=484;

--
-- AUTO_INCREMENT for table `translation_jobs`
--
ALTER TABLE `translation_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trash_mails`
--
ALTER TABLE `trash_mails`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `blog_categories`
--
ALTER TABLE `blog_categories`
  ADD CONSTRAINT `blog_categories_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `blog_posts`
--
ALTER TABLE `blog_posts`
  ADD CONSTRAINT `blog_posts_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `blog_categories` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `blog_posts_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `domains`
--
ALTER TABLE `domains`
  ADD CONSTRAINT `domains_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `faqs`
--
ALTER TABLE `faqs`
  ADD CONSTRAINT `faqs_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `features`
--
ALTER TABLE `features`
  ADD CONSTRAINT `features_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `menus`
--
ALTER TABLE `menus`
  ADD CONSTRAINT `menus_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `pages`
--
ALTER TABLE `pages`
  ADD CONSTRAINT `pages_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sections`
--
ALTER TABLE `sections`
  ADD CONSTRAINT `sections_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `seo`
--
ALTER TABLE `seo`
  ADD CONSTRAINT `seo_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;


ALTER TABLE `plan_features`
  ADD CONSTRAINT `plan_features_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `plan_subscriptions`
--
ALTER TABLE `plan_subscriptions`
  ADD CONSTRAINT `plan_subscriptions_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE SET NULL ON UPDATE CASCADE;

--
-- Constraints for table `plan_subscription_features`
--
ALTER TABLE `plan_subscription_features`
  ADD CONSTRAINT `plan_subscription_features_plan_feature_id_foreign` FOREIGN KEY (`plan_feature_id`) REFERENCES `plan_features` (`id`) ON DELETE SET NULL ON UPDATE CASCADE,
  ADD CONSTRAINT `plan_subscription_features_plan_subscription_id_foreign` FOREIGN KEY (`plan_subscription_id`) REFERENCES `plan_subscriptions` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `plan_subscription_usage`
--
ALTER TABLE `plan_subscription_usage`
  ADD CONSTRAINT `plan_subscription_usage_plan_subscription_feature_id_foreign` FOREIGN KEY (`plan_subscription_feature_id`) REFERENCES `plan_subscription_features` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `transactions`
--
ALTER TABLE `transactions`
  ADD CONSTRAINT `transactions_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `translates`
--
ALTER TABLE `translates`
  ADD CONSTRAINT `translates_lang_foreign` FOREIGN KEY (`lang`) REFERENCES `languages` (`code`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
