/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 12.12.12.120:3306
 Source Schema         : codepush

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 02/02/2023 14:31:38
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for apps
-- ----------------------------
DROP TABLE IF EXISTS `apps`;
CREATE TABLE `apps`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `uid` bigint(0) UNSIGNED NOT NULL DEFAULT 0,
  `os` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `platform` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `is_use_diff_text` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_name`(`name`(12)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for collaborators
-- ----------------------------
DROP TABLE IF EXISTS `collaborators`;
CREATE TABLE `collaborators`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `uid` bigint(0) UNSIGNED NOT NULL DEFAULT 0,
  `roles` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_appid`(`appid`) USING BTREE,
  INDEX `idx_uid`(`uid`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for deployments
-- ----------------------------
DROP TABLE IF EXISTS `deployments`;
CREATE TABLE `deployments`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `appid` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `deployment_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `last_deployment_version_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `label_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_appid`(`appid`) USING BTREE,
  INDEX `idx_deploymentkey`(`deployment_key`(40)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for deployments_history
-- ----------------------------
DROP TABLE IF EXISTS `deployments_history`;
CREATE TABLE `deployments_history`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deployment_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `package_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_deployment_id`(`deployment_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for deployments_versions
-- ----------------------------
DROP TABLE IF EXISTS `deployments_versions`;
CREATE TABLE `deployments_versions`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deployment_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `app_version` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `current_package_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `min_version` bigint(0) UNSIGNED NOT NULL DEFAULT 0,
  `max_version` bigint(0) UNSIGNED NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_did_minversion`(`deployment_id`, `min_version`) USING BTREE,
  INDEX `idx_did_maxversion`(`deployment_id`, `max_version`) USING BTREE,
  INDEX `idx_did_appversion`(`deployment_id`, `app_version`(30)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_report_deploy
-- ----------------------------
DROP TABLE IF EXISTS `log_report_deploy`;
CREATE TABLE `log_report_deploy`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `package_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `client_unique_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `previous_label` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `previous_deployment_key` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for log_report_download
-- ----------------------------
DROP TABLE IF EXISTS `log_report_download`;
CREATE TABLE `log_report_download`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `package_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `client_unique_id` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for packages
-- ----------------------------
DROP TABLE IF EXISTS `packages`;
CREATE TABLE `packages`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deployment_version_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `deployment_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `package_hash` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `blob_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `size` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `manifest_blob_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `release_method` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `label` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `original_label` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `original_deployment` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `released_by` bigint(0) UNSIGNED NOT NULL DEFAULT 0,
  `is_mandatory` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `is_disabled` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `rollout` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  `region` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_deploymentid_label`(`deployment_id`, `label`(8)) USING BTREE,
  INDEX `idx_versions_id`(`deployment_version_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for packages_diff
-- ----------------------------
DROP TABLE IF EXISTS `packages_diff`;
CREATE TABLE `packages_diff`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `package_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `diff_against_package_hash` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `diff_blob_url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `diff_size` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_packageid_hash`(`package_id`, `diff_against_package_hash`(40)) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for packages_metrics
-- ----------------------------
DROP TABLE IF EXISTS `packages_metrics`;
CREATE TABLE `packages_metrics`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `package_id` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `active` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `downloaded` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `failed` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `installed` int(0) UNSIGNED NOT NULL DEFAULT 0,
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `created_at` timestamp(0) NULL DEFAULT NULL,
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_packageid`(`package_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_tokens
-- ----------------------------
DROP TABLE IF EXISTS `user_tokens`;
CREATE TABLE `user_tokens`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uid` bigint(0) UNSIGNED NOT NULL DEFAULT 0,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `tokens` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `created_by` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `description` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `is_session` tinyint(0) UNSIGNED NOT NULL DEFAULT 0,
  `expires_at` timestamp(0) NULL DEFAULT NULL,
  `created_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
  `deleted_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_uid`(`uid`) USING BTREE,
  INDEX `idx_tokens`(`tokens`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `identical` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `ack_code` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `updated_at` timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0),
  `created_at` timestamp(0) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `udx_identical`(`identical`) USING BTREE,
  INDEX `udx_username`(`username`) USING BTREE,
  INDEX `idx_email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for versions
-- ----------------------------
DROP TABLE IF EXISTS `versions`;
CREATE TABLE `versions`  (
  `id` int(0) UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` tinyint(0) UNSIGNED NOT NULL DEFAULT 0 COMMENT '1.DBversion',
  `version` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `udx_type`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
