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
-- Структура таблицы `atm`
--

CREATE TABLE `atm` (
  `id` int(11) NOT NULL,
  `ax` float NOT NULL,
  `ay` float NOT NULL,
  `az` float NOT NULL,
  `arz` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;

--
-- Дамп данных таблицы `atm`
--

INSERT INTO `atm` (`id`, `ax`, `ay`, `az`, `arz`) VALUES
(1, 1142.24, -1763.93, 13.508, 180),
(2, 1749.01, -1864.12, 13.459, -89.1),
(3, 1917.18, -1766.42, 13.418, -90.4),
(4, 1172.6, -1329.15, 15.305, -88),
(5, 457.355, -1486.53, 30.975, 17.9),
(6, -2035.53, -102.602, 35.034, -89.7),
(7, -2033.54, 159.224, 28.926, -179.9),
(8, 2160.09, 940.033, 10.7, 0),
(9, 2850.72, 1285.96, 11.281, -89.1),
(10, 1592.17, 2218.55, 10.91, 90.3),
(11, 1439.51, 2645.46, 11.283, 89.5),
(12, 1159.64, 1223.44, 10.69, 88.8),
(13, 2174.44, 1403.39, 10.932, 0),
(14, 566.258, -1297.76, 17.118, 180),
(15, -1958.89, 308.697, 35.339, 89.6),
(16, -1717.71, 1355.32, 7.031, 45.7),
(17, -2621.45, 1415.34, 6.744, 160.3),
(19, 91.545, 1180.78, 18.394, 90.5),
(20, 2021.5, 1017.23, 10.62, 90.6),
(21, 152.347, 1961.8, 19.64, -178.5),
(24, 152.347, 1961.8, 19.64, -178.5);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `atm`
--
ALTER TABLE `atm`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `atm`
--
ALTER TABLE `atm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
