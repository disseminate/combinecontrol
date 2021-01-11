util.AddNetworkString( "nCharacterList" );
util.AddNetworkString( "nRequestPData" );

util.AddNetworkString( "nOpenCharCreate" );
util.AddNetworkString( "nCreateCharacter" );
util.AddNetworkString( "nSelectCharacter" );
util.AddNetworkString( "nDeleteCharacter" );
util.AddNetworkString( "nSetNewbieStatus" );

util.AddNetworkString( "nChangeRPName" );
util.AddNetworkString( "nChangeTitle" );

util.AddNetworkString( "nAddChat" );
util.AddNetworkString( "nSay" );
util.AddNetworkString( "nConSay" );
util.AddNetworkString( "nChatLocal" );
util.AddNetworkString( "nChatYell" );
util.AddNetworkString( "nChatWhisper" );
util.AddNetworkString( "nChatMe" );
util.AddNetworkString( "nChatIt" );
util.AddNetworkString( "nChatAn" );
util.AddNetworkString( "nChatOOC" );
util.AddNetworkString( "nChatLOOC" );
util.AddNetworkString( "nChatAdmin" );
util.AddNetworkString( "nChatPM" );
util.AddNetworkString( "nChatRadioDeath" );
util.AddNetworkString( "nChatRadio" );
util.AddNetworkString( "nChatRadioSurround" );
util.AddNetworkString( "nChatBigRadio" );
util.AddNetworkString( "nChangeRadio" );
util.AddNetworkString( "nChatCRDevice" );
util.AddNetworkString( "nChatCRDeviceSurround" );
util.AddNetworkString( "nChatBroadcast" );
util.AddNetworkString( "nChatEvent" );
util.AddNetworkString( "nChatAdvertise" );
util.AddNetworkString( "nRoll" );

util.AddNetworkString( "nAUpdateAdminVariable" );
util.AddNetworkString( "nANotAdmin" );
util.AddNetworkString( "nANotSuperAdmin" );
util.AddNetworkString( "nANoSteamIDSpecified" );
util.AddNetworkString( "nAInvalidSteamID" );
util.AddNetworkString( "nANoBanFound" );
util.AddNetworkString( "nANoTargetSpecified" );
util.AddNetworkString( "nANoTargetFound" );
util.AddNetworkString( "nAOneTargetNotFound" );
util.AddNetworkString( "nAAdminTarget" );
util.AddNetworkString( "nANoDurationSpecified" );
util.AddNetworkString( "nANoValueSpecified" );
util.AddNetworkString( "nANegativeDuration" );
util.AddNetworkString( "nAInvalidValue" );
util.AddNetworkString( "nARestart" );
util.AddNetworkString( "nAInvalidMap" );
util.AddNetworkString( "nAChangeMap" );
util.AddNetworkString( "nAKill" );
util.AddNetworkString( "nASlap" );
util.AddNetworkString( "nAKO" );
util.AddNetworkString( "nAKick" );
util.AddNetworkString( "nARemove" );
util.AddNetworkString( "nABadModel" );
util.AddNetworkString( "nASetModel" );
util.AddNetworkString( "nAChangeName" );
util.AddNetworkString( "nABan" );
util.AddNetworkString( "nAOBan" );
util.AddNetworkString( "nAUnBan" );
util.AddNetworkString( "nASeeAll" );
util.AddNetworkString( "nASetCombineFlag" );
util.AddNetworkString( "nARemoveCombineFlag" );
util.AddNetworkString( "nASetCharFlags" );
util.AddNetworkString( "nARemoveCharFlags" );
util.AddNetworkString( "nASetCombineSquad" );
util.AddNetworkString( "nARemoveCombineSquad" );
util.AddNetworkString( "nASetCombineSquadID" );
util.AddNetworkString( "nACombineRoster" );
util.AddNetworkString( "nANoCombineRoster" );
util.AddNetworkString( "nAFlagsRoster" );
util.AddNetworkString( "nANoFlagsRoster" );
util.AddNetworkString( "nASetToolTrust" );
util.AddNetworkString( "nARemoveToolTrust" );
util.AddNetworkString( "nASetPhysTrust" );
util.AddNetworkString( "nARemovePhysTrust" );
util.AddNetworkString( "nASetPropTrust" );
util.AddNetworkString( "nARemovePropTrust" );
util.AddNetworkString( "nAPlayMusic" );
util.AddNetworkString( "nAStopMusic" );
util.AddNetworkString( "nAListItems" );
util.AddNetworkString( "nAPlayOverwatch" );
util.AddNetworkString( "nAListOverwatch" );
util.AddNetworkString( "nATooTight" );
util.AddNetworkString( "nAEditInventory" );
util.AddNetworkString( "nARemoveItem" );
util.AddNetworkString( "nAUpdateInventory" );
util.AddNetworkString( "nARemoveItem" );
util.AddNetworkString( "nWarnName" );
util.AddNetworkString( "nAStopSound" );

