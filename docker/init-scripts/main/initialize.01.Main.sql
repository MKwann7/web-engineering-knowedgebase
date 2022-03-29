-- --------------------------------------------------------
-- Host:                         35.192.58.83
-- Server version:               5.7.34-google-log - (Google)
-- Server OS:                    Linux
-- Server OS:                    Linux
-- HeidiSQL Version:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Dumping database structure for excell_main
CREATE DATABASE IF NOT EXISTS `main` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;
USE `main`;

-- Dumping structure for table excell_main.app_instance
CREATE TABLE IF NOT EXISTS `app_instance` (
    `app_instance_id` int(15) NOT NULL AUTO_INCREMENT,
    `owner_id` int(15) DEFAULT NULL,
    `card_id` int(15) DEFAULT NULL,
    `card_tab_id` int(15) DEFAULT NULL,
    `card_addon_id` int(15) DEFAULT NULL,
    `module_app_id` int(15) DEFAULT NULL,
    `module_app_widget_id` int(15) DEFAULT NULL,
    `instance_uuid` char(36) DEFAULT NULL,
    `product_id` int(15) DEFAULT NULL,
    `created_on` datetime DEFAULT NULL,
    `last_updated` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    `sys_row_id` char(36) DEFAULT NULL,
    PRIMARY KEY (`app_instance_id`) USING BTREE,
    UNIQUE KEY `sys_row_id` (`sys_row_id`),
    UNIQUE KEY `insance_uuid` (`instance_uuid`) USING BTREE,
    KEY `last_updated` (`last_updated`),
    KEY `card_id` (`card_id`),
    KEY `card_addon_id` (`card_addon_id`),
    KEY `module_widget_id` (`module_app_id`) USING BTREE,
    KEY `module_app_widget_id` (`module_app_widget_id`),
    KEY `product_id` (`product_id`),
    KEY `card_tab_id` (`card_tab_id`,`owner_id`) USING BTREE,
    KEY `owner_id` (`owner_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- Data exporting was unselected.

-- Dumping structure for procedure main.UpdateCardTabs
DELIMITER //
CREATE PROCEDURE `UpdateCardTabs`(IN intSourceRel INT, IN strDestinationRels VARCHAR(255))
BEGIN

	SET @cardTab = (SELECT ctr1.card_tab_id FROM card_tab_rel ctr1 WHERE ctr1.card_tab_rel_id = intSourceRel LIMIT 1);

UPDATE
    card_tab
SET
    library_tab = 1
WHERE
        card_tab_id = @cardTab
    LIMIT 1;

UPDATE
    card_tab_rel
SET
    card_tab_rel_type = 'mirror'
WHERE
        card_tab_rel_id = intSourceRel
    LIMIT 1;

IF @cardTab > 0 THEN
		SET @sql = CONCAT('UPDATE
			card_tab_rel
		SET
			card_tab_id = @cardTab,
			card_tab_rel_type = \'mirror\'
		WHERE
			card_tab_rel_id IN (',strDestinationRels,');');
PREPARE stmt FROM @SQL;
EXECUTE stmt;
DEALLOCATE PREPARE stmt;

END IF;

END//
DELIMITER ;

-- Dumping structure for table excell_main.user
CREATE TABLE IF NOT EXISTS `user` (
    `user_id` int(15) NOT NULL AUTO_INCREMENT COMMENT 'UserId',
    `division_id` int(15) DEFAULT NULL COMMENT 'DivisionId',
    `company_id` int(15) DEFAULT '0' COMMENT 'CompanyId',
    `sponsor_id` int(15) DEFAULT NULL COMMENT 'SponsorId',
    `first_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT 'FirstName',
    `last_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT 'LastName',
    `name_prefx` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT 'NamePrefix',
    `middle_name` varchar(45) CHARACTER SET utf8 DEFAULT NULL COMMENT 'MiddleName',
    `name_sufx` varchar(15) CHARACTER SET utf8 DEFAULT NULL COMMENT 'NameSufix',
    `username` varchar(35) CHARACTER SET utf8 DEFAULT NULL COMMENT 'UserName',
    `password` varchar(250) CHARACTER SET utf8 DEFAULT NULL COMMENT 'Password',
    `password_reset_token` char(36) CHARACTER SET utf8 DEFAULT NULL COMMENT 'PasswordResetToken',
    `pin` int(6) DEFAULT NULL COMMENT 'Pin',
    `user_email` int(15) DEFAULT NULL COMMENT 'UserEmail',
    `user_phone` int(15) DEFAULT NULL COMMENT 'UserPhone',
    `created_on` datetime DEFAULT NULL COMMENT 'CreatedOn',
    `created_by` int(15) DEFAULT NULL COMMENT 'CreatedBy',
    `last_updated` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT 'LastUpdated',
    `updated_by` int(15) DEFAULT NULL COMMENT 'UpdatedBy',
    `status` varchar(15) CHARACTER SET utf8 DEFAULT 'Active' COMMENT 'Status',
    `preferred_name` varchar(50) CHARACTER SET utf8 DEFAULT NULL COMMENT 'PreferredName',
    `last_login` datetime DEFAULT NULL COMMENT 'LastLogin',
    `old_user_id` int(10) DEFAULT NULL COMMENT 'OldUserId',
    `sys_row_id` char(36) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT 'SysRowId',
    PRIMARY KEY (`user_id`),
    UNIQUE KEY `sys_row_id` (`sys_row_id`),
    UNIQUE KEY `user_email` (`user_email`),
    UNIQUE KEY `user_phone` (`user_phone`),
    KEY `sponsor_id` (`sponsor_id`),
    KEY `company_id` (`company_id`),
    KEY `division_id` (`division_id`),
    KEY `status_id` (`status`) USING BTREE,
    KEY `fk_user_created_by` (`created_by`),
    KEY `fk_user_updated_by` (`updated_by`),
    KEY `first_name` (`first_name`),
    KEY `last_name` (`last_name`),
    ) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='UserTable for Excell  3.0';

-- Data exporting was unselected.

-- Dumping structure for table excell_main.user_class
CREATE TABLE IF NOT EXISTS `user_class` (
    `user_class_id` int(15) NOT NULL AUTO_INCREMENT COMMENT 'UserClassId',
    `user_id` int(15) NOT NULL COMMENT 'UserId',
    `user_class_type_id` int(15) NOT NULL COMMENT 'UserClassTypeId',
    `sys_row_id` char(36) CHARACTER SET utf8 NOT NULL COMMENT 'SysRowId',
    PRIMARY KEY (`user_class_id`),
    KEY `fk_user_class_type_id` (`user_class_type_id`),
    KEY `fk_user_class_user` (`user_id`),
    CONSTRAINT `fk_user_class_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE NO ACTION ON UPDATE NO ACTION
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Dumping structure for table excell_main.user_class_type
CREATE TABLE IF NOT EXISTS `user_class_type` (
    `user_class_type_id` int(15) NOT NULL COMMENT 'UserClassTypeId',
    `name` varchar(35) NOT NULL COMMENT 'Name',
    `sys_row_id` char(36) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL COMMENT 'SysRowId',
    PRIMARY KEY (`user_class_type_id`),
    UNIQUE KEY `sys_row_id` (`sys_row_id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='UserClassTypeTable for Excell  3.0';


-- Dumping structure for trigger main.tgr_user_class_type_sysrowid
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tgr_user_class_type_sysrowid` BEFORE INSERT ON `user_class_type` FOR EACH ROW SET NEW.sys_row_id = UUID()//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger main.tgr_user_class_sysrowid
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tgr_user_class_sysrowid` BEFORE INSERT ON `user_class` FOR EACH ROW SET NEW.sys_row_id = UUID()//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;

-- Dumping structure for trigger main.tgr_user_sysrowid
SET @OLDTMP_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO';
DELIMITER //
CREATE TRIGGER `tgr_user_sysrowid` BEFORE INSERT ON `user` FOR EACH ROW SET NEW.sys_row_id = UUID()//
DELIMITER ;
SET SQL_MODE=@OLDTMP_SQL_MODE;