-- phpMyAdmin SQL Dump
-- version 3.4.5
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Sep 02, 2013 at 07:00 PM
-- Server version: 5.5.16
-- PHP Version: 5.3.8

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `itrack`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(255) NOT NULL,
  `LastName` varchar(255) NOT NULL,
  `Email` varchar(255) NOT NULL,
  `Company` varchar(255) NOT NULL,
  `Mobile` varchar(255) NOT NULL,
  `Telephone` varchar(255) NOT NULL,
  `Fax` varchar(255) NOT NULL,
  `Address` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`id`, `FirstName`, `LastName`, `Email`, `Company`, `Mobile`, `Telephone`, `Fax`, `Address`) VALUES
(1, 'Adrian', 'Santos', 'acsantos1010@gmail.com', 'Microsoft', '09058629211', '866-211-22', '003-123', '5557 Tramo St. San Dionisio Paranaque City');

-- --------------------------------------------------------

--
-- Table structure for table `deliveryreport`
--

CREATE TABLE IF NOT EXISTS `deliveryreport` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Employee` varchar(255) NOT NULL,
  `AuthPerson` varchar(255) NOT NULL,
  `Status` varchar(255) NOT NULL,
  `Remarks` varchar(255) NOT NULL,
  `Purchaseorder_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_DeliveryReport_Purchaseorder1` (`Purchaseorder_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `deliveryreport`
--

INSERT INTO `deliveryreport` (`id`, `Date`, `Employee`, `AuthPerson`, `Status`, `Remarks`, `Purchaseorder_id`) VALUES
(1, '2013-09-02', 'Adrian Santos', 'Jake Pasculado', 'Complete', 'Complete Delivery.\r\n500 Rims Marlboro Lights Half\r\n20 S-Boxes H&S Mint', 1);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE IF NOT EXISTS `inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(255) NOT NULL,
  `Brand` varchar(255) NOT NULL,
  `Description` varchar(255) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `PerShelf` int(11) NOT NULL,
  `Unit` varchar(255) NOT NULL,
  `Price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `inventory`
--

INSERT INTO `inventory` (`id`, `Name`, `Brand`, `Description`, `Quantity`, `PerShelf`, `Unit`, `Price`) VALUES
(1, 'H&S-Mint Small', 'P&G', 'Head and Shoulders Mint Cool, Small Containers', 28, 100, 'Boxes (small)', 500),
(3, 'Mlboro-L-Half', 'Marlboro', 'Marlboro Lights Half Pack', 450, 100, 'Boxes (small)', 600);

-- --------------------------------------------------------

--
-- Table structure for table `orderdetails`
--

