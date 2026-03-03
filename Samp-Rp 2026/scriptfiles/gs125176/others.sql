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
-- Структура таблицы `others`
--

CREATE TABLE `others` (
  `bank_lsnews` int(11) NOT NULL DEFAULT 0,
  `bank_sfnews` int(11) NOT NULL DEFAULT 0,
  `bank_lvnews` int(11) NOT NULL DEFAULT 0,
  `bank_ballas` int(11) NOT NULL DEFAULT 0,
  `bank_vagos` int(11) NOT NULL DEFAULT 0,
  `bank_grove` int(11) NOT NULL DEFAULT 0,
  `bank_aztec` int(11) NOT NULL DEFAULT 0,
  `bank_rifa` int(11) NOT NULL DEFAULT 0,
  `bank_exchequer` int(11) NOT NULL DEFAULT 1000000,
  `bank_ssmc` int(11) NOT NULL DEFAULT 0,
  `bank_hamc` int(11) NOT NULL DEFAULT 0,
  `bank_omc` int(11) NOT NULL DEFAULT 0,
  `bank_wmc` int(11) NOT NULL DEFAULT 0,
  `bank_hwmc` int(11) NOT NULL DEFAULT 0,
  `bank_fsmc` int(11) NOT NULL DEFAULT 0,
  `bank_pmc` int(11) NOT NULL DEFAULT 0,
  `bank_mmc` int(11) NOT NULL DEFAULT 0,
  `bank_vmc` int(11) NOT NULL DEFAULT 0,
  `bank_bmc` int(11) NOT NULL DEFAULT 0,
  `heal_ballas` int(11) NOT NULL DEFAULT 5000,
  `heal_grove` int(11) NOT NULL DEFAULT 5000,
  `heal_vagos` int(11) NOT NULL DEFAULT 5000,
  `heal_aztec` int(11) NOT NULL DEFAULT 5000,
  `heal_rifa` int(11) NOT NULL DEFAULT 5000,
  `adprice_ls` int(11) NOT NULL DEFAULT 1,
  `adprice_sf` int(11) NOT NULL DEFAULT 1,
  `adprice_lv` int(11) NOT NULL DEFAULT 1,
  `healprice` int(11) NOT NULL DEFAULT 10,
  `heal_yakuza` int(11) NOT NULL DEFAULT 0,
  `heal_lcn` int(11) NOT NULL DEFAULT 0,
  `heal_rm` int(11) NOT NULL DEFAULT 0,
  `mats_lsa` int(11) NOT NULL DEFAULT 0,
  `mats_lva` int(11) NOT NULL DEFAULT 0,
  `mats_sfa` int(11) NOT NULL DEFAULT 0,
  `mats_ssmc` int(11) NOT NULL DEFAULT 0,
  `mats_hamc` int(11) NOT NULL DEFAULT 0,
  `mats_omc` int(11) NOT NULL DEFAULT 0,
  `mats_wmc` int(11) NOT NULL DEFAULT 0,
  `mats_hwmc` int(11) NOT NULL DEFAULT 0,
  `mats_fsmc` int(11) NOT NULL DEFAULT 0,
  `mats_vmc` int(11) NOT NULL DEFAULT 0,
  `mats_pmc` int(11) NOT NULL DEFAULT 0,
  `mats_mmc` int(11) NOT NULL DEFAULT 0,
  `mats_bmc` int(11) NOT NULL DEFAULT 0,
  `mats_rifa` int(11) NOT NULL DEFAULT 0,
  `mats_ballas` int(11) NOT NULL DEFAULT 0,
  `mats_aztec` int(11) NOT NULL DEFAULT 0,
  `mats_vagos` int(11) NOT NULL DEFAULT 0,
  `mats_grove` int(11) NOT NULL DEFAULT 0,
  `mats_lspd` int(11) NOT NULL DEFAULT 0,
  `mats_fbi` int(11) NOT NULL DEFAULT 0,
  `mats_yakuza` int(11) NOT NULL DEFAULT 0,
  `mats_rm` int(11) NOT NULL DEFAULT 0,
  `mats_lcn` int(11) NOT NULL DEFAULT 0,
  `mats_sfpd` int(11) NOT NULL DEFAULT 0,
  `mats_lvpd` int(11) NOT NULL DEFAULT 0,
  `bank_lcn` int(11) NOT NULL DEFAULT 0,
  `bank_yakuza` int(11) NOT NULL DEFAULT 0,
  `bank_rm` int(11) NOT NULL DEFAULT 0,
  `best_gang` int(2) NOT NULL,
  `slit` int(1) NOT NULL DEFAULT 0,
  `News_zp` varchar(32) NOT NULL DEFAULT '500,500,500'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `others`
--

INSERT INTO `others` (`bank_lsnews`, `bank_sfnews`, `bank_lvnews`, `bank_ballas`, `bank_vagos`, `bank_grove`, `bank_aztec`, `bank_rifa`, `bank_exchequer`, `bank_ssmc`, `bank_hamc`, `bank_omc`, `bank_wmc`, `bank_hwmc`, `bank_fsmc`, `bank_pmc`, `bank_mmc`, `bank_vmc`, `bank_bmc`, `heal_ballas`, `heal_grove`, `heal_vagos`, `heal_aztec`, `heal_rifa`, `adprice_ls`, `adprice_sf`, `adprice_lv`, `healprice`, `heal_yakuza`, `heal_lcn`, `heal_rm`, `mats_lsa`, `mats_lva`, `mats_sfa`, `mats_ssmc`, `mats_hamc`, `mats_omc`, `mats_wmc`, `mats_hwmc`, `mats_fsmc`, `mats_vmc`, `mats_pmc`, `mats_mmc`, `mats_bmc`, `mats_rifa`, `mats_ballas`, `mats_aztec`, `mats_vagos`, `mats_grove`, `mats_lspd`, `mats_fbi`, `mats_yakuza`, `mats_rm`, `mats_lcn`, `mats_sfpd`, `mats_lvpd`, `bank_lcn`, `bank_yakuza`, `bank_rm`, `best_gang`, `slit`, `News_zp`) VALUES
(100000, 100000, 100000, 7990551, 4031950, 17189100, 1588300, 500000, 999717, 500000, 596000, 500000, 500000, 500000, 500000, 500000, 500000, 500000, 500000, 4995, 5000, 5000, 5000, 5000, 30, 30, 30, 30, 5000, 5000, 5000, 99000, 276700, 300000, 50000, 50000, 50000, 50000, 50000, 50000, 50000, 60000, 50000, 50000, 100000, 107700, 99500, 100500, 108910, 97500, 78300, 94670, 97750, 97170, 100000, 99500, 1500001, 507000, 1176100001, 0, 0, '0,0,500');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
