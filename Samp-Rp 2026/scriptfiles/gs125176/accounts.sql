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

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `accounts`
--
ALTER TABLE `accounts`
  ADD PRIMARY KEY (`pID`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `accounts`
--
ALTER TABLE `accounts`
  MODIFY `pID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