CREATE TABLE IF NOT EXISTS `orderdetails` (
  `id` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `Inventory` int(11) NOT NULL,
  PRIMARY KEY (`Inventory`,`id`),
  KEY `id` (`id`),
  KEY `Inventory` (`Inventory`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `orderdetails`
--

INSERT INTO `orderdetails` (`id`, `Quantity`, `Inventory`) VALUES
(1, 10, 1),
(16, 5, 1),
(17, 2, 1),
(18, 250, 3);

-- --------------------------------------------------------

--
-- Table structure for table `person`
--

CREATE TABLE IF NOT EXISTS `person` (
  `person_id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) NOT NULL,
  `middle_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  PRIMARY KEY (`person_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Dumping data for table `person`
--

INSERT INTO `person` (`person_id`, `first_name`, `middle_name`, `last_name`, `gender`) VALUES
(1, 'Root', 'Super', 'User', 'Male');

-- --------------------------------------------------------

--
-- Table structure for table `purchaseorder`
--

CREATE TABLE IF NOT EXISTS `purchaseorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Customer` int(11) NOT NULL,
  `DateOfDelivery` date NOT NULL,
  `Date` date NOT NULL,
  `Status` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `Customer` (`Customer`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `purchaseorder`
--

INSERT INTO `purchaseorder` (`id`, `Customer`, `DateOfDelivery`, `Date`, `Status`) VALUES
(1, 1, '2013-10-13', '2013-09-02', 'New'),
(16, 1, '2013-09-02', '2013-09-02', 'New'),
(17, 1, '2013-09-02', '2013-09-02', 'New'),
(18, 1, '2013-09-02', '2013-09-02', 'New');

-- --------------------------------------------------------

--
-- Table structure for table `salesinvoice`
--

CREATE TABLE IF NOT EXISTS `salesinvoice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Status` varchar(255) NOT NULL,
  `Employee` varchar(255) NOT NULL,
  `SalesOrder_id` int(11) NOT NULL,
  `Customer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_SalesInvoice_SalesOrder1` (`SalesOrder_id`),
  KEY `fk_SalesInvoice_Customer1` (`Customer_id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `salesorder`
--

CREATE TABLE IF NOT EXISTS `salesorder` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `Date` date NOT NULL,
  `Employee` varchar(255) NOT NULL,
  `Status` varchar(45) NOT NULL,
  `PurchaseOrder` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `PurchaseOrder` (`PurchaseOrder`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- Table structure for table `system_log`
--

CREATE TABLE IF NOT EXISTS `system_log` (
  `entry_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip_address` varchar(255) NOT NULL,
  `user` varchar(255) NOT NULL,
  `datetime` int(11) NOT NULL,
  `action` varchar(50000) NOT NULL,
  `module` varchar(255) NOT NULL,
  PRIMARY KEY (`entry_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=474 ;

--
-- Dumping data for table `system_log`
--

INSERT INTO `system_log` (`entry_id`, `ip_address`, `user`, `datetime`, `action`, `module`) VALUES
(1, '::1', 'root', 1378116797, 'Module Access', '/ITrack/Customer/listview_customer.php'),
(2, '::1', 'root', 1378116798, 'Module Access', '/ITrack/Delivery Report/listview_deliveryreport.php'),
(3, '::1', 'root', 1378116799, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(4, '::1', 'root', 1378116799, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(5, '::1', 'root', 1378116800, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(6, '::1', 'root', 1378116801, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(7, '::1', 'root', 1378116801, 'Module Access', '/ITrack/Delivery Report/listview_deliveryreport.php'),
(8, '::1', 'root', 1378116803, 'Module Access', '/ITrack/Delivery Report/add_deliveryreport.php'),
(9, '::1', 'root', 1378116826, 'Module Access', '/ITrack/Customer/listview_customer.php'),
(10, '::1', 'root', 1378116827, 'Module Access', '/ITrack/Customer/add_customer.php'),
(11, '::1', 'root', 1378116860, 'Pressed submit button', '/ITrack/Customer/add_customer.php'),
(12, '::1', 'root', 1378116887, 'Pressed submit button', '/ITrack/Customer/add_customer.php'),
(13, '::1', 'root', 1378116919, 'Module Access', '/ITrack/Customer/listview_customer.php'),
(14, '::1', 'root', 1378116919, 'Module Access', '/ITrack/Customer/add_customer.php'),
(15, '::1', 'root', 1378116937, 'Pressed submit button', '/ITrack/Customer/add_customer.php'),
(16, '::1', 'root', 1378116937, 'Query executed: <br> INSERT INTO customer(id, FirstName, LastName, Email, Company, Mobile, Telephone, Fax, Address) VALUES('''', ''Adrian'', ''Santos'', ''acsantos1010@gmail.com'', ''Microsoft'', ''09058629211'', ''866-211-22'', ''003-123'', ''5557 Tramo St. San Dionisio Paranaque City'')', '/ITrack/Customer/add_customer.php'),
(17, '::1', 'root', 1378116937, 'Module Access', '/ITrack/Customer/listview_customer.php'),
(18, '::1', 'root', 1378116943, 'Module Access', '/ITrack/Customer/detailview_customer.php'),
(19, '::1', 'root', 1378116947, 'Pressed cancel button', '/ITrack/Customer/detailview_customer.php'),
(20, '::1', 'root', 1378116947, 'Module Access', '/ITrack/Customer/listview_customer.php'),
(21, '::1', 'root', 1378116948, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(22, '::1', 'root', 1378116949, 'Module Access', '/ITrack/Inventory/add_inventory.php'),
(23, '::1', 'root', 1378117019, 'Pressed submit button', '/ITrack/Inventory/add_inventory.php'),
(24, '::1', 'root', 1378117030, 'Pressed submit button', '/ITrack/Inventory/add_inventory.php'),
(25, '::1', 'root', 1378117030, 'Query executed: <br> INSERT INTO inventory(id, Name, Brand, Description, Quantity, PerShelf, Unit, Price) VALUES('''', ''H&S-Mint Small'', ''P&G'', ''Head and Shoulders Mint Cool, Small Containers'', ''500'', ''100'', ''Boxes (small)'', ''500'')', '/ITrack/Inventory/add_inventory.php'),
(26, '::1', 'root', 1378117030, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(27, '::1', 'root', 1378117033, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(28, '::1', 'root', 1378117033, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(29, '::1', 'root', 1378117036, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(30, '::1', 'root', 1378117039, 'Module Access', '/ITrack/Inventory/add_inventory.php'),
(31, '::1', 'root', 1378117084, 'Pressed submit button', '/ITrack/Inventory/add_inventory.php'),
(32, '::1', 'root', 1378117084, 'Query executed: <br> INSERT INTO inventory(id, Name, Brand, Description, Quantity, PerShelf, Unit, Price) VALUES('''', ''Mlboro-L-Half'', ''Marlboro'', ''Marlboro Lights Half Pack'', ''500'', ''250'', ''Rim'', ''600'')', '/ITrack/Inventory/add_inventory.php'),
(33, '::1', 'root', 1378117084, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(34, '::1', 'root', 1378117086, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(35, '::1', 'root', 1378117087, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(36, '::1', 'root', 1378117123, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(37, '::1', 'root', 1378117123, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-10-13'', ''2013-09-02'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(38, '::1', 'root', 1378117123, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''1'', ''4'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(39, '::1', 'root', 1378117123, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''1'', ''10'', ''1'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(40, '::1', 'root', 1378117123, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(41, '::1', 'root', 1378117129, 'Module Access', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(42, '::1', 'root', 1378117134, 'Pressed cancel button', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(43, '::1', 'root', 1378117134, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(44, '::1', 'root', 1378117137, 'Module Access', '/ITrack/Delivery Report/listview_deliveryreport.php'),
(45, '::1', 'root', 1378117138, 'Module Access', '/ITrack/Delivery Report/add_deliveryreport.php'),
(46, '::1', 'root', 1378117184, 'Pressed submit button', '/ITrack/Delivery Report/add_deliveryreport.php'),
(47, '::1', 'root', 1378117184, 'Query executed: <br> INSERT INTO deliveryreport(id, Date, Employee, AuthPerson, Status, Remarks, Purchaseorder_id) VALUES('''', ''2013-09-02'', ''Adrian Santos'', ''Jake Pasculado'', ''Complete'', ''Complete Delivery.\\r\\n500 Rims Marlboro Lights Half\\r\\n20 S-Boxes H&S Mint'', ''1'')', '/ITrack/Delivery Report/add_deliveryreport.php'),
(48, '::1', 'root', 1378117184, 'Module Access', '/ITrack/Delivery Report/listview_deliveryreport.php'),
(49, '::1', 'root', 1378117187, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(50, '::1', 'root', 1378117188, 'Module Access', '/ITrack/Sales Order/add_salesorder.php'),
(51, '::1', 'root', 1378117221, 'Pressed submit button', '/ITrack/Sales Order/add_salesorder.php'),
(52, '::1', 'root', 1378117221, 'Query executed: <br> INSERT INTO salesorder(id, Date, Employee, Status, PurchaseOrder) VALUES('''', ''2013-09-02'', ''Adrian Santos'', ''New'', ''1'')', '/ITrack/Sales Order/add_salesorder.php'),
(53, '::1', 'root', 1378117221, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(54, '::1', 'root', 1378117224, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(55, '::1', 'root', 1378117224, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(56, '::1', 'root', 1378117225, 'Module Access', '/ITrack/Sales Invoice/add_salesinvoice.php'),
(57, '::1', 'root', 1378117246, 'Pressed submit button', '/ITrack/Sales Invoice/add_salesinvoice.php'),
(58, '::1', 'root', 1378117246, 'Query executed: <br> INSERT INTO salesinvoice(id, Date, Status, Employee, SalesOrder_id, Customer_id) VALUES('''', ''2013-09-02'', ''Delivered'', ''Adrian Santos'', ''1'', ''1'')', '/ITrack/Sales Invoice/add_salesinvoice.php'),
(59, '::1', 'root', 1378117246, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(60, '::1', 'root', 1378119207, 'Module Access', '/ITrack/Customer/listview_customer.php'),
(61, '::1', 'root', 1378119208, 'Module Access', '/ITrack/Delivery Report/listview_deliveryreport.php'),
(62, '::1', 'root', 1378119208, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(63, '::1', 'root', 1378119209, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(64, '::1', 'root', 1378119210, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(65, '::1', 'root', 1378119213, 'Pressed cancel button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(66, '::1', 'root', 1378119213, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(67, '::1', 'root', 1378120531, 'Module Access', '/ITrack/Customer/listview_customer.php'),
(68, '::1', 'root', 1378127293, 'Module Access', '/ITrack/Customer/listview_customer.php'),
(69, '::1', 'root', 1378127294, 'Module Access', '/ITrack/Delivery Report/listview_deliveryreport.php'),
(70, '::1', 'root', 1378127295, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(71, '::1', 'root', 1378127296, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(72, '::1', 'root', 1378127297, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(73, '::1', 'root', 1378127298, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(74, '::1', 'root', 1378132584, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(75, '::1', 'root', 1378132592, 'Module Access', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(76, '::1', 'root', 1378132594, 'Pressed cancel button', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(77, '::1', 'root', 1378132594, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(78, '::1', 'root', 1378132595, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(79, '::1', 'root', 1378132642, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(80, '::1', 'root', 1378132651, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(81, '::1', 'root', 1378132676, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(82, '::1', 'root', 1378132690, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(83, '::1', 'root', 1378132704, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(84, '::1', 'root', 1378133102, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(85, '::1', 'root', 1378133181, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(86, '::1', 'root', 1378133182, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(87, '::1', 'root', 1378133183, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(88, '::1', 'root', 1378133184, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(89, '::1', 'root', 1378133184, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(90, '::1', 'root', 1378133373, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(91, '::1', 'root', 1378133387, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(92, '::1', 'root', 1378133389, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(93, '::1', 'root', 1378133403, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(94, '::1', 'root', 1378133403, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-10-02'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(95, '::1', 'root', 1378133403, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''2'', ''80'', ''1'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(96, '::1', 'root', 1378133403, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(97, '::1', 'root', 1378133405, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(98, '::1', 'root', 1378133410, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(99, '::1', 'root', 1378133415, 'Module Access', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(100, '::1', 'root', 1378133416, 'Pressed cancel button', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(101, '::1', 'root', 1378133416, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(102, '::1', 'root', 1378133417, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(103, '::1', 'root', 1378133423, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(104, '::1', 'root', 1378133424, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(105, '::1', 'root', 1378133426, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(106, '::1', 'root', 1378133427, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(107, '::1', 'root', 1378133428, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(108, '::1', 'root', 1378133428, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(109, '::1', 'root', 1378133429, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(110, '::1', 'root', 1378133429, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(111, '::1', 'root', 1378133430, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(112, '::1', 'root', 1378133430, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(113, '::1', 'root', 1378133431, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(114, '::1', 'root', 1378133431, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(115, '::1', 'root', 1378133467, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(116, '::1', 'root', 1378133468, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(117, '::1', 'root', 1378133469, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(118, '::1', 'root', 1378133470, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(119, '::1', 'root', 1378133470, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(120, '::1', 'root', 1378133471, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(121, '::1', 'root', 1378133471, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(122, '::1', 'root', 1378133471, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(123, '::1', 'root', 1378133471, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(124, '::1', 'root', 1378133472, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(125, '::1', 'root', 1378133472, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(126, '::1', 'root', 1378133472, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(127, '::1', 'root', 1378133472, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(128, '::1', 'root', 1378133472, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(129, '::1', 'root', 1378133473, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(130, '::1', 'root', 1378133473, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(131, '::1', 'root', 1378133473, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(132, '::1', 'root', 1378133482, 'Module Access', '/ITrack/Inventory/edit_inventory.php'),
(133, '::1', 'root', 1378133486, 'Pressed submit button', '/ITrack/Inventory/edit_inventory.php'),
(134, '::1', 'root', 1378133487, 'Query executed: <br> UPDATE inventory SET Name = ''Mlboro-L-Half'', Brand = ''Marlboro'', Description = ''Marlboro Lights Half Pack'', Quantity = ''2000'', PerShelf = ''250'', Unit = ''Rim'', Price = ''600'' WHERE id = ''2''', '/ITrack/Inventory/edit_inventory.php'),
(135, '::1', 'root', 1378133487, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(136, '::1', 'root', 1378133500, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(137, '::1', 'root', 1378133500, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(138, '::1', 'root', 1378133501, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(139, '::1', 'root', 1378133765, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(140, '::1', 'root', 1378133766, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(141, '::1', 'root', 1378133767, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(142, '::1', 'root', 1378133767, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(143, '::1', 'root', 1378133768, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(144, '::1', 'root', 1378133769, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(145, '::1', 'root', 1378133769, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(146, '::1', 'root', 1378133770, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(147, '::1', 'root', 1378133771, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(148, '::1', 'root', 1378133772, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(149, '::1', 'root', 1378133788, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(150, '::1', 'root', 1378133788, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-10-10'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(151, '::1', 'root', 1378133788, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''3'', ''50'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(152, '::1', 'root', 1378133788, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(153, '::1', 'root', 1378133791, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(154, '::1', 'root', 1378133795, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(155, '::1', 'root', 1378133796, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(156, '::1', 'root', 1378133796, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(157, '::1', 'root', 1378133797, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(158, '::1', 'root', 1378133797, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(159, '::1', 'root', 1378133798, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(160, '::1', 'root', 1378133798, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(161, '::1', 'root', 1378133799, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(162, '::1', 'root', 1378133861, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(163, '::1', 'root', 1378133862, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(164, '::1', 'root', 1378133863, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(165, '::1', 'root', 1378133863, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(166, '::1', 'root', 1378133864, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(167, '::1', 'root', 1378133865, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(168, '::1', 'root', 1378133868, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(169, '::1', 'root', 1378133882, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(170, '::1', 'root', 1378133882, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-12-02'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(171, '::1', 'root', 1378133882, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''4'', ''40'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(172, '::1', 'root', 1378133882, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(173, '::1', 'root', 1378133884, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(174, '::1', 'root', 1378133885, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(175, '::1', 'root', 1378133916, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(176, '::1', 'root', 1378133917, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(177, '::1', 'root', 1378133918, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(178, '::1', 'root', 1378133918, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(179, '::1', 'root', 1378133918, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(180, '::1', 'root', 1378133919, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(181, '::1', 'root', 1378134279, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(182, '::1', 'root', 1378134282, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(183, '::1', 'root', 1378134283, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(184, '::1', 'root', 1378134284, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(185, '::1', 'root', 1378134286, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(186, '::1', 'root', 1378134297, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(187, '::1', 'root', 1378134297, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-09-03'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(188, '::1', 'root', 1378134297, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''5'', ''40'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(189, '::1', 'root', 1378134297, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(190, '::1', 'root', 1378134299, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(191, '::1', 'root', 1378134318, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(192, '::1', 'root', 1378134318, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(193, '::1', 'root', 1378134319, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(194, '::1', 'root', 1378134321, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(195, '::1', 'root', 1378134322, 'Module Access', '/ITrack/Purchase Order/edit_purchaseorder.php'),
(196, '::1', 'root', 1378134326, 'Pressed submit button', '/ITrack/Purchase Order/edit_purchaseorder.php'),
(197, '::1', 'root', 1378134326, 'Query executed: <br> UPDATE purchaseorder SET Customer = ''1'', DateOfDelivery = ''2013-09-02'', Date = ''2013-09-03'', Status = ''New'' WHERE id = ''5''', '/ITrack/Purchase Order/edit_purchaseorder.php'),
(198, '::1', 'root', 1378134326, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''5'' AND Inventory = ''''', '/ITrack/Purchase Order/edit_purchaseorder.php'),
(199, '::1', 'root', 1378134334, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(200, '::1', 'root', 1378134335, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(201, '::1', 'root', 1378134337, 'Module Access', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(202, '::1', 'root', 1378134339, 'Pressed cancel button', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(203, '::1', 'root', 1378134339, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(204, '::1', 'root', 1378134340, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(205, '::1', 'root', 1378134351, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(206, '::1', 'root', 1378134356, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(207, '::1', 'root', 1378134356, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2014-09-02'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(208, '::1', 'root', 1378134356, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''6'', ''40'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(209, '::1', 'root', 1378134356, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(210, '::1', 'root', 1378134359, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(211, '::1', 'root', 1378134361, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(212, '::1', 'root', 1378134362, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(213, '::1', 'root', 1378134421, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(214, '::1', 'root', 1378134423, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(215, '::1', 'root', 1378134433, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(216, '::1', 'root', 1378134433, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2015-09-02'', ''Complete'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(217, '::1', 'root', 1378134433, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''7'', ''40'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(218, '::1', 'root', 1378134433, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(219, '::1', 'root', 1378134435, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(220, '::1', 'root', 1378134435, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(221, '::1', 'root', 1378135475, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(222, '::1', 'root', 1378135477, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(223, '::1', 'root', 1378135487, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(224, '::1', 'root', 1378135487, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-09-03'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(225, '::1', 'root', 1378135487, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''8'', ''40'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(226, '::1', 'root', 1378135487, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(227, '::1', 'root', 1378135490, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(228, '::1', 'root', 1378135498, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(229, '::1', 'root', 1378135498, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(230, '::1', 'root', 1378135499, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(231, '::1', 'root', 1378135500, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(232, '::1', 'root', 1378135501, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(233, '::1', 'root', 1378135501, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(234, '::1', 'root', 1378135502, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(235, '::1', 'root', 1378135503, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(236, '::1', 'root', 1378135798, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(237, '::1', 'root', 1378135799, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(238, '::1', 'root', 1378135800, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(239, '::1', 'root', 1378135801, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(240, '::1', 'root', 1378135802, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(241, '::1', 'root', 1378135803, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(242, '::1', 'root', 1378135805, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(243, '::1', 'root', 1378135820, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(244, '::1', 'root', 1378135827, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(245, '::1', 'root', 1378135827, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2014-09-10'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(246, '::1', 'root', 1378135827, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''9'', ''4'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(247, '::1', 'root', 1378135828, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(248, '::1', 'root', 1378135830, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(249, '::1', 'root', 1378135831, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(250, '::1', 'root', 1378135832, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(251, '::1', 'root', 1378135833, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(252, '::1', 'root', 1378136468, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(253, '::1', 'root', 1378136469, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(254, '::1', 'root', 1378136470, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(255, '::1', 'root', 1378136470, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(256, '::1', 'root', 1378136471, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(257, '::1', 'root', 1378136472, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(258, '::1', 'root', 1378136474, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(259, '::1', 'root', 1378136476, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(260, '::1', 'root', 1378136478, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(261, '::1', 'root', 1378136481, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(262, '::1', 'root', 1378136485, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(263, '::1', 'root', 1378136543, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(264, '::1', 'root', 1378136544, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(265, '::1', 'root', 1378136547, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(266, '::1', 'root', 1378136548, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(267, '::1', 'root', 1378136550, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(268, '::1', 'root', 1378136568, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(269, '::1', 'root', 1378136569, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(270, '::1', 'root', 1378136571, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(271, '::1', 'root', 1378136582, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(272, '::1', 'root', 1378136584, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(273, '::1', 'root', 1378136586, 'Pressed cancel button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(274, '::1', 'root', 1378136586, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(275, '::1', 'root', 1378136587, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(276, '::1', 'root', 1378136588, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(277, '::1', 'root', 1378136591, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(278, '::1', 'root', 1378136592, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(279, '::1', 'root', 1378136594, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(280, '::1', 'root', 1378136594, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''9''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(281, '::1', 'root', 1378136594, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''9'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(282, '::1', 'root', 1378136594, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(283, '::1', 'root', 1378136596, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(284, '::1', 'root', 1378136597, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(285, '::1', 'root', 1378136597, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''8''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(286, '::1', 'root', 1378136597, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''8'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(287, '::1', 'root', 1378136597, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(288, '::1', 'root', 1378136599, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(289, '::1', 'root', 1378136600, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(290, '::1', 'root', 1378136600, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''7''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(291, '::1', 'root', 1378136600, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''7'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(292, '::1', 'root', 1378136600, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(293, '::1', 'root', 1378136602, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(294, '::1', 'root', 1378136603, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(295, '::1', 'root', 1378136603, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''6''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(296, '::1', 'root', 1378136603, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''6'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(297, '::1', 'root', 1378136603, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(298, '::1', 'root', 1378136604, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(299, '::1', 'root', 1378136605, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(300, '::1', 'root', 1378136605, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''5''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(301, '::1', 'root', 1378136605, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''5'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(302, '::1', 'root', 1378136605, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(303, '::1', 'root', 1378136606, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(304, '::1', 'root', 1378136607, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(305, '::1', 'root', 1378136607, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''4''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(306, '::1', 'root', 1378136607, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''4'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(307, '::1', 'root', 1378136608, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(308, '::1', 'root', 1378136610, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(309, '::1', 'root', 1378136610, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(310, '::1', 'root', 1378136610, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''3''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(311, '::1', 'root', 1378136611, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''3'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(312, '::1', 'root', 1378136611, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(313, '::1', 'root', 1378136612, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(314, '::1', 'root', 1378136612, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(315, '::1', 'root', 1378136612, 'Query executed: <br> DELETE FROM orderdetails WHERE id = '''' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(316, '::1', 'root', 1378136612, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(317, '::1', 'root', 1378136615, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(318, '::1', 'root', 1378136616, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(319, '::1', 'root', 1378136616, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''2''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(320, '::1', 'root', 1378136616, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''2'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(321, '::1', 'root', 1378136616, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(322, '::1', 'root', 1378136617, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(323, '::1', 'root', 1378136619, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(324, '::1', 'root', 1378136620, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(325, '::1', 'root', 1378136623, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(326, '::1', 'root', 1378136624, 'Module Access', '/ITrack/Sales Order/delete_salesorder.php'),
(327, '::1', 'root', 1378136625, 'Pressed delete button', '/ITrack/Sales Order/delete_salesorder.php'),
(328, '::1', 'root', 1378136627, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(329, '::1', 'root', 1378136629, 'Module Access', '/ITrack/Sales Invoice/delete_salesinvoice.php'),
(330, '::1', 'root', 1378136630, 'Pressed delete button', '/ITrack/Sales Invoice/delete_salesinvoice.php'),
(331, '::1', 'root', 1378136630, 'Query executed: <br> DELETE FROM salesinvoice WHERE id = ''1''', '/ITrack/Sales Invoice/delete_salesinvoice.php'),
(332, '::1', 'root', 1378136630, 'Module Access', '/ITrack/Sales Invoice/listview_salesinvoice.php'),
(333, '::1', 'root', 1378136631, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(334, '::1', 'root', 1378136633, 'Module Access', '/ITrack/Sales Order/delete_salesorder.php'),
(335, '::1', 'root', 1378136634, 'Pressed delete button', '/ITrack/Sales Order/delete_salesorder.php'),
(336, '::1', 'root', 1378136634, 'Query executed: <br> DELETE FROM salesorder WHERE id = ''1''', '/ITrack/Sales Order/delete_salesorder.php'),
(337, '::1', 'root', 1378136634, 'Module Access', '/ITrack/Sales Order/listview_salesorder.php'),
(338, '::1', 'root', 1378136635, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(339, '::1', 'root', 1378136636, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(340, '::1', 'root', 1378136638, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(341, '::1', 'root', 1378136641, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(342, '::1', 'root', 1378136643, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(343, '::1', 'root', 1378136656, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(344, '::1', 'root', 1378136656, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-11-02'', ''PENDING'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(345, '::1', 'root', 1378136656, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''10'', ''04'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(346, '::1', 'root', 1378136656, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(347, '::1', 'root', 1378136658, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(348, '::1', 'root', 1378136660, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(349, '::1', 'root', 1378136660, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(350, '::1', 'root', 1378136661, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(351, '::1', 'root', 1378137164, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(352, '::1', 'root', 1378137165, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(353, '::1', 'root', 1378137260, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(354, '::1', 'root', 1378137264, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(355, '::1', 'root', 1378137291, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(356, '::1', 'root', 1378137291, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-10-12'', ''PENDING'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(357, '::1', 'root', 1378137291, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''11'', ''8'', ''1'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(358, '::1', 'root', 1378137291, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''11'', ''92'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(359, '::1', 'root', 1378137292, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(360, '::1', 'root', 1378137295, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(361, '::1', 'root', 1378137298, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(362, '::1', 'root', 1378137299, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(363, '::1', 'root', 1378137302, 'Module Access', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(364, '::1', 'root', 1378137314, 'Pressed cancel button', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(365, '::1', 'root', 1378137314, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(366, '::1', 'root', 1378137316, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(367, '::1', 'root', 1378137317, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(368, '::1', 'root', 1378137317, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''11''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(369, '::1', 'root', 1378137317, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''11'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(370, '::1', 'root', 1378137317, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(371, '::1', 'root', 1378137459, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(372, '::1', 'root', 1378137475, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(373, '::1', 'root', 1378137475, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-09-02'', ''Complete'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(374, '::1', 'root', 1378137475, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''12'', ''08'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(375, '::1', 'root', 1378137475, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(376, '::1', 'root', 1378137479, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(377, '::1', 'root', 1378137482, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(378, '::1', 'root', 1378137626, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(379, '::1', 'root', 1378137639, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(380, '::1', 'root', 1378137639, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-09-02'', ''PENDING'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(381, '::1', 'root', 1378137639, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''13'', ''84'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(382, '::1', 'root', 1378137640, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(383, '::1', 'root', 1378137643, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(384, '::1', 'root', 1378137644, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(385, '::1', 'root', 1378137645, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(386, '::1', 'root', 1378137895, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(387, '::1', 'root', 1378137905, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(388, '::1', 'root', 1378137915, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(389, '::1', 'root', 1378137915, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-10-02'', ''PENDING'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(390, '::1', 'root', 1378137915, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''14'', ''700'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(391, '::1', 'root', 1378137915, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(392, '::1', 'root', 1378137920, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(393, '::1', 'root', 1378137924, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(394, '::1', 'root', 1378137924, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(395, '::1', 'root', 1378137926, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(396, '::1', 'root', 1378138011, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(397, '::1', 'root', 1378138251, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(398, '::1', 'root', 1378138926, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(399, '::1', 'root', 1378139308, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(400, '::1', 'root', 1378139310, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(401, '::1', 'root', 1378139311, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(402, '::1', 'root', 1378139336, 'Module Access', '/ITrack/Inventory/add_inventory.php'),
(403, '::1', 'root', 1378139338, 'Pressed cancel button', '/ITrack/Inventory/add_inventory.php'),
(404, '::1', 'root', 1378139338, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(405, '::1', 'root', 1378139340, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(406, '::1', 'root', 1378139353, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(407, '::1', 'root', 1378139353, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-09-02'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(408, '::1', 'root', 1378139353, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''15'', ''16'', ''2'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(409, '::1', 'root', 1378139353, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(410, '::1', 'root', 1378139357, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(411, '::1', 'root', 1378139378, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(412, '::1', 'root', 1378139381, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(413, '::1', 'root', 1378139381, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(414, '::1', 'root', 1378139386, 'Module Access', '/ITrack/Inventory/delete_inventory.php'),
(415, '::1', 'root', 1378139387, 'Pressed delete button', '/ITrack/Inventory/delete_inventory.php'),
(416, '::1', 'root', 1378139387, 'Query executed: <br> DELETE FROM inventory WHERE id = ''2''', '/ITrack/Inventory/delete_inventory.php'),
(417, '::1', 'root', 1378139387, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(418, '::1', 'root', 1378139395, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(419, '::1', 'root', 1378139396, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(420, '::1', 'root', 1378139396, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''15''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(421, '::1', 'root', 1378139396, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''15'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(422, '::1', 'root', 1378139396, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(423, '::1', 'root', 1378139398, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(424, '::1', 'root', 1378139399, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(425, '::1', 'root', 1378139399, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''14''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(426, '::1', 'root', 1378139399, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''14'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(427, '::1', 'root', 1378139399, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(428, '::1', 'root', 1378139401, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(429, '::1', 'root', 1378139401, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(430, '::1', 'root', 1378139401, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''13''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(431, '::1', 'root', 1378139401, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''13'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(432, '::1', 'root', 1378139402, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(433, '::1', 'root', 1378139403, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(434, '::1', 'root', 1378139405, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(435, '::1', 'root', 1378139405, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''12''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(436, '::1', 'root', 1378139405, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''12'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(437, '::1', 'root', 1378139405, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(438, '::1', 'root', 1378139406, 'Module Access', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(439, '::1', 'root', 1378139407, 'Pressed delete button', '/ITrack/Purchase Order/delete_purchaseorder.php');
INSERT INTO `system_log` (`entry_id`, `ip_address`, `user`, `datetime`, `action`, `module`) VALUES
(440, '::1', 'root', 1378139407, 'Query executed: <br> DELETE FROM purchaseorder WHERE id = ''10''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(441, '::1', 'root', 1378139408, 'Query executed: <br> DELETE FROM orderdetails WHERE id = ''10'' AND Inventory = ''''', '/ITrack/Purchase Order/delete_purchaseorder.php'),
(442, '::1', 'root', 1378139408, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(443, '::1', 'root', 1378139409, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(444, '::1', 'root', 1378139418, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(445, '::1', 'root', 1378139421, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(446, '::1', 'root', 1378139421, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-09-02'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(447, '::1', 'root', 1378139421, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''16'', ''5'', ''1'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(448, '::1', 'root', 1378139421, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(449, '::1', 'root', 1378139424, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(450, '::1', 'root', 1378139426, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(451, '::1', 'root', 1378139453, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(452, '::1', 'root', 1378139463, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(453, '::1', 'root', 1378139463, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-09-02'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(454, '::1', 'root', 1378139463, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''17'', ''2'', ''1'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(455, '::1', 'root', 1378139463, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(456, '::1', 'root', 1378139466, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(457, '::1', 'root', 1378139467, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(458, '::1', 'root', 1378139482, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(459, '::1', 'root', 1378139487, 'Module Access', '/ITrack/Inventory/add_inventory.php'),
(460, '::1', 'root', 1378139513, 'Pressed submit button', '/ITrack/Inventory/add_inventory.php'),
(461, '::1', 'root', 1378139513, 'Query executed: <br> INSERT INTO inventory(id, Name, Brand, Description, Quantity, PerShelf, Unit, Price) VALUES('''', ''Mlboro-L-Half'', ''Marlboro'', ''Marlboro Lights Half Pack'', ''700'', ''100'', ''Boxes (small)'', ''600'')', '/ITrack/Inventory/add_inventory.php'),
(462, '::1', 'root', 1378139513, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(463, '::1', 'root', 1378139519, 'Module Access', '/ITrack/Purchase Order/add_purchaseorder.php'),
(464, '::1', 'root', 1378139530, 'Pressed submit button', '/ITrack/Purchase Order/add_purchaseorder.php'),
(465, '::1', 'root', 1378139530, 'Query executed: <br> INSERT INTO purchaseorder(id, Customer, DateOfDelivery, Date, Status) VALUES('''', ''1'', ''2013-09-02'', ''2013-09-02'', ''New'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(466, '::1', 'root', 1378139530, 'Query executed: <br> INSERT INTO orderdetails(id, Quantity, Inventory) VALUES(''18'', ''250'', ''3'')', '/ITrack/Purchase Order/add_purchaseorder.php'),
(467, '::1', 'root', 1378139530, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(468, '::1', 'root', 1378139532, 'Module Access', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(469, '::1', 'root', 1378139533, 'Pressed cancel button', '/ITrack/Purchase Order/detailview_purchaseorder.php'),
(470, '::1', 'root', 1378139533, 'Module Access', '/ITrack/Purchase Order/listview_purchaseorder.php'),
(471, '::1', 'root', 1378139538, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(472, '::1', 'root', 1378139546, 'Module Access', '/ITrack/Inventory/listview_inventory.php'),
(473, '::1', 'root', 1378139553, 'Module Access', '/ITrack/Inventory/listview_inventory.php');

-- --------------------------------------------------------

--
-- Table structure for table `system_settings`
--

CREATE TABLE IF NOT EXISTS `system_settings` (
  `setting` varchar(255) NOT NULL,
  `value` varchar(255) NOT NULL,
  PRIMARY KEY (`setting`)
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

CREATE TABLE IF NOT EXISTS `system_skins` (
  `skin_id` int(11) NOT NULL AUTO_INCREMENT,
  `skin_name` varchar(255) NOT NULL,
  `header` varchar(255) NOT NULL,
  `footer` varchar(255) NOT NULL,
  `css` varchar(255) NOT NULL,
  PRIMARY KEY (`skin_id`)
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

CREATE TABLE IF NOT EXISTS `user` (
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `salt` varchar(255) NOT NULL,
  `iteration` int(11) NOT NULL,
  `method` varchar(255) NOT NULL,
  `person_id` int(11) NOT NULL,
  `user_type_id` int(11) NOT NULL,
  `skin_id` int(11) NOT NULL,
  PRIMARY KEY (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`username`, `password`, `salt`, `iteration`, `method`, `person_id`, `user_type_id`, `skin_id`) VALUES
('root', 'e43de37614c7ed43f569d508a45f56841d741584', '4cc8f5c547a701399b70b32a02ea7eca5a7b19c6', 178239, 'SHA1', 1, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_links`
--

CREATE TABLE IF NOT EXISTS `user_links` (
  `link_id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `target` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `descriptive_title` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `description` text COLLATE latin1_general_ci NOT NULL,
  `passport_group_id` int(11) NOT NULL,
  `show_in_tasklist` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `status` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `icon` varchar(255) COLLATE latin1_general_ci NOT NULL,
  PRIMARY KEY (`link_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci PACK_KEYS=0 AUTO_INCREMENT=56 ;

--
-- Dumping data for table `user_links`
--

INSERT INTO `user_links` (`link_id`, `name`, `target`, `descriptive_title`, `description`, `passport_group_id`, `show_in_tasklist`, `status`, `icon`) VALUES
(1, 'Module Control', '/ITrack/sysadmin/module_control.php', 'Module Control', 'Enable and/or disable system modules', 2, 'Yes', 'On', 'modulecontrol.png'),
(2, 'Set User Passports', '/ITrack/sysadmin/set_user_passports.php', 'Set User Passports', 'Change the passport settings of system users', 2, 'Yes', 'On', 'passport.png'),
(3, 'Security Monitor', '/ITrack/sysadmin/security_monitor.php', 'Security Monitor', 'Examine the system log', 2, 'Yes', 'On', 'security3.png'),
(4, 'Add person', '/ITrack/sysadmin/add_person.php', 'Add person', '', 2, 'No', 'On', 'form.png'),
(5, 'Edit person', '/ITrack/sysadmin/edit_person.php', 'Edit person', '', 2, 'No', 'On', 'form.png'),
(6, 'View person', '/ITrack/sysadmin/listview_person.php', 'Manage person', '', 2, 'Yes', 'On', 'persons.png'),
(7, 'Delete person', '/ITrack/sysadmin/delete_person.php', 'Delete person', '', 2, 'No', 'On', 'form.png'),
(8, 'Add user', '/ITrack/sysadmin/add_user.php', 'Add user', '', 2, 'No', 'On', 'form.png'),
(9, 'Edit user', '/ITrack/sysadmin/edit_user.php', 'Edit user', '', 2, 'No', 'On', 'form.png'),
(10, 'View user', '/ITrack/sysadmin/listview_user.php', 'Manage user', '', 2, 'Yes', 'On', 'card.png'),
(11, 'Delete user', '/ITrack/sysadmin/delete_user.php', 'Delete user', '', 2, 'No', 'On', 'form.png'),
(12, 'Add user types', '/ITrack/sysadmin/add_user_types.php', 'Add user types', '', 2, 'No', 'On', 'form.png'),
(13, 'Edit user types', '/ITrack/sysadmin/edit_user_types.php', 'Edit user types', '', 2, 'No', 'On', 'form.png'),
(14, 'View user types', '/ITrack/sysadmin/listview_user_types.php', 'Manage user types', '', 2, 'Yes', 'On', 'user_type2.png'),
(15, 'Delete user types', '/ITrack/sysadmin/delete_user_types.php', 'Delete user types', '', 2, 'No', 'On', 'form.png'),
(16, 'Add user role', '/ITrack/sysadmin/add_user_role.php', 'Add user role', '', 2, 'No', 'On', 'form.png'),
(17, 'Edit user role', '/ITrack/sysadmin/edit_user_role.php', 'Edit user role', '', 2, 'No', 'On', 'form.png'),
(18, 'View user role', '/ITrack/sysadmin/listview_user_role.php', 'Manage user roles', '', 2, 'Yes', 'On', 'roles.png'),
(19, 'Delete user role', '/ITrack/sysadmin/delete_user_role.php', 'Delete user role', '', 2, 'No', 'On', 'form.png'),
(20, 'Add system settings', '/ITrack/sysadmin/add_system_settings.php', 'Add system settings', '', 2, 'No', 'On', 'form.png'),
(21, 'Edit system settings', '/ITrack/sysadmin/edit_system_settings.php', 'Edit system settings', '', 2, 'No', 'On', 'form.png'),
(22, 'View system settings', '/ITrack/sysadmin/listview_system_settings.php', 'Manage system settings', '', 2, 'Yes', 'On', 'system_settings.png'),
(23, 'Delete system settings', '/ITrack/sysadmin/delete_system_settings.php', 'Delete system settings', '', 2, 'No', 'On', 'form.png'),
(24, 'Add user links', '/ITrack/sysadmin/add_user_links.php', 'Add user links', '', 2, 'No', 'On', 'form.png'),
(25, 'Edit user links', '/ITrack/sysadmin/edit_user_links.php', 'Edit user links', '', 2, 'No', 'On', 'form.png'),
(26, 'View user links', '/ITrack/sysadmin/listview_user_links.php', 'Manage user links', '', 2, 'Yes', 'On', 'links.png'),
(27, 'Delete user links', '/ITrack/sysadmin/delete_user_links.php', 'Delete user links', '', 2, 'No', 'On', 'form.png'),
(28, 'Add user passport groups', '/ITrack/sysadmin/add_user_passport_groups.php', 'Add user passport groups', '', 2, 'No', 'On', 'form.png'),
(29, 'Edit user passport groups', '/ITrack/sysadmin/edit_user_passport_groups.php', 'Edit user passport groups', '', 2, 'No', 'On', 'form.png'),
(30, 'View user passport groups', '/ITrack/sysadmin/listview_user_passport_groups.php', 'Manage user passport groups', '', 2, 'Yes', 'On', 'passportgroup.png'),
(31, 'Delete user passport groups', '/ITrack/sysadmin/delete_user_passport_groups.php', 'Delete user passport groups', '', 2, 'No', 'On', 'form.png'),
(32, 'Add customer', '/ITrack/Customer/add_customer.php', 'Add customer', '', 1, 'No', 'On', 'form3.png'),
(33, 'Edit customer', '/ITrack/Customer/edit_customer.php', 'Edit customer', '', 1, 'No', 'On', 'form3.png'),
(34, 'View customer', '/ITrack/Customer/listview_customer.php', 'Manage customer', '', 1, 'Yes', 'On', 'form3.png'),
(35, 'Delete customer', '/ITrack/Customer/delete_customer.php', 'Delete customer', '', 1, 'No', 'On', 'form3.png'),
(36, 'Add deliveryreport', '/ITrack/Delivery Report/add_deliveryreport.php', 'Add deliveryreport', '', 1, 'No', 'On', 'form3.png'),
(37, 'Edit deliveryreport', '/ITrack/Delivery Report/edit_deliveryreport.php', 'Edit deliveryreport', '', 1, 'No', 'On', 'form3.png'),
(38, 'View deliveryreport', '/ITrack/Delivery Report/listview_deliveryreport.php', 'Manage deliveryreport', '', 1, 'Yes', 'On', 'form3.png'),
(39, 'Delete deliveryreport', '/ITrack/Delivery Report/delete_deliveryreport.php', 'Delete deliveryreport', '', 1, 'No', 'On', 'form3.png'),
(40, 'Add inventory', '/ITrack/Inventory/add_inventory.php', 'Add inventory', '', 1, 'No', 'On', 'form3.png'),
(41, 'Edit inventory', '/ITrack/Inventory/edit_inventory.php', 'Edit inventory', '', 1, 'No', 'On', 'form3.png'),
(42, 'View inventory', '/ITrack/Inventory/listview_inventory.php', 'Manage inventory', '', 1, 'Yes', 'On', 'form3.png'),
(43, 'Delete inventory', '/ITrack/Inventory/delete_inventory.php', 'Delete inventory', '', 1, 'No', 'On', 'form3.png'),
(44, 'Add purchaseorder', '/ITrack/Purchase Order/add_purchaseorder.php', 'Add purchaseorder', '', 1, 'No', 'On', 'form3.png'),
(45, 'Edit purchaseorder', '/ITrack/Purchase Order/edit_purchaseorder.php', 'Edit purchaseorder', '', 1, 'No', 'On', 'form3.png'),
(46, 'View purchaseorder', '/ITrack/Purchase Order/listview_purchaseorder.php', 'Manage purchaseorder', '', 1, 'Yes', 'On', 'form3.png'),
(47, 'Delete purchaseorder', '/ITrack/Purchase Order/delete_purchaseorder.php', 'Delete purchaseorder', '', 1, 'No', 'On', 'form3.png'),
(48, 'Add salesinvoice', '/ITrack/Sales Invoice/add_salesinvoice.php', 'Add salesinvoice', '', 1, 'No', 'On', 'form3.png'),
(49, 'Edit salesinvoice', '/ITrack/Sales Invoice/edit_salesinvoice.php', 'Edit salesinvoice', '', 1, 'No', 'On', 'form3.png'),
(50, 'View salesinvoice', '/ITrack/Sales Invoice/listview_salesinvoice.php', 'Manage salesinvoice', '', 1, 'Yes', 'On', 'form3.png'),
(51, 'Delete salesinvoice', '/ITrack/Sales Invoice/delete_salesinvoice.php', 'Delete salesinvoice', '', 1, 'No', 'On', 'form3.png'),
(52, 'Add salesorder', '/ITrack/Sales Order/add_salesorder.php', 'Add salesorder', '', 1, 'No', 'On', 'form3.png'),
(53, 'Edit salesorder', '/ITrack/Sales Order/edit_salesorder.php', 'Edit salesorder', '', 1, 'No', 'On', 'form3.png'),
(54, 'View salesorder', '/ITrack/Sales Order/listview_salesorder.php', 'Manage salesorder', '', 1, 'Yes', 'On', 'form3.png'),
(55, 'Delete salesorder', '/ITrack/Sales Order/delete_salesorder.php', 'Delete salesorder', '', 1, 'No', 'On', 'form3.png');

-- --------------------------------------------------------

--
-- Table structure for table `user_passport`
--

CREATE TABLE IF NOT EXISTS `user_passport` (
  `username` varchar(255) COLLATE latin1_general_ci NOT NULL,
  `link_id` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`username`,`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;

--
-- Dumping data for table `user_passport`
--

INSERT INTO `user_passport` (`username`, `link_id`) VALUES
('root', 1),
('root', 2),
('root', 3),
('root', 4),
('root', 5),
('root', 6),
('root', 7),
('root', 8),
('root', 9),
('root', 10),
('root', 11),
('root', 12),
('root', 13),
('root', 14),
('root', 15),
('root', 16),
('root', 17),
('root', 18),
('root', 19),
('root', 20),
('root', 21),
('root', 22),
('root', 23),
('root', 24),
('root', 25),
('root', 26),
('root', 27),
('root', 28),
('root', 29),
('root', 30),
('root', 31),
('root', 32),
('root', 33),
('root', 34),
('root', 35),
('root', 36),
('root', 37),
('root', 38),
('root', 39),
('root', 40),
('root', 41),
('root', 42),
('root', 43),
('root', 44),
('root', 45),
('root', 46),
('root', 47),
('root', 48),
('root', 49),
('root', 50),
('root', 51),
('root', 52),
('root', 53),
('root', 54),
('root', 55),
('root', 56),
('root', 57),
('root', 58),
('root', 59),
('root', 60),
('root', 61),
('root', 62),
('root', 63),
('root', 64),
('root', 65),
('root', 66),
('root', 67);

-- --------------------------------------------------------

--
-- Table structure for table `user_passport_groups`
--

CREATE TABLE IF NOT EXISTS `user_passport_groups` (
  `passport_group_id` int(11) NOT NULL AUTO_INCREMENT,
  `passport_group` varchar(255) NOT NULL,
  `icon` varchar(255) NOT NULL,
  PRIMARY KEY (`passport_group_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `user_passport_groups`
--

INSERT INTO `user_passport_groups` (`passport_group_id`, `passport_group`, `icon`) VALUES
(1, 'Default', 'blue_folder3.png'),
(2, 'Sysadmin', 'preferences-system.png');

-- --------------------------------------------------------

--
-- Table structure for table `user_role`
--

CREATE TABLE IF NOT EXISTS `user_role` (
  `role_id` int(11) NOT NULL AUTO_INCREMENT,
  `role` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- Table structure for table `user_role_links`
--

CREATE TABLE IF NOT EXISTS `user_role_links` (
  `role_id` int(11) NOT NULL,
  `link_id` int(11) NOT NULL,
  PRIMARY KEY (`role_id`,`link_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user_types`
--

CREATE TABLE IF NOT EXISTS `user_types` (
  `user_type_id` int(11) NOT NULL AUTO_INCREMENT,
  `user_type` varchar(255) NOT NULL,
  PRIMARY KEY (`user_type_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `user_types`
--

INSERT INTO `user_types` (`user_type_id`, `user_type`) VALUES
(1, 'System Admin'),
(2, 'Staff');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `deliveryreport`
--
ALTER TABLE `deliveryreport`
  ADD CONSTRAINT `fk_DeliveryReport_Purchaseorder1` FOREIGN KEY (`Purchaseorder_id`) REFERENCES `purchaseorder` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `orderdetails`
--
ALTER TABLE `orderdetails`
  ADD CONSTRAINT `orderdetails_ibfk_2` FOREIGN KEY (`id`) REFERENCES `purchaseorder` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `orderdetails_ibfk_1` FOREIGN KEY (`Inventory`) REFERENCES `inventory` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `purchaseorder`
--
ALTER TABLE `purchaseorder`
  ADD CONSTRAINT `Customer` FOREIGN KEY (`Customer`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `salesinvoice`
--
ALTER TABLE `salesinvoice`
  ADD CONSTRAINT `fk_SalesInvoice_SalesOrder1` FOREIGN KEY (`SalesOrder_id`) REFERENCES `salesorder` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_SalesInvoice_Customer1` FOREIGN KEY (`Customer_id`) REFERENCES `customer` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `salesorder`
--
ALTER TABLE `salesorder`
  ADD CONSTRAINT `PurchaseOrder` FOREIGN KEY (`PurchaseOrder`) REFERENCES `purchaseorder` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