for k, v in pairs( GM.Stats ) do
	
	util.AddNetworkString( "nASet" .. v );
	
end

util.AddNetworkString( "nQuizBan" );
util.AddNetworkString( "nAQuizBan" );

util.AddNetworkString( "nGetBansList" );
util.AddNetworkString( "nBansList" );
util.AddNetworkString( "nGetLogList" );
util.AddNetworkString( "nLogList" );
util.AddNetworkString( "nGetRosterList" );
util.AddNetworkString( "nRosterList" );

util.AddNetworkString( "nApproveCPApp" );
util.AddNetworkString( "nDenyCPApp" );
util.AddNetworkString( "nCombineAccepted" );
util.AddNetworkString( "nCombineDenied" );
util.AddNetworkString( "nApplyCombine" );
util.AddNetworkString( "nApplyCombineSuccess" );
util.AddNetworkString( "nPromoteRecruit" );
util.AddNetworkString( "nDemoteUnit" );
util.AddNetworkString( "nCombinePromoted" );
util.AddNetworkString( "nCombineDemoted" );
util.AddNetworkString( "nRefreshSqL" );
util.AddNetworkString( "nDropRation" );
util.AddNetworkString( "nDropPoster" );
util.AddNetworkString( "nCombineRefill" );
util.AddNetworkString( "nGetCPAppsList" );
util.AddNetworkString( "nCPAppsList" );
util.AddNetworkString( "nRequestCombineHousingDoors" );
util.AddNetworkString( "nReceiveCombineHousingDoors" );
util.AddNetworkString( "nCPGetRosterList" );
util.AddNetworkString( "nCPRosterList" );
util.AddNetworkString( "nRefreshCombinePromotions" );
util.AddNetworkString( "nSetSquad" );
util.AddNetworkString( "nSetSquadID" );
util.AddNetworkString( "nUpdateRecord" );
util.AddNetworkString( "nAddPrison" );
util.AddNetworkString( "nRemovePrison" );
util.AddNetworkString( "nPrisonNotify30" );
util.AddNetworkString( "nPrisonNotify" );

util.AddNetworkString( "nCIDTooLow" );
util.AddNetworkString( "nCIDTooHigh" );
util.AddNetworkString( "nCIDNumber" );

util.AddNetworkString( "nWakeUp" );
util.AddNetworkString( "nRagSetPlayer" );

util.AddNetworkString( "nLoadInventory" );
util.AddNetworkString( "nGiveItem" );
util.AddNetworkString( "nRemoveItem" );
util.AddNetworkString( "nThrowOutItem" );
util.AddNetworkString( "nDropItem" );
util.AddNetworkString( "nUseItem" );
util.AddNetworkString( "nTooHeavy" );

util.AddNetworkString( "nFlashbang" );
util.AddNetworkString( "nSmoke" );

util.AddNetworkString( "nCPPK" );

util.AddNetworkString( "nRequestPlayerData" );
util.AddNetworkString( "nRequestAllPlayerData" );
util.AddNetworkString( "nRequestDoorData" );
util.AddNetworkString( "nRequestNPCData" );
util.AddNetworkString( "nRequestPropData" );

util.AddNetworkString( "nPlayVCD" );

