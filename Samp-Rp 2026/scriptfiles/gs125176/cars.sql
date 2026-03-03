-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Мар 03 2026 г., 16:28
-- Версия сервера: 10.11.6-MariaDB-0+deb12u1
-- Версия PHP: 8.2.26

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `gs125176`
--

-- --------------------------------------------------------

--
-- Структура таблицы `cars`
--

CREATE TABLE `cars` (
  `id` int(11) NOT NULL,
  `owner` varchar(32) NOT NULL,
  `model` int(11) NOT NULL DEFAULT 462,
  `color_one` int(11) NOT NULL DEFAULT 1,
  `color_two` int(11) NOT NULL DEFAULT 1,
  `percent` int(11) NOT NULL DEFAULT 0,
  `fuel` float NOT NULL DEFAULT 100,
  `vehcom_1` int(11) NOT NULL DEFAULT 0,
  `vehcom_2` int(11) NOT NULL DEFAULT 0,
  `vehcom_3` int(11) NOT NULL DEFAULT 0,
  `vehcom_4` int(11) NOT NULL DEFAULT 0,
  `vehcom_5` int(11) NOT NULL DEFAULT 0,
  `vehcom_6` int(11) NOT NULL DEFAULT 0,
  `vehcom_7` int(11) NOT NULL DEFAULT 0,
  `vehcom_8` int(11) NOT NULL DEFAULT 0,
  `vehcom_9` int(11) NOT NULL DEFAULT 0,
  `vehcom_10` int(11) NOT NULL DEFAULT 0,
  `vehcom_11` int(11) NOT NULL DEFAULT 0,
  `vehcom_12` int(11) NOT NULL DEFAULT 0,
  `vehcom_13` int(11) NOT NULL DEFAULT 0,
  `vehcom_14` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `cars`
--

INSERT INTO `cars` (`id`, `owner`, `model`, `color_one`, `color_two`, `percent`, `fuel`, `vehcom_1`, `vehcom_2`, `vehcom_3`, `vehcom_4`, `vehcom_5`, `vehcom_6`, `vehcom_7`, `vehcom_8`, `vehcom_9`, `vehcom_10`, `vehcom_11`, `vehcom_12`, `vehcom_13`, `vehcom_14`) VALUES
(0, 'Mariotto_Caltabiano', 503, 0, 0, 100, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(0, 'Mariotto_Caltabiano', 503, 0, 0, 100, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(0, 'Test', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 'Test', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Test', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'Test', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Test', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(0, 'Mariotto_Caltabiano', 503, 0, 0, 100, 200, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Mariotto_Caltabiano', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(0, 'Ruslan_Limonchyk', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(1, 'Ruslan_Limonchyk', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(2, 'Ruslan_Limonchyk', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(3, 'Ruslan_Limonchyk', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
(4, 'Ruslan_Limonchyk', 462, 1, 1, 0, 100, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
