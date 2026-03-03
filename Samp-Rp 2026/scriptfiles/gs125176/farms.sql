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
-- Структура таблицы `farms`
--

CREATE TABLE `farms` (
  `id` int(11) NOT NULL,
  `owner` varchar(32) NOT NULL DEFAULT 'None',
  `menu_1` float NOT NULL,
  `menu_2` float NOT NULL,
  `menu_3` float NOT NULL,
  `cloakroom_1` float NOT NULL,
  `cloakroom_2` float NOT NULL,
  `cloakroom_3` float NOT NULL,
  `bank` int(11) NOT NULL DEFAULT 0,
  `landtax` int(11) NOT NULL DEFAULT 0,
  `zp` int(11) NOT NULL DEFAULT 30,
  `grain_price` int(11) NOT NULL DEFAULT 6,
  `grain` int(11) NOT NULL DEFAULT 0,
  `grain_sown` int(11) NOT NULL DEFAULT 0,
  `prods_selling` int(11) NOT NULL DEFAULT 1,
  `prods` int(11) NOT NULL DEFAULT 0,
  `prods_price` int(11) NOT NULL DEFAULT 21,
  `deputy_1` varchar(32) NOT NULL DEFAULT 'None',
  `deputy_2` varchar(32) NOT NULL DEFAULT 'None',
  `deputy_3` varchar(32) NOT NULL DEFAULT 'None',
  `farmer_1` varchar(32) NOT NULL DEFAULT 'None',
  `farmer_2` varchar(32) NOT NULL DEFAULT 'None',
  `farmer_3` varchar(32) NOT NULL DEFAULT 'None',
  `farmer_4` varchar(32) NOT NULL DEFAULT 'None',
  `farmer_5` varchar(32) NOT NULL DEFAULT 'None',
  `auctions` varchar(64) NOT NULL DEFAULT '0, 0, 0, 0, 0',
  `auction_name` varchar(32) NOT NULL DEFAULT 'None',
  `Biker` int(2) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `farms`
--

INSERT INTO `farms` (`id`, `owner`, `menu_1`, `menu_2`, `menu_3`, `cloakroom_1`, `cloakroom_2`, `cloakroom_3`, `bank`, `landtax`, `zp`, `grain_price`, `grain`, `grain_sown`, `prods_selling`, `prods`, `prods_price`, `deputy_1`, `deputy_2`, `deputy_3`, `farmer_1`, `farmer_2`, `farmer_3`, `farmer_4`, `farmer_5`, `auctions`, `auction_name`, `Biker`) VALUES
(1, 'None', -382.621, -1438.95, 26.0286, -382.977, -1426.26, 26.319, 0, 0, 30, 5, 0, 0, 1, 0, 21, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', '0, 0, 0, 0, 0', 'None', 24),
(2, 'None', -111.47, -10.794, 3.1094, -108.977, -3.4238, 3.1172, 0, 0, 30, 5, 0, 0, 1, 0, 21, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', '0, 0, 0, 0, 0', 'None', 26),
(3, 'None', -1060.95, -1205.36, 129.596, -1061.01, -1195.44, 129.704, 0, 0, 50, 6, 0, 0, 1, 0, 21, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', '0, 0, 0, 0, 0', 'None', 0),
(4, 'None', -5.587, 67.8603, 3.1172, -2.8887, 75.0772, 3.1172, 0, 0, 50, 6, 0, 0, 1, 0, 21, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', '0, 0, 0, 0, 0', 'None', 0),
(5, 'None', 1925.54, 170.041, 37.2813, 1918.26, 172.62, 37.2574, 0, 0, 30, 5, 0, 0, 1, 0, 21, 'None', 'None', 'None', 'None', 'None', 'None', 'None', 'None', '0, 0, 0, 0, 0', 'None', 0);

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `farms`
--
ALTER TABLE `farms`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `farms`
--
ALTER TABLE `farms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
