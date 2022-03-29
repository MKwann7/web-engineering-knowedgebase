SET FOREIGN_KEY_CHECKS=0;

-- Main Database Data Load:
USE `main`;

INSERT INTO `main`.`user` (`user_id`, `division_id`, `company_id`, `sponsor_id`, `first_name`, `last_name`, `name_prefx`, `middle_name`, `name_sufx`, `username`, `password`, `password_reset_token`, `pin`, `user_email`, `user_phone`, `created_on`, `created_by`, `last_updated`, `updated_by`, `status`, `preferred_name`, `last_login`, `old_user_id`, `sys_row_id`) VALUES (1000, 0, 0, null, 'Micah', 'Zak', '', '', '', 'mz490464', '$2y$10$N2U0OThlMjg1M2FiNWFjO.sJ2FH.YA8UlTsO72yOXASj/lUl09nJi', NULL, NULL, 1000, 1001, '2018-01-20 00:00:00', NULL, '2021-08-27 04:44:47', NULL, 'Active', '', '2021-08-27 04:44:47', NULL, '5865fe8b-111f-4c6f-a098-8118e5c83af2');

INSERT INTO `user_class` (`user_class_id`, `user_id`, `user_class_type_id`, `sys_row_id`) VALUES (1, 1000, 0, '79b8e57d-c83e-11e8-95ec-6ef620543eb9');

INSERT INTO `user_class_type` (`user_class_type_id`, `name`, `sys_row_id`) VALUES
(0, 'Supreme', '0aa06096-dbeb-11ea-82fd-4201ac163002'),
(1, 'Application Admin', '1999db9d-c83e-11e8-9461-52de8773d5f0'),
(2, 'Application Team Member', '2192621d-c83e-11e8-9461-52de8773d5f0'),
(3, 'Application Read-Only', '294f0c35-c83e-11e8-9461-52de8773d5f0'),
(5, 'Custom Platform Admin', '84e8f1a5-ce60-11e8-95ec-6ef620543eb9'),
(6, 'Custom Platform Team Member', 'be4549c2-da0a-11e8-95ec-6ef620543eb9'),
(7, 'Custom Platform Read-Only', '402ae2aa-8d0d-11eb-969d-42010a52200b'),
(8, 'Third-Party Affiliate', '4ed1bca4-8d0d-11eb-969d-42010a52200b'),
(9, 'Third-Party Read-Only', '54a30045-8d0d-11eb-969d-42010a52200b'),
(15, 'Members', '18524741-8d8d-11eb-969d-42010a52200b');

SET FOREIGN_KEY_CHECKS=1;