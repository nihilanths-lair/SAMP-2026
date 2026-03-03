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
-- Структура таблицы `podezd`
--

CREATE TABLE `podezd` (
  `pid` int(11) NOT NULL,
  `podPicX` float NOT NULL,
  `podPicY` float NOT NULL,
  `podPicZ` float NOT NULL,
  `podEtazi` int(11) NOT NULL,
  `carX` float NOT NULL,
  `carY` float NOT NULL,
  `carZ` float NOT NULL,
  `podInt` int(11) NOT NULL,
  `carC` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `podezd`
--

INSERT INTO `podezd` (`pid`, `podPicX`, `podPicY`, `podPicZ`, `podEtazi`, `carX`, `carY`, `carZ`, `podInt`, `carC`) VALUES
(1, -2356.66, 580.036, 24.8906, 2, -2361.53, 577.147, 24.5953, 0, 178.744),
(2, 1498.56, -1581.11, 13.5498, 9, 1493.48, -1584.99, 13.2519, 1, 269.97);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `podezd`
--
ALTER TABLE `podezd`
  ADD PRIMARY KEY (`pid`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `podezd`
--
ALTER TABLE `podezd`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