util.AddNetworkString( "nCreateTimedProgressBar" );
util.AddNetworkString( "nCBuyDoor" );
util.AddNetworkString( "nCSellDoor" );
util.AddNetworkString( "nCLockUnlock" );
util.AddNetworkString( "nCNameDoor" );
util.AddNetworkString( "nCDestroyItem" );
util.AddNetworkString( "nCMakeOwner" );
util.AddNetworkString( "nCRemoveOwner" );
util.AddNetworkString( "nCAssignOwner" );
util.AddNetworkString( "nCUnassignOwner" );
util.AddNetworkString( "nCGiveCredits" );
util.AddNetworkString( "nCReceiveCredits" );
util.AddNetworkString( "nCExamine" );
util.AddNetworkString( "nCPatDownStart" );
util.AddNetworkString( "nCPatDown" );
util.AddNetworkString( "nCPattedDown" );
util.AddNetworkString( "nCTieUpStart" );
util.AddNetworkString( "nCTieUp" );
util.AddNetworkString( "nCTiedUp" );
util.AddNetworkString( "nCSlitThroat" );
util.AddNetworkString( "nCUntieStart" );
util.AddNetworkString( "nCUntie" );
util.AddNetworkString( "nCTakeRadio" );
util.AddNetworkString( "nCTakeTurret" );
util.AddNetworkString( "nCTakeTV" );
util.AddNetworkString( "nCRepairTV" );
util.AddNetworkString( "nCElectrocuteTV" );
util.AddNetworkString( "nCTakeMicrowave" );
util.AddNetworkString( "nCRadioChannel" );
util.AddNetworkString( "nCTVRepair" );
util.AddNetworkString( "nCTVRepairDone" );
util.AddNetworkString( "nCRepairStove" );
util.AddNetworkString( "nCStoveRepair" );
util.AddNetworkString( "nCStoveRepairDone" );
util.AddNetworkString( "nCPercLevel" );
util.AddNetworkString( "nUnownedStove" );

util.AddNetworkString( "nTakeLoan" );
util.AddNetworkString( "nGiveLoan" );
util.AddNetworkString( "nDeductLoan" );
util.AddNetworkString( "nLoanDeducted" );

util.AddNetworkString( "nSetTyping" );

util.AddNetworkString( "nPopulateBusiness" );
util.AddNetworkString( "nBuyBusinessLicense" );
util.AddNetworkString( "nBuyItem" );

util.AddNetworkString( "nWritePaper" );

util.AddNetworkString( "nIntroStart" );
util.AddNetworkString( "nFlashRed" );

util.AddNetworkString( "nToggleHolster" );
util.AddNetworkString( "nSelectWeapon" );

util.AddNetworkString( "nCombineCrate" );
util.AddNetworkString( "nCombineCrateNotCP" );
util.AddNetworkString( "nTakeLoadout" );
util.AddNetworkString( "nCombineRation" );
util.AddNetworkString( "nCombineRationNotCP" );
util.AddNetworkString( "nCombineRationTooEarly" );
util.AddNetworkString( "nCombineRationTooHeavy" );

util.AddNetworkString( "nPlaySignal" );
util.AddNetworkString( "nPlayExpression" );
util.AddNetworkString( "nSayVoice" );

util.AddNetworkString( "nNMMGoTo" );
util.AddNetworkString( "nNMMWalkTo" );
util.AddNetworkString( "nNMMSetMastermindColor" );
util.AddNetworkString( "nNMMFireInput" );
util.AddNetworkString( "nNMMGunOn" );
util.AddNetworkString( "nNMMPlayGesture" );
util.AddNetworkString( "nNMMHateUnflagged" );
util.AddNetworkString( "nNMMHateFlagged" );
util.AddNetworkString( "nNMMHateCitizens" );
util.AddNetworkString( "nNMMHateRebels" );
util.AddNetworkString( "nNMMHateWeapons" );
util.AddNetworkString( "nNMMKill" );

util.AddNetworkString( "nNCMShake" );

util.AddNetworkString( "nSetJW" );

util.AddNetworkString( "nAddNotification" );

util.AddNetworkString( "nDonationProcess" );

util.AddNetworkString( "nAddPropProtection" );
util.AddNetworkString( "nRemovePropProtection" );

util.AddNetworkString( "nConnect" );
util.AddNetworkString( "nServerOffer" );
util.AddNetworkString( "nServerOfferAccept" );