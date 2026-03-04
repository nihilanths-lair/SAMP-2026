SaveMySQL(idx, i = 0)
{
	new temp[0x9e];
	switch (idx)
	{
	case 0:
		{
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_OTHERS"` SET ");
			format(temp,sizeof(temp),"`bank_lsnews`= '%i',",FracBank[0][fLsnews]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_sfnews`= '%i',",FracBank[0][fSfnews]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_lvnews`= '%i',",FracBank[0][fLvnews]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_ballas`= '%i',",FracBank[0][fBallas]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_vagos`= '%i',",FracBank[0][fVagos]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_grove`= '%i',",FracBank[0][fGrove]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_aztec`= '%i',",FracBank[0][fAztek]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_exchequer`= '%i',",FracBank[0][fKazna]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_ssmc`= '%i',",FracBank[0][fSsmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_hamc`= '%i',",FracBank[0][fHamc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_omc`= '%i',",FracBank[0][fOmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_wmc`= '%i',",FracBank[0][fWmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_hwmc`= '%i',",FracBank[0][fHwmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_fsmc`= '%i',",FracBank[0][fFsmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_pmc`= '%i',",FracBank[0][fPmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_mmc`= '%i',",FracBank[0][fMmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_vmc`= '%i',",FracBank[0][fVmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_bmc`= '%i',",FracBank[0][fBmc]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`heal_ballas`= '%i',",ballashel), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`heal_grove`= '%i',",groovhel), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`heal_vagos`= '%i',",vagoshel), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`heal_aztec`= '%i',",aztekhel), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`heal_rifa`= '%i',",rifahel), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`adprice_ls`= '%i',",addd[0]), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`adprice_sf`= '%i',",addd[1]), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`adprice_lv`= '%i',",addd[2]), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`healprice`= '%i',",healpric), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`heal_yakuza`= '%i',",yakuzahel), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`heal_lcn`= '%i',",lcnhel), 								strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`heal_rm`= '%i',",rmhel), 								strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_lsa`= '%i',",lsamatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_lva`= '%i',",armmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_sfa`= '%i',",armmatsf), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_ssmc`= '%i',",ssmcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_hamc`= '%i',",hamcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_omc`= '%i',",omcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_wmc`= '%i',",wmcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_hwmc`= '%i',",hwmcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_fsmc`= '%i',",fsmcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_vmc`= '%i',",vmcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_pmc`= '%i',",pmcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_mmc`= '%i',",mmcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_bmc`= '%i',",bmcmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_rifa`= '%i',",rifamatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_ballas`= '%i',",ballasmatbi), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_aztec`= '%i',",aztekmatbi), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_vagos`= '%i',",vagosmatbi), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_grove`= '%i',",groovmatbi), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_lspd`= '%i',",lspdmatbi), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_fbi`= '%i',",fbimats), 								strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_yakuza`= '%i',",yakuzamats), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_rm`= '%i',",rmmats), 								strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_lcn`= '%i',",lcnmats), 								strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_sfpd`= '%i',",sfpdmats), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mats_lvpd`= '%i',",lvpdmats), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_lcn`= '%i',",MafiaBank[0][nLcn]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_yakuza`= '%i',",MafiaBank[0][nYakuza]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank_rm`= '%i',",MafiaBank[0][nRm]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`best_gang`= '%i',",BestGang), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`slit`= '%i',",slit), 									strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`News_zp`= '%i,%i,%i'",newsZP[1], newsZP[0], newsZP[2]),	strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `grating` SET `mark` = '%i' WHERE `gang` = '%s'", gRating[Grove], "Grove street");
			mysql_function_query(DATABASE, QUERY, true, "", "");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `grating` SET `mark` = '%i' WHERE `gang` = '%s'", gRating[Rifa], "Rifa");
			mysql_function_query(DATABASE, QUERY, true, "", "");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `grating` SET `mark` = '%i' WHERE `gang` = '%s'", gRating[Ballas], "Ballas");
			mysql_function_query(DATABASE, QUERY, true, "", "");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `grating` SET `mark` = '%i' WHERE `gang` = '%s'", gRating[Vagos], "Vagos");
			mysql_function_query(DATABASE, QUERY, true, "", "");
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `grating` SET `mark` = '%i' WHERE `gang` = '%s'", gRating[Aztec], "Aztec");
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 1:
		{
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_CASINO"` SET ");
			format(temp,sizeof(temp),"`ID`= '%i',",CasinoInfo[i][caID]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Name`= '%s',",CasinoInfo[i][caName]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Mafia`= '%i',",CasinoInfo[i][caMafia]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Manager`= '%s',",CasinoInfo[i][caManager]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Manager2`= '%s',",CasinoInfo[i][caManager2]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Manager3`= '%s',",CasinoInfo[i][caManager3]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie`= '%s',",CasinoInfo[i][caKrupie]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie2`= '%s',",CasinoInfo[i][caKrupie2]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie3`= '%s',",CasinoInfo[i][caKrupie3]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie4`= '%s',",CasinoInfo[i][caKrupie4]),				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie5`= '%s',",CasinoInfo[i][caKrupie5]),				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie6`= '%s',",CasinoInfo[i][caKrupie6]),				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie7`= '%s',",CasinoInfo[i][caKrupie7]),				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie8`= '%s',",CasinoInfo[i][caKrupie8]),				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie9`= '%s',",CasinoInfo[i][caKrupie9]),				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Krupie10`= '%s'",CasinoInfo[i][caKrupie10]),				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp)," WHERE ID = '%i'",CasinoInfo[i][caID]),					strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 2:
		{
			if(GetPVarInt(i,"player_save") || !PTEMP[i][pLogin]) return true;
			SetPVarInt(i,"player_save",1);
			for(new x = 1; x < 11; x++) GetPlayerWeaponData(i,x,PTEMP[i][pWeapon][x-1],PTEMP[i][pAmmo][x-1]);
			format(PTEMP[i][pWeapons],32,"%i, %i, %i, %i, %i, %i, %i, %i, %i, %i, %i",PTEMP[i][pWeapon][0], PTEMP[i][pWeapon][1], PTEMP[i][pWeapon][2], PTEMP[i][pWeapon][3],
			PTEMP[i][pWeapon][4], PTEMP[i][pWeapon][5], PTEMP[i][pWeapon][6], PTEMP[i][pWeapon][7], PTEMP[i][pWeapon][8], PTEMP[i][pWeapon][9], PTEMP[i][pWeapon][10]);
			format(PTEMP[i][pAmmos],32,"%i, %i, %i, %i, %i, %i, %i, %i, %i, %i, %i",PTEMP[i][pAmmo][0], PTEMP[i][pAmmo][1], PTEMP[i][pAmmo][2], PTEMP[i][pAmmo][3],
			PTEMP[i][pAmmo][4], PTEMP[i][pAmmo][5], PTEMP[i][pAmmo][6], PTEMP[i][pAmmo][7], PTEMP[i][pAmmo][8], PTEMP[i][pAmmo][9], PTEMP[i][pAmmo][10]);
			format(PTEMP[i][pGunSkills],30,"%i, %i, %i, %i, %i ,%i",PTEMP[i][pGunSkill][0],PTEMP[i][pGunSkill][1],PTEMP[i][pGunSkill][2],PTEMP[i][pGunSkill][3],PTEMP[i][pGunSkill][4],PTEMP[i][pGunSkill][5]);
			format(PTEMP[i][pChars],30,"%i, %i, %i, %i, %i ,%i",PTEMP[i][pChar][0],PTEMP[i][pChar][1],PTEMP[i][pChar][2],PTEMP[i][pChar][3],PTEMP[i][pChar][4],PTEMP[i][pChar][5]);
			
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_ACCOUNTS"` SET `pLevel` = '%i', `pHelper` = '%i', `pRatingSupport` = '%i', `pJobHeal` = '%i', `pMestoJail` = '%i', `pHousecash` = '%i', `pCheckip` = '%i'",
			PTEMP[i][pLevel], PTEMP[i][pHelper], PTEMP[i][pRatingSupport], PTEMP[i][pJobHeal], PTEMP[i][pMestoJail], PTEMP[i][pHousecash], PTEMP[i][pCheckip]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pHP` = '%f', `pSatiety` = '%i', `pDonateRank` = '%i', `pMats` = '%i', `pSex` = '%i', `pArrested` = '%i'",
			QUERY, PTEMP[i][pHP], PTEMP[i][pSatiety], PTEMP[i][pDonateRank], PTEMP[i][pMats], PTEMP[i][pSex], PTEMP[i][pArrested]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pMuted` = '%i', `pCrimes` = '%i', `pExp` = '%i', `pCash` = '%i',`pPHouseKey` = '%i',`pAdmin` = '%i',`pChar` = '%i', `pWantedDeaths` = '%i', `pPayCheck` = '%i', `pJailTime` = '%i', `pDrugs` = '%i', `pLeader` = '%i', `pMember` = '%i', `pQuestL` = '%i', `pQuest` = '%i', `pQuestP` = '%i', `pQuestF` = '%i', `pQuestPF` = '%i', `pQuestShow` = '%i'",
			QUERY, PTEMP[i][pMuted], PTEMP[i][pCrimes], PTEMP[i][pExp], PTEMP[i][pCash], PTEMP[i][pPHouseKey],PTEMP[i][pAdmin],PTEMP[i][pChar][0], PTEMP[i][pWantedDeaths], PTEMP[i][pPayCheck], PTEMP[i][pJailTime], PTEMP[i][pDrugs], PTEMP[i][pLeader], PTEMP[i][pMember], PTEMP[i][pQuestL], PTEMP[i][pQuest], PTEMP[i][pQuestP], PTEMP[i][pQuestF], PTEMP[i][pQuestPF], PTEMP[i][pQuestShow]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pRank` = '%i', `pChars` = '%s', `pJob` = '%i', `pModel` = '%i', `pPnumber` = '%i', `pDirectory` = '%i', `pVhoddata` = '%i', `pVhodMes` = '%i', `pVhodchas` = '%i', `pVhodminute` = '%i'",
			QUERY, PTEMP[i][pRank], PTEMP[i][pChars], PTEMP[i][pJob], PTEMP[i][pModel], PTEMP[i][pPnumber], PTEMP[i][pDirectory], PTEMP[i][pVhoddata], PTEMP[i][pVhodMes], PTEMP[i][pVhodchas], PTEMP[i][pVhodminute]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pCarLic` = '%i', `pFlyLic` = '%i', `pBoatLic` = '%i', `pFishLic` = '%i', `pGunLic` = '%i', `pBizLic` = '%i', `pZakonp` = '%i', `pText` = '%i'",
			QUERY, PTEMP[i][pCarLic], PTEMP[i][pFlyLic], PTEMP[i][pBoatLic], PTEMP[i][pFishLic], PTEMP[i][pGunLic], PTEMP[i][pBizLic], PTEMP[i][pZakonp], PTEMP[i][pText]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pAddiction` = '%i', `pNarcoLomka` = '%i', `pPayDayHad` = '%i', `pTut` = '%i', `pWarns` = '%i', `OffWarns` = '%i', `punWarns` = '%i', `pFuel` = '%i', `pMarriedTo` = '%s', `pMushrooms` = '%i'",
			QUERY, PTEMP[i][pAddiction], PTEMP[i][pNarcoLomka], PTEMP[i][pPayDayHad], PTEMP[i][pTut], PTEMP[i][pWarns], PTEMP[i][OffWarns], PTEMP[i][punWarns], PTEMP[i][pFuel], PTEMP[i][pMarriedTo], PTEMP[i][pMushrooms]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pFishes` = '%f', `pBank` = '%i', `pMobile` = '%i', `pDolg` = '%i', `pKrisha` = '%i', `pUseKrisha` = '%i', `pWantedLevel` = '%i'",
			QUERY, PTEMP[i][pFishes], PTEMP[i][pBank], PTEMP[i][pMobile], PTEMP[i][pDolg], PTEMP[i][pKrisha], PTEMP[i][pUseKrisha], PTEMP[i][pWantedLevel]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pWeapons` = '%s', `pAmmos` = '%s', `pGunSkills` = '%s', `ptaxiexp` = '%i', `ptaxilvl` = '%i', `pTraining` = '%i', `pBoxSkill` = '%i', `pKongfuSkill` = '%i', `pKickboxSkill` = '%i', `pDLevel` = '%i', `pDExp` = '%i'",
			QUERY, PTEMP[i][pWeapons], PTEMP[i][pAmmos], PTEMP[i][pGunSkills], PTEMP[i][ptaxiexp], PTEMP[i][ptaxilvl], PTEMP[i][pTraining], PTEMP[i][pBoxSkill], PTEMP[i][pKongfuSkill], PTEMP[i][pKickboxSkill], PTEMP[i][pDLevel], PTEMP[i][pDExp]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pDMgruz` = '%i', `pPSkill` = '%i', `pPProc` = '%i', `pPMGruz` = '%i', `pDonateAccount` = '%i'",
			QUERY, PTEMP[i][pDMgruz], PTEMP[i][pPSkill], PTEMP[i][pPProc], PTEMP[i][pPMGruz], PTEMP[i][pDonateAccount]);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pChas` = `pChas` + %i, `pMin` = `pMin` + %i, `pSkilla` = '%i', `prods_skill` = '%i', `prods_exp` = '%i', `pSpawnChange` = '%i,%i', `progolos` = '%i', `grating` = '%i'",
			QUERY, Online[i], Online[i], PTEMP[i][pSkilla], PTEMP[i][pProdsSkill][0], PTEMP[i][pProdsSkill][1], PTEMP[i][pSpawnChange][0], PTEMP[i][pSpawnChange][1], PTEMP[i][progolos], PTEMP[i][pGRating]);

			new Hash1[64 + 1], Hash2[64 + 1];
			SHA256_PassHash(PTEMP[i][pKey], "78sdjs", Hash1, sizeof Hash1);
			SHA256_PassHash(PTEMP[i][pKeyip], "78sdjs", Hash2, sizeof Hash2);
			
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s, `pRecognition` = '%i', `pRobHouse` = '%i', `pFishesPach` = '%i', `pDrivingSkill` = '%i', `pGoogleIP` = '%i', `pEmail` = '%s', `activate_mail` = '%i', `pKey` = '%s', `pKeyip` = '%s'",
			QUERY, PTEMP[i][pRecognition], PTEMP[i][pRobHouse], PTEMP[i][pFishesPach], PTEMP[i][pDrivingSkill], PTEMP[i][pGoogleIP], PTEMP[i][pEmail], PTEMP[i][pActivemail], Hash1, Hash2);

			mysql_format(DATABASE, QUERY, sizeof(QUERY), "%s WHERE `Name` = '%e'", QUERY, PTEMP[i][pName]);
			mysql_function_query(DATABASE, QUERY, false, "", "");
			printf("Файл-Аккаунт %s успешно сохранён", PTEMP[i][pName]);
			SaveMySQL(10,i);
			DeletePVar(i, "player_save");
		}
	case 3:
		{
			format(WorkshopInfo[i][wAuctions],128,"%i, %i, %i, %i, %i",WorkshopInfo[i][wAuction][0], WorkshopInfo[i][wAuction][1], WorkshopInfo[i][wAuction][2], WorkshopInfo[i][wAuction][3], WorkshopInfo[i][wAuction][4]);
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_WORKSHOPS"` SET ");
			format(temp,sizeof(temp),"`owner`= '%s',",WorkshopInfo[i][wOwner]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank`= '%i',",WorkshopInfo[i][wBank]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`landtax`= '%i',",WorkshopInfo[i][wLandTax]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`prods`= '%i',",WorkshopInfo[i][wProds]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`priceprods`= '%i',",WorkshopInfo[i][wPriceProds]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`zp`= '%i',",WorkshopInfo[i][wZp]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`deputy_one`= '%s',",WorkshopInfo[i][wDeputy1]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`deputy_two`= '%s',",WorkshopInfo[i][wDeputy2]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`deputy_three`= '%s',",WorkshopInfo[i][wDeputy3]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mechanic_one`= '%s',",WorkshopInfo[i][wMechanic1]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mechanic_two`= '%s',",WorkshopInfo[i][wMechanic2]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mechanic_three`= '%s',",WorkshopInfo[i][wMechanic3]), 	strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mechanic_four`= '%s',",WorkshopInfo[i][wMechanic4]), 	strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`mechanic_five`= '%s',",WorkshopInfo[i][wMechanic5]), 	strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`auctions`= '%s',",WorkshopInfo[i][wAuctions]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`auction_name`= '%s',",WorkshopInfo[i][wAuctionName]), 	strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Biker`= '%i'",WorkshopInfo[i][wBiker]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp)," WHERE id = '%i'",WorkshopInfo[i][wID]),					strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 4:
		{
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_BIZZ"` SET ");
			format(temp,sizeof(temp),"`bOwner`= '%s',",BizzInfo[i][bOwner]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bMessage`= '%s',",BizzInfo[i][bMessage]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bEntranceX`= '%f',",BizzInfo[i][bEntranceX]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bEntranceY`= '%f',",BizzInfo[i][bEntranceY]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bEntranceZ`= '%f',",BizzInfo[i][bEntranceZ]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bExitX`= '%f',",BizzInfo[i][bExitX]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bExitY`= '%f',",BizzInfo[i][bExitY]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bExitZ`= '%f',",BizzInfo[i][bExitZ]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bBuyPrice`= '%i',",BizzInfo[i][bBuyPrice]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bEntranceCost`= '%i',",BizzInfo[i][bEntranceCost]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bTill`= '%i',",BizzInfo[i][bTill]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bLocked`= '%i',",BizzInfo[i][bLocked]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bInterior`= '%i',",BizzInfo[i][bInterior]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bProducts`= '%i',",BizzInfo[i][bProducts]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bPrice`= '%i',",BizzInfo[i][bPrice]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bBarX`= '%f',",BizzInfo[i][bBarX]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bBarY`= '%f',",BizzInfo[i][bBarY]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bBarZ`= '%f',",BizzInfo[i][bBarZ]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bMafia`= '%i',",BizzInfo[i][bMafia]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bType`= '%i',",BizzInfo[i][bType]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bLockTime`= '%i',",BizzInfo[i][bLockTime]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bLicense`= '%i',",BizzInfo[i][bLicense]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bStavka`= '%i',",BizzInfo[i][bStavka]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bNameStavka`= '%s',",BizzInfo[i][bNameStavka]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bLastStavka`= '%i',",BizzInfo[i][bLastStavka]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bTimeStavka`= '%i',",BizzInfo[i][bTimeStavka]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bMinStavka`= '%i',",BizzInfo[i][bMinStavka]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bVirtualWorld`= '%i',",BizzInfo[i][bVirtualWorld]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bLandTax`= '%i',",BizzInfo[i][bLandTax]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bProdPrice`= '%i'",BizzInfo[i][bProdPrice]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp)," WHERE bID = '%i'",BizzInfo[i][bID]),						strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 5:
		{
			format(HouseInfo[i][hSafes],128,"%i, %i, %i, %i, %i, %i, %i, %i, %i, %i, %i",HouseInfo[i][hSafe][0], HouseInfo[i][hSafe][1], HouseInfo[i][hSafe][2], HouseInfo[i][hSafe][3], HouseInfo[i][hSafe][4],
			HouseInfo[i][hSafe][5], HouseInfo[i][hSafe][6], HouseInfo[i][hSafe][7], HouseInfo[i][hSafe][8], HouseInfo[i][hSafe][9], HouseInfo[i][hSafe][10]);
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_HOUSE"` SET ");
			format(temp,sizeof(temp),"`hEntrancex`= '%f',",HouseInfo[i][hEntrancex]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hEntrancey`= '%f',",HouseInfo[i][hEntrancey]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hEntrancez`= '%f',",HouseInfo[i][hEntrancez]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hExitx`= '%f',",HouseInfo[i][hExitx]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hExity`= '%f',",HouseInfo[i][hExity]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hExitz`= '%f',",HouseInfo[i][hExitz]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hOwner`= '%s',",HouseInfo[i][hOwner]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hValue`= '%i',",HouseInfo[i][hValue]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hTakings`= '%i',",HouseInfo[i][hTakings]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hHel`= '%i',",HouseInfo[i][hHel]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hInt`= '%i',",HouseInfo[i][hInt]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hLock`= '%i',",HouseInfo[i][hLock]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hVec`= '%i',",HouseInfo[i][hVec]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hVcol1`= '%i',",HouseInfo[i][hVcol1]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hVcol2`= '%i',",HouseInfo[i][hVcol2]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hKlass`= '%i',",HouseInfo[i][hKlass]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hVehSost`= '%i',",HouseInfo[i][hVehSost]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hCarx`= '%f',",HouseInfo[i][hCarx]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hCary`= '%f',",HouseInfo[i][hCary]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hCarz`= '%f',",HouseInfo[i][hCarz]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hCarc`= '%f',",HouseInfo[i][hCarc]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`hSafes`= '%s'",HouseInfo[i][hSafes]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp)," WHERE hID = '%i'",HouseInfo[i][hID]),					strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 6:
		{
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_KVARTIRS"` SET ");
			format(temp,sizeof(temp),"`pXpic`= '%f',",kvartinfo[i][pXpic]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`pYpic`= '%f',",kvartinfo[i][pYpic]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`pZpic`= '%f',",kvartinfo[i][pZpic]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`vladelec`= '%s',",kvartinfo[i][vladelec]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`lock`= '%i',",kvartinfo[i][lock]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`kworld`= '%i',",kvartinfo[i][kworld]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`aptek`= '%i',",kvartinfo[i][aptek]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`plata`= '%i',",kvartinfo[i][plata]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`kCena`= '%i',",kvartinfo[i][kCena]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`kInt`= '%i',",kvartinfo[i][kInt]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`virtmir`= '%i'",kvartinfo[i][virtmir]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp)," WHERE kid = '%i'",kvartinfo[i][kid]),					strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 7:
		{
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_PODEZDS"` SET ");
			format(temp,sizeof(temp),"`podPicX`= '%f',",PodeezdInfo[i][podPicX]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`podPicY`= '%f',",PodeezdInfo[i][podPicY]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`podPicZ`= '%f',",PodeezdInfo[i][podPicZ]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`podEtazi`= '%i',",PodeezdInfo[i][podEtazi]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`carX`= '%f',",PodeezdInfo[i][carX]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`carY`= '%f',",PodeezdInfo[i][carY]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`carZ`= '%f',",PodeezdInfo[i][carZ]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`podInt`= '%i',",PodeezdInfo[i][podInt]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`carC`= '%f'",PodeezdInfo[i][carC]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp)," WHERE pid = '%i'",PodeezdInfo[i][pid]),					strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 8:
		{
			mysql_format(DATABASE,QUERY, 500, "UPDATE "TABLE_ATM" SET `id` = '%i', `ax` = '%f', `ay` = '%f', `az` = '%f', `arz` = '%f' WHERE id = %i",
			ATMInfo[i][aid], ATMInfo[i][aX],ATMInfo[i][aY],ATMInfo[i][aZ],ATMInfo[i][arZ], ATMInfo[i][aid]);
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 9:
		{
			format(FarmInfo[i][fAuctions],64,"%i, %i, %i, %i, %i",FarmInfo[i][fAuction][0], FarmInfo[i][fAuction][1], FarmInfo[i][fAuction][2], FarmInfo[i][fAuction][3], FarmInfo[i][fAuction][4]);
			mysql_format(DATABASE, QUERY, sizeof(QUERY), "UPDATE `"TABLE_FARM"` SET ");
			format(temp,sizeof(temp),"`owner`= '%s',",FarmInfo[i][fOwner]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`bank`= '%i',",FarmInfo[i][fBank]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`landtax`= '%i',",FarmInfo[i][fLandTax]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`zp`= '%i',",FarmInfo[i][fZp]), 							strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`grain_price`= '%i',",FarmInfo[i][fGrain_Price]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`grain`= '%i',",FarmInfo[i][fGrain]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`grain_sown`= '%i',",FarmInfo[i][fGrain_Sown]), 			strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`prods_selling`= '%i',",FarmInfo[i][fProds_Selling]), 	strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`prods`= '%i',",FarmInfo[i][fProds]), 					strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`prods_price`= '%i',",FarmInfo[i][fProds_Price]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`deputy_1`= '%s',",FarmInfo[i][fDeputy_1]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`deputy_2`= '%s',",FarmInfo[i][fDeputy_2]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`deputy_3`= '%s',",FarmInfo[i][fDeputy_3]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`farmer_1`= '%s',",FarmInfo[i][fFarmer_1]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`farmer_2`= '%s',",FarmInfo[i][fFarmer_2]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`farmer_3`= '%s',",FarmInfo[i][fFarmer_3]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`farmer_4`= '%s',",FarmInfo[i][fFarmer_4]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`farmer_5`= '%s',",FarmInfo[i][fFarmer_5]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`auctions`= '%s',",FarmInfo[i][fAuctions]), 				strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`auction_name`= '%s',",FarmInfo[i][fAuctionName]), 		strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp),"`Biker`= '%i'",FarmInfo[i][fBiker]), 						strcat(QUERY,temp,sizeof(QUERY));
			format(temp,sizeof(temp)," WHERE id = '%i'",FarmInfo[i][fID]),						strcat(QUERY,temp,sizeof(QUERY));
			mysql_function_query(DATABASE, QUERY, true, "", "");
		}
	case 10:
		{
			mysql_format(DATABASE,QUERY,256,"SELECT * FROM `"TABLE_CARS"` WHERE `owner` = '%s'",PTEMP[i][pName]), mysql_function_query(DATABASE,QUERY,true,"OnMySQL_QUERY","iis",37,i,"");
		}
	}
	return true;
}