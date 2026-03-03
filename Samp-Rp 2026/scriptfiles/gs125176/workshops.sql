-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Мар 03 2026 г., 16:29
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
-- Структура таблицы `workshops`
--

CREATE TABLE `workshops` (
  `id` int(11) NOT NULL,
  `owner` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'None',
  `entrx` float NOT NULL,
  `entry` float NOT NULL,
  `entrz` float NOT NULL,
  `exitx` float NOT NULL,
  `exity` float NOT NULL,
  `exitz` float NOT NULL,
  `menux` float NOT NULL,
  `menuy` float NOT NULL,
  `menuz` float NOT NULL,
  `bank` int(11) NOT NULL DEFAULT 0,
  `landtax` int(11) NOT NULL DEFAULT 0,
  `prods` int(11) NOT NULL DEFAULT 0,
  `priceprods` int(11) NOT NULL DEFAULT 50,
  `zp` int(11) NOT NULL DEFAULT 5,
  `deputy_one` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT 'None',
  `deputy_two` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT 'None',
  `deputy_three` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT 'None',
  `mechanic_one` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'None',
  `mechanic_two` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'None',
  `mechanic_three` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'None',
  `mechanic_four` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'None',
  `mechanic_five` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT 'None',
  `auctions` varchar(128) NOT NULL DEFAULT '0, 0, 0, 0, 0',
  `auction_name` varchar(32) NOT NULL DEFAULT 'None',
  `Biker` int(2) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;

--
-- Дамп данных таблицы `workshops`
--

INSERT INTO `workshops` (`id`, `owner`, `entrx`, `entry`, `entrz`, `exitx`, `exity`, `exitz`, `menux`, `menuy`, `menuz`, `bank`, `landtax`, `prods`, `priceprods`, `zp`, `deputy_one`, `deputy_two`, `deputy_three`, `mechanic_one`, `mechanic_two`, `mechanic_three`, `mechanic_four`, `mechanic_five`, `auctions`, `auction_name`, `Biker`) VALUES
(1, 'None', 1658.5, 2200.3, 10.8, 1494.38, 1303.58, 1093.29, 1646.24, 2198.13, 10.8203, 0, 0, 0, 50, 5, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', '0, 0, 0, 0, 0', 'None', 0),
(2, 'None', -1799.95, 1200.42, 25.1194, 1494.38, 1303.58, 1093.29, -1786.66, 1206.76, 25.125, 0, 0, 0, 50, 5, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', '0, 0, 0, 0, 0', 'None', 0),
(3, 'None', 854.585, -605.204, 18.4219, 1494.38, 1303.58, 1093.29, 844.812, -599.737, 18.4219, -24606, 1000, 20000, 50, 5, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', '0, 0, 0, 0, 0', 'None', 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `workshops`
--
ALTER TABLE `workshops`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `workshops`
--
ALTER TABLE `workshops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
