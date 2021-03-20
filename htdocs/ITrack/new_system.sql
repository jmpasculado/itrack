-- 
-- Table structure for table `person`
-- 

CREATE TABLE `person` (
  `person_id` int(11) NOT NULL auto_increment,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  PRIMARY KEY  (`person_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- 
-- Dumping data for table `person`
-- 

INSERT INTO `person` (`person_id`, `first_name`, `middle_name`, `last_name`, `gender`) VALUES 
(1, 'Root', 'Super', 'User', 'Male');

-- --------------------------------------------------------

-- 
-- Table structure for table `system_log`
-- 

CREATE TABLE `system_log` (
  `entry_id` bigint(20) NOT NULL auto_increment,
  `ip_address` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  `datetime` int(11) NOT NULL,
  `action` varchar(50000) NOT NULL,
  `module` varchar(255) NOT NULL,
  PRIMARY KEY  (`entry_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `system_log`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `system_settings`
-- 

CREATE TABLE `system_settings` (
  `setting` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY  (`setting`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `system_settings`
-- 

INSERT INTO `system_settings` (`setting`, `value`) VALUES 
('Security Level', 'Red Alert');

-- --------------------------------------------------------

-- 
-- Table structure for table `system_skins`
-- 

CREATE TABLE `system_skins` (
  `skin_id` int(11) NOT NULL auto_increment,
  `skin_name` varchar(255) NOT NULL,
  `header` varchar(255) NOT NULL,
  `footer` varchar(255) NOT NULL,
  `css` varchar(255) NOT NULL,
  PRIMARY KEY  (`skin_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

-- 
-- Dumping data for table `system_skins`
-- 

INSERT INTO `system_skins` (`skin_id`, `skin_name`, `header`, `footer`, `css`) VALUES 
(1, 'Cobalt Default', 'skins/default_header.php', 'skins/default_footer.php', 'cobalt.css');

-- --------------------------------------------------------

-- 
-- Table structure for table `user`
-- 

CREATE TABLE `user` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `iteration` int(11) NOT NULL,
  `method` varchar(255) NOT NULL,
  `person_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  `skin_id` int(11) NOT NULL,
  PRIMARY KEY  (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- 
-- Dumping data for table `user`
-- 

INSERT INTO `user` (`username`, `password`, `salt`, `iteration`, `method`, `person_id`, `user_type_id`, `skin_id`) VALUES 
('root', 'e43de37614c7ed43f569d508a45f56841d741584', '4cc8f5c547a701399b70b32a02ea7eca5a7b19c6', '178239', 'SHA1', '1', 1, 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `user_links`
-- 

CREATE TABLE `user_links` (
  `link_id` int(11) NOT NULL auto_increment,
  `name` varchar(255) collate latin1_general_ci NOT NULL,
  `target` varchar(255) collate latin1_general_ci NOT NULL,
  `descriptive_title` varchar(255) collate latin1_general_ci NOT NULL,
  `description` text collate latin1_general_ci NOT NULL,
  `passport_group_id` int(11) NOT NULL,
  `show_in_tasklist` varchar(255) collate latin1_general_ci NOT NULL,
  `status` varchar(255) collate latin1_general_ci NOT NULL,
  `icon` varchar(255) collate latin1_general_ci NOT NULL,
  PRIMARY KEY  (`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci PACK_KEYS=0 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `user_links`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `user_passport`
-- 

CREATE TABLE `user_passport` (
  `username` varchar(255) collate latin1_general_ci NOT NULL,
  `link_id` int(11) NOT NULL default '0',
  PRIMARY KEY  (`username`,`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

-- 
-- Dumping data for table `user_passport`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `user_passport_groups`
-- 

CREATE TABLE `user_passport_groups` (
  `passport_group_id` int(11) NOT NULL auto_increment,
  `passport_group` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,  
  PRIMARY KEY  (`passport_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `user_passport_groups`
-- 

INSERT INTO `user_passport_groups` (`passport_group_id`, `passport_group`,`icon`) VALUES 
(1, 'Default','blue_folder3.png'),
(2, 'Sysadmin','preferences-system.png');


-- --------------------------------------------------------

-- 
-- Table structure for table `user_role`
-- 

 CREATE TABLE `user_role` (
`role_id` INT NOT NULL AUTO_INCREMENT PRIMARY KEY ,
`role` VARCHAR( 255 ) NOT NULL ,
`description` VARCHAR( 255 ) NOT NULL
) ENGINE = MYISAM ;

-- 
-- Dumping data for table `user_role`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `user_role_links`
-- 

CREATE TABLE `user_role_links` (
`role_id` INT NOT NULL ,
`link_id` INT NOT NULL ,
PRIMARY KEY ( `role_id` , `link_id` )
) ENGINE = MYISAM ;

-- 
-- Dumping data for table `user_role_links`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `user_types`
-- 

CREATE TABLE `user_types` (
  `user_type_id` int(11) NOT NULL auto_increment,
  `user_type` varchar(255) NOT NULL,
  PRIMARY KEY  (`user_type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- 
-- Dumping data for table `user_types`
-- 

INSERT INTO `user_types` (`user_type_id`, `user_type`) VALUES 
(1, 'System Admin'),
(2, 'Staff');

INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('1', 'Module Control', '/ITrack/sysadmin/module_control.php', 'Module Control', 'Enable and/or disable system modules','2','Yes','On','modulecontrol.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('2', 'Set User Passports', '/ITrack/sysadmin/set_user_passports.php', 'Set User Passports', 'Change the passport settings of system users','2','Yes','On','passport.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('3', 'Security Monitor', '/ITrack/sysadmin/security_monitor.php', 'Security Monitor', 'Examine the system log','2','Yes','On','security3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('4', 'Add person', '/ITrack/sysadmin/add_person.php', 'Add person', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('5', 'Edit person', '/ITrack/sysadmin/edit_person.php', 'Edit person', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('6', 'View person', '/ITrack/sysadmin/listview_person.php', 'Manage person', '', '2', 'Yes', 'On','persons.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('7', 'Delete person', '/ITrack/sysadmin/delete_person.php', 'Delete person', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('8', 'Add user', '/ITrack/sysadmin/add_user.php', 'Add user', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('9', 'Edit user', '/ITrack/sysadmin/edit_user.php', 'Edit user', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('10', 'View user', '/ITrack/sysadmin/listview_user.php', 'Manage user', '', '2', 'Yes', 'On','card.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('11', 'Delete user', '/ITrack/sysadmin/delete_user.php', 'Delete user', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('12', 'Add user types', '/ITrack/sysadmin/add_user_types.php', 'Add user types', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('13', 'Edit user types', '/ITrack/sysadmin/edit_user_types.php', 'Edit user types', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('14', 'View user types', '/ITrack/sysadmin/listview_user_types.php', 'Manage user types', '', '2', 'Yes', 'On','user_type2.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('15', 'Delete user types', '/ITrack/sysadmin/delete_user_types.php', 'Delete user types', '', '2', 'No', 'On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('16','Add user role', '/ITrack/sysadmin/add_user_role.php', 'Add user role','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('17','Edit user role', '/ITrack/sysadmin/edit_user_role.php', 'Edit user role','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('18','View user role', '/ITrack/sysadmin/listview_user_role.php', 'Manage user roles','','2','Yes','On','roles.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('19','Delete user role', '/ITrack/sysadmin/delete_user_role.php', 'Delete user role','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('20','Add system settings', '/ITrack/sysadmin/add_system_settings.php', 'Add system settings','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('21','Edit system settings', '/ITrack/sysadmin/edit_system_settings.php', 'Edit system settings','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('22','View system settings', '/ITrack/sysadmin/listview_system_settings.php', 'Manage system settings','','2','Yes','On','system_settings.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('23','Delete system settings', '/ITrack/sysadmin/delete_system_settings.php', 'Delete system settings','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('24','Add user links', '/ITrack/sysadmin/add_user_links.php', 'Add user links','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('25','Edit user links', '/ITrack/sysadmin/edit_user_links.php', 'Edit user links','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('26','View user links', '/ITrack/sysadmin/listview_user_links.php', 'Manage user links','','2','Yes','On','links.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('27','Delete user links', '/ITrack/sysadmin/delete_user_links.php', 'Delete user links','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('28','Add user passport groups', '/ITrack/sysadmin/add_user_passport_groups.php', 'Add user passport groups','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('29','Edit user passport groups', '/ITrack/sysadmin/edit_user_passport_groups.php', 'Edit user passport groups','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('30','View user passport groups', '/ITrack/sysadmin/listview_user_passport_groups.php', 'Manage user passport groups','','2','Yes','On','passportgroup.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES('31','Delete user passport groups', '/ITrack/sysadmin/delete_user_passport_groups.php', 'Delete user passport groups','','2','No','On','form.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Add customer', '/ITrack/Customer/add_customer.php', 'Add customer','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Edit customer', '/ITrack/Customer/edit_customer.php', 'Edit customer','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'View customer', '/ITrack/Customer/listview_customer.php', 'Manage customer','','1','Yes','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Delete customer', '/ITrack/Customer/delete_customer.php', 'Delete customer','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Add deliveryreport', '/ITrack/Delivery Report/add_deliveryreport.php', 'Add deliveryreport','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Edit deliveryreport', '/ITrack/Delivery Report/edit_deliveryreport.php', 'Edit deliveryreport','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'View deliveryreport', '/ITrack/Delivery Report/listview_deliveryreport.php', 'Manage deliveryreport','','1','Yes','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Delete deliveryreport', '/ITrack/Delivery Report/delete_deliveryreport.php', 'Delete deliveryreport','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Add inventory', '/ITrack/Inventory/add_inventory.php', 'Add inventory','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Edit inventory', '/ITrack/Inventory/edit_inventory.php', 'Edit inventory','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'View inventory', '/ITrack/Inventory/listview_inventory.php', 'Manage inventory','','1','Yes','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Delete inventory', '/ITrack/Inventory/delete_inventory.php', 'Delete inventory','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Add purchaseorder', '/ITrack/Purchase Order/add_purchaseorder.php', 'Add purchaseorder','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Edit purchaseorder', '/ITrack/Purchase Order/edit_purchaseorder.php', 'Edit purchaseorder','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'View purchaseorder', '/ITrack/Purchase Order/listview_purchaseorder.php', 'Manage purchaseorder','','1','Yes','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Delete purchaseorder', '/ITrack/Purchase Order/delete_purchaseorder.php', 'Delete purchaseorder','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Add salesinvoice', '/ITrack/Sales Invoice/add_salesinvoice.php', 'Add salesinvoice','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Edit salesinvoice', '/ITrack/Sales Invoice/edit_salesinvoice.php', 'Edit salesinvoice','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'View salesinvoice', '/ITrack/Sales Invoice/listview_salesinvoice.php', 'Manage salesinvoice','','1','Yes','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Delete salesinvoice', '/ITrack/Sales Invoice/delete_salesinvoice.php', 'Delete salesinvoice','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Add salesorder', '/ITrack/Sales Order/add_salesorder.php', 'Add salesorder','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Edit salesorder', '/ITrack/Sales Order/edit_salesorder.php', 'Edit salesorder','','1','No','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'View salesorder', '/ITrack/Sales Order/listview_salesorder.php', 'Manage salesorder','','1','Yes','On','form3.png');
INSERT INTO `user_links`(link_id, name, target, descriptive_title, description, passport_group_id, show_in_tasklist, `status`, icon) VALUES(null,'Delete salesorder', '/ITrack/Sales Order/delete_salesorder.php', 'Delete salesorder','','1','No','On','form3.png');
INSERT INTO `user_passport`(username, link_id) VALUES('root','1');
INSERT INTO `user_passport`(username, link_id) VALUES('root','2');
INSERT INTO `user_passport`(username, link_id) VALUES('root','3');
INSERT INTO `user_passport`(username, link_id) VALUES('root','4');
INSERT INTO `user_passport`(username, link_id) VALUES('root','5');
INSERT INTO `user_passport`(username, link_id) VALUES('root','6');
INSERT INTO `user_passport`(username, link_id) VALUES('root','7');
INSERT INTO `user_passport`(username, link_id) VALUES('root','8');
INSERT INTO `user_passport`(username, link_id) VALUES('root','9');
INSERT INTO `user_passport`(username, link_id) VALUES('root','10');
INSERT INTO `user_passport`(username, link_id) VALUES('root','11');
INSERT INTO `user_passport`(username, link_id) VALUES('root','12');
INSERT INTO `user_passport`(username, link_id) VALUES('root','13');
INSERT INTO `user_passport`(username, link_id) VALUES('root','14');
INSERT INTO `user_passport`(username, link_id) VALUES('root','15');
INSERT INTO `user_passport`(username, link_id) VALUES('root','16');
INSERT INTO `user_passport`(username, link_id) VALUES('root','17');
INSERT INTO `user_passport`(username, link_id) VALUES('root','18');
INSERT INTO `user_passport`(username, link_id) VALUES('root','19');
INSERT INTO `user_passport`(username, link_id) VALUES('root','20');
INSERT INTO `user_passport`(username, link_id) VALUES('root','21');
INSERT INTO `user_passport`(username, link_id) VALUES('root','22');
INSERT INTO `user_passport`(username, link_id) VALUES('root','23');
INSERT INTO `user_passport`(username, link_id) VALUES('root','24');
INSERT INTO `user_passport`(username, link_id) VALUES('root','25');
INSERT INTO `user_passport`(username, link_id) VALUES('root','26');
INSERT INTO `user_passport`(username, link_id) VALUES('root','27');
INSERT INTO `user_passport`(username, link_id) VALUES('root','28');
INSERT INTO `user_passport`(username, link_id) VALUES('root','29');
INSERT INTO `user_passport`(username, link_id) VALUES('root','30');
INSERT INTO `user_passport`(username, link_id) VALUES('root','31');
INSERT INTO `user_passport`(username, link_id) VALUES('root','32');
INSERT INTO `user_passport`(username, link_id) VALUES('root','33');
INSERT INTO `user_passport`(username, link_id) VALUES('root','34');
INSERT INTO `user_passport`(username, link_id) VALUES('root','35');
INSERT INTO `user_passport`(username, link_id) VALUES('root','36');
INSERT INTO `user_passport`(username, link_id) VALUES('root','37');
INSERT INTO `user_passport`(username, link_id) VALUES('root','38');
INSERT INTO `user_passport`(username, link_id) VALUES('root','39');
INSERT INTO `user_passport`(username, link_id) VALUES('root','40');
INSERT INTO `user_passport`(username, link_id) VALUES('root','41');
INSERT INTO `user_passport`(username, link_id) VALUES('root','42');
INSERT INTO `user_passport`(username, link_id) VALUES('root','43');
INSERT INTO `user_passport`(username, link_id) VALUES('root','44');
INSERT INTO `user_passport`(username, link_id) VALUES('root','45');
INSERT INTO `user_passport`(username, link_id) VALUES('root','46');
INSERT INTO `user_passport`(username, link_id) VALUES('root','47');
INSERT INTO `user_passport`(username, link_id) VALUES('root','48');
INSERT INTO `user_passport`(username, link_id) VALUES('root','49');
INSERT INTO `user_passport`(username, link_id) VALUES('root','50');
INSERT INTO `user_passport`(username, link_id) VALUES('root','51');
INSERT INTO `user_passport`(username, link_id) VALUES('root','52');
INSERT INTO `user_passport`(username, link_id) VALUES('root','53');
INSERT INTO `user_passport`(username, link_id) VALUES('root','54');
INSERT INTO `user_passport`(username, link_id) VALUES('root','55');
INSERT INTO `user_passport`(username, link_id) VALUES('root','56');
INSERT INTO `user_passport`(username, link_id) VALUES('root','57');
INSERT INTO `user_passport`(username, link_id) VALUES('root','58');
INSERT INTO `user_passport`(username, link_id) VALUES('root','59');
INSERT INTO `user_passport`(username, link_id) VALUES('root','60');
INSERT INTO `user_passport`(username, link_id) VALUES('root','61');
INSERT INTO `user_passport`(username, link_id) VALUES('root','62');
INSERT INTO `user_passport`(username, link_id) VALUES('root','63');
INSERT INTO `user_passport`(username, link_id) VALUES('root','64');
INSERT INTO `user_passport`(username, link_id) VALUES('root','65');
INSERT INTO `user_passport`(username, link_id) VALUES('root','66');
INSERT INTO `user_passport`(username, link_id) VALUES('root','67');
