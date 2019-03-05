-- phpMyAdmin SQL Dump
-- version 4.8.4
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1:3306
-- Tiempo de generación: 01-03-2019 a las 04:29:22
-- Versión del servidor: 5.7.24
-- Versión de PHP: 7.2.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `bd_ml`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `datos_owners`
--

DROP TABLE IF EXISTS `datos_owners`;
CREATE TABLE IF NOT EXISTS `datos_owners` (
  `Classification` varchar(10) NOT NULL DEFAULT 'high',
  `dn_name` varchar(50) NOT NULL,
  `owner_email` varchar(50) DEFAULT NULL,
  `user_manager` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `datos_owners`
--

INSERT INTO `datos_owners` (`Classification`, `dn_name`, `owner_email`, `user_manager`) VALUES
('high', 'users', 'enzo.trossero@mercadolibre.com', 'romina.marzovilla@mercadolibre.com'),
('high', 'locations', 'ricardo.bochini@mercadolibre.com', 'ernesto.vincelli@mercadolibre.com'),
('high', 'orders', 'luis.islas@mercadolibre.com', 'ernesto.vincelli@mercadolibre.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `db_list`
--

DROP TABLE IF EXISTS `db_list`;
CREATE TABLE IF NOT EXISTS `db_list` (
  `dn_name` varchar(50) NOT NULL,
  `classification_confidentiality` varchar(50) DEFAULT NULL,
  `classification_integrity` varchar(50) DEFAULT NULL,
  `classification_availability` varchar(50) DEFAULT NULL,
  `owner_name` varchar(50) DEFAULT NULL,
  `owner_uid` varchar(50) DEFAULT NULL,
  `owner_email` varchar(50) DEFAULT NULL,
  `time_stamp` varchar(50) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `db_list`
--

INSERT INTO `db_list` (`dn_name`, `classification_confidentiality`, `classification_integrity`, `classification_availability`, `owner_name`, `owner_uid`, `owner_email`, `time_stamp`) VALUES
('users', 'low', 'high', 'medium', 'Enzo Trossero', 'etrossero', 'enzo.trossero@mercadolibre.com', '2018-11-28 17:10:07.414345'),
('items', 'medium', 'low', '', 'Daniel Bertoni', 'dbertoni', '', '2018-11-28 17:10:07.414345'),
('locations', 'high', 'high', 'low', 'Ricardo Bochini', 'rbochini', 'ricardo.bochini@mercadolibre.com', '2018-11-28 17:10:07.414345'),
('sellers', 'low', 'medium', 'medium', 'Daniel Garnero', 'dgarnero', 'dani.garnero@mercadolibre.com', '2018-11-28 17:10:07.414345'),
('sellers', 'low', 'low', 'medium', 'JosÃ© Pastoriza', 'jopastoriza', 'jose.omar.pastoriza@mercadolibre.com', '2018-11-28 17:10:07.414345'),
('orders', 'high', 'high', 'medium', 'Luis Alberto Islas', 'laislas', 'luis.islas@mercadolibre.com', '2018-11-28 17:10:07.414345'),
('questions', 'low', 'low', 'low', 'Albeiro Usuriaga', 'ausuriaga', 'albeiro@mercadolibre.com', '2018-11-28 17:10:07.414345');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `mails`
--

DROP TABLE IF EXISTS `mails`;
CREATE TABLE IF NOT EXISTS `mails` (
  `mails` text NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `mails`
--

INSERT INTO `mails` (`mails`) VALUES
('amaury60315@gmail.com'),
('amaury60315@gmail.com'),
('ayelencs@gmail.com');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `user_manager`
--

DROP TABLE IF EXISTS `user_manager`;
CREATE TABLE IF NOT EXISTS `user_manager` (
  `row_id` varchar(20) NOT NULL,
  `user_id` varchar(20) NOT NULL,
  `user_state` varchar(20) NOT NULL,
  `user_manager` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Volcado de datos para la tabla `user_manager`
--

INSERT INTO `user_manager` (`row_id`, `user_id`, `user_state`, `user_manager`) VALUES
('1', 'etrossero', 'activo', 'romina.marzovilla@mercadolibre.com'),
('2', 'dbertoni', 'activo', 'romina.marzovilla@mercadolibre.com'),
('3', 'rbochini', 'activo', 'ernesto.vincelli@mercadolibre.com'),
('4', 'dgarnero', 'activo', 'romina.marzovilla@mercadolibre.com'),
('5', 'jopastoriza', 'activo', 'ernesto.vincelli@mercadolibre.com'),
('6', 'laislas', 'activo', 'ernesto.vincelli@mercadolibre.com');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
