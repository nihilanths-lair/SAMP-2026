-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Хост: localhost
-- Время создания: Мар 03 2026 г., 16:27
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
-- Структура таблицы `accounts`
--

CREATE TABLE `accounts` (
  `pID` int(11) NOT NULL,
  `Name` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pKey` varchar(256) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pLevel` int(11) NOT NULL DEFAULT 1,
  `pHelper` int(11) NOT NULL DEFAULT 0,
  `pRatingSupport` int(11) NOT NULL DEFAULT 0,
  `pJobHeal` int(11) NOT NULL DEFAULT 0,
  `pMestoJail` int(11) NOT NULL DEFAULT 0,
  `pIp` varchar(127) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pvIp` varchar(128) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pIpReg` varchar(128) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pHousecash` int(11) NOT NULL DEFAULT 0,
  `pCheckip` int(11) NOT NULL DEFAULT 0,
  `pGoogleIP` int(1) NOT NULL DEFAULT 0,
  `pGoogleKey` varchar(32) NOT NULL,
  `pText` int(11) NOT NULL DEFAULT 0,
  `pvehcom` varchar(64) NOT NULL DEFAULT '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0',
  `pKeyip` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pHP` float NOT NULL DEFAULT 100,
  `pSatiety` int(11) NOT NULL DEFAULT 100,
  `pDataReg` varchar(128) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pDonateRank` int(11) NOT NULL DEFAULT 0,
  `pMats` int(11) NOT NULL DEFAULT 0,
  `pSex` int(11) NOT NULL,
  `pArrested` int(11) NOT NULL DEFAULT 0,
  `pMuted` int(11) NOT NULL DEFAULT 0,
  `pCrimes` int(11) NOT NULL DEFAULT 0,
  `pExp` int(11) NOT NULL DEFAULT 0,
  `pBank` int(11) NOT NULL DEFAULT 0,
  `pCash` int(11) NOT NULL DEFAULT 0,
  `pPHouseKey` int(255) NOT NULL,
  `pKvartiraKey` int(11) NOT NULL,
  `pPBizzKey` int(11) NOT NULL,
  `pPFarmKey` int(11) NOT NULL,
  `pPLimitBank` int(11) NOT NULL,
  `pAdmin` int(11) NOT NULL,
  `pChar` int(11) NOT NULL,
  `pWantedDeaths` int(11) NOT NULL DEFAULT 0,
  `pPayCheck` int(11) NOT NULL DEFAULT 0,
  `pJailTime` int(11) NOT NULL DEFAULT 0,
  `pDrugs` int(11) NOT NULL DEFAULT 0,
  `pLeader` int(11) NOT NULL DEFAULT 0,
  `pMember` int(11) NOT NULL DEFAULT 0,
  `pRank` int(11) NOT NULL DEFAULT 0,
  `pJob` int(11) NOT NULL DEFAULT 0,
  `pModel` int(11) NOT NULL DEFAULT 0,
  `pPnumber` int(11) NOT NULL,
  `pDirectory` int(11) NOT NULL DEFAULT 0,
  `pVhoddata` int(11) NOT NULL,
  `pVhodMes` int(11) NOT NULL,
  `pVhodchas` int(11) NOT NULL,
  `pVhodminute` int(11) NOT NULL,
  `pCarLic` int(11) NOT NULL DEFAULT 0,
  `pFlyLic` int(11) NOT NULL DEFAULT 0,
  `pBoatLic` int(11) NOT NULL DEFAULT 0,
  `pFishLic` int(11) NOT NULL DEFAULT 0,
  `pGunLic` int(11) NOT NULL DEFAULT 0,
  `pBizLic` int(11) NOT NULL DEFAULT 0,
  `pZakonp` int(11) NOT NULL DEFAULT 0,
  `pAddiction` int(11) NOT NULL DEFAULT 0,
  `pNarcoLomka` int(11) NOT NULL DEFAULT 0,
  `pPayDayHad` int(11) NOT NULL DEFAULT 0,
  `pTut` int(11) NOT NULL DEFAULT 1,
  `pWarns` int(11) NOT NULL DEFAULT 0,
  `OffWarns` varchar(128) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `punWarns` int(11) NOT NULL DEFAULT 0,
  `pFuel` int(11) NOT NULL DEFAULT 0,
  `pMarriedTo` varchar(128) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT '-',
  `pDrug` varchar(128) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT '-',
  `pMushrooms` int(11) NOT NULL DEFAULT 0,
  `pFishes` float NOT NULL DEFAULT 0,
  `pBanks` int(11) NOT NULL DEFAULT 0,
  `pMobile` int(11) NOT NULL DEFAULT 0,
  `pDolg` int(11) NOT NULL DEFAULT 0,
  `pKrisha` int(11) NOT NULL DEFAULT 0,
  `pUseKrisha` int(11) NOT NULL DEFAULT 0,
  `pWantedLevel` int(11) NOT NULL DEFAULT 0,
  `pWeapons` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0',
  `pAmmos` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0',
  `pGunSkills` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL DEFAULT '0, 0, 0, 0, 0, 0',
  `ptaxiexp` int(11) NOT NULL DEFAULT 0,
  `ptaxilvl` int(11) NOT NULL DEFAULT 1,
  `pTraining` int(11) NOT NULL,
  `pBoxSkill` int(11) NOT NULL DEFAULT 0,
  `pKongfuSkill` int(11) NOT NULL DEFAULT 0,
  `pKickboxSkill` int(11) NOT NULL DEFAULT 0,
  `pDLevel` int(11) NOT NULL DEFAULT 1,
  `pDExp` int(11) NOT NULL DEFAULT 0,
  `pDMgruz` int(11) NOT NULL DEFAULT 8,
  `pPSkill` int(11) NOT NULL,
  `pPProc` int(11) NOT NULL,
  `pPMGruz` int(11) NOT NULL,
  `pQuestL` int(11) NOT NULL,
  `pQuest` int(11) NOT NULL,
  `pQuestP` int(11) NOT NULL,
  `pQuestF` int(11) NOT NULL,
  `pQuestPF` int(11) NOT NULL,
  `pQuestShow` int(11) NOT NULL,
  `pOnline` varchar(128) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pChas` int(11) NOT NULL,
  `pMin` int(11) NOT NULL,
  `pEmail` varchar(64) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pOnlineLid` varchar(32) CHARACTER SET cp1251 COLLATE cp1251_bin NOT NULL,
  `pSkilla` int(11) NOT NULL DEFAULT 0,
  `pRecognition` int(11) NOT NULL DEFAULT 0,
  `pRobHouse` int(11) NOT NULL DEFAULT 0,
  `pFishesPach` int(11) NOT NULL DEFAULT 0,
  `activate_mail` int(11) NOT NULL DEFAULT 0,
  `pLogin` int(11) NOT NULL DEFAULT 0,
  `pDrivingSkill` int(11) NOT NULL DEFAULT 0,
  `pDonateAccount` int(11) NOT NULL DEFAULT 0,
  `pChars` varchar(32) NOT NULL,
  `prods_skill` int(11) NOT NULL DEFAULT 1,
  `prods_exp` int(11) NOT NULL DEFAULT 0,
  `pSpawnChange` varchar(11) NOT NULL DEFAULT '1,1',
  `progolos` int(11) NOT NULL DEFAULT 0,
  `grating` int(11) NOT NULL DEFAULT 0
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `admin`
--

CREATE TABLE `admin` (
  `Name` varchar(32) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `level` int(2) NOT NULL,
  `password` varchar(32) NOT NULL DEFAULT 'qwerty',
  `LastCon` varchar(32) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

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

-- --------------------------------------------------------

--
-- Структура таблицы `ban`
--

CREATE TABLE `ban` (
  `ID` int(11) NOT NULL,
  `Text` varchar(255) NOT NULL,
  `Name` varchar(128) NOT NULL,
  `NameAdmin` varchar(128) NOT NULL,
  `Date` varchar(128) NOT NULL,
  `Unban` int(11) NOT NULL,
  `Reason` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `banip`
--

CREATE TABLE `banip` (
  `IP` varchar(255) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `bizz`
--

CREATE TABLE `bizz` (
  `bID` int(11) NOT NULL,
  `bOwner` varchar(32) NOT NULL,
  `bMessage` varchar(64) NOT NULL,
  `bEntranceX` float NOT NULL,
  `bEntranceY` float NOT NULL,
  `bEntranceZ` float NOT NULL,
  `bExitX` float NOT NULL,
  `bExitY` float NOT NULL,
  `bExitZ` float NOT NULL,
  `bBuyPrice` int(11) NOT NULL,
  `bEntranceCost` int(11) NOT NULL,
  `bTill` int(11) NOT NULL,
  `bLocked` int(11) NOT NULL,
  `bInterior` int(11) NOT NULL,
  `bProducts` int(11) NOT NULL,
  `bPrice` int(11) NOT NULL,
  `bBarX` float NOT NULL,
  `bBarY` float NOT NULL,
  `bBarZ` float NOT NULL,
  `bMafia` int(11) NOT NULL,
  `bType` int(11) NOT NULL,
  `bLockTime` int(11) NOT NULL,
  `bLicense` int(11) NOT NULL,
  `bStavka` int(11) NOT NULL,
  `bNameStavka` varchar(50) NOT NULL,
  `bLastStavka` int(11) NOT NULL,
  `bTimeStavka` int(11) NOT NULL,
  `bMinStavka` int(11) NOT NULL,
  `bVirtualWorld` int(11) NOT NULL,
  `bLandTax` int(11) NOT NULL DEFAULT 0,
  `bProdPrice` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `bizz`
--

INSERT INTO `bizz` (`bID`, `bOwner`, `bMessage`, `bEntranceX`, `bEntranceY`, `bEntranceZ`, `bExitX`, `bExitY`, `bExitZ`, `bBuyPrice`, `bEntranceCost`, `bTill`, `bLocked`, `bInterior`, `bProducts`, `bPrice`, `bBarX`, `bBarY`, `bBarZ`, `bMafia`, `bType`, `bLockTime`, `bLicense`, `bStavka`, `bNameStavka`, `bLastStavka`, `bTimeStavka`, `bMinStavka`, `bVirtualWorld`, `bLandTax`, `bProdPrice`) VALUES
(1, 'None', 'Alhambra', 1836.51, -1682.58, 13.345, 493.487, -24.9609, 1000.67, 100000, 100, 0, 1, 17, 0, 100, 499.97, -20.7076, 1000.68, 0, 1, 1, 0, 0, '-', 0, 0, 0, 1, 2400, 16),
(2, 'None', 'PigPen', 2421.59, -1219.51, 25.5444, 1204.67, -13.8521, 1000.92, 100000, 100, 0, 1, 2, 0, 0, 1215.29, -13.2987, 1000.92, 0, 1, 0, 0, 0, '-', 0, 0, 0, 2, 0, 16),
(3, 'None', 'Misty Club', -2242.2, -88.0869, 35.3203, 1212.05, -25.8763, 1000.95, 100000, 0, 0, 1, 3, 0, 0, 1207.24, -29.434, 1000.95, 0, 1, 0, 0, 0, '-', 0, 0, 0, 3, 0, 16),
(4, 'None', 'Casino Chinatown', 1022.49, -1121.42, 23.8701, 1133.18, -12.675, 1000.68, 100000, 100, 0, 1, 12, 0, 0, 1139.72, -4.90998, 1000.67, 0, 1, 0, 0, 0, '-', 0, 0, 0, 4, 0, 16),
(5, 'None', 'Grove Street Bar', 2309.95, -1643.42, 14.8269, 501.903, -67.563, 998.758, 100000, 100, 0, 1, 11, 0, 0, 497.353, -76.0409, 998.758, 0, 1, 0, 0, 0, '-', 0, 0, 0, 5, 0, 16),
(6, 'None', 'Sobrino de Botin', 2269.86, -74.1605, 26.7723, -795.082, 489.282, 1376.2, 100000, 0, 0, 1, 1, 0, 0, -785.496, 500.074, 1371.74, 0, 2, 0, 0, 0, '-', 0, 0, 0, 6, 0, 16),
(7, 'None', 'Vinewood Burger', 1199.18, -918.168, 43.1236, 362.919, -75.207, 1001.51, 100000, 100, 0, 1, 10, 0, 100, 377.075, -67.4374, 1001.51, 0, 2, 1, 0, 0, '-', 0, 0, 0, 7, 2400, 8),
(8, 'None', 'Marina Burger', 810.492, -1616.15, 13.5468, 460.557, -88.594, 999.555, 100000, 0, 0, 1, 4, 0, 0, 450.445, -83.6521, 999.555, 0, 2, 0, 0, 0, '-', 0, 0, 0, 8, 0, 8),
(9, 'None', 'Idlewood Pizza', 2105.48, -1806.37, 13.5546, 372.36, -133.521, 1001.49, 100000, 100, 0, 1, 5, 0, 0, 375.888, -118.817, 1001.5, 0, 2, 0, 0, 0, '-', 0, 0, 0, 9, 0, 8),
(10, 'None', 'Downtown Cluc', -1816.64, 618.672, 35.1719, 366.126, -9.0925, 1001.85, 100000, 100, 50, 1, 9, 0, 100, 369.924, -6.01969, 1001.86, 0, 2, 1, 0, 0, '-', 0, 0, 0, 10, 2400, 8),
(11, 'None', 'Marina Cluc', 928.914, -1352.79, 13.3437, 376.554, -191.184, 1000.63, 100000, 0, 0, 1, 17, 0, 0, 379.239, -187.858, 1000.63, 0, 2, 0, 0, 0, '-', 0, 0, 0, 11, 0, 8),
(12, 'None', 'Idelwood 24/7', 1928.6, -1776.17, 13.5468, -2240.96, 128.329, 1035.41, 100000, 100, 0, 1, 6, 0, 0, -2236.11, 130.158, 1035.41, 0, 3, 0, 0, 0, '-', 0, 0, 0, 12, 0, 16),
(13, 'None', 'Flint 24/7', -78.436, -1170.03, 2.1354, -2240.96, 128.329, 1035.41, 100000, 100, 0, 1, 6, 0, 100, -2236.11, 130.158, 1035.41, 0, 3, 1, 0, 0, '-', 0, 0, 0, 13, 3600, 16),
(14, 'None', 'Easter 24/7', -1676.18, 432.187, 7.1796, -2240.96, 128.329, 1035.41, 100000, 100, 0, 1, 6, 0, 0, -2236.11, 130.158, 1035.41, 0, 3, 0, 0, 0, '-', 0, 0, 0, 14, 0, 16),
(15, 'None', 'Mullholand 24/7', 1000.59, -919.911, 42.328, -2240.96, 128.329, 1035.41, 100000, 100, 0, 1, 6, 0, 100, -2236.11, 130.158, 1035.41, 0, 3, 1, 0, 0, '-', 0, 0, 0, 15, 3600, 16),
(16, 'None', 'Jizzy', -2624.49, 1411.88, 7.0938, -2636.61, 1404.99, 906.461, 100000, 100, 0, 1, 3, 0, 100, -2654.02, 1407.91, 906.277, 0, 1, 1, 0, 0, '-', 0, 0, 0, 16, 2400, 16),
(17, 'None', 'Redsands West 24/7', 1599.12, 2221.87, 11.0625, -2240.96, 128.329, 1035.41, 100000, 0, 0, 1, 6, 0, 0, -2236.11, 130.158, 1035.41, 0, 3, 0, 0, 0, '-', 0, 0, 0, 17, 0, 16),
(18, 'None', 'Julious 24/7', 2637.29, 1129.68, 11.1796, -2240.96, 128.329, 1035.41, 100000, 0, 0, 1, 6, 0, 0, -2236.11, 130.158, 1035.41, 0, 3, 0, 0, 0, '-', 0, 0, 0, 18, 0, 16),
(19, 'None', 'Lil\"Probe\"inn', -89.6103, 1378.24, 10.4697, -227.028, 1401.23, 27.7656, 100000, 0, 0, 1, 18, 0, 0, -224.781, 1404.44, 27.7734, 0, 1, 0, 0, 0, '-', 0, 0, 0, 19, 0, 16),
(20, 'None', 'Idelwood Gas', 1940.93, -1772.94, 13.6406, 0, 0, 0, 100000, 100, 1060, 1, 0, 25848, 1000, 0, 0, 0, 6, 4, 1, 1, 0, '-', 0, 0, 0, 20, 71800, 2),
(21, 'None', 'Mullholand Gas', 1003.76, -936.11, 42.3281, 0, 0, 0, 100000, 100, 0, 1, 0, 0, 100, 0, 0, 0, 0, 4, 1, 0, 0, '-', 0, 0, 0, 21, 1200, 2),
(22, 'None', 'Whetstone 24-7', -1567.11, -2730.04, 48.7435, -2240.96, 128.329, 1035.41, 100000, 0, 0, 1, 6, 0, 0, -2236.11, 130.158, 1035.41, 0, 3, 0, 0, 0, '-', 0, 0, 0, 22, 0, 16),
(23, 'None', 'East Cluc', 2419.85, -1508.87, 24, 460.557, -88.594, 999.555, 100000, 0, 0, 1, 4, 0, 0, 450.445, -83.6521, 999.555, 0, 2, 0, 0, 0, '-', 0, 0, 0, 23, 0, 8),
(24, 'None', 'WillowField Cluc', 2397.94, -1899.2, 13.5469, 460.557, -88.594, 999.555, 100000, 0, 0, 1, 4, 0, 0, 450.445, -83.6521, 999.555, 0, 2, 0, 0, 0, '-', 0, 0, 0, 24, 0, 8),
(25, 'None', 'Flats Cluc', -2672.29, 258.429, 4.63281, 362.919, -75.207, 1001.51, 100000, 0, 0, 1, 10, 0, 0, 377.075, -67.4374, 1001.51, 0, 2, 0, 0, 0, '-', 0, 0, 0, 25, 0, 8),
(26, 'None', 'Financial Pizza', -1808.78, 945.849, 24.8906, 372.36, -133.521, 1001.49, 100000, 0, 0, 1, 5, 0, 0, 375.888, -118.652, 1001.49, 0, 2, 0, 0, 0, '-', 0, 0, 0, 26, 0, 8),
(27, 'None', 'Come-A-Lot Gas', 2115.31, 919.956, 10.8203, 0, 0, 0, 100000, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 27, 0, 2),
(28, 'None', 'FortCarson Gas', 70.6284, 1218.96, 18.8125, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 28, 0, 2),
(29, 'None', 'BoneCountry Gas', 611.912, 1694.78, 6.99219, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 29, 0, 2),
(30, 'None', 'Julius Gas', 2640.31, 1106.13, 10.8203, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 30, 0, 2),
(31, 'None', 'PricklePine Gas', 2146.86, 2748.08, 10.8203, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 31, 0, 2),
(32, 'None', 'Flint Gas', -91.0336, -1168.99, 2.4236, 0, 0, 0, 100000, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 32, 0, 2),
(33, 'None', 'Easter Gas', -1675.54, 413.452, 7.17969, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 33, 0, 2),
(34, 'None', 'Doherty Gas', -2026.7, 156.561, 29.0391, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 34, 0, 2),
(35, 'None', 'Juniper 24/7', -2420.16, 969.801, 45.2969, -2240.47, 137.06, 1035.41, 100000, 0, 0, 1, 6, 0, 0, -2236.11, 130.158, 1035.41, 0, 3, 0, 0, 0, '-', 0, 0, 0, 35, 0, 16),
(36, 'None', 'Juniper Gas', -2410.85, 973.991, 45.4609, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 36, 0, 2),
(37, 'None', 'Emerald Isle 24/7', 2187.71, 2469.6, 11.2422, -2240.47, 137.06, 1035.41, 100000, 0, 0, 1, 6, 0, 0, -2236.11, 130.158, 1035.41, 0, 3, 0, 0, 0, '-', 0, 0, 0, 37, 0, 16),
(38, 'None', 'Emerald Isle Gas', 2202.19, 2474.56, 10.8203, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 38, 0, 2),
(39, 'None', 'Redsands-West Gas', 1596.15, 2198.81, 10.8203, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 39, 0, 2),
(40, 'None', 'ElGuebrabos Gas', -1328.47, 2677.47, 50.0625, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 40, 0, 2),
(41, 'None', 'TierraRobada Gas', -1471.27, 1863.98, 32.6328, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 41, 0, 2),
(42, 'None', 'AngelPine Gas', -2243.93, -2560.73, 31.9219, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 42, 0, 2),
(43, 'None', 'Whestone Gas', -1605.93, -2714.13, 48.5335, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 43, 0, 2),
(44, 'None', 'Dilimore Gas', 655.629, -565.151, 16.3359, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 44, 0, 2),
(45, 'None', 'Montgomery Gas', 1382.44, 460.336, 20.0579, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 4, 0, 0, 0, '-', 0, 0, 0, 45, 0, 2),
(46, 'None', 'Fort-Carson Cluc', 424.202, -1318.55, 14.9907, -2240.47, 137.06, 1035.41, 100000, 100, 0, 1, 6, 0, 0, -2236.11, 130.158, 1035.41, 0, 3, 0, 0, 0, '-', 0, 0, 0, 46, 0, 0),
(47, 'None', 'Four Dragons Bar', 1903.65, 964.972, 10.8203, 0, 0, 0, 100000, 0, 0, 1, 0, 0, 0, 1946.22, 1017.7, 992.469, 0, 1, 0, 0, 0, '0', 0, 0, 0, 1, 0, 0),
(48, 'None', 'Caligula Bar', 2172.78, 1964.97, 1685.95, 0, 0, 0, 100000, 100, 0, 1, 0, 0, 0, 2193.99, 1603.46, 1005.06, 0, 1, 0, 0, 0, '-', 0, 0, 0, 999, 0, 0);

-- --------------------------------------------------------

--
-- Структура таблицы `boost`
--

CREATE TABLE `boost` (
  `Text` varchar(255) NOT NULL,
  `boosttime` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=cp1251 COLLATE=cp1251_general_ci;

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

-- --------------------------------------------------------

--
-- Структура таблицы `donate`
--

CREATE TABLE `donate` (
  `code_one` int(11) NOT NULL,
  `code_two` int(11) NOT NULL,
  `name` varchar(32) NOT NULL,
  `money` int(11) NOT NULL,
  `used` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `donate`
--

INSERT INTO `donate` (`code_one`, `code_two`, `name`, `money`, `used`) VALUES
(26254, 28090, 'Mariotto_Caltabiano', 10000, 1);

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

-- --------------------------------------------------------

--
-- Структура таблицы `gangzone`
--

CREATE TABLE `gangzone` (
  `id` int(11) NOT NULL,
  `coord_one` float NOT NULL,
  `coord_two` float NOT NULL,
  `coord_three` float NOT NULL,
  `coord_four` float NOT NULL,
  `gang_owner` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `gangzone`
--

INSERT INTO `gangzone` (`id`, `coord_one`, `coord_two`, `coord_three`, `coord_four`, `gang_owner`) VALUES
(1, 1642.71, -2174.57, 1770.71, -2073.57, 17),
(2, 1770.71, -2174.57, 1898.71, -2073.57, 17),
(3, 1898.71, -2174.57, 2026.71, -2073.57, 17),
(4, 2026.71, -2174.57, 2154.71, -2073.57, 12),
(5, 2154.71, -2174.57, 2282.71, -2073.57, 12),
(6, 2282.71, -2174.57, 2410.71, -2073.57, 12),
(7, 2410.71, -2174.57, 2538.71, -2073.57, 12),
(8, 2538.71, -2174.57, 2666.71, -2073.57, 12),
(9, 2666.71, -2174.57, 2794.71, -2073.57, 12),
(10, 2794.71, -2174.57, 2922.71, -2073.57, 13),
(11, 1642.71, -2073.57, 1770.71, -1972.57, 17),
(12, 1770.71, -2073.57, 1898.71, -1972.57, 17),
(13, 1898.71, -2073.57, 2026.71, -1972.57, 17),
(14, 2026.71, -2073.57, 2154.71, -1972.57, 12),
(15, 2154.71, -2073.57, 2282.71, -1972.57, 12),
(16, 2282.71, -2073.57, 2410.71, -1972.57, 12),
(17, 2410.71, -2073.57, 2538.71, -1972.57, 12),
(18, 2538.71, -2073.57, 2666.71, -1972.57, 12),
(19, 2666.71, -2073.57, 2794.71, -1972.57, 15),
(20, 2794.71, -2073.57, 2922.71, -1972.57, 13),
(21, 1642.71, -1972.57, 1770.71, -1871.57, 17),
(22, 1770.71, -1972.57, 1898.71, -1871.57, 15),
(23, 1898.71, -1972.57, 2026.71, -1871.57, 17),
(24, 2026.71, -1972.57, 2154.71, -1871.57, 12),
(25, 2154.71, -1972.57, 2282.71, -1871.57, 12),
(26, 2282.71, -1972.57, 2410.71, -1871.57, 12),
(27, 2410.71, -1972.57, 2538.71, -1871.57, 12),
(28, 2538.71, -1972.57, 2666.71, -1871.57, 15),
(29, 2666.71, -1972.57, 2794.71, -1871.57, 15),
(30, 2794.71, -1972.57, 2922.71, -1871.57, 13),
(31, 1642.71, -1871.57, 1770.71, -1770.57, 17),
(32, 1770.71, -1871.57, 1898.71, -1770.57, 17),
(33, 1898.71, -1871.57, 2026.71, -1770.57, 17),
(34, 2026.71, -1871.57, 2154.71, -1770.57, 18),
(35, 2154.71, -1871.57, 2282.71, -1770.57, 18),
(36, 2282.71, -1871.57, 2410.71, -1770.57, 18),
(37, 2410.71, -1871.57, 2538.71, -1770.57, 12),
(38, 2538.71, -1871.57, 2666.71, -1770.57, 12),
(39, 2666.71, -1871.57, 2794.71, -1770.57, 13),
(40, 2794.71, -1871.57, 2922.71, -1770.57, 13),
(41, 1642.71, -1770.57, 1770.71, -1669.57, 17),
(42, 1770.71, -1770.57, 1898.71, -1669.57, 17),
(43, 1898.71, -1770.57, 2026.71, -1669.57, 17),
(44, 2026.71, -1770.57, 2154.71, -1669.57, 18),
(45, 2154.71, -1770.57, 2282.71, -1669.57, 18),
(46, 2282.71, -1770.57, 2410.71, -1669.57, 18),
(47, 2410.71, -1770.57, 2538.71, -1669.57, 15),
(48, 2538.71, -1770.57, 2666.71, -1669.57, 15),
(49, 2666.71, -1770.57, 2794.71, -1669.57, 13),
(50, 2794.71, -1770.57, 2922.71, -1669.57, 13),
(51, 1642.71, -1669.57, 1770.71, -1568.57, 17),
(52, 1770.71, -1669.57, 1898.71, -1568.57, 17),
(53, 1898.71, -1669.57, 2026.71, -1568.57, 17),
(54, 2026.71, -1669.57, 2154.71, -1568.57, 18),
(55, 2154.71, -1669.57, 2282.71, -1568.57, 18),
(56, 2282.71, -1669.57, 2410.71, -1568.57, 18),
(57, 2410.71, -1669.57, 2538.71, -1568.57, 15),
(58, 2538.71, -1669.57, 2666.71, -1568.57, 15),
(59, 2666.71, -1669.57, 2794.71, -1568.57, 13),
(60, 2794.71, -1669.57, 2922.71, -1568.57, 13),
(61, 1642.71, -1568.57, 1770.71, -1467.57, 17),
(62, 1770.71, -1568.57, 1898.71, -1467.57, 17),
(63, 1898.71, -1568.57, 2026.71, -1467.57, 17),
(64, 2026.71, -1568.57, 2154.71, -1467.57, 18),
(65, 2154.71, -1568.57, 2282.71, -1467.57, 18),
(66, 2282.71, -1568.57, 2410.71, -1467.57, 18),
(67, 2410.71, -1568.57, 2538.71, -1467.57, 15),
(68, 2538.71, -1568.57, 2666.71, -1467.57, 15),
(69, 2666.71, -1568.57, 2794.71, -1467.57, 13),
(70, 2794.71, -1568.57, 2922.71, -1467.57, 13),
(71, 1642.71, -1467.57, 1770.71, -1366.57, 17),
(72, 1770.71, -1467.57, 1898.71, -1366.57, 17),
(73, 1898.71, -1467.57, 2026.71, -1366.57, 17),
(74, 2026.71, -1467.57, 2154.71, -1366.57, 18),
(75, 2154.71, -1467.57, 2282.71, -1366.57, 18),
(76, 2282.71, -1467.57, 2410.71, -1366.57, 18),
(77, 2410.71, -1467.57, 2538.71, -1366.57, 15),
(78, 2538.71, -1467.57, 2666.71, -1366.57, 15),
(79, 2666.71, -1467.57, 2794.71, -1366.57, 13),
(80, 2794.71, -1467.57, 2922.71, -1366.57, 13),
(81, 1642.71, -1366.57, 1770.71, -1265.57, 17),
(82, 1770.71, -1366.57, 1898.71, -1265.57, 17),
(83, 1898.71, -1366.57, 2026.71, -1265.57, 17),
(84, 2026.71, -1366.57, 2154.71, -1265.57, 18),
(85, 2154.71, -1366.57, 2282.71, -1265.57, 18),
(86, 2282.71, -1366.57, 2410.71, -1265.57, 18),
(87, 2410.71, -1366.57, 2538.71, -1265.57, 15),
(88, 2538.71, -1366.57, 2666.71, -1265.57, 15),
(89, 2666.71, -1366.57, 2794.71, -1265.57, 13),
(90, 2794.71, -1366.57, 2922.71, -1265.57, 13),
(91, 1642.71, -1265.57, 1770.71, -1164.57, 17),
(92, 1770.71, -1265.57, 1898.71, -1164.57, 17),
(93, 1898.71, -1265.57, 2026.71, -1164.57, 17),
(94, 2026.71, -1265.57, 2154.71, -1164.57, 18),
(95, 2154.71, -1265.57, 2282.71, -1164.57, 18),
(96, 2282.71, -1265.57, 2410.71, -1164.57, 18),
(97, 2410.71, -1265.57, 2538.71, -1164.57, 15),
(98, 2538.71, -1265.57, 2666.71, -1164.57, 15),
(99, 2666.71, -1265.57, 2794.71, -1164.57, 13),
(100, 2794.71, -1265.57, 2922.71, -1164.57, 13),
(101, 1642.71, -1164.57, 1770.71, -1063.57, 17),
(102, 1770.71, -1164.57, 1898.71, -1063.57, 17),
(103, 1898.71, -1164.57, 2026.71, -1063.57, 17),
(104, 2026.71, -1164.57, 2154.71, -1063.57, 18),
(105, 2154.71, -1164.57, 2282.71, -1063.57, 18),
(106, 2282.71, -1164.57, 2410.71, -1063.57, 18),
(107, 2410.71, -1164.57, 2538.71, -1063.57, 15),
(108, 2538.71, -1164.57, 2666.71, -1063.57, 15),
(109, 2666.71, -1164.57, 2794.71, -1063.57, 13),
(110, 2794.71, -1164.57, 2922.71, -1063.57, 13),
(111, 1642.71, -1063.57, 1770.71, -962.568, 17),
(112, 1770.71, -1063.57, 1898.71, -962.568, 17),
(113, 1898.71, -1063.57, 2026.71, -962.568, 17),
(114, 2026.71, -1063.57, 2154.71, -962.568, 18),
(115, 2154.71, -1063.57, 2282.71, -962.568, 18),
(116, 2282.71, -1063.57, 2410.71, -962.568, 18),
(117, 2410.71, -1063.57, 2538.71, -962.568, 15),
(118, 2538.71, -1063.57, 2666.71, -962.568, 15),
(119, 2666.71, -1063.57, 2794.71, -962.568, 15),
(120, 2794.71, -1063.57, 2922.71, -962.568, 15),
(121, 1642.71, -962.568, 1770.71, -861.568, 17),
(122, 1770.71, -962.568, 1898.71, -861.568, 17),
(123, 1898.71, -962.568, 2026.71, -861.568, 17),
(124, 2026.71, -962.568, 2154.71, -861.568, 18),
(125, 2154.71, -962.568, 2282.71, -861.568, 18),
(126, 2282.71, -962.568, 2410.71, -861.568, 18),
(127, 2410.71, -962.568, 2538.71, -861.568, 15),
(128, 2538.71, -962.568, 2666.71, -861.568, 15),
(129, 2666.71, -962.568, 2794.71, -861.568, 15),
(130, 2794.71, -962.568, 2922.71, -861.568, 15);

-- --------------------------------------------------------

--
-- Структура таблицы `grating`
--

CREATE TABLE `grating` (
  `id` int(11) NOT NULL,
  `gang` varchar(32) NOT NULL,
  `mark` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `grating`
--

INSERT INTO `grating` (`id`, `gang`, `mark`) VALUES
(0, 'Rifa', 100),
(1, 'Grove street', 5500),
(2, 'Ballas', 10700),
(3, 'Vagos', 5200),
(4, 'Aztec', 100);

-- --------------------------------------------------------

--
-- Структура таблицы `gratinghistory`
--

CREATE TABLE `gratinghistory` (
  `date` varchar(32) NOT NULL,
  `player` varchar(32) NOT NULL,
  `playerMark` int(11) NOT NULL,
  `Grove street` int(11) NOT NULL,
  `Ballas` int(11) NOT NULL,
  `Rifa` int(11) NOT NULL,
  `Aztec` int(11) NOT NULL,
  `Vagos` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

-- --------------------------------------------------------

--
-- Структура таблицы `house`
--

CREATE TABLE `house` (
  `hID` int(11) NOT NULL,
  `hEntrancex` float NOT NULL,
  `hEntrancey` float NOT NULL,
  `hEntrancez` float NOT NULL,
  `hExitx` float NOT NULL,
  `hExity` float NOT NULL,
  `hExitz` float NOT NULL,
  `hCarx` float NOT NULL,
  `hCary` float NOT NULL,
  `hCarz` float NOT NULL,
  `hCarc` float NOT NULL,
  `hOwner` varchar(40) CHARACTER SET cp1251 COLLATE cp1251_general_ci NOT NULL,
  `hValue` int(11) NOT NULL,
  `hHel` int(11) NOT NULL,
  `hInt` int(11) NOT NULL,
  `hLock` int(11) NOT NULL,
  `hTakings` int(11) NOT NULL,
  `hDate` int(11) NOT NULL,
  `hKlass` int(11) NOT NULL,
  `hVec` int(11) NOT NULL,
  `hVcol1` int(11) NOT NULL,
  `hVcol2` int(11) NOT NULL,
  `hVehSost` int(11) NOT NULL,
  `hNarko` int(11) NOT NULL,
  `hGun1` int(11) NOT NULL,
  `hGun2` int(11) NOT NULL,
  `hGun3` int(11) NOT NULL,
  `hGun4` int(11) NOT NULL,
  `hGun5` int(11) NOT NULL,
  `hGunAmmo1` int(11) NOT NULL,
  `hGunAmmo2` int(11) NOT NULL,
  `hGunAmmo3` int(11) NOT NULL,
  `hGunAmmo4` int(11) NOT NULL,
  `hGunAmmo5` int(11) NOT NULL,
  `hSafes` varchar(64) NOT NULL DEFAULT '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci PACK_KEYS=0 ROW_FORMAT=DYNAMIC;

--
-- Дамп данных таблицы `house`
--

INSERT INTO `house` (`hID`, `hEntrancex`, `hEntrancey`, `hEntrancez`, `hExitx`, `hExity`, `hExitz`, `hCarx`, `hCary`, `hCarz`, `hCarc`, `hOwner`, `hValue`, `hHel`, `hInt`, `hLock`, `hTakings`, `hDate`, `hKlass`, `hVec`, `hVcol1`, `hVcol2`, `hVehSost`, `hNarko`, `hGun1`, `hGun2`, `hGun3`, `hGun4`, `hGun5`, `hGunAmmo1`, `hGunAmmo2`, `hGunAmmo3`, `hGunAmmo4`, `hGunAmmo5`, `hSafes`) VALUES
(1, 1298.45, -797.984, 84.1406, 225.631, 1022.48, 1084.07, 1248.86, -803.995, 84.1406, 178.232, 'None', 30000000, 0, 7, 1, 0, 0, 5, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(2, 1496.95, -687.895, 95.5633, 225.631, 1022.48, 1084.07, 1516.89, -694.469, 94.75, 87.5463, 'None', 25000000, 0, 7, 1, 0, 0, 4, 0, -1, -1, -2034, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(3, 1442.56, -628.832, 95.7186, 225.631, 1022.48, 1084.07, 1460.23, -632.771, 95.7635, 180.188, 'None', 15000000, 0, 7, 1, 15150, 0, 4, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(4, 1527.62, -772.785, 80.5781, 447.049, 1398.1, 1084.3, 1515.96, -766.009, 80.0051, 135.801, 'None', 1000000, 0, 2, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(5, 1273.95, 2522.47, 10.8203, 140.221, 1367.27, 1083.86, 1274.74, 2529.67, 10.8203, 271.382, 'None', 1500000, 0, 5, 1, 999999999, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(6, 1095.02, -647.915, 113.648, 2324.34, -1148.63, 1050.71, 1087.79, -640.185, 113.17, 290.082, 'None', 2000000, 0, 12, 1, 62900, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(7, 1045.17, -642.935, 120.117, 2324.34, -1148.63, 1050.71, 1039.18, -640.881, 120.117, 359.937, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(8, 980.496, -677.258, 121.976, 140.221, 1367.27, 1083.86, 1011.86, -660.505, 121.14, 32.2057, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, -1, -1, -5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(9, 946.368, -710.668, 122.62, 2324.34, -1148.63, 1050.71, 945.38, -717.014, 122.211, 26.2289, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(10, 897.843, -677.238, 116.89, 140.221, 1367.27, 1083.86, 911.015, -664.307, 116.932, 235.746, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(11, 867.508, -717.584, 105.68, 2324.34, -1148.63, 1050.71, 864.959, -712.413, 105.68, 324.478, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(12, 848.033, -745.552, 94.9693, 421.761, 2536.48, 10, 813.536, -768.085, 76.7269, 247.943, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(13, 808.282, -759.446, 76.5314, 22.7405, 1404.38, 1084.43, 814.651, -767.68, 76.884, 285.332, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(14, 835.91, -894.807, 68.7689, 2807.61, -1173.75, 1025.57, 833.108, -888.456, 68.7734, 312.51, 'None', 1500000, 0, 8, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(15, 827.796, -857.991, 70.3308, 2324.34, -1148.63, 1050.71, 829.716, -851.449, 69.9264, 197.556, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(16, 923.932, -853.464, 93.4565, 22.7405, 1404.38, 1084.43, 931.52, -857.033, 93.4802, 21.1338, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(17, 937.877, -848.711, 93.5772, 2324.34, -1148.63, 1050.71, 944.426, -842.095, 94.0379, 30.3225, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(18, 989.712, -828.705, 95.4686, 140.221, 1367.27, 1083.86, 978.935, -829.376, 95.826, 27.2338, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(19, 1034.83, -813.175, 101.852, 140.221, 1367.27, 1083.86, 1029.17, -811.903, 101.852, 20.9255, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(20, 977.48, -771.719, 112.203, 2324.34, -1148.63, 1050.71, 975.163, -758.61, 112.2, 94.4542, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(21, 1094.07, -807.115, 107.418, 225.631, 1022.48, 1084.07, 1093.34, -785.579, 107.247, 75.9907, 'None', 20000000, 0, 7, 1, 17250, 0, 4, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(22, 1112.64, -741.951, 100.133, 2324.34, -1148.63, 1050.71, 1110.52, -732.385, 100.253, 92.3675, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(23, 1535.04, -800.182, 72.8495, 22.7405, 1404.38, 1084.43, 1531.65, -813.545, 72.0639, 86.2215, 'None', 1000000, 0, 5, 1, 150, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(24, 1540.47, -851.257, 64.3361, 2324.34, -1148.63, 1050.71, 1538.22, -841.667, 64.4734, 93.8144, 'None', 1500000, 0, 12, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(25, 1468.54, -906.185, 54.8359, 2324.34, -1148.63, 1050.71, 1463.82, -902.821, 54.8359, 354.891, 'None', 2000000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(26, 1421.93, -886.231, 50.6864, 22.7405, 1404.38, 1084.43, 1428.28, -883.239, 50.7717, 32.9235, 'None', 1000000, 0, 5, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(27, 1410.96, -920.839, 38.4219, 2324.34, -1148.63, 1050.71, 1422.45, -919.569, 36.0469, 171.739, 'None', 1600000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(28, 1440.62, -926.129, 39.6477, 2324.34, -1148.63, 1050.71, 1452.85, -923.571, 37.6094, 176.118, 'None', 1600000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(29, 142.578, -1470.33, 25.2109, 2324.34, -1148.63, 1050.71, 151.612, -1468.74, 25.375, 49.7937, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(30, 227.993, -1405.46, 51.6094, 2324.34, -1148.63, 1050.71, 226.511, -1398.3, 51.5898, 56.3504, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(31, 167.897, -1308.18, 70.3513, 140.221, 1367.27, 1083.86, 166.452, -1340.57, 69.7233, 181.395, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(32, 254.406, -1367.17, 53.1094, 140.221, 1367.27, 1083.86, 251.426, -1359.74, 53.1094, 299.285, 'None', 1500000, 0, 5, 1, 88800, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(33, 298.819, -1338.53, 53.4415, 140.221, 1367.27, 1083.86, 310.163, -1333.69, 53.4475, 31.9099, 'None', 1500000, 0, 5, 1, 999999999, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(34, 251.454, -1220.2, 76.1024, 2317.77, -1026.17, 1050.22, 259.976, -1221.67, 74.6647, 193.836, 'None', 25000000, 0, 9, 1, 0, 0, 5, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(35, 219.203, -1249.83, 78.3366, 140.221, 1367.27, 1083.86, 221.718, -1268.73, 65.2035, 145.57, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(36, 355.037, -1281.18, 53.7036, 421.761, 2536.48, 10, 360.871, -1275.22, 53.7616, 28.8992, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(37, 398.141, -1271.38, 50.0198, 2324.34, -1148.63, 1050.71, 406.647, -1264.8, 50.2139, 25.9342, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(38, 552.899, -1200.29, 44.8315, 140.221, 1367.27, 1083.86, 559.012, -1195.9, 44.6485, 290.035, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(39, 646.028, -1117.38, 44.207, 140.221, 1367.27, 1083.86, 637.279, -1122.59, 44.3924, 42.0463, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(40, 700.373, -1060.14, 49.4217, 2324.34, -1148.63, 1050.71, 688.467, -1073.96, 49.4523, 57.7078, 'None', 2500000, 0, 12, 1, 100, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(41, 731.273, -1012.84, 52.7379, 140.221, 1367.27, 1083.86, 726.9, -995.942, 52.7344, 59.1413, 'None', 1500000, 0, 5, 1, 999999999, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(42, 1325.95, -1067.7, 31.5547, 2324.34, -1148.63, 1050.71, 1330.74, -1060.01, 28.5942, 256.505, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(43, 1326.26, -1090.7, 27.9766, 2324.34, -1148.63, 1050.71, 1325.94, -1081.49, 25.585, 271.134, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(44, 1285.26, -1090.17, 28.2578, 22.7405, 1404.38, 1084.43, 1279.93, -1099.02, 26.0383, 89.5527, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(45, 1285.26, -1067.27, 31.6789, 22.7405, 1404.38, 1084.43, 1278.77, -1058.46, 29.5922, 89.5292, 'None', 1500000, 0, 5, 1, 150, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(46, 1242.27, -1099.67, 27.9766, 2324.34, -1148.63, 1050.71, 1245.86, -1108.34, 25.5066, 270.324, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(47, 1241.95, -1076.27, 31.5547, 22.7405, 1404.38, 1084.43, 1245.62, -1085.54, 28.3467, 270.614, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(48, 1183.47, -1075.91, 31.6789, 22.7405, 1404.38, 1084.43, 1179.06, -1067.44, 28.9857, 91.4089, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(49, 1183.48, -1099.04, 28.2578, 22.7405, 1404.38, 1084.43, 1178.41, -1108.12, 25.2823, 92.3491, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(50, 1142.12, -1093.19, 28.1875, 2324.34, -1148.63, 1050.71, 1146.63, -1101.18, 25.7256, 271.264, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(51, 1141.81, -1069.76, 31.7656, 22.7405, 1404.38, 1084.43, 1144.97, -1079.08, 28.6579, 272.204, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(52, 1103.4, -1069.26, 31.8899, 2324.34, -1148.63, 1050.71, 1098.85, -1060.91, 29.5511, 90.4922, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(53, 1103.4, -1092.53, 28.4688, 447.049, 1398.1, 1084.3, 1098.87, -1101.38, 25.5512, 90.6978, 'None', 1500000, 0, 2, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(54, 1118.11, -1021.67, 34.9922, 2324.34, -1148.63, 1050.71, 1108.18, -1024.29, 31.8868, 185.602, 'None', 2500000, 0, 12, 1, 100, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(55, 1128.01, -1021.56, 34.9922, 22.7405, 1404.38, 1084.43, 1137.67, -1024.26, 31.8906, 175.575, 'None', 1500000, 0, 5, 1, 150, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(56, 1051.13, -1059.03, 34.7966, 2324.34, -1148.63, 1050.71, 1040.86, -1055.42, 31.7031, 359.167, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(57, 993.66, -1059.03, 33.6995, 22.7405, 1404.38, 1084.43, 1004.16, -1054.36, 30.918, 3.88998, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(58, 985.867, -1094.39, 27.6041, 22.7405, 1404.38, 1084.43, 974.274, -1091.57, 24.2134, 87.2374, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(59, 1059.34, -1105.14, 28.0451, 2365.2, -1134.69, 1050.88, 1070.61, -1102.46, 24.7116, 266.31, 'None', 1500000, 0, 8, 1, 7050, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(60, 725.558, -1451.04, 17.6953, 140.221, 1367.27, 1083.86, 716.666, -1436.73, 13.5391, 32.4317, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(61, 813.536, -1456.84, 14.1641, 2324.34, -1148.63, 1050.71, 809.323, -1464.09, 13.1075, 87.6159, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(62, 822.427, -1505.24, 14.3946, 2324.34, -1148.63, 1050.71, 830.162, -1502.02, 13.0099, 2.58088, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(63, 841.207, -1471.41, 14.2882, 2324.34, -1148.63, 1050.71, 833.463, -1474.54, 13.0028, 180, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(64, 852.265, -1423.09, 14.1423, 2324.34, -1148.63, 1050.71, 844.524, -1419.71, 12.8031, 358.334, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(65, 791.04, -1661.21, 13.4853, -68.8618, 1352.22, 1080.21, 788.989, -1668.36, 13.4739, 269.053, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(66, 794.812, -1692.09, 14.4633, -68.8618, 1352.22, 1080.21, 802.902, -1688.56, 13.5469, 179.066, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(67, 793.977, -1707.59, 14.0382, 421.761, 2536.48, 10, 802.818, -1700.75, 13.5469, 179.775, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(68, 797.237, -1729.31, 13.5469, 421.761, 2536.48, 10, 802.651, -1724.86, 13.5391, 179.379, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(69, 791.457, -1753.21, 13.4606, 2324.34, -1148.63, 1050.71, 795.845, -1761.61, 13.476, 85.821, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(70, 769.228, -1746.08, 13.0773, 2324.34, -1148.63, 1050.71, 762.335, -1751.33, 12.7963, 356.567, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(71, 769.226, -1696.63, 5.15542, -68.8618, 1352.22, 1080.21, 762.158, -1700.93, 5.19783, 1.60352, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(72, 768.079, -1655.79, 5.60938, 421.761, 2536.48, 10, 765.354, -1660.08, 5.70324, 90.1564, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(73, 766.923, -1605.79, 13.8039, -68.8618, 1352.22, 1080.21, 759.42, -1602.26, 13.3727, 180.634, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(74, 692.916, -1602.77, 15.0469, -68.8618, 1352.22, 1080.21, 688.51, -1600.73, 14.1005, 359.549, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(75, 653.244, -1619.78, 15, -68.8618, 1352.22, 1080.21, 646.122, -1615.64, 15.22, 357.099, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(76, 657.222, -1652.67, 15.4062, 421.761, 2536.48, 10, 653.914, -1656.94, 14.5957, 86.578, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(77, 652.663, -1694.02, 14.5503, 421.761, 2536.48, 10, 643.919, -1691.04, 14.9957, 170.969, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(78, 653.593, -1714.01, 14.7648, -68.8618, 1352.22, 1080.21, 640.419, -1713.87, 14.3516, 170.239, 'None', 350000, 0, 6, 1, 100, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(79, 902.838, -1815.45, 13.3029, 22.7405, 1404.38, 1084.43, 905.595, -1821.82, 12.5745, 263.82, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(80, 914.408, -1816.72, 13.3081, 22.7405, 1404.38, 1084.43, 913.166, -1823.96, 12.5239, 260.152, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(81, 926.01, -1818.01, 13.3247, 22.7405, 1404.38, 1084.43, 925.916, -1825.52, 12.5891, 261.405, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(82, 960.926, -1824.06, 13.3267, 22.7405, 1404.38, 1084.43, 959.307, -1830.63, 12.5999, 256.055, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(83, 972.526, -1826.78, 13.3335, 2269.51, -1210.53, 1047.56, 973.689, -1833.79, 12.6112, 252.193, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(84, 983.83, -1829.56, 13.3297, 2237.54, -1080.53, 1049.02, 983.136, -1836.56, 12.611, 252.843, 'None', 1500000, 0, 2, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(85, 315.942, -1769.43, 4.6234, 2324.34, -1148.63, 1050.71, 322.613, -1764.94, 4.58081, 179.653, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(86, 167.765, -1758.91, 6.79688, 2324.34, -1148.63, 1050.71, 167.68, -1775.35, 4.20098, 88.9326, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(87, 1804.22, -2124.9, 13.9424, -68.8618, 1352.22, 1080.21, 1793.34, -2129.8, 13.5469, 0.710241, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(88, 1801.95, -2098.94, 14.021, 421.761, 2536.48, 10, 1800.01, -2106.32, 13.5469, 269.553, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(89, 1781.48, -2101.27, 14.0566, 421.761, 2536.48, 10, 1773.23, -2096.91, 13.5469, 177.142, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(90, 1782.03, -2126.51, 14.0679, 421.761, 2536.48, 10, 1772.25, -2127.02, 13.5469, 358.854, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(91, 1762.41, -2101.98, 13.857, 421.761, 2536.48, 10, 1758.66, -2106.93, 13.5469, 268.323, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(92, 1761.18, -2125.45, 14.0566, 421.761, 2536.48, 10, 1744.94, -2127.44, 13.5469, 357.601, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(93, 1734.79, -2130.36, 14.021, 421.761, 2536.48, 10, 1724.9, -2128.08, 13.5543, 357.914, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(94, 1734.08, -2097.98, 14.0366, 421.761, 2536.48, 10, 1747.47, -2094.22, 13.5469, 177.769, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(95, 1711.57, -2101.23, 14.021, 421.761, 2536.48, 10, 1724.88, -2096.03, 13.5469, 177.746, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(96, 1715.15, -2125.45, 14.0566, 421.761, 2536.48, 10, 1710.7, -2118.88, 13.5469, 269.577, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(97, 1695.57, -2125.83, 13.8101, 421.761, 2536.48, 10, 1704.42, -2129.68, 13.5469, 1.38423, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(98, 1684.82, -2098.15, 13.8343, -68.8618, 1352.22, 1080.21, 1698.97, -2083.01, 13.5469, 178.274, 'None', 350000, 0, 6, 1, 70700, 0, 1, 0, -1, -1, -2915, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(99, 1673.66, -2122.44, 14.146, 421.761, 2536.48, 10, 1672.25, -2116.72, 13.5469, 269.67, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(100, 1851.74, -2134.84, 15.3882, 421.761, 2536.48, 10, 1856.82, -2144.44, 13.5469, 89.259, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(101, 1872.49, -2132.9, 15.482, -68.8618, 1352.22, 1080.21, 1878.4, -2143.88, 13.5469, 87.6925, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(102, 1894.24, -2133.2, 15.4663, -68.8618, 1352.22, 1080.21, 1899.79, -2143.92, 13.5469, 87.7393, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(103, 1851.78, -2070.46, 15.4812, 421.761, 2536.48, 10, 1849.55, -2058.64, 13.5469, 89.7972, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(104, 1873.56, -2070.75, 15.4971, -68.8618, 1352.22, 1080.21, 1878.29, -2058.24, 13.5469, 89.844, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(105, 1895.49, -2068.91, 15.6689, 421.761, 2536.48, 10, 1899.94, -2058.1, 13.5469, 91.0972, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(106, 1938.54, -1911.32, 15.2568, 421.761, 2536.48, 10, 1943.81, -1926.17, 13.5469, 86.7103, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(107, 1913.42, -1911.9, 15.2568, -68.8618, 1352.22, 1080.21, 1908.25, -1926.33, 13.5469, 90.5172, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(108, 1891.91, -1914.39, 15.2568, -68.8618, 1352.22, 1080.21, 1896.41, -1926.6, 13.5469, 87.1174, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(109, 1872.2, -1911.79, 15.2568, -68.8618, 1352.22, 1080.21, 1874.92, -1926.38, 13.5469, 86.1776, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(110, 1854.02, -1914.26, 15.2568, 421.761, 2536.48, 10, 1853.17, -1926.02, 14.8855, 88.2883, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(111, 1969.3, -1705.14, 15.9688, 421.761, 2536.48, 10, 1973.07, -1708.37, 15.9688, 88.2212, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(112, 1980.99, -1682.87, 17.0538, 2807.61, -1173.75, 1025.57, 1980.26, -1710.56, 15.9688, 265.86, 'None', 1500000, 0, 8, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(113, 1980.38, -1718.99, 17.0304, 22.7405, 1404.38, 1084.43, 1982, -1711.82, 15.9688, 266.393, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(114, 1973.3, -1654.67, 15.9688, -68.8618, 1352.22, 1080.21, 1968.75, -1657.54, 15.9688, 265.881, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(115, 2011.38, -1594.37, 13.5834, 421.761, 2536.48, 10, 2014.63, -1597.33, 13.5717, 141.076, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(116, 1972.92, -1559.9, 13.6396, -68.8618, 1352.22, 1080.21, 1967.03, -1564.01, 13.624, 228.979, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(117, 2018.05, -1629.94, 14.0426, 421.761, 2536.48, 10, 2008.36, -1634.22, 13.5469, 0.980983, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(118, 2016.54, -1641.66, 14.1129, -68.8618, 1352.22, 1080.21, 2025.67, -1648.32, 13.5547, 89.6555, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(119, 2013.43, -1656.51, 14.1363, 421.761, 2536.48, 10, 2007.8, -1656.4, 13.5469, 180.209, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(120, 2018.24, -1703.28, 14.2344, 421.761, 2536.48, 10, 2018.02, -1707.65, 13.5469, 86.5075, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(121, 2016.2, -1716.96, 14.125, -68.8618, 1352.22, 1080.21, 2008.11, -1722.14, 13.5469, 358.17, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(122, 2015.35, -1732.56, 14.2344, 421.761, 2536.48, 10, 2014.96, -1737.4, 13.5547, 87.9525, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(123, 2067.05, -1731.62, 14.2066, -68.8618, 1352.22, 1080.21, 2075.24, -1728.17, 13.5469, 181.832, 'None', 350000, 0, 6, 1, 33600, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(124, 2066.24, -1717.13, 14.1363, -68.8618, 1352.22, 1080.21, 2075.24, -1712.31, 13.5469, 179.059, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(125, 2065.1, -1703.51, 14.1484, 421.761, 2536.48, 10, 2051.86, -1694.73, 13.5547, 269.961, 'None', 130000, 0, 10, 1, 6500, 0, 0, 0, -1, -1, -971, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(126, 2066.74, -1656.54, 14.1328, 421.761, 2536.48, 10, 2073.85, -1656.1, 13.5469, 180.093, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(127, 2067.56, -1643.74, 14.1363, -68.8618, 1352.22, 1080.21, 2065.37, -1637.05, 13.5469, 268.523, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(128, 2067.7, -1629, 14.2066, 421.761, 2536.48, 10, 2076.09, -1626.53, 13.5469, 357.824, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(129, 2143.1, -1604.71, 14.3516, 421.761, 2536.48, 10, 2138.73, -1608.12, 14.039, 190.526, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(130, 2151.04, -1789.1, 13.5093, 421.761, 2536.48, 10, 2154.29, -1793, 13.5288, 238.553, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(131, 2145.13, -1801.79, 16.1406, 2217.91, -1076.32, 1050.48, 2153.3, -1801.58, 13.5654, 301.341, 'None', 130000, 0, 1, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(132, 2146.52, -1808.45, 16.1406, 421.761, 2536.48, 10, 2153.62, -1806.39, 13.5557, 301.173, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(133, 2146.47, -1815.06, 16.1406, 421.761, 2536.48, 10, 2155.03, -1811.63, 13.5469, 310.353, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(134, 2164.82, -1819.7, 16.1406, 421.761, 2536.48, 10, 2163.3, -1812.1, 13.5469, 332.502, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(135, 2172.4, -1819.7, 16.1406, 421.761, 2536.48, 10, 2171.45, -1812.43, 13.5469, 340.022, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(136, 2232.79, -1785.74, 13.56, -68.8618, 1352.22, 1080.21, 2222.02, -1792.04, 13.5625, 357.807, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(137, 2275.82, -1785.71, 13.5469, -68.8618, 1352.22, 1080.21, 2261.97, -1789.68, 13.5469, 357.18, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(138, 2307.68, -1785.64, 13.5572, -68.8618, 1352.22, 1080.21, 2299.27, -1788.93, 13.5469, 357.807, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(139, 2321.96, -1796.06, 13.5469, -68.8618, 1352.22, 1080.21, 2326.24, -1799.89, 13.5469, 316.76, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(140, 2380.68, -1785.62, 13.5469, -68.8618, 1352.22, 1080.21, 2370.34, -1789.06, 13.5469, 356.844, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(141, 2394.96, -1795.98, 13.5469, -68.8618, 1352.22, 1080.21, 2407.75, -1799.23, 13.5469, 357.807, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(142, 2308.86, -1714.49, 14.9801, 421.761, 2536.48, 10, 2314.07, -1726.13, 13.5469, 89.0113, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(143, 2326.79, -1716.7, 14.2379, 421.761, 2536.48, 10, 2328.42, -1725.09, 13.537, 86.5514, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(144, 2326.88, -1681.96, 14.9297, -68.8618, 1352.22, 1080.21, 2327.39, -1677.22, 14.4238, 264.863, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(145, 2307.12, -1679.2, 14.3316, -68.8618, 1352.22, 1080.21, 2305.34, -1673.61, 14.1215, 342.571, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(146, 2362.87, -1643.15, 14.3516, 421.761, 2536.48, 10, 2367.49, -1652.3, 13.5469, 90.1151, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(147, 2393.25, -1646.04, 13.9051, -68.8618, 1352.22, 1080.21, 2397.89, -1652.26, 13.5421, 89.8252, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(148, 2368.3, -1675.35, 14.1682, 421.761, 2536.48, 10, 2361.71, -1673.06, 13.5463, 359.272, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(149, 2384.64, -1675.82, 15.2457, 421.761, 2536.48, 10, 2393.13, -1676.02, 14.1753, 358.308, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(150, 2408.98, -1674.94, 14.375, 421.761, 2536.48, 10, 2411.84, -1665.24, 13.5469, 87.5851, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(151, 2413.8, -1646.79, 14.0119, 421.761, 2536.48, 10, 2419.01, -1652.16, 13.5469, 88.8383, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(152, 2451.9, -1641.41, 14.0662, -68.8618, 1352.22, 1080.21, 2443.15, -1642.73, 13.4588, 178.789, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(153, 2469.48, -1646.35, 13.7801, 421.761, 2536.48, 10, 2471.59, -1652.98, 13.4688, 88.8851, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(154, 2486.38, -1644.53, 14.0772, -68.8618, 1352.22, 1080.21, 2486.84, -1653.15, 13.4729, 86.6918, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(155, 2524.71, -1658.59, 15.824, 421.761, 2536.48, 10, 2516.03, -1663.93, 13.8225, 102.985, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(156, 2523.27, -1679.28, 15.497, 225.631, 1022.48, 1084.07, 2517.01, -1671.98, 13.9787, 49.1382, 'None', 350000, 0, 7, 1, 33100, 0, 5, 0, -1, -1, -59, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(157, 2459.45, -1691.66, 13.5458, 421.761, 2536.48, 10, 2474.03, -1695.31, 13.5155, 0.594461, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(158, 2498.52, -1642.26, 14.1131, 421.761, 2536.48, 10, 2501.79, -1648.9, 13.5747, 110.935, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(159, 2851.85, -1366.07, 14.1708, 140.221, 1367.27, 1083.86, 2855.61, -1355.81, 11.066, 264.517, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(160, 2842.08, -1334.8, 14.7421, 2324.34, -1148.63, 1050.71, 2852.83, -1330.18, 10.7959, 278.035, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(161, 2847.02, -1309.84, 14.685, 22.7405, 1404.38, 1084.43, 2845.69, -1286.65, 19.2649, 277.954, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(162, 2808.1, -1190.89, 25.3404, -68.8618, 1352.22, 1080.21, 2808.51, -1186.89, 25.3437, 267.348, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(163, 2808.08, -1175.91, 25.3798, 421.761, 2536.48, 10, 2808.56, -1179.1, 25.3611, 266.408, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(164, 2781.94, -1358.51, 26.3707, 22.7405, 1404.38, 1084.43, 2780.95, -1366.41, 24.637, 269.227, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(165, 2781.94, -1333.39, 32.399, 22.7405, 1404.38, 1084.43, 2781.05, -1341.44, 30.6649, 270.84, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(166, 2782.15, -1306.41, 38.8819, 22.7405, 1404.38, 1084.43, 2781.25, -1314.15, 36.8141, 270.79, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(167, 2782.15, -1281.45, 44.3737, 22.7405, 1404.38, 1084.43, 2780.71, -1289.05, 42.3668, 266.798, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(168, 2809.53, -1280.99, 43.9026, 22.7405, 1404.38, 1084.43, 2811.51, -1287.52, 42.284, 89.5735, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(169, 2809.53, -1302.96, 38.925, 22.7405, 1404.38, 1084.43, 2811.27, -1309.47, 37.3237, 91.477, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(170, 2809.53, -1324.76, 33.8745, 22.7405, 1404.38, 1084.43, 2811.29, -1331.48, 32.2677, 90.2655, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(171, 2797.86, -1245.39, 47.3786, 22.7405, 1404.38, 1084.43, 2804.67, -1253.73, 46.9531, 135.028, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(172, 2776.02, -1245.37, 49.5797, 22.7405, 1404.38, 1084.43, 2782.56, -1243.24, 47.8772, 182.555, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(173, 2750.39, -1238.72, 61.5245, -68.8618, 1352.22, 1080.21, 2744.17, -1234.44, 62.0841, 178.395, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(174, 2750.39, -1222.23, 64.6016, -68.8618, 1352.22, 1080.21, 2743.78, -1222.38, 64.2441, 179.312, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(175, 2750.39, -1205.72, 67.4844, -68.8618, 1352.22, 1080.21, 2743.84, -1208.28, 66.7938, 179.972, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(176, 2756.31, -1182.81, 69.4035, 2324.34, -1148.63, 1050.71, 2759.04, -1176.63, 69.4057, 92.1393, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(177, 2635.58, -2012.88, 14.1443, 421.761, 2536.48, 10, 2635.98, -2004.84, 13.5565, 269.617, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(178, 2637.12, -1991.65, 14.324, 421.761, 2536.48, 10, 2634.91, -1999.36, 13.5525, 266.55, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(179, 2652.8, -1989.43, 13.9988, 421.761, 2536.48, 10, 2645.24, -1989.86, 13.5536, 179.087, 'None', 130000, 0, 10, 1, 35100, 0, 0, 0, 0, 0, -3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(180, 2672.72, -1989.47, 14.324, 421.761, 2536.48, 10, 2684.91, -1987.15, 13.5523, 180, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(181, 2696.41, -1990.36, 14.2229, -68.8618, 1352.22, 1080.21, 2699.59, -1996.78, 13.5547, 270.87, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(182, 2695.35, -2020.55, 14.0223, -68.8618, 1352.22, 1080.21, 2685.03, -2018.53, 13.5415, 1.08786, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(183, 2673.3, -2020.29, 14.1682, 421.761, 2536.48, 10, 2676.11, -2010.45, 13.5547, 270.31, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(184, 2524.35, -1998.3, 14.1131, -68.8618, 1352.22, 1080.21, 2528.28, -2007.13, 13.5469, 89.2109, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(185, 2522.64, -2019.1, 14.0744, -68.8618, 1352.22, 1080.21, 2527.15, -2012.07, 13.554, 89.3975, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(186, 2507.87, -2021.05, 14.2101, 421.761, 2536.48, 10, 2498.01, -2022.92, 13.5469, 359.966, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(187, 2508.29, -1998.37, 13.9025, 421.761, 2536.48, 10, 2513.23, -2002.38, 13.5469, 90.1837, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(188, 2486.41, -2021.55, 13.9988, 421.761, 2536.48, 10, 2491.18, -2016.09, 13.5469, 88.481, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(189, 2483.48, -1995.34, 13.8343, 421.761, 2536.48, 10, 2495.15, -1995.76, 13.5177, 178.577, 'None', 2000000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(190, 2465.42, -2020.79, 14.1242, 421.761, 2536.48, 10, 2466.4, -2015.89, 13.5469, 90.8666, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(191, 2465.03, -1995.75, 14.0193, -68.8618, 1352.22, 1080.21, 2473.61, -1995.81, 13.5469, 181.879, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(192, 2437.89, -2020.84, 13.9025, -68.8618, 1352.22, 1080.21, 2451.85, -2024.17, 13.5469, 1.27579, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(193, 2439.59, -1357.19, 24.1007, 421.761, 2536.48, 10, 2444.37, -1364.86, 24, 359.682, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(194, 2439.59, -1338.98, 24.1016, -68.8618, 1352.22, 1080.21, 2444.4, -1343.91, 24, 358.742, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(195, 2434.8, -1289.33, 25.3479, 421.761, 2536.48, 10, 2444.64, -1293.79, 24, 0, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(196, 2433.6, -1274.98, 24.7567, -68.8618, 1352.22, 1080.21, 2444.27, -1277.09, 24, 359.369, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(197, 2469.18, -1278.38, 30.3664, 421.761, 2536.48, 10, 2457.64, -1280.68, 24, 179.201, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(198, 2470.37, -1295.53, 30.2332, 421.761, 2536.48, 10, 2457.6, -1293.63, 24, 179.828, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(199, 2472.84, -1238.12, 32.5695, 421.761, 2536.48, 10, 2466, -1247.94, 25.3579, 166.377, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(200, 2492.11, -1239.01, 37.9054, 421.761, 2536.48, 10, 2486.71, -1247.24, 30.9704, 181.173, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(201, 2374.03, -1138.92, 29.0588, 421.761, 2536.48, 10, 2372.57, -1147.84, 27.625, 90.9788, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(202, 2394.9, -1133.54, 30.7188, 421.761, 2536.48, 10, 2399.8, -1134.46, 30.1288, 183.39, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(203, 2488.03, -1135.24, 39.5859, 421.761, 2536.48, 10, 2492.27, -1143.2, 38.417, 88.7622, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(204, 2510.57, -1132.68, 41.6207, -68.8618, 1352.22, 1080.21, 2503.08, -1131.06, 39.3074, 155.816, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(205, 2467.69, -1200.41, 36.8117, -68.8618, 1352.22, 1080.21, 2464.45, -1191.93, 37.1534, 100.402, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(206, 2514.54, -1240.45, 39.3406, 22.7405, 1404.38, 1084.43, 2514.44, -1250.13, 35.0547, 87.2892, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(207, 2551.05, -1233.8, 49.3318, 421.761, 2536.48, 10, 2546.91, -1248.44, 42.0366, 177.283, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(208, 2550.33, -1197.53, 60.8435, -68.8618, 1352.22, 1080.21, 2558.87, -1194.99, 61.4504, 357.428, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(209, 2627.64, -1085.13, 69.7156, 421.761, 2536.48, 10, 2636.29, -1082.29, 69.6198, 179.316, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(210, 2628.1, -1068.03, 69.7156, 421.761, 2536.48, 10, 2636.24, -1067.75, 69.625, 178.69, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(211, 2625.94, -1098.74, 69.3582, -68.8618, 1352.22, 1080.21, 2629.13, -1097.47, 69.4882, 260.181, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(212, 2625.94, -1112.72, 67.9953, -68.8618, 1352.22, 1080.21, 2635.99, -1112.37, 67.991, 179.654, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(213, 2579.65, -1033.2, 69.5798, 421.761, 2536.48, 10, 2570.75, -1030.3, 69.5828, 178.06, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(214, 2562.11, -1034.4, 69.8692, 221.677, 1142.5, 1082.61, 2560.85, -1040.02, 69.5724, 92.5195, 'None', 130000, 0, 4, 1, 35350, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(215, 2549.2, -1032.23, 69.5788, 421.761, 2536.48, 10, 2547.5, -1040.01, 69.5704, 90.6161, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(216, 2526.86, -1033.52, 69.5793, 421.761, 2536.48, 10, 2535.39, -1030.58, 69.5813, 178.327, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(217, 2512.71, -1027.16, 70.0859, 421.761, 2536.48, 10, 2503.53, -1023.65, 70.0859, 174.782, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(218, 2534.48, -1063.36, 69.5655, 421.761, 2536.48, 10, 2530.6, -1066.67, 69.5657, 4.15124, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(219, 2526.09, -1060.75, 69.9708, 421.761, 2536.48, 10, 2523.43, -1055.37, 69.5701, 88.1254, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(220, 2499.75, -1065.55, 70.2359, 421.761, 2536.48, 10, 2497.89, -1060.21, 70.1328, 357.133, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(221, 2479.7, -1063.92, 66.9982, 421.761, 2536.48, 10, 2474.13, -1061.91, 66.8359, 342.08, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(222, 2457.76, -1054.66, 59.9592, 421.761, 2536.48, 10, 2452.22, -1051.37, 59.7422, 356.779, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(223, 2491.34, -1012.35, 65.3984, 421.761, 2536.48, 10, 2486.08, -1014.1, 65.3543, 151.983, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(224, 2462.31, -1011.11, 60.1137, 421.761, 2536.48, 10, 2454.02, -1013.51, 59.7748, 176.11, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(225, 2439.9, -1010.88, 54.3438, 421.761, 2536.48, 10, 2426.97, -1011.37, 54.3438, 195.439, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(226, 2440.53, -1057.34, 54.7387, 421.761, 2536.48, 10, 2431.98, -1053.61, 54.3438, 0.601984, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(227, 2389.23, -1037.07, 53.5472, 421.761, 2536.48, 10, 2381.07, -1046.77, 53.7853, 233.69, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(228, 2576.68, -1070.71, 69.8322, -68.8618, 1352.22, 1080.21, 2568.48, -1063.85, 69.4217, 169.716, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(229, 2572.34, -1091.81, 67.2257, -68.8618, 1352.22, 1080.21, 2565.66, -1096.64, 66.2424, 43.8776, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(230, 2519.03, -1112.96, 56.5926, 421.761, 2536.48, 10, 2524.97, -1109.94, 56.5971, 349.694, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(231, 2470.6, -1105.32, 44.4879, 421.761, 2536.48, 10, 2475.24, -1095.83, 45.2807, 84.3243, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(232, 2456.95, -1102.48, 43.8672, -68.8618, 1352.22, 1080.21, 2452.7, -1100.51, 43.1789, 358.784, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(233, 2438.61, -1105.79, 43.0816, -68.8618, 1352.22, 1080.21, 2439.9, -1095.99, 42.4408, 65.8578, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(234, 2407.9, -1106.97, 40.2957, 421.761, 2536.48, 10, 2412.54, -1095.11, 40.1096, 95.3114, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(235, 2287.5, -1081.05, 48.2472, 421.761, 2536.48, 10, 2294.62, -1080.99, 47.5945, 69.9717, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0');
INSERT INTO `house` (`hID`, `hEntrancex`, `hEntrancey`, `hEntrancez`, `hExitx`, `hExity`, `hExitz`, `hCarx`, `hCary`, `hCarz`, `hCarc`, `hOwner`, `hValue`, `hHel`, `hInt`, `hLock`, `hTakings`, `hDate`, `hKlass`, `hVec`, `hVcol1`, `hVcol2`, `hVehSost`, `hNarko`, `hGun1`, `hGun2`, `hGun3`, `hGun4`, `hGun5`, `hGunAmmo1`, `hGunAmmo2`, `hGunAmmo3`, `hGunAmmo4`, `hGunAmmo5`, `hSafes`) VALUES
(236, 2278.79, -1077.43, 48.2373, 421.761, 2536.48, 10, 2274.59, -1072.93, 47.6782, 54.6182, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(237, 2249.27, -1060.26, 55.9688, 421.761, 2536.48, 10, 2244.36, -1050.03, 53.3431, 45.5314, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(238, 2218.99, -1031.86, 60.2641, 421.761, 2536.48, 10, 2215.15, -1026.81, 60.4541, 63.3916, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(239, 2208.28, -1026.69, 61.3502, 421.761, 2536.48, 10, 2202.25, -1020.61, 61.5276, 63.3916, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(240, 2186.55, -997.337, 66.4688, 421.761, 2536.48, 10, 2176.19, -985.518, 64.1958, 172.636, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(241, 2139.78, -1008.43, 61.9853, 421.761, 2536.48, 10, 2140.44, -1005.06, 61.7181, 68.9791, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(242, 2154.12, -979.862, 63.2934, 421.761, 2536.48, 10, 2150.71, -994.891, 62.4128, 75.896, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(243, 2142.66, -978.234, 61.3793, 421.761, 2536.48, 10, 2136.56, -991.118, 60.3246, 73.255, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(244, 2131.95, -974.016, 59.7856, 2233.69, -1112.81, 1050.88, 2126.6, -987.548, 58.4068, 71.1491, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(245, 2122.06, -970.291, 58.2074, 421.761, 2536.48, 10, 2116.81, -984.615, 56.3514, 74.5084, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(246, 2108.95, -1000.79, 60.5078, 421.761, 2536.48, 10, 2119.45, -998.475, 57.729, 72.6518, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(247, 2073.43, -965.168, 49.3915, 421.761, 2536.48, 10, 2075.83, -973.099, 49.4178, 159.759, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(248, 2066.26, -993.201, 48.7998, -68.8618, 1352.22, 1080.21, 2070.7, -986.688, 48.9523, 75.5358, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(249, 2051.27, -954.69, 48.0341, -68.8618, 1352.22, 1080.21, 2054.97, -970.066, 45.7467, 168.219, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(250, 2049, -987.278, 44.9784, 421.761, 2536.48, 10, 2059, -986.903, 46.6333, 359.395, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(251, 2015.57, -977.574, 36.9531, 421.761, 2536.48, 10, 2016.37, -982.216, 36.1024, 127.196, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(252, 2045.17, -965.83, 44.5542, 421.761, 2536.48, 10, 2032.03, -964.184, 42.5345, 116.559, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(253, 2000.27, -991.589, 32.1314, 421.761, 2536.48, 10, 2004.91, -992.333, 32.22, 138.163, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(254, 1906.01, -1112.94, 26.6641, -68.8618, 1352.22, 1080.21, 1910.77, -1115.88, 25.6641, 177.976, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(255, 1921.3, -1115.2, 27.0883, 421.761, 2536.48, 10, 1920.75, -1129.14, 24.9988, 269.47, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(256, 1939.05, -1114.48, 27.4523, 421.761, 2536.48, 10, 1934.17, -1122.34, 26.2846, 181.759, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(257, 1955.12, -1115.34, 27.8305, 421.761, 2536.48, 10, 1947.66, -1130.14, 25.6765, 271.71, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(258, 2000.03, -1114.05, 27.125, 2324.34, -1148.63, 1050.71, 2003.82, -1119.61, 26.7812, 180.924, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(259, 2022.96, -1120.26, 26.421, 22.7405, 1404.38, 1084.43, 2015.38, -1128.96, 25.0778, 268.263, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(260, 2045.65, -1116.65, 26.3617, 421.761, 2536.48, 10, 2051.89, -1118.63, 24.8733, 181.179, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(261, 2093.93, -1122.67, 27.6899, 421.761, 2536.48, 10, 2078.55, -1121.25, 24.144, 181.516, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(262, 2095.36, -1145.17, 26.5929, -68.8618, 1352.22, 1080.21, 2087.35, -1141.03, 25.2202, 94.432, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(263, 2092.24, -1166.52, 26.5859, -68.8618, 1352.22, 1080.21, 2089.63, -1170.79, 25.5938, 84.4052, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(264, 2091.62, -1184.3, 27.0571, 421.761, 2536.48, 10, 2078.72, -1188.29, 23.8229, 181.539, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(265, 2090.74, -1235.18, 26.0191, 421.761, 2536.48, 10, 2094.03, -1227.34, 23.9766, 270.527, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(266, 2110.99, -1244.4, 25.8516, 421.761, 2536.48, 10, 2105, -1240.69, 24.8409, 359.806, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(267, 2133.38, -1233, 24.4219, 421.761, 2536.48, 10, 2131.58, -1227.42, 23.9766, 269.564, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(268, 2153.85, -1243.81, 25.3672, 421.761, 2536.48, 10, 2148.25, -1239.4, 24.502, 359.781, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(269, 2191.78, -1239.23, 24.4879, 421.761, 2536.48, 10, 2195.13, -1226.24, 23.9688, 267.882, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(270, 2209.77, -1240.25, 24.4801, 421.761, 2536.48, 10, 2206.87, -1226.26, 23.9688, 267.882, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(271, 2229.61, -1241.61, 25.6562, 421.761, 2536.48, 10, 2223.72, -1238.83, 24.9578, 356.533, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(272, 2249.84, -1238.91, 25.8984, 421.761, 2536.48, 10, 2245.38, -1245.29, 25.4297, 1.2095, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(273, 2250.31, -1280.05, 25.4766, 421.761, 2536.48, 10, 2254.81, -1273.35, 25.3594, 181.963, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(274, 2230.06, -1280.06, 25.6285, 421.761, 2536.48, 10, 2231.39, -1294.12, 23.9795, 87.4308, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(275, 2207.95, -1280.82, 25.1207, -68.8618, 1352.22, 1080.21, 2210.98, -1293.82, 23.9766, 89.6241, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(276, 2191.57, -1275.6, 25.1562, -68.8618, 1352.22, 1080.21, 2196.55, -1283.82, 24.3105, 179.867, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(277, 2150.15, -1285.04, 24.5269, -68.8618, 1352.22, 1080.21, 2148.32, -1293.67, 23.9792, 88.3708, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(278, 2132.23, -1280.05, 25.8906, 421.761, 2536.48, 10, 2136.83, -1272.87, 25.4937, 178.902, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(279, 2111.26, -1278.98, 25.8359, 421.761, 2536.48, 10, 2102.53, -1272.96, 25.4899, 177.335, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(280, 2091.02, -1277.84, 26.1797, -68.8618, 1352.22, 1080.21, 2095.62, -1283.42, 25.1721, 179.528, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(281, 2100.84, -1321.89, 25.9531, -68.8618, 1352.22, 1080.21, 2096.3, -1327.8, 25.5463, 359.673, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(282, 2126.75, -1320.87, 26.6242, 22.7405, 1404.38, 1084.43, 2135.91, -1320.97, 25.0976, 0.925984, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(283, 2148.6, -1320.08, 26.0738, -68.8618, 1352.22, 1080.21, 2140.94, -1320.59, 25.0527, 358.396, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(284, 2147.61, -1366.12, 25.9723, 421.761, 2536.48, 10, 2139.1, -1368.86, 24.6885, 179.393, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(285, 2129.61, -1361.69, 26.1363, 421.761, 2536.48, 10, 2136.39, -1358.15, 25.5391, 179.393, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(286, 2185.17, -1363.71, 26.1598, 421.761, 2536.48, 10, 2185.87, -1377.86, 23.9954, 270.686, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(287, 2230.39, -1397.24, 24.5738, -68.8618, 1352.22, 1080.21, 2231.2, -1391.49, 23.9965, 270.082, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(288, 2243.38, -1397.24, 24.5738, 421.761, 2536.48, 10, 2244.03, -1391.68, 23.997, 269.769, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(289, 2256.53, -1397.24, 24.5738, -68.8618, 1352.22, 1080.21, 2256.43, -1391.73, 23.9972, 269.769, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(290, 2263.87, -1469.35, 24.3707, 421.761, 2536.48, 10, 2265.38, -1476.72, 22.8793, 89.914, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(291, 2247.59, -1469.34, 24.4801, -68.8618, 1352.22, 1080.21, 2246.54, -1476.53, 23.4218, 88.6607, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(292, 2232.65, -1469.34, 24.5816, 421.761, 2536.48, 10, 2231.14, -1476.4, 23.8247, 89.6007, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(293, 2151.19, -1400.69, 26.1285, -68.8618, 1352.22, 1080.21, 2148.03, -1408.61, 24.9396, 89.9613, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(294, 2150.92, -1419.04, 25.9219, 421.761, 2536.48, 10, 2157.28, -1423.75, 25.5391, 87.1413, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(295, 2149.86, -1433.73, 26.0703, 421.761, 2536.48, 10, 2140.92, -1429.7, 24.3601, 90.9248, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(296, 2152.22, -1446.35, 26.1051, -68.8618, 1352.22, 1080.21, 2155.43, -1454.48, 25.5391, 91.2381, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(297, 2146.8, -1470.48, 26.0426, 421.761, 2536.48, 10, 2136.39, -1471.74, 23.9575, 358.514, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(298, 2148.94, -1484.9, 26.624, 22.7405, 1404.38, 1084.43, 2136.41, -1486.93, 23.9844, 358.514, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(299, 2296.53, -1882.01, 14.2344, 421.761, 2536.48, 10, 2295.87, -1887.74, 13.5951, 89.5848, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(300, 2269.13, -1882.02, 14.2344, 421.761, 2536.48, 10, 2269.22, -1887.9, 13.5469, 90.5248, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(301, 2241.95, -1882.01, 14.2344, 421.761, 2536.48, 10, 2242.3, -1887.73, 13.5469, 88.6448, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(302, 2238.14, -1906.83, 14.9375, -68.8618, 1352.22, 1080.21, 2234.21, -1901.89, 13.5469, 270.983, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(303, 2261.45, -1906.76, 14.9375, -68.8618, 1352.22, 1080.21, 2257.83, -1901.91, 13.5469, 271.297, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(304, 2284.6, -1906.6, 14.9297, -68.8618, 1352.22, 1080.21, 2284.66, -1901.56, 13.5749, 270.043, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(305, 2333.49, -1943.24, 14.9688, -68.8618, 1352.22, 1080.21, 2327.3, -1948.09, 13.5801, 88.0182, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(306, 2787.07, -1952.6, 13.5469, -68.8618, 1352.22, 1080.21, 2789.19, -1945.59, 13.5469, 90.3598, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(307, 2751.5, -1962.96, 13.5469, -68.8618, 1352.22, 1080.21, 2762.54, -1958.63, 13.5469, 179.324, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(308, 2751.5, -1936.27, 13.5394, -68.8618, 1352.22, 1080.21, 2750.16, -1943.35, 13.5469, 273.578, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(309, 2787.07, -1926.16, 13.5469, -68.8618, 1352.22, 1080.21, 2775.84, -1929.36, 13.5394, 178.95, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(310, 2801.92, -1962.95, 13.5469, 421.761, 2536.48, 10, 2804.67, -1969.94, 13.2736, 270.531, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(311, 2801.92, -1936.43, 13.5469, 421.761, 2536.48, 10, 2804.39, -1919.74, 13.2744, 267.137, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(312, 2023.04, -1052.89, 25.5961, 421.761, 2536.48, 10, 2023.36, -1060.68, 24.6799, 246.065, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(313, 2035.78, -1059.41, 25.6508, -68.8618, 1352.22, 1080.21, 2036.85, -1066.73, 24.7653, 244.498, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(314, 2050.74, -1065.73, 25.7836, 421.761, 2536.48, 10, 2050.48, -1072.73, 24.8349, 245.751, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(315, 2060.97, -1075.31, 25.6863, -68.8618, 1352.22, 1080.21, 2064.68, -1079.12, 24.919, 245.751, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(316, 2075.26, -1081.89, 25.6819, 421.761, 2536.48, 10, 2073.84, -1085.14, 24.9829, 245.751, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(317, 2082.53, -1085.18, 25.687, 421.761, 2536.48, 10, 2080.05, -1087.66, 25.038, 246.065, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(318, 2207.43, -1100.48, 31.5547, 421.761, 2536.48, 10, 2198.07, -1105.89, 25.2146, 158.556, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(319, 2083.06, -1039.67, 32.2095, -68.8618, 1352.22, 1080.21, 2080.34, -1041.8, 32.002, 234.251, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(320, 2077.32, -1057, 31.3464, -68.8618, 1352.22, 1080.21, 2078.57, -1054.13, 31.0771, 234.528, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(321, 2105.49, -1056.04, 27.1556, 421.761, 2536.48, 10, 2105.57, -1060.35, 26.6582, 231.118, 'None', 130000, 0, 10, 1, 28850, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(322, 2101.59, -1075.84, 25.9317, 421.761, 2536.48, 10, 2104.41, -1073.84, 25.7177, 232.371, 'None', 130000, 0, 10, 0, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(323, 743.313, -509.321, 18.0129, 22.7405, 1404.38, 1084.43, 752.249, -497.707, 17.3281, 178.767, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(324, 745.195, -556.784, 18.0129, 22.7405, 1404.38, 1084.43, 750.54, -552.865, 17.3313, 1.12865, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(325, 768.299, -503.483, 18.0129, 22.7405, 1404.38, 1084.43, 762.686, -507.65, 17.3119, 181.61, 'None', 1500000, 0, 5, 1, 150, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(326, 766.648, -556.784, 18.0129, 22.7405, 1404.38, 1084.43, 771.884, -552.241, 17.2826, 1.7785, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(327, 795.132, -506.149, 18.0129, 22.7405, 1404.38, 1084.43, 786.166, -489.769, 17.3439, 179.31, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(328, 818.233, -509.319, 18.0129, 22.7405, 1404.38, 1084.43, 827.356, -496.558, 17.3281, 180.079, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(329, 745.667, -591.084, 18.0129, 22.7405, 1404.38, 1084.43, 749.39, -581.9, 17.2473, 90.8024, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(330, 2197.27, -60.7055, 28.1535, 140.221, 1367.27, 1083.86, 2201.07, -66.1369, 27.4838, 273.407, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(331, 2203.11, -89.1904, 28.1535, 2324.34, -1148.63, 1050.71, 2189.77, -80.3462, 27.4688, 271.214, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(332, 2199.95, -37.2851, 28.1535, 2324.34, -1148.63, 1050.71, 2196.78, -46.4718, 27.3619, 270.587, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(333, 2245.47, -1.66091, 28.1536, 22.7405, 1404.38, 1084.43, 2240.25, -5.80588, 27.4543, 178.78, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(334, 2270.43, -7.50136, 28.1535, 22.7405, 1404.38, 1084.43, 2279.63, 4.66553, 27.4688, 180.347, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(335, 2245.39, -122.288, 28.1535, 22.7405, 1404.38, 1084.43, 2254.64, -124.579, 27.3298, 0.538501, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(336, 2272.33, -119.118, 28.1535, 22.7405, 1404.38, 1084.43, 2263.29, -130.331, 27.4688, 358.635, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(337, 2293.83, -124.963, 28.1535, 22.7405, 1404.38, 1084.43, 2299.01, -120.76, 27.4497, 356.128, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(338, 2322.31, -124.964, 28.1536, 22.7405, 1404.38, 1084.43, 2327.82, -119.964, 27.3877, 2.08131, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(339, 2367.36, -49.1259, 28.1535, 22.7405, 1404.38, 1084.43, 2358.15, -61.7891, 27.4688, 0.224684, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(340, 2392.37, -54.9616, 28.1536, 22.7405, 1404.38, 1084.43, 2397.91, -50.5014, 27.4296, 0.851338, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(341, 2415.46, -52.2834, 28.1535, 22.7405, 1404.38, 1084.43, 2424.63, -54.2797, 27.3137, 0.247868, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(342, 2438.8, -54.9638, 28.1535, 22.7405, 1404.38, 1084.43, 2444.26, -51.1925, 27.4838, 1.18812, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(343, 2484.49, -28.4027, 28.4416, 22.7405, 1404.38, 1084.43, 2476.4, -22.5592, 27.1573, 0.247868, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(344, 2513.37, -28.4035, 28.4416, 22.7405, 1404.38, 1084.43, 2521.26, -23.2031, 27.2639, 359.934, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(345, 2509.49, 11.7621, 28.4416, 22.7405, 1404.38, 1084.43, 2501.44, 6.70885, 27.2876, 181.983, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(346, 2488.36, 11.7632, 28.4416, 22.7405, 1404.38, 1084.43, 2496.38, 6.34391, 27.2263, 181.019, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(347, 2551.22, -5.53142, 27.6756, 22.7405, 1404.38, 1084.43, 2552.88, 2.24064, 26.4766, 92.369, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(348, 2549.23, 25.0519, 27.6756, 22.7405, 1404.38, 1084.43, 2553.76, 14.0245, 27.0426, 85.1622, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(349, 2551.22, 57.176, 27.6756, 22.7405, 1404.38, 1084.43, 2558.41, 72.3146, 26.4766, 89.2357, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(350, 2551.22, 91.7359, 27.6756, 22.7405, 1404.38, 1084.43, 2550.76, 81.3242, 26.4766, 89.2356, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(351, 2536.21, 128.987, 27.6835, 22.7405, 1404.38, 1084.43, 2528.43, 131.702, 26.4844, 181.67, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(352, 2518.4, 128.988, 27.6756, 22.7405, 1404.38, 1084.43, 2503.49, 135.723, 26.4766, 178.513, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(353, 2480.64, 126.992, 27.6756, 22.7405, 1404.38, 1084.43, 2491.61, 131.905, 27.0464, 183.503, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(354, 2458.87, 128.987, 27.6756, 22.7405, 1404.38, 1084.43, 2469.23, 128.607, 26.4766, 178.803, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(355, 2479.39, 94.398, 27.6835, 22.7405, 1404.38, 1084.43, 2494.45, 87.7633, 26.4844, 1.76813, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(356, 2514.04, 94.3982, 27.6835, 22.7405, 1404.38, 1084.43, 2503.69, 94.6363, 26.4844, 0.515102, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(357, 2443.85, 92.2525, 28.4416, 22.7405, 1404.38, 1084.43, 2448.79, 84.3872, 27.3057, 271.574, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(358, 2481.22, 64.4176, 27.6835, 22.7405, 1404.38, 1084.43, 2483.67, 72.2066, 26.4844, 90.1763, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(359, 2446.63, 19.0083, 27.6835, 22.7405, 1404.38, 1084.43, 2444.38, 11.1275, 26.4844, 268.488, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(360, 2448.4, -11.0219, 27.6835, 22.7405, 1404.38, 1084.43, 2433.39, -3.60609, 26.4844, 180.441, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(361, 2411.22, -5.65168, 27.6835, 22.7405, 1404.38, 1084.43, 2413.65, 2.13524, 26.4844, 93.3331, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(362, 2411.22, 21.7395, 27.6835, 22.7405, 1404.38, 1084.43, 2410.55, 11.3124, 26.4844, 90.1996, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(363, 2373.85, -8.6779, 28.4416, 22.7405, 1404.38, 1084.43, 2379.63, -11.9391, 27.169, 271.018, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(364, 2373.85, 22.0005, 28.4416, 22.7405, 1404.38, 1084.43, 2379.75, 26.1285, 27.1492, 269.765, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(365, 2373.85, 42.1195, 28.4416, 22.7405, 1404.38, 1084.43, 2379.54, 34.4887, 27.1837, 271.041, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(366, 2373.85, 71.0804, 28.4416, 22.7405, 1404.38, 1084.43, 2379.06, 79.1741, 27.2591, 272.921, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(367, 2398.4, 111.762, 28.4416, 22.7405, 1404.38, 1084.43, 2406.29, 106.29, 27.2176, 180.487, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(368, 2364, 116.136, 28.4416, 22.7405, 1404.38, 1084.43, 2358.62, 124.025, 27.235, 88.6562, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(369, 2363.99, 141.941, 28.4416, 22.7405, 1404.38, 1084.43, 2357.57, 145.654, 27.0646, 91.4763, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(370, 2364, 166.137, 28.4416, 22.7405, 1404.38, 1084.43, 2358.84, 173.98, 27.2702, 89.5962, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(371, 2363.99, 187.184, 28.4416, 22.7405, 1404.38, 1084.43, 2358.7, 179.207, 27.2457, 91.4763, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(372, 2323.85, 191.142, 28.4416, 22.7405, 1404.38, 1084.43, 2329.48, 199.091, 27.1915, 270.995, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(373, 2323.9, 162.201, 28.4416, 22.7405, 1404.38, 1084.43, 2329.28, 154.495, 27.2265, 270.995, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(374, 2323.85, 136.322, 28.4416, 22.7405, 1404.38, 1084.43, 2329.86, 132.624, 27.1322, 269.718, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(375, 2323.85, 116.099, 28.4416, 22.7405, 1404.38, 1084.43, 2329.38, 124.209, 27.2077, 272.514, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(376, 2269.44, 111.768, 28.4416, 22.7405, 1404.38, 1084.43, 2261.62, 106.138, 27.1939, 182.9, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(377, 2249.27, 111.771, 28.4416, 22.7405, 1404.38, 1084.43, 2253.46, 106.531, 27.2575, 180.056, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(378, 2203.85, 106.109, 28.4416, 22.7405, 1404.38, 1084.43, 2209.22, 114.178, 27.2333, 272.468, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(379, 2236.46, 168.299, 28.1535, 2324.34, -1148.63, 1050.71, 2231.08, 171.424, 27.4797, 180.75, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(380, 2257.92, 168.339, 28.1536, 22.7405, 1404.38, 1084.43, 2252.46, 163.284, 27.3834, 183.13, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(381, 2285.93, 161.766, 28.4416, 22.7405, 1404.38, 1084.43, 2293.94, 155.759, 27.1301, 177.827, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(382, 2203.85, 62.2114, 28.4416, 22.7405, 1404.38, 1084.43, 2209.82, 54.4741, 27.1387, 272.923, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(383, 1845.44, 741.293, 11.4609, 22.7405, 1404.38, 1084.43, 1843.11, 734.04, 11.4609, 269.937, 'None', 2000000, 0, 5, 1, 105300, 0, 2, 0, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(384, 1844, 718.695, 11.4683, 22.7405, 1404.38, 1084.43, 1841.66, 726.661, 11.4683, 267.263, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(385, 1844.53, 690.426, 11.4531, 22.7405, 1404.38, 1084.43, 1849.98, 698.761, 11.381, 269.6, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(386, 1845.44, 661.177, 11.4609, 22.7405, 1404.38, 1084.43, 1843.18, 653.676, 11.4609, 273.36, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(387, 2014.03, 775.196, 11.4609, 2237.54, -1080.53, 1049.02, 2006.85, 777.178, 11.4609, 181.38, 'None', 2000000, 0, 2, 1, 0, 0, 2, 0, -1, -1, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(388, 2013.24, 730.36, 11.4531, 22.7405, 1404.38, 1084.43, 2004.41, 735.907, 11.3676, 357.765, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(389, 2043.23, 776.103, 11.4531, 22.7405, 1404.38, 1084.43, 2052.09, 770.507, 11.3649, 176.344, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(390, 2042.49, 731.265, 11.4609, 22.7405, 1404.38, 1084.43, 2049.75, 729.78, 11.4609, 2.46521, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(391, 2071.64, 776.636, 11.4605, 22.7405, 1404.38, 1084.43, 2079.55, 778.973, 11.4605, 177.95, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(392, 2065.04, 729.826, 11.4683, 22.7405, 1404.38, 1084.43, 2056.55, 728.412, 11.4683, 358.055, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(393, 2094.07, 775.196, 11.4531, 22.7405, 1404.38, 1084.43, 2086.81, 777.493, 11.4531, 182.61, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(394, 2093.35, 730.359, 11.4531, 22.7405, 1404.38, 1084.43, 2084.63, 736, 11.363, 358.682, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(395, 2123.29, 776.103, 11.4453, 22.7405, 1404.38, 1084.43, 2132.45, 769.987, 11.3169, 178.514, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(396, 2122.5, 731.264, 11.4609, 22.7405, 1404.38, 1084.43, 2129.8, 729.169, 11.4609, 4.94867, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(397, 2011.5, 695.187, 11.4609, 22.7405, 1404.38, 1084.43, 2004.3, 696.843, 11.4609, 182.842, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(398, 2014.07, 650.405, 11.4609, 22.7405, 1404.38, 1084.43, 2004.89, 656.521, 11.3321, 1.1073, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(399, 2040.63, 696.093, 11.4531, 22.7405, 1404.38, 1084.43, 2049.9, 690.229, 11.3411, 182.505, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(400, 2043.25, 651.312, 11.4609, 22.7405, 1404.38, 1084.43, 2050.38, 649.438, 11.4609, 357.661, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(401, 2068.99, 696.63, 11.4683, 22.7405, 1404.38, 1084.43, 2077.65, 698.616, 11.4683, 178.432, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(402, 2065.83, 649.863, 11.4683, 22.7405, 1404.38, 1084.43, 2057.16, 648.231, 11.4683, 358.264, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(403, 2091.19, 695.188, 11.4609, 22.7405, 1404.38, 1084.43, 2083.92, 697.194, 11.4609, 180, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(404, 2094.05, 650.406, 11.4609, 22.7405, 1404.38, 1084.43, 2084.94, 656.048, 11.3653, 2.6504, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(405, 2120.47, 696.089, 11.4531, 22.7405, 1404.38, 1084.43, 2129.61, 691.196, 11.4094, 173.709, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(406, 2123.33, 651.315, 11.4609, 22.7405, 1404.38, 1084.43, 2130.6, 649.481, 11.4609, 3.27704, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(407, 2169.36, 772.302, 11.4609, 22.7405, 1404.38, 1084.43, 2171.2, 779.735, 11.4609, 91.9512, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(408, 2177.59, 736.102, 11.4609, 22.7405, 1404.38, 1084.43, 2186.79, 731.401, 11.4308, 178.432, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(409, 2177.28, 690.351, 11.4609, 22.7405, 1404.38, 1084.43, 2167.89, 695.103, 11.4249, 357.324, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(410, 2205.93, 736.638, 11.4683, 22.7405, 1404.38, 1084.43, 2214.44, 738.216, 11.4683, 179.518, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(411, 2206.41, 691.25, 11.4609, 22.7405, 1404.38, 1084.43, 2213.57, 689.113, 11.4609, 0, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(412, 2228.36, 735.2, 11.4609, 22.7405, 1404.38, 1084.43, 2221.28, 737.469, 11.4609, 183.592, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(413, 2228.6, 689.808, 11.4605, 22.7405, 1404.38, 1084.43, 2220.57, 686.756, 11.4605, 1.97407, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(414, 2257.6, 736.111, 11.4609, 22.7405, 1404.38, 1084.43, 2265.75, 731.435, 11.4456, 179.856, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(415, 2256.93, 690.349, 11.4531, 22.7405, 1404.38, 1084.43, 2248.91, 694.36, 11.4531, 355.661, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(416, 2258.16, 655.978, 11.4531, 22.7405, 1404.38, 1084.43, 2267.11, 651.275, 11.4257, 180.388, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(417, 2228.87, 655.186, 11.4609, 22.7405, 1404.38, 1084.43, 2221.65, 657.353, 11.4609, 183.522, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(418, 2206.36, 656.629, 11.4683, 22.7405, 1404.38, 1084.43, 2214.4, 660.144, 11.4683, 181.305, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(419, 2178.13, 655.994, 11.4609, 22.7405, 1404.38, 1084.43, 2187.31, 651.353, 11.4346, 179.716, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(420, 2346.57, 736.638, 11.4683, 22.7405, 1404.38, 1084.43, 2354.83, 740.626, 11.4683, 180.289, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(421, 2317.24, 690.352, 11.4609, 22.7405, 1404.38, 1084.43, 2309.17, 693.631, 11.4609, 357.3, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(422, 2346.48, 691.257, 11.4609, 22.7405, 1404.38, 1084.43, 2353.48, 688.867, 11.4609, 0.432958, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(423, 2369.07, 735.195, 11.4609, 22.7405, 1404.38, 1084.43, 2361.77, 737.398, 11.4609, 184.049, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(424, 2368.63, 689.799, 11.4605, 22.7405, 1404.38, 1084.43, 2360.47, 685.606, 11.4605, 5.1337, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(425, 2396.88, 690.342, 11.4531, 22.7405, 1404.38, 1084.43, 2388.65, 693.698, 11.4531, 358.844, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(426, 2398.32, 736.099, 11.4609, 22.7405, 1404.38, 1084.43, 2406.62, 733.149, 11.4609, 179.302, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(427, 2450.27, 742.652, 11.4609, 22.7405, 1404.38, 1084.43, 2446.92, 734.402, 11.4609, 90.6044, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(428, 2450.81, 714.368, 11.4683, 22.7405, 1404.38, 1084.43, 2455, 706.317, 11.4683, 90.6042, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(429, 2449.23, 689.807, 11.4609, 2324.34, -1148.63, 1050.71, 2453.56, 697.767, 11.4609, 88.7295, 'None', 2500000, 0, 12, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(430, 2450.27, 662.66, 11.4609, 22.7405, 1404.38, 1084.43, 2446.8, 654.426, 11.4609, 91.3804, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(431, 2397.54, 656.111, 11.4609, 22.7405, 1404.38, 1084.43, 2405.88, 652.014, 11.4609, 181.285, 'None', 2000000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(432, 2368.37, 655.211, 11.4609, 22.7405, 1404.38, 1084.43, 2361.12, 657.505, 11.4609, 181.285, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(433, 2346.13, 656.638, 11.4605, 22.7405, 1404.38, 1084.43, 2354.34, 660.729, 11.4605, 180.32, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(434, 2317.89, 656.102, 11.4531, 22.7405, 1404.38, 1084.43, 2326.27, 652.087, 11.4531, 183.431, 'None', 2000000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(435, 1030.81, 1848.07, 11.4683, 22.7405, 1404.38, 1084.43, 1034.42, 1839.85, 11.4683, 91.8671, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(436, 1030.37, 1876.4, 11.4688, 22.7405, 1404.38, 1084.43, 1026.59, 1868.19, 11.4688, 91.8436, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(437, 983.972, 1878.89, 11.4683, 22.7405, 1404.38, 1084.43, 979.822, 1887.19, 11.4683, 267.289, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(438, 985.415, 1901.09, 11.4609, 22.7405, 1404.38, 1084.43, 983.107, 1893.82, 11.4609, 274.205, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(439, 1029.37, 1906.03, 11.4609, 22.7405, 1404.38, 1084.43, 1031.53, 1913.21, 11.4609, 89.6736, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(440, 1030.81, 1928.17, 11.4683, 22.7405, 1404.38, 1084.43, 1034.11, 1919.85, 11.4683, 92.7836, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(441, 984.713, 1930.62, 11.4688, 22.7405, 1404.38, 1084.43, 988.628, 1938.76, 11.4688, 267.915, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(442, 930.81, 1928.19, 11.4683, 22.7405, 1404.38, 1084.43, 934.532, 1919.68, 11.4683, 91.5538, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(443, 885.413, 1980.54, 11.4609, 22.7405, 1404.38, 1084.43, 883.063, 1973.28, 11.4609, 272.036, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(444, 885.415, 2047.2, 11.4609, 22.7405, 1404.38, 1084.43, 883.342, 2039.83, 11.4609, 271.746, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(445, 930.807, 2027.85, 11.4683, 22.7405, 1404.38, 1084.43, 934.086, 2019.58, 11.4683, 87.8174, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(446, 929.064, 2006.42, 11.4609, 2324.34, -1148.63, 1050.71, 933.107, 2011.72, 11.4609, 88.5731, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(447, 983.972, 1978.26, 11.4683, 22.7405, 1404.38, 1084.43, 980.122, 1986.79, 11.4683, 270.86, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(448, 985.414, 2000.59, 11.4609, 22.7405, 1404.38, 1084.43, 983.38, 1993.29, 11.4609, 272.184, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(449, 1030.27, 1976.05, 11.4688, 22.7405, 1404.38, 1084.43, 1026.36, 1968.15, 11.4688, 87.3155, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(450, 1029.37, 2005.62, 11.4609, 22.7405, 1404.38, 1084.43, 1031.44, 2012.69, 11.4609, 91.0755, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(451, 984.506, 2030.1, 11.4688, 22.7405, 1404.38, 1084.43, 988.661, 2038.39, 11.4688, 270.907, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(452, 1030.81, 2028.17, 11.4683, 22.7405, 1404.38, 1084.43, 1034.03, 2019.7, 11.4683, 91.3657, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(453, 1083.96, 2031.71, 11.4683, 22.7405, 1404.38, 1084.43, 1079.78, 2040.11, 11.4683, 267.751, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(454, 1085.41, 2000.82, 11.4609, 22.7405, 1404.38, 1084.43, 1083.01, 1993.59, 11.4609, 272.764, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(455, 1084.51, 1976.64, 11.4688, 22.7405, 1404.38, 1084.43, 1088.37, 1984.79, 11.4688, 271.801, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(456, 1570.23, 2711.11, 10.8203, 140.221, 1367.27, 1083.86, 1562.42, 2720.81, 10.8203, 359.907, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(457, 1580.29, 2708.85, 10.8265, 140.221, 1367.27, 1083.86, 1587.22, 2719.42, 10.8203, 1.15961, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(458, 1599.49, 2757.6, 10.8265, 140.221, 1367.27, 1083.86, 1592.73, 2747.01, 10.8203, 183.545, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(459, 1565.47, 2757.06, 10.8203, 2324.34, -1148.63, 1050.71, 1555.81, 2749.92, 10.8203, 90.6521, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(460, 1564.78, 2776.63, 10.8203, 2324.34, -1148.63, 1050.71, 1557.38, 2768.72, 10.8274, 92.2188, 'None', 2500000, 0, 12, 1, 67900, 0, 3, 0, 0, 0, -2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(461, 1565.47, 2793.54, 10.8203, 2324.34, -1148.63, 1050.71, 1555.65, 2786.57, 10.8203, 90.6521, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(462, 1550.6, 2846.08, 10.8265, 140.221, 1367.27, 1083.86, 1543.35, 2834.95, 10.8203, 179.96, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(463, 1575.68, 2844.17, 10.8203, 140.221, 1367.27, 1083.86, 1580.35, 2841.76, 10.8203, 178.7, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(464, 1588.55, 2797.33, 10.8265, 2324.34, -1148.63, 1050.71, 1595.53, 2808.13, 10.8203, 0.748081, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(465, 1622.79, 2846.08, 10.8265, 2324.34, -1148.63, 1050.71, 1615.98, 2835.11, 10.8203, 184.363, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(466, 1601.82, 2846.08, 10.8265, 140.221, 1367.27, 1083.86, 1594.56, 2834.51, 10.8203, 179.98, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(467, 1618.4, 2800.79, 10.8203, 2324.34, -1148.63, 1050.71, 1611.64, 2810.18, 10.8203, 357.035, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(468, 1601.19, 2708.85, 10.8265, 2324.34, -1148.63, 1050.71, 1608.08, 2719.76, 10.8203, 4.89165, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(469, 1556.07, 2658.52, 10.8203, 22.7405, 1404.38, 1084.43, 1548.54, 2665.21, 10.8274, 3.66164, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(470, 1607.61, 2679.4, 10.8203, 22.7405, 1404.38, 1084.43, 1601.22, 2671.94, 10.8274, 90.4558, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(471, 1611.77, 2648.26, 10.8265, 2324.34, -1148.63, 1050.71, 1601.49, 2655.57, 10.8203, 91.709, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0');
INSERT INTO `house` (`hID`, `hEntrancex`, `hEntrancey`, `hEntrancez`, `hExitx`, `hExity`, `hExitz`, `hCarx`, `hCary`, `hCarz`, `hCarc`, `hOwner`, `hValue`, `hHel`, `hInt`, `hLock`, `hTakings`, `hDate`, `hKlass`, `hVec`, `hVcol1`, `hVcol2`, `hVehSost`, `hNarko`, `hGun1`, `hGun2`, `hGun3`, `hGun4`, `hGun5`, `hGunAmmo1`, `hGunAmmo2`, `hGunAmmo3`, `hGunAmmo4`, `hGunAmmo5`, `hSafes`) VALUES
(472, 1316.47, 2524.61, 10.8203, 2324.34, -1148.63, 1050.71, 1305.12, 2529.31, 10.8264, 91.1085, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(473, 1269.62, 2554.43, 10.8265, 140.221, 1367.27, 1083.86, 1280.8, 2547.21, 10.8203, 269.397, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(474, 1271.88, 2564.39, 10.8203, 140.221, 1367.27, 1083.86, 1282.49, 2572.08, 10.8203, 272.554, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(475, 1641.26, 2149.72, 11.3125, 22.7405, 1404.38, 1084.43, 1638.31, 2141.7, 11.3125, 90.5055, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(476, 1596.41, 2147.27, 11.4609, 22.7405, 1404.38, 1084.43, 1593.96, 2140.03, 11.4609, 272.241, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(477, 1645.56, 2127.38, 11.2031, 22.7405, 1404.38, 1084.43, 1645.64, 2131.51, 11.2031, 90.5289, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(478, 1595.5, 2123.18, 11.4609, 22.7405, 1404.38, 1084.43, 1598.07, 2131.48, 11.4609, 269.131, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(479, 1640.35, 2102.95, 11.3125, 22.7405, 1404.38, 1084.43, 1642.97, 2110.3, 11.3125, 91.8057, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(480, 1596.41, 2093.54, 11.3125, 22.7405, 1404.38, 1084.43, 1594, 2086.34, 11.3125, 272.601, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(481, 1640.35, 2075.68, 11.3125, 22.7405, 1404.38, 1084.43, 1643.07, 2083.12, 11.3125, 92.1657, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(482, 1594.96, 2071.13, 11.3199, 22.7405, 1404.38, 1084.43, 1592.17, 2078.57, 11.3199, 272.334, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(483, 1641.79, 2044.9, 11.3199, 22.7405, 1404.38, 1084.43, 1644.41, 2037.14, 11.3199, 90.3324, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(484, 1595.5, 2038.4, 11.4688, 22.7405, 1404.38, 1084.43, 1598.27, 2046.51, 11.4688, 271.127, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(485, 1554.35, 2074.05, 11.3594, 22.7405, 1404.38, 1084.43, 1553.67, 2077.67, 11.3594, 89.3924, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(486, 1550.27, 2096.28, 11.4609, 22.7405, 1404.38, 1084.43, 1547.03, 2088.35, 11.4609, 90.959, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(487, 1549.35, 2125.66, 11.4609, 22.7405, 1404.38, 1084.43, 1551.75, 2133.14, 11.4609, 91.2722, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(488, 1365.42, 1974.08, 11.4609, 22.7405, 1404.38, 1084.43, 1362.41, 1966.65, 11.4609, 273.924, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(489, 1364.39, 2003.73, 11.4609, 22.7405, 1404.38, 1084.43, 1366.66, 2011.63, 11.4609, 269.584, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(490, 1365.42, 2027.95, 11.4609, 22.7405, 1404.38, 1084.43, 1362.85, 2020.65, 11.4609, 273.031, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(491, 1320.76, 2028.1, 11.4683, 22.7405, 1404.38, 1084.43, 1323.36, 2020.34, 11.4683, 92.2824, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(492, 1319.28, 2005.82, 11.4609, 22.7405, 1404.38, 1084.43, 1321.68, 2013.5, 11.4609, 91.6792, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(493, 1320.21, 1975.89, 11.4688, 22.7405, 1404.38, 1084.43, 1317.9, 1968.25, 11.4688, 91.3894, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(494, 1309.53, 1931.25, 11.4609, 22.7405, 1404.38, 1084.43, 1316.68, 1928.63, 11.4609, 4.61872, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(495, 1336.5, 1931.25, 11.4609, 22.7405, 1404.38, 1084.43, 1343.93, 1928.82, 11.4609, 2.11202, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(496, 1363.96, 1931.76, 11.4683, 22.7405, 1404.38, 1084.43, 1361.49, 1939.13, 11.4683, 272.568, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(497, 1364.51, 1896.75, 11.4688, 22.7405, 1404.38, 1084.43, 1367.37, 1904.92, 11.4688, 270.375, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(498, 1408.88, 1897.02, 11.4609, 22.7405, 1404.38, 1084.43, 1411.77, 1902.35, 11.4609, 88.5245, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(499, 1408.82, 1919.51, 11.4688, 22.7405, 1404.38, 1084.43, 1406.46, 1911.9, 11.4688, 90.8922, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(500, 1412.48, 1951.25, 11.4531, 22.7405, 1404.38, 1084.43, 1420.35, 1949.53, 11.4531, 4.41144, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(501, 1439.7, 1951.25, 11.4609, 22.7405, 1404.38, 1084.43, 1447.54, 1948.72, 11.4609, 1.61471, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(502, 1462.19, 1949.81, 11.4683, 22.7405, 1404.38, 1084.43, 1454.73, 1947.88, 11.4683, 1.92803, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(503, 1464.5, 1920.04, 11.4609, 22.7405, 1404.38, 1084.43, 1467.99, 1928.08, 11.4609, 269.494, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(504, 1464.5, 1895.07, 11.4609, 22.7405, 1404.38, 1084.43, 1466.86, 1902.1, 11.4609, 272.337, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(505, -2058.93, 889.366, 61.8567, 2324.34, -1148.63, 1050.71, -2048.27, 900.443, 53.6132, 357.66, 'Mariotto_Caltabiano', 2500000, 0, 12, 1, 100, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(506, -2075.17, 898.64, 64.1328, 2324.34, -1148.63, 1050.71, -2080.03, 901.379, 64.1328, 2.0699, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(507, -2099.75, 897.359, 76.7109, 140.221, 1367.27, 1083.86, -2105.26, 893.324, 76.7031, 359.903, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(508, -2116.85, 927.824, 86.0791, 2324.34, -1148.63, 1050.71, -2125.68, 921.073, 79.9391, 87.7793, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(509, -2655.32, 985.784, 64.9913, 140.221, 1367.27, 1083.86, -2664.36, 989.044, 64.9234, 358.229, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(510, -2710.57, 967.471, 54.4609, 140.221, 1367.27, 1083.86, -2721.01, 977.292, 54.4609, 5.00081, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(511, -2720.86, 923.954, 67.5938, 140.221, 1367.27, 1083.86, -2721.73, 916.067, 67.5938, 87.9654, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(512, -2706.58, 864.454, 70.7031, 2324.34, -1148.63, 1050.71, -2713.06, 868.259, 70.7031, 87.5997, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(513, -2660.06, 876.331, 79.7738, 140.221, 1367.27, 1083.86, -2679.99, 867.638, 76.2993, 7.67524, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(514, -2671.27, 927.427, 79.7031, 140.221, 1367.27, 1083.86, -2664.93, 913.725, 79.6752, 181.914, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(515, -2641.14, 935.72, 71.9531, 2324.34, -1148.63, 1050.71, -2636.35, 933.291, 71.9531, 179.43, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(516, -2905.2, 1154.74, 13.6641, 2324.34, -1148.63, 1050.71, -2902.87, 1151.61, 13.7003, 269.515, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(517, -2905.17, 1164.72, 13.6641, 2324.34, -1148.63, 1050.71, -2903.25, 1161.8, 13.6677, 268.888, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(518, -2905.26, 1171.6, 13.6641, 2324.34, -1148.63, 1050.71, -2903.48, 1168.02, 13.6641, 268.888, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(519, -2905.1, 1178.7, 13.6641, 2324.34, -1148.63, 1050.71, -2903.4, 1175.75, 13.6641, 269.201, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(520, -2895.57, 1016.89, 36.8281, 22.7405, 1404.38, 1084.43, -2892.72, 1014.63, 36.8352, 287.498, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(521, -2899.15, 1026.73, 36.8281, 2365.2, -1134.69, 1050.88, -2898.98, 1030.63, 36.8308, 290.631, 'None', 1500000, 0, 8, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(522, -2901.62, 1033.51, 36.8281, 2324.34, -1148.63, 1050.71, -2901.13, 1037.65, 36.7417, 289.378, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(523, -2622.35, -198.11, 4.33594, 2324.34, -1148.63, 1050.71, -2616.3, -194.748, 4.33594, 274.275, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(524, -2623.38, -99.4896, 7.20312, 2324.34, -1148.63, 1050.71, -2616.71, -96.6895, 4.33594, 270.045, 'None', 2500000, 0, 12, 1, 20700, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 100, 0, 0, 0, 0, 0'),
(525, -2687.9, -89.4027, 4.33594, 2324.34, -1148.63, 1050.71, -2693.09, -92.6864, 4.33594, 91.1146, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(526, -2725.75, -92.627, 7.20312, 2324.34, -1148.63, 1050.71, -2719.39, -89.8689, 4.33594, 269.113, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(527, -2686.82, -188.035, 7.20312, 2324.34, -1148.63, 1050.71, -2693.17, -190.938, 4.33594, 88.1881, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(528, -2724.67, -191.271, 4.33594, 2324.34, -1148.63, 1050.71, -2718.98, -187.922, 4.33594, 271.826, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(529, -2789.3, -181.297, 10.0625, 2324.34, -1148.63, 1050.71, -2795.33, -183.891, 7.1875, 85.1856, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(530, -2790.25, -82.4836, 7.19531, 2324.34, -1148.63, 1050.71, -2795.78, -86.0169, 7.1875, 88.9348, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(531, -2789.17, -52.5779, 10.0625, 2324.34, -1148.63, 1050.71, -2795.95, -55.4604, 7.1875, 90.3253, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(532, -2724.71, -58.0365, 4.34258, 2324.34, -1148.63, 1050.71, -2718.48, -54.6524, 4.33594, 270.6, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(533, -2687.88, 137.146, 4.34258, 2324.34, -1148.63, 1050.71, -2693.62, 133.676, 4.33594, 89.6419, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(534, -2623.3, 131.574, 7.20312, 2324.34, -1148.63, 1050.71, -2617.26, 134.322, 4.33594, 271.196, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(535, -2621.04, 96.693, 5, 2324.34, -1148.63, 1050.71, -2616.82, 91.6345, 4.33594, 269.185, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(536, -2622.37, 71.7487, 4.33594, 2324.34, -1148.63, 1050.71, -2617.09, 74.8973, 4.33594, 270.751, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(537, -2689.56, 96.319, 7.20312, 2324.34, -1148.63, 1050.71, -2692.85, 98.6181, 4.33594, 90.2814, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(538, -2689.44, 74.5148, 7.20312, 2324.34, -1148.63, 1050.71, -2692.87, 72.0675, 4.33594, 87.5082, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(539, -2632, 274.461, 4.33477, 2324.34, -1148.63, 1050.71, -2637.74, 270.76, 4.32812, 88.4729, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(540, -2634.9, 239.708, 4.56547, 2324.34, -1148.63, 1050.71, -2636.87, 246.047, 4.32812, 89.7261, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(541, -2688.95, 197.836, 7.20312, 2324.34, -1148.63, 1050.71, -2691.76, 203.924, 4.33594, 359.485, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(542, -2620.7, -185.895, 7.20312, -68.8618, 1352.22, 1080.21, -2616.51, -188.294, 4.33594, 270.764, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(543, -2621.01, -173.289, 5, 22.7405, 1404.38, 1084.43, -2616.05, -178.59, 4.33594, 266.389, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(544, -2622.36, -169.535, 4.34258, -68.8618, 1352.22, 1080.21, -2616.34, -166.02, 4.33594, 268.551, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(545, -2619.46, -153.462, 4.33594, 22.7405, 1404.38, 1084.43, -2616.58, -159.604, 4.33594, 268.888, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(546, -2620.82, -146.214, 7.20312, -68.8618, 1352.22, 1080.21, -2616.25, -143.702, 4.33594, 267.707, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(547, -2621.01, -134.724, 5, 22.7405, 1404.38, 1084.43, -2615.9, -140.119, 4.33594, 271.697, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(548, -2619.75, -127.611, 4.77178, -68.8618, 1352.22, 1080.21, -2616.11, -131.199, 4.33594, 271.721, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(549, -2620.74, -120.213, 7.20312, 22.7405, 1404.38, 1084.43, -2616.09, -122.654, 4.33594, 272.107, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(550, -2622.36, -112.384, 4.34258, -68.8618, 1352.22, 1080.21, -2615.78, -108.955, 4.33594, 267.184, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(551, 300.131, -1154.34, 81.3901, 225.631, 1022.48, 1084.07, 283.095, -1159.54, 80.9141, 229.303, 'None', 30000000, 0, 7, 1, 0, 0, 5, 0, -1, -1, -5, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(552, 352.393, -1197.93, 76.5156, 2324.34, -1148.63, 1050.71, 346.833, -1198.87, 76.5156, 32.6521, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(553, 416.603, -1154.02, 76.6876, 22.7405, 1404.38, 1084.43, 406.23, -1152.67, 77.0926, 150.665, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(554, 470.755, -1163.57, 67.2178, 140.221, 1367.27, 1083.86, 473.013, -1170.05, 65.2562, 195.472, 'None', 1500000, 0, 5, 1, 999999999, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(555, 497.517, -1095.07, 82.3592, 140.221, 1367.27, 1083.86, 479.597, -1090.54, 82.4088, 359.474, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(556, 559.036, -1076.46, 72.922, 2324.34, -1148.63, 1050.71, 566.129, -1069.23, 73.1312, 29.5536, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(557, 673.136, -1020.14, 55.7596, 22.7405, 1404.38, 1084.43, 684.828, -1024.05, 51.4376, 183.86, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(558, -2724.68, -105.646, 4.34258, -68.8618, 1352.22, 1080.21, -2718.82, -101.955, 4.33594, 270.509, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(559, -2689.58, -101.605, 7.20312, -68.8618, 1352.22, 1080.21, -2693.65, -99.2333, 4.33594, 91.2214, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(560, -2723.02, -113.392, 7.20312, 22.7405, 1404.38, 1084.43, -2718.91, -115.665, 4.33594, 269.569, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(561, -2722.03, -120.752, 4.74114, -68.8618, 1352.22, 1080.21, -2719.49, -124.413, 4.33594, 269.882, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(562, -2689.24, -114.238, 5, 22.7405, 1404.38, 1084.43, -2693.98, -108.907, 4.33594, 91.2448, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(563, -2723.34, -127.893, 5, 22.7405, 1404.38, 1084.43, -2719.31, -132.965, 4.33594, 272.076, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(564, -2687.9, -117.929, 4.34258, -68.8618, 1352.22, 1080.21, -2694.06, -121.459, 4.33594, 90.9315, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(565, -2690.79, -133.865, 4.33594, 22.7405, 1404.38, 1084.43, -2693.7, -127.861, 4.33594, 90.9783, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(566, -2723.06, -139.394, 7.20312, -68.8618, 1352.22, 1080.21, -2719.26, -136.958, 4.33594, 269.592, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(567, -2721.78, -146.837, 4.33594, 22.7405, 1404.38, 1084.43, -2719.76, -152.741, 4.33594, 269.592, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(568, -2689.48, -141.288, 7.20312, -68.8618, 1352.22, 1080.21, -2693.98, -143.688, 4.33594, 90.9783, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(569, -2689.24, -152.791, 5, 22.7405, 1404.38, 1084.43, -2694.07, -147.379, 4.33594, 89.7483, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(570, -2724.67, -162.668, 4.34258, -68.8618, 1352.22, 1080.21, -2718.89, -159.338, 4.33594, 270.243, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(571, -2690.5, -159.902, 4.77144, -68.8618, 1352.22, 1080.21, -2693.79, -156.368, 4.33594, 90.7117, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(572, -2723.33, -166.498, 5, 22.7405, 1404.38, 1084.43, -2719.39, -171.527, 4.33594, 269.929, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(573, -2689.45, -167.312, 7.20312, 22.7405, 1404.38, 1084.43, -2693.91, -164.891, 4.33594, 91.9884, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(574, -2723.04, -179.075, 7.20312, -68.8618, 1352.22, 1080.21, -2719.83, -181.544, 4.33594, 269.616, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(575, -2687.89, -175.077, 4.34258, -68.8618, 1352.22, 1080.21, -2694.36, -178.446, 4.33594, 92.0119, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(576, -2790.24, -168.247, 7.20195, -68.8618, 1352.22, 1080.21, -2796.38, -171.891, 7.1875, 88.2751, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(577, -2791.94, -160.474, 10.0547, 22.7405, 1404.38, 1084.43, -2795.51, -158.048, 7.1875, 91.3278, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(578, -2792.84, -153.092, 7.63013, -68.8618, 1352.22, 1080.21, -2796.66, -149.48, 7.1875, 92.3662, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(579, -2791.58, -145.937, 7.85938, 22.7405, 1404.38, 1084.43, -2795.42, -140.789, 7.1875, 88.821, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(580, -2793.14, -127.096, 7.1875, 22.7405, 1404.38, 1084.43, -2795.51, -120.92, 7.1875, 89.4474, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(581, -2791.83, -134.467, 10.0547, -68.8618, 1352.22, 1080.21, -2796.82, -136.729, 7.1875, 85.5246, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(582, -2791.59, -107.4, 7.85938, 22.7405, 1404.38, 1084.43, -2795.62, -102.275, 7.1875, 86.9407, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(583, -2790.25, -111.181, 7.20195, -68.8618, 1352.22, 1080.21, -2796.7, -114.514, 7.1875, 88.8265, 'None', 350000, 0, 6, 0, 0, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(584, -2791.76, -94.7869, 10.0547, -68.8618, 1352.22, 1080.21, -2795.99, -92.3736, 7.1875, 89.7665, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(585, -2791.88, -41.8154, 10.0547, 22.7405, 1404.38, 1084.43, -2795.99, -39.4007, 7.1875, 90.4111, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(586, -2791.59, -35.8976, 7.85938, -68.8618, 1352.22, 1080.21, -2796.31, -30.5253, 7.1875, 92.25, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(587, -2791.8, -24.3954, 10.0547, 22.7405, 1404.38, 1084.43, -2795.58, -26.8285, 7.1875, 89.8079, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(588, -2791.58, -17.8435, 7.85938, -68.8618, 1352.22, 1080.21, -2796.7, -12.3077, 7.1875, 90.3699, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(589, -2790.25, 7.18737, 7.19531, 2324.34, -1148.63, 1050.71, -2795.41, 3.79537, 7.1875, 89.8078, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(590, -2793.14, 11.1042, 7.43266, -68.8618, 1352.22, 1080.21, -2796.51, 17.5508, 7.1875, 92.9, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(591, -2793.14, 21.3066, 7.1875, 22.7405, 1404.38, 1084.43, -2795.42, 27.4105, 7.1875, 89.4944, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(592, -2790.24, 69.7373, 7.20195, 2324.34, -1148.63, 1050.71, -2795.48, 66.3012, 7.1875, 90.4343, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(593, -2791.79, 77.5957, 10.0547, -68.8618, 1352.22, 1080.21, -2796.65, 80.0145, 7.1875, 91.9601, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(594, -2792.84, 85.0334, 7.62945, 22.7405, 1404.38, 1084.43, -2795.07, 88.4446, 7.1875, 89.4942, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(595, -2791.59, 92.0993, 7.85938, -68.8618, 1352.22, 1080.21, -2796.44, 97.2414, 7.1875, 92.3876, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(596, -2791.82, 103.598, 10.0547, 22.7405, 1404.38, 1084.43, -2795.7, 101.164, 7.1875, 88.2642, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(597, -2793.14, 110.951, 7.1875, -68.8618, 1352.22, 1080.21, -2796.44, 117.087, 7.1875, 93.0377, 'None', 350000, 0, 6, 1, 100, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(598, -2791.59, 130.675, 7.85938, -68.8618, 1352.22, 1080.21, -2796.51, 135.695, 7.1875, 89.9043, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(599, -2790.25, 126.991, 7.20195, 2324.34, -1148.63, 1050.71, -2795.52, 123.678, 7.1875, 89.5409, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(600, -2791.88, 143.271, 10.0547, 22.7405, 1404.38, 1084.43, -2795.36, 145.686, 7.1875, 89.5407, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(601, -2789.19, 183.798, 10.0625, 2324.34, -1148.63, 1050.71, -2795.99, 180.939, 7.1875, 90.1907, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(602, -2791.98, 194.576, 10.0547, -68.8618, 1352.22, 1080.21, -2795.64, 196.799, 7.1875, 90.8173, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(603, -2791.6, 200.551, 7.85938, 22.7405, 1404.38, 1084.43, -2795.42, 205.539, 7.1875, 87.0572, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(604, -2791.94, 212.002, 10.0547, -68.8618, 1352.22, 1080.21, -2794.95, 209.631, 7.1875, 90.5272, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(605, -2791.81, 218.814, 7.85938, -68.8618, 1352.22, 1080.21, -2795.26, 223.669, 7.1875, 90.2138, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(606, -2634.61, 261.041, 4.76413, -68.8618, 1352.22, 1080.21, -2637.12, 264.609, 4.32812, 88.9606, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(607, -2630.92, 252.856, 7.1875, 22.7405, 1404.38, 1084.43, -2636.45, 249.996, 4.33518, 89.9007, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(608, -2653.97, 200.242, 5, 2324.34, -1148.63, 1050.71, -2648.98, 203.609, 4.33594, 358.406, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(609, -2660.73, 200.603, 7.19531, -68.8618, 1352.22, 1080.21, -2663.22, 203.724, 4.33594, 356.863, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(610, -2672.15, 200.234, 5, 22.7405, 1404.38, 1084.43, -2667.28, 203.782, 4.33594, 0.912787, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(611, -2678.17, 200.654, 7.19531, -68.8618, 1352.22, 1080.21, -2675.73, 203.684, 4.33594, 1.22637, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(612, -2639.4, 168.565, 7.19531, 2324.34, -1148.63, 1050.71, -2636.81, 165.619, 4.32812, 180.164, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(613, -2628.02, 168.908, 5, 22.7405, 1404.38, 1084.43, -2632.91, 165.637, 4.32812, 177.972, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(614, -2621.98, 168.585, 7.19531, -68.8618, 1352.22, 1080.21, -2624.25, 165.633, 4.32812, 178.912, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(615, -2690.48, 123.729, 4.77127, -68.8618, 1352.22, 1080.21, -2692.99, 127.197, 4.33594, 87.7542, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(616, -2686.8, 115.516, 7.19531, 22.7405, 1404.38, 1084.43, -2692.27, 112.708, 4.34356, 91.8277, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(617, -2690.77, 102.211, 4.57296, -68.8618, 1352.22, 1080.21, -2692.92, 108.735, 4.33594, 89.3209, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(618, -2690.48, 64.5567, 4.77024, 22.7405, 1404.38, 1084.43, -2692.97, 68.105, 4.33594, 86.1876, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(619, -2689.55, 57.0851, 7.20312, -68.8618, 1352.22, 1080.21, -2693.02, 59.4019, 4.33594, 89.3209, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(620, -2723.04, 21.9048, 7.20312, 2324.34, -1148.63, 1050.71, -2719.83, 19.5364, 4.33594, 271.056, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(621, -2722.1, 14.4448, 4.77041, 22.7405, 1404.38, 1084.43, -2719.78, 10.8366, 4.33594, 269.176, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(622, -2723.02, 4.48338, 7.20312, -68.8618, 1352.22, 1080.21, -2719.55, 6.97047, 4.33594, 269.826, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(623, -2723.05, -17.3175, 7.20312, 22.7405, 1404.38, 1084.43, -2719.4, -19.6037, 4.33594, 269.826, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(624, -2721.81, -23.3908, 4.57264, -68.8618, 1352.22, 1080.21, -2720.29, -29.6809, 4.34324, 271.079, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(625, -2725.79, -36.6662, 7.19531, 22.7405, 1404.38, 1084.43, -2719.53, -33.8026, 4.33594, 270.139, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(626, -2722.11, -44.7292, 4.77059, -68.8618, 1352.22, 1080.21, -2719.61, -48.3072, 4.33594, 271.079, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(627, -2619.48, 57.5959, 4.33594, -68.8618, 1352.22, 1080.21, -2617.29, 51.7119, 4.33594, 270.766, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(628, -2619.48, 67.8202, 4.57232, 22.7405, 1404.38, 1084.43, -2616.92, 61.4512, 4.33594, 269.199, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(629, -2620.72, 103.387, 7.20312, -68.8618, 1352.22, 1080.21, -2616.93, 105.628, 4.33594, 268.596, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(630, -2621.04, 114.819, 5, 22.7405, 1404.38, 1084.43, -2617.41, 109.86, 4.33594, 268.283, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(631, -2620.71, 120.816, 7.20312, -68.8618, 1352.22, 1080.21, -2618.02, 118.541, 4.33594, 272.356, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(632, -2161.44, -2535.55, 31.8163, 22.7405, 1404.38, 1084.43, -2149.15, -2544.14, 30.6172, 323.355, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(633, -2180.92, -2520.07, 31.8163, 22.7405, 1404.38, 1084.43, -2168.48, -2528.19, 30.6172, 323.331, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(634, -2193.13, -2510.35, 31.8163, 22.7405, 1404.38, 1084.43, -2200.24, -2502.61, 30.6172, 320.633, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(635, -2224.45, -2482.97, 31.8163, 22.7405, 1404.38, 1084.43, -2237.24, -2476.92, 31.1685, 320.006, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(636, -2239.25, -2423.69, 32.7073, 22.7405, 1404.38, 1084.43, -2232.08, -2424.05, 31.4271, 229.765, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(637, -2220.39, -2399.89, 32.5823, 22.7405, 1404.38, 1084.43, -2218.17, -2406.39, 31.3099, 231.958, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(638, -2213.93, -2451.81, 31.8163, 22.7405, 1404.38, 1084.43, -2205.7, -2439.51, 30.6172, 52.1269, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(639, -2173.8, -2481.53, 31.8163, 22.7405, 1404.38, 1084.43, -2179.27, -2475.9, 30.6172, 142.101, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(640, -2132.7, -2510.98, 31.8163, 22.7405, 1404.38, 1084.43, -2124.55, -2504, 30.6172, 233.619, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(641, -2075.73, -2312.76, 31.1313, 2324.34, -1148.63, 1050.71, -2072.03, -2307.33, 30.625, 56.4431, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(642, -2552.35, 2266.58, 5.47552, 140.221, 1367.27, 1083.86, -2555.78, 2268.18, 5.06126, 333.164, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(643, -2523.89, 2238.82, 5.39844, 2324.34, -1148.63, 1050.71, -2527.9, 2251.89, 4.97336, 334.281, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(644, -2583.74, 2307.84, 7.00288, 2324.34, -1148.63, 1050.71, -2568.81, 2312.41, 4.98438, 2.93078, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(645, -2583.13, 2300.28, 7.00288, 2324.34, -1148.63, 1050.71, -2566.62, 2300.03, 4.98438, 15.3284, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(646, -2627.64, 2283.36, 8.31487, 140.221, 1367.27, 1083.86, -2628.54, 2273.3, 8.30649, 271.661, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(647, -2627.64, 2292.06, 8.31487, 2324.34, -1148.63, 1050.71, -2619.72, 2293.97, 8.28125, 359.578, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(648, -2627.36, 2309.96, 8.31266, 140.221, 1367.27, 1083.86, -2619.54, 2305.86, 8.28125, 358.324, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(649, -2627.58, 2318.67, 8.31441, 140.221, 1367.27, 1083.86, -2619.93, 2319.03, 8.28125, 359.578, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(650, -2636.34, 2351.01, 8.48864, 140.221, 1367.27, 1083.86, -2624.68, 2348.15, 8.50479, 271.53, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(651, -2627.4, 2359.48, 8.98717, 140.221, 1367.27, 1083.86, -2619.61, 2357.68, 8.72662, 358.661, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(652, -2597.31, 2364.67, 9.88299, 2324.34, -1148.63, 1050.71, -2610.73, 2367.39, 9.12122, 0.226419, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(653, -2597.31, 2357.12, 9.88299, 140.221, 1367.27, 1083.86, -2610.72, 2354.18, 8.65278, 358.708, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(654, -2632.34, 2374.88, 9.05156, 140.221, 1367.27, 1083.86, -2619.79, 2373.26, 9.41792, 357.791, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(655, -2634.92, 2401.7, 11.2196, 140.221, 1367.27, 1083.86, -2617.84, 2396.48, 11.3547, 350.921, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(656, -2479.9, 2449.95, 17.323, 140.221, 1367.27, 1083.86, -2481.95, 2436.7, 16.2287, 110.592, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(657, -2472.31, 2451.36, 17.323, 2324.34, -1148.63, 1050.71, -2467.68, 2438.72, 15.6113, 97.4554, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(658, -2424.71, 2449.06, 13.1391, 140.221, 1367.27, 1083.86, -2422.25, 2439.72, 13.0058, 88.9953, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(659, -2386.14, 2447.47, 10.1694, 140.221, 1367.27, 1083.86, -2389.25, 2434.86, 10.0817, 69.2319, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(660, -2379.23, 2444.64, 10.1694, 2324.34, -1148.63, 1050.71, -2378.71, 2430.61, 9.04647, 58.9152, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(661, -2348.41, 2423.63, 7.32948, 2324.34, -1148.63, 1050.71, -2356.05, 2417.09, 7.186, 56.4085, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(662, -2382.08, 2406.6, 8.89207, 2324.34, -1148.63, 1050.71, -2379.75, 2413.49, 8.52483, 20.6646, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(663, -2437.46, 2354.94, 5.44307, 2324.34, -1148.63, 1050.71, -2426.27, 2346.26, 4.96847, 191.265, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(664, 12.8349, 1113.67, 20.9399, -68.8618, 1352.22, 1080.21, -1.56406, 1115.94, 19.7187, 180.708, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(665, -18.2872, 1115.67, 20.9399, -68.8618, 1352.22, 1080.21, -26.0255, 1116.17, 19.7493, 180.082, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(666, -36.0499, 1115.67, 20.9399, -68.8618, 1352.22, 1080.21, -50.7831, 1114.25, 19.7455, 179.745, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(667, 1.75292, 1076.16, 20.9399, -68.8618, 1352.22, 1080.21, 0.798066, 1083.7, 19.7493, 88.611, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(668, -45.0621, 1081.08, 20.9399, -68.8618, 1352.22, 1080.21, -30.1475, 1082.24, 19.7453, 2.12992, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(669, -258.813, 1083.07, 20.9399, 22.7405, 1404.38, 1084.43, -245.387, 1081.69, 19.709, 0.250229, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(670, -258.25, 1043.82, 20.9399, 22.7405, 1404.38, 1084.43, -257.942, 1059.02, 19.7447, 91.4555, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(671, -247.842, 1001.07, 20.9399, -68.8618, 1352.22, 1080.21, -240.176, 998.818, 19.7493, 359.625, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(672, -278.759, 1003.07, 20.9399, -68.8618, 1352.22, 1080.21, -264.996, 1002.26, 19.7028, 1.84133, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(673, -260.24, 1120.13, 20.9399, 22.7405, 1404.38, 1084.43, -259.027, 1133.5, 19.7072, 89.2622, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(674, -258.462, 1151.13, 20.9399, 22.7405, 1404.38, 1084.43, -258.567, 1158.54, 19.7493, 88.6355, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(675, -258.246, 1168.89, 20.9399, 22.7405, 1404.38, 1084.43, -258.907, 1183.83, 19.7451, 90.5155, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(676, -290.783, 1176.7, 20.9399, 22.7405, 1404.38, 1084.43, -291.642, 1163.03, 19.7026, 270.394, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(677, -324.415, 1165.67, 20.9399, 22.7405, 1404.38, 1084.43, -339.634, 1164.56, 19.745, 176.73, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(678, -298.407, 1115.67, 20.9399, 22.7405, 1404.38, 1084.43, -305.95, 1114.92, 19.7493, 179.237, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(679, -328.247, 1118.92, 20.9399, 22.7405, 1404.38, 1084.43, -329.402, 1134, 19.7451, 90.2256, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(680, -360.846, 1141.63, 20.9399, -68.8618, 1352.22, 1080.21, -361.557, 1128.45, 19.7017, 266.971, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(681, -362.839, 1110.67, 20.9399, -68.8618, 1352.22, 1080.21, -361.136, 1102.86, 19.7493, 269.164, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(682, -369.868, 1169.45, 20.2719, 2324.34, -1148.63, 1050.71, -360.903, 1197.89, 19.7422, 180.576, 'None', 2500000, 0, 12, 0, 0, 0, 3, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(683, -910.909, 2685.97, 42.3703, 140.221, 1367.27, 1083.86, -903.456, 2697.68, 42.3703, 44.6766, 'None', 1500000, 0, 5, 1, 999999999, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(684, -683.935, 939.584, 13.6328, 140.221, 1367.27, 1083.86, -686.868, 963.767, 12.1327, 89.2355, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(685, -692.329, 939.511, 13.6328, 140.221, 1367.27, 1083.86, -686.414, 967.953, 12.1328, 88.9459, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(686, 1684.52, 2123.38, 11.4609, 22.7405, 1404.38, 1084.43, 1686.9, 2131.4, 11.4609, 269.549, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(687, 1685.42, 2093.8, 11.4609, 22.7405, 1404.38, 1084.43, 1683.4, 2085.97, 11.4609, 272.032, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(688, 1680.27, 2069.24, 11.3594, 22.7405, 1404.38, 1084.43, 1680.38, 2064.12, 11.3594, 268.586, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(689, 1684.52, 2046.56, 11.4688, 22.7405, 1404.38, 1084.43, 1686.88, 2054.6, 11.4688, 271.116, 'None', 1500000, 0, 5, 0, 0, 0, 2, 0, -1, -1, -4, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(690, 805.402, 358.363, 19.7621, 421.761, 2536.48, 10, 804.902, 363.17, 19.3717, 267.698, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(691, 808.075, 372.326, 19.453, 421.761, 2536.48, 10, 810.68, 379.54, 19.3183, 80.9627, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(692, 783.203, 377.545, 21.2967, 421.761, 2536.48, 10, 788.944, 381.25, 21.4507, 247.718, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(693, 758.915, 375.028, 23.3922, 421.761, 2536.48, 10, 761.588, 379.106, 23.1688, 98.6458, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(694, 751.716, 375.253, 23.3749, 421.761, 2536.48, 10, 748.177, 382.224, 23.1719, 277.327, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(695, 748.431, 350.903, 20.5858, 421.761, 2536.48, 10, 748.301, 344.625, 20.4963, 309.279, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(696, 772.927, 348.228, 20.1527, 421.761, 2536.48, 10, 767.214, 346.652, 20, 9.07833, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(697, 746.393, 305.033, 20.2344, 421.761, 2536.48, 10, 753.496, 301.513, 20.2344, 8.20205, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(698, 719.066, 300.628, 20.3766, 421.761, 2536.48, 10, 721.173, 304.248, 20.2344, 97.4698, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(699, 705.349, 292.088, 20.4219, 421.761, 2536.48, 10, 693.999, 291.391, 20.2483, 183.958, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(700, 723.648, 269.677, 22.4531, 421.761, 2536.48, 10, 712.282, 271.686, 22.029, 182.718, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(701, 748.197, 257.115, 27.0859, 421.761, 2536.48, 10, 750.963, 262.932, 27.0859, 102.438, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(702, 747.128, 278.191, 27.2188, 421.761, 2536.48, 10, 752.688, 274.52, 27.2764, 196.533, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(703, 783.939, 352.595, 19.5938, 421.761, 2536.48, 10, 790.646, 357.573, 19.4685, 101.12, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(704, 342.645, 62.6877, 3.86291, 421.761, 2536.48, 10, 342.345, 66.7755, 3.92327, 121.008, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(705, 317.757, 54.6328, 3.375, 421.761, 2536.48, 10, 315.409, 47.049, 2.96704, 231.04, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0');
INSERT INTO `house` (`hID`, `hEntrancex`, `hEntrancey`, `hEntrancez`, `hExitx`, `hExity`, `hExitz`, `hCarx`, `hCary`, `hCarz`, `hCarc`, `hOwner`, `hValue`, `hHel`, `hInt`, `hLock`, `hTakings`, `hDate`, `hKlass`, `hVec`, `hVcol1`, `hVcol2`, `hVehSost`, `hNarko`, `hGun1`, `hGun2`, `hGun3`, `hGun4`, `hGun5`, `hGunAmmo1`, `hGunAmmo2`, `hGunAmmo3`, `hGunAmmo4`, `hGunAmmo5`, `hSafes`) VALUES
(706, 309.112, 44.4174, 3.08797, 421.761, 2536.48, 10, 306.482, 36.5896, 2.77055, 295.376, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(707, 286.061, 41.1444, 2.54844, 421.761, 2536.48, 10, 290.112, 40.4716, 2.56209, 22.307, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(708, 316.456, 18.2419, 4.51562, 421.761, 2536.48, 10, 304.986, 17.0628, 4.17525, 196.021, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(709, 340.039, 33.6335, 6.40814, 421.761, 2536.48, 10, 340.867, 28.707, 6.35938, 308.101, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(710, 295.075, -54.5432, 2.77721, -68.8618, 1352.22, 1080.21, 287.423, -54.8124, 1.57812, 181.687, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(711, 271.581, -48.7522, 2.77721, -68.8618, 1352.22, 1080.21, 278.138, -57.574, 1.57812, 180.226, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(712, 252.888, -92.3999, 3.53539, 22.7405, 1404.38, 1084.43, 246.901, -86.1425, 2.23032, 90.1475, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(713, 252.888, -121.359, 3.53539, 22.7405, 1404.38, 1084.43, 245.535, -127.309, 2.00629, 88.0978, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(714, 253.494, -274.481, 1.65612, 421.761, 2536.48, 10, 254.613, -269.531, 1.58358, 215.021, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(715, 255.887, -278.495, 1.65612, 421.761, 2536.48, 10, 259.311, -276.52, 1.57812, 210.122, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(716, 261.981, -270.004, 1.64049, 421.761, 2536.48, 10, 267.851, -274.726, 1.57812, 120.633, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(717, 264.515, -283.752, 1.72643, 421.761, 2536.48, 10, 266.346, -278.863, 1.57812, 91.4636, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(718, 264.514, -288.484, 1.72643, 421.761, 2536.48, 10, 262.156, -292.492, 1.57812, 0.513198, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(719, 260.558, -303.034, 1.91837, 421.761, 2536.48, 10, 256.385, -300.607, 1.57812, 139.279, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(720, 253.25, -289.971, 1.70299, 421.761, 2536.48, 10, 249.713, -293.207, 1.57812, 0.365303, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(721, 242.038, -298.602, 1.68737, 421.761, 2536.48, 10, 247.345, -294.047, 1.57812, 92.8523, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(722, 235.123, -309.458, 1.7108, 421.761, 2536.48, 10, 228.784, -310.701, 1.61055, 354.664, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(723, 226.457, -302.812, 1.92618, 421.761, 2536.48, 10, 234.813, -302.715, 1.57812, 177.663, 'None', 130000, 0, 10, 1, 50, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(724, 312.722, -121.305, 3.53539, 22.7405, 1404.38, 1084.43, 318.821, -127.382, 2.21201, 271.463, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(725, 312.721, -92.3741, 3.53539, 22.7405, 1404.38, 1084.43, 318.984, -86.1199, 2.18313, 272.194, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(726, 2190.31, -1487.63, 26.1051, 421.761, 2536.48, 10, 2196.9, -1480.81, 24.6161, 270.002, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(727, 2190.44, -1470.43, 25.9141, -68.8618, 1352.22, 1080.21, 2184.99, -1465.57, 25.5391, 271.319, 'None', 350000, 0, 6, 1, 100, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(728, 2191.1, -1455.81, 26, -68.8618, 1352.22, 1080.21, 2199.87, -1452.48, 24.6486, 267.828, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(729, 2194.35, -1442.98, 26.0738, -68.8618, 1352.22, 1080.21, 2197.75, -1434.58, 24.6023, 269.581, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(730, 2188.55, -1419.28, 26.1562, -68.8618, 1352.22, 1080.21, 2189.65, -1414.59, 25.5391, 270.024, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(731, 2196.21, -1404.06, 25.9488, -68.8618, 1352.22, 1080.21, 2206.21, -1404.05, 23.9844, 358.49, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(732, 2202.8, -1363.67, 26.191, -68.8618, 1352.22, 1080.21, 2207.27, -1376.97, 24, 270.459, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(733, 2185.31, -1608.14, 14.3594, 421.761, 2536.48, 10, 2192.28, -1606.5, 14.3515, 160.208, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(734, 2257.12, -1643.94, 15.8082, -68.8618, 1352.22, 1080.21, 2256.24, -1651.77, 15.4759, 74.9576, 'None', 350000, 0, 6, 1, 100, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(735, 2244.5, -1637.63, 16.2379, -68.8618, 1352.22, 1080.21, 2237.76, -1633.32, 15.6856, 162.105, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(736, 2282.31, -1641.21, 15.8898, -68.8618, 1352.22, 1080.21, 2280.81, -1653.45, 15.2056, 268.482, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(737, 2513.74, -1650.27, 14.3557, 421.761, 2536.48, 10, 2508.42, -1658.68, 13.5938, 215.28, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(738, 1323.84, 375.613, 19.5625, 140.221, 1367.27, 1083.86, 1324.33, 372.13, 19.5547, 242.05, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(739, -347.829, -1045.66, 59.8125, 2324.34, -1148.63, 1050.71, -356.668, -1045, 59.378, 182.237, 'None', 2500000, 0, 12, 1, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(740, 1451.67, 375.751, 19.4005, -68.8618, 1352.22, 1080.21, 1455.41, 376.137, 19.1584, 160.698, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(741, 1447.38, 361.766, 18.9081, -68.8618, 1352.22, 1080.21, 1443.58, 368.787, 18.9843, 245.224, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(742, 1469.64, 351.53, 18.9268, -68.8618, 1352.22, 1080.21, 1468.28, 346.361, 18.8417, 20.9208, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(743, 1465.74, 364.2, 19.2609, -68.8618, 1352.22, 1080.21, 1464.04, 369.247, 19.2822, 244.497, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(744, 1475.35, 372.74, 19.6562, -68.8618, 1352.22, 1080.21, 1484.62, 380.074, 20.0259, 70.3481, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(745, 1488.57, 360.976, 19.413, -68.8618, 1352.22, 1080.21, 1488.97, 364.965, 19.505, 121.089, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(746, 1461.15, 342.493, 18.9531, -68.8618, 1352.22, 1080.21, 1464.65, 330.303, 18.8438, 115.311, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(747, 2284.14, -1046.06, 49.8871, 421.761, 2536.48, 10, 2280.14, -1048.83, 49.4603, 234.928, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(748, 2297.68, -1053.06, 49.934, 421.761, 2536.48, 10, 2295.88, -1056.65, 49.461, 251.196, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(749, 2319.78, -1053.33, 52.4608, 421.761, 2536.48, 10, 2313.76, -1055.22, 52.0368, 157.396, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(750, 2335.14, -1046.01, 52.5529, -68.8618, 1352.22, 1080.21, 2339.09, -1045.54, 52.5799, 182.183, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(751, 2351.03, -1039.78, 54.3358, 421.761, 2536.48, 10, 2348.97, -1043.11, 53.9804, 101.176, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(752, 2355.53, -1038.58, 54.3358, 421.761, 2536.48, 10, 2358.48, -1041.35, 54.1484, 282.495, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(753, 2370.29, -1034.55, 54.4106, 421.761, 2536.48, 10, 2370.68, -1038.1, 54.2363, 105.274, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(754, 2145.17, -1084.63, 25.0357, 223.141, 1287.33, 1082.14, 2159.72, -1093.7, 25.4192, 71.0693, 'None', 350000, 0, 1, 1, 100, 0, 1, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(755, 2140.67, -1082.54, 25.0361, -68.8618, 1352.22, 1080.21, 2136.02, -1083.81, 24.3245, 240.942, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(756, 2108.82, -1082.35, 25.4904, 421.761, 2536.48, 10, 2112.52, -1079.58, 24.5961, 46.6731, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(757, 2091.54, -1068.16, 28.0853, 421.761, 2536.48, 10, 2096.22, -1067.02, 27.1431, 44.2541, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(758, 2099.8, -1051.72, 28.8154, -68.8618, 1352.22, 1080.21, 2096.08, -1054.06, 28.4705, 225.652, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(759, 2093.85, -1047.38, 30.108, -68.8618, 1352.22, 1080.21, 2090.6, -1049.56, 29.71, 231.292, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(760, 2454.18, -965.068, 80.0731, 421.761, 2536.48, 10, 2458.15, -964.476, 80.0867, 0.521143, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(761, 2472.4, -962.048, 80.5255, 421.761, 2536.48, 10, 2476.17, -964.044, 80.2219, 354.881, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(762, 2459.44, -947.701, 80.0828, -68.8618, 1352.22, 1080.21, 2461.52, -952.446, 80.0992, 265.894, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(763, 2499.46, -946.996, 82.4708, 421.761, 2536.48, 10, 2503.43, -948.582, 82.2943, 352.688, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(764, 2492.11, -965.687, 82.5489, -68.8618, 1352.22, 1080.21, 2490.13, -971.215, 82.0456, 273.704, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(765, 2517.86, -965.347, 82.3284, 421.761, 2536.48, 10, 2517.09, -968.982, 82.015, 91.6786, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(766, 2531.11, -963.295, 82.3685, -68.8618, 1352.22, 1080.21, 2538.79, -962.183, 82.0849, 6.13785, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(767, 2552.04, -958.348, 82.6165, 421.761, 2536.48, 10, 2554.04, -965.513, 82.55, 86.352, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(768, 2581.52, -969.354, 81.3646, 421.761, 2536.48, 10, 2580.83, -965.248, 81.3516, 276.837, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(769, 2582.83, -952.946, 81.3878, -68.8618, 1352.22, 1080.21, 2584.93, -957.612, 81.3516, 278.404, 'None', 350000, 0, 6, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(770, 2388.42, -1279.57, 25.1291, 421.761, 2536.48, 10, 2376.73, -1277.29, 24, 3.69284, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(771, 2387.86, -1328.44, 25.1242, 421.761, 2536.48, 10, 2377.03, -1327.22, 24, 358.993, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(772, 2389.73, -1346.19, 25.077, 421.761, 2536.48, 10, 2378.8, -1346.29, 24, 177.258, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(773, 2383.54, -1366.3, 24.4914, 421.761, 2536.48, 10, 2378.19, -1367.25, 23.9922, 202.325, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(774, 2433.93, -1303.35, 25.3234, 421.761, 2536.48, 10, 2445.96, -1305.22, 24, 354.606, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(775, 2433.93, -1320.68, 25.3234, 421.761, 2536.48, 10, 2443.4, -1323.22, 24, 358.993, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(776, -923.7, -496.982, 26.7656, 421.761, 2536.48, 10, -918.83, -503.082, 25.9609, 78.8614, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(777, -940.544, -491.232, 26.3637, 421.761, 2536.48, 10, -933.318, -495.318, 25.9609, 161.318, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(778, -960.741, -507.601, 26.2387, 421.761, 2536.48, 10, -955.156, -507.721, 25.9536, 185.247, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(779, -940.267, -536.809, 26.7656, 421.761, 2536.48, 10, -938.289, -531.139, 25.9536, 76.6115, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(780, -924.467, -536.339, 26.1405, 421.761, 2536.48, 10, -929.806, -540.259, 25.9536, 22.7607, 'None', 130000, 0, 10, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(781, 1332.07, -633.52, 109.135, 225.631, 1022.48, 1084.07, 1354.39, -630.002, 109.133, 17.4473, 'None', 30000000, 0, 7, 1, 0, 0, 5, 0, -1, -1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0'),
(782, 2206.71, 1762.68, 1084.23, 140.221, 1367.27, 1083.86, 0, 0, 0, 0, 'None', 1500000, 0, 5, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, '0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0');

-- --------------------------------------------------------

--
-- Структура таблицы `kvart`
--

CREATE TABLE `kvart` (
  `kid` int(11) NOT NULL,
  `pXpic` float NOT NULL,
  `pYpic` float NOT NULL,
  `pZpic` float NOT NULL,
  `vladelec` varchar(32) NOT NULL,
  `lock` int(11) NOT NULL,
  `aptek` int(11) NOT NULL,
  `plata` int(11) NOT NULL,
  `kCena` int(11) NOT NULL,
  `kInt` int(11) NOT NULL,
  `virtmir` int(11) NOT NULL,
  `kworld` int(11) NOT NULL,
  `Hours` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `kvart`
--

INSERT INTO `kvart` (`kid`, `pXpic`, `pYpic`, `pZpic`, `vladelec`, `lock`, `aptek`, `plata`, `kCena`, `kInt`, `virtmir`, `kworld`, `Hours`) VALUES
(1, 2269.81, 1667.86, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 1, 0),
(2, 2266.04, 1662.63, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 1, 0),
(3, 2271.34, 1662.56, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 1, 0),
(4, 2266.04, 1652.56, 1084.23, 'None', 0, 0, 0, 300000, 2, 2, 1, 0),
(5, 2271.34, 1652.55, 1084.23, 'None', 0, 0, 0, 300000, 2, 2, 1, 0),
(6, 2266.05, 1642.15, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 1, 0),
(7, 2271.34, 1642.23, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 1, 0),
(8, 2266.05, 1633.55, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 1, 0),
(9, 2271.33, 1633.46, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 1, 0),
(10, 2269.8, 1627.58, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 1, 0),
(11, 2201.06, -1188.58, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(12, 2209.67, -1187.37, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(13, 2209.71, -1189.99, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(14, 2225.47, -1187.25, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(15, 2225.71, -1189.96, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(16, 2239.84, -1170.6, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(17, 2242.52, -1170.67, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(18, 2239.84, -1159.76, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(19, 2242.63, -1159.65, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(20, 2229.38, -1150.51, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 1, 0),
(21, 2201.06, -1188.67, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(22, 2209.74, -1187.37, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(23, 2209.71, -1189.99, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(24, 2225.61, -1187.25, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(25, 2225.5, -1189.96, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(26, 2239.84, -1170.82, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(27, 2242.52, -1170.66, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(28, 2239.84, -1159.75, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(29, 2242.63, -1159.78, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(30, 2229.38, -1150.51, 1029.8, 'None', 0, 0, 0, 100000, 0, 1, 2, 0),
(31, 2269.8, 1667.86, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(32, 2271.34, 1662.51, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(33, 2266.04, 1662.6, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(34, 2271.34, 1652.52, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(35, 2266.04, 1652.57, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(36, 2271.34, 1642.17, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(37, 2266.05, 1642.19, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(38, 2271.34, 1633.49, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(39, 2266.05, 1633.5, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(40, 2269.81, 1627.58, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 2, 0),
(41, 2269.8, 1667.86, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(42, 2271.34, 1662.51, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(43, 2266.04, 1662.6, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(44, 2271.34, 1652.52, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(45, 2266.04, 1652.57, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(46, 2271.34, 1642.17, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(47, 2266.05, 1642.19, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(48, 2271.34, 1633.49, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(49, 2266.05, 1633.5, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(50, 2269.81, 1627.58, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 3, 0),
(51, 2269.8, 1667.86, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(52, 2271.34, 1662.51, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(53, 2266.04, 1662.6, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(54, 2271.34, 1652.52, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(55, 2266.04, 1652.57, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(56, 2271.34, 1642.17, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(57, 2266.05, 1642.19, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(58, 2271.34, 1633.49, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(59, 2266.05, 1633.5, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(60, 2269.81, 1627.58, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 4, 0),
(61, 2269.8, 1667.86, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(62, 2271.34, 1662.51, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(63, 2266.04, 1662.6, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(64, 2271.34, 1652.52, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(65, 2266.04, 1652.57, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(66, 2271.34, 1642.17, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(67, 2266.05, 1642.19, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(68, 2271.34, 1633.49, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(69, 2266.05, 1633.5, 1084.23, 'None', 0, 0, 0, 300000, 0, 2, 5, 0),
(70, 2269.81, 1627.58, 1084.25, 'None', 0, 0, 0, 300000, 0, 2, 5, 0);

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

-- --------------------------------------------------------

--
-- Структура таблицы `stall`
--

CREATE TABLE `stall` (
  `id` int(11) NOT NULL,
  `pos_x` float NOT NULL,
  `pos_y` float NOT NULL,
  `pos_z` float NOT NULL,
  `pos_r` float NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Дамп данных таблицы `stall`
--

INSERT INTO `stall` (`id`, `pos_x`, `pos_y`, `pos_z`, `pos_r`) VALUES
(1, 1145.1, -1755.97, 13.8167, 0),
(2, 1145.1, -1753.53, 13.8167, 0),
(3, 1436.35, -1677.85, 13.506, 0);

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
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`pID`);

--
-- Индексы таблицы `admin`
--
ALTER TABLE `admin`
  ADD UNIQUE KEY `Name` (`Name`);

--
-- Индексы таблицы `atm`
--
ALTER TABLE `atm`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `ban`
--
ALTER TABLE `ban`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `bizz`
--
ALTER TABLE `bizz`
  ADD PRIMARY KEY (`bID`);

--
-- Индексы таблицы `casino`
--
ALTER TABLE `casino`
  ADD PRIMARY KEY (`ID`);

--
-- Индексы таблицы `farms`
--
ALTER TABLE `farms`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `gangzone`
--
ALTER TABLE `gangzone`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `grating`
--
ALTER TABLE `grating`
  ADD UNIQUE KEY `id` (`id`);

--
-- Индексы таблицы `house`
--
ALTER TABLE `house`
  ADD PRIMARY KEY (`hID`),
  ADD KEY `hID` (`hID`),
  ADD KEY `hID_2` (`hID`),
  ADD KEY `hID_3` (`hID`);

--
-- Индексы таблицы `kvart`
--
ALTER TABLE `kvart`
  ADD PRIMARY KEY (`kid`);

--
-- Индексы таблицы `podezd`
--
ALTER TABLE `podezd`
  ADD PRIMARY KEY (`pid`);

--
-- Индексы таблицы `stall`
--
ALTER TABLE `stall`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `workshops`
--
ALTER TABLE `workshops`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `pID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT для таблицы `atm`
--
ALTER TABLE `atm`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT для таблицы `ban`
--
ALTER TABLE `ban`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=89;

--
-- AUTO_INCREMENT для таблицы `bizz`
--
ALTER TABLE `bizz`
  MODIFY `bID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=49;

--
-- AUTO_INCREMENT для таблицы `casino`
--
ALTER TABLE `casino`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `farms`
--
ALTER TABLE `farms`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT для таблицы `gangzone`
--
ALTER TABLE `gangzone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=131;

--
-- AUTO_INCREMENT для таблицы `grating`
--
ALTER TABLE `grating`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT для таблицы `house`
--
ALTER TABLE `house`
  MODIFY `hID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=783;

--
-- AUTO_INCREMENT для таблицы `kvart`
--
ALTER TABLE `kvart`
  MODIFY `kid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=71;

--
-- AUTO_INCREMENT для таблицы `podezd`
--
ALTER TABLE `podezd`
  MODIFY `pid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `stall`
--
ALTER TABLE `stall`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT для таблицы `workshops`
--
ALTER TABLE `workshops`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
