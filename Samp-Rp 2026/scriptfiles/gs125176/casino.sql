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
-- Структура таблицы `casino`
--

CREATE TABLE `casino` (
  `ID` int(11) NOT NULL,
  `Name` varchar(64) NOT NULL,
  `Mafia` int(11) NOT NULL DEFAULT 0,
  `Krupie` varchar(32) NOT NULL DEFAULT '-',
  `Krupie2` varchar(32) NOT NULL DEFAULT '-',
  `Krupie3` varchar(32) NOT NULL DEFAULT '-',
  `Krupie4` varchar(32) NOT NULL DEFAULT '-',
  `Krupie5` varchar(32) NOT NULL DEFAULT '-',
  `Krupie6` varchar(32) NOT NULL DEFAULT '-',
  `Krupie7` varchar(32) NOT NULL DEFAULT '-',
  `Krupie8` varchar(32) NOT NULL DEFAULT '-',
  `Krupie9` varchar(32) NOT NULL DEFAULT '-',
  `Krupie10` varchar(32) NOT NULL DEFAULT '-',
  `Manager` varchar(32) NOT NULL DEFAULT '-',
  `Manager2` varchar(32) NOT NULL DEFAULT '-',
  `Manager3` varchar(32) NOT NULL DEFAULT '-',
  `posX` float NOT NULL,
  `posY` float NOT NULL,
  `posZ` float NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;

--
-- Дамп данных таблицы `casino`
--

INSERT INTO `casino` (`ID`, `Name`, `Mafia`, `Krupie`, `Krupie2`, `Krupie3`, `Krupie4`, `Krupie5`, `Krupie6`, `Krupie7`, `Krupie8`, `Krupie9`, `Krupie10`, `Manager`, `Manager2`, `Manager3`, `posX`, `posY`, `posZ`) VALUES
(1, '4 Dragons', 14, '-', '-', '-', '-', '-', '-', '-', 'Punisher_Mendes', 'Punisher_Mendes', 'Sorvik_Majorvik', 'Alex_White', 'sensation', 'CRUPA', 1961.97, 1018.16, 992.469),
(2, 'Caligula', 0, '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', '-', 2235.49, 1617.33, 1006.18);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `casino`
--
ALTER TABLE `casino`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `casino`
--
ALTER TABLE `casino`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
