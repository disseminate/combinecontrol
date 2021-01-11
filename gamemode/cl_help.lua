function GM:RefreshHelpMenuContent()

	self.HelpContent = {
		{ "Credits",
			[[CombineControl created by Disseminate.
			
			Casadis - for all the support and ideas.
			Kamern - ideas and support.]] },
		
		{ "Chat Commands",
			[[Just entering something in the chatbox will make you say it in character.
			
			/help - Show this menu
			
			/cid - Change your CID
			
			/y - Yell
			/w - Whisper
			/me - Action
			/it - World action
			/an - Anonymous
			// - Global OOC
			[[, .// - Local OOC
			/a - Talk to admins
			/pm [name] [text] - PM another player
			/r - Talk on your radio if you have one
			/cr - Talk on your CR device if you have one
			/bc - Broadcast a message as a CP
			/ad - Send out an advertisement (costs 10 credits)
			/help - Open this menu
			
			/citizen - Become a citizen, if flagged.
			/cp - Become a CP, if you have combine flags.
			
			/rus - Speak Russian.
			/chi - Speak Chinese.
			/jap - Speak Japanese.
			/spa - Speak Spanish.
			/fre - Speak French.
			/ger - Speak German.
			/ita - Speak Italian.]] },
		{ "Key Bindings", [[F1 - Open help menu.
		F2 - Open character menu.
		F3 - Open player menu.
		F4 - Open admin menu.
		C - Open context menu.]] },
		{ "Flags", [[CombineControl uses a flag system for combine and other playable races.
		
		If an admin sets your combine flags, you can "flag up" or become the faction with /cp, and become a citizen again with /citizen.
		Non-combine flags are automatic - you don't need to flag up for them.
		
		Combine Flags
		A - Recruit
		B - Standard Unit
		C - Squad Leader
		
		Character Flags
		V - Vortigaunt
		W - Vortigaunt Slave]] },
		{ "Tooltrust", [[By default, you don't have tooltrust, you have phystrust, and you have proptrust. Phys- and proptrust give you a physgun and the ability to spawn props respectively. Tooltrust gives you a toolgun.
		
		Basic tooltrust gives you some common simple tools, a slightly increased prop limit, and slightly increased prop spawn permissions. To get this, ask an admin.
		
		Advanced tooltrust gives you most tools, an increased prop limit, and increased prop spawn permissions. Advanced tooltrust users' props are solid, whereas basic and non tooltrusted props are no-collided. To get this, check the forums.
		
		Admins can take away phys and proptrust if you abuse the privillege - you can get it back on the forums.]] },
		{ "Making Money", [[There are a few ways to earn credits in CombineControl.
		
		1) Rations contain a stipend of credits.
		
		2) Form a business and sell items. To do this, open the player menu and go to the Business tab. You need to buy a business license first. Check the Businesses help menu topic for more.
		
		3) Sell services. Offer to clean another citizen's apartment, or do advertising for someone's business. Check if a CP wants you to wash something. Repair TVs or stoves for people (assuming you're perceptive enough). You never know what kind of work you'll find!
		
		4) Go illegal. Although getting arrested is a possible consequence, making a drug lab or taking hit requests is lucrative if you know how.
		
		5) Loans are a temporary way of getting credits. Open the Loans tab in the player menu.
		
		6) Put up propaganda posters for the Combine. Although you're sacrificing some of your dignity, you'll earn a small amount of credits for each poster.]] },
		{ "Businesses", [[Businesses in CombineControl are pretty loosely organized. Any character can make a business.
		
		First, you need business licenses. ICly, these are sold by the CCA and allow you to buy inventory in bulk. They're not cheap, but once you have one you can start buying items. Loans are good for this purpose.
		
		With a business license, you can buy inventory. Items come in packs of 5, so you need some startup capital. Be sure you can sell them all, or you'll end up with a bunch of junk sitting around in your inventory. Also, be warned that buying inventory doesn't check your inventory size, so if you buy literally tons of items, be prepared to not be able to run until you can sell everything.]] },
		{ "Stats", [[Stats are more in-depth in CombineControl than in other gamemodes.
		
		Speed
		- Determines how fast you run.
		- Increase this by running.
		Strength
		- Determines how far you can throw things, how hard you can punch, how much you can carry, etc.
		- Increase this by throwing things or practicing boxing.
		Toughness
		- Determines how much damage you can take, how fast you can recover from leg damage, etc.
		- Increase this by taking damage.
		Perception
		- Determines how far you can see things, how fast you can repair, etc.
		- Increase this by examining things, repairing things or making art.
		Agility
		- Determines how high you can jump.
		- Increase this by practicing jumping.
		Aim
		- Determines how well you can aim a firearm.
		- Increase this by target shooting, either far-away or moving objects.]] },
	};

	if( LocalPlayer():IsAdmin() ) then
		
		table.insert( self.HelpContent, { "Admin Commands", [[Press F4 to open the admin menu.
		
		If you want to enter commands manually, below is a list of all admin commands in CombineControl.
		
		Note: In CombineControl, there is no rpa_observe - observe mode is just noclip.
		
		If the command needs a player, you can specify "^" to target yourself and "-" to target the player you're looking at.
		
		rpa_restart - Restart the server.
		rpa_kill [player] - Kill a player.
		rpa_slap [player] - Slap a player.
		rpa_ko [player] - Knock out a player.
		rpa_kick [player] (reason) - Kick a player.
		rpa_ban [player] [time] (reason) - Ban a player. A time of 0 is a permaban.
		rpa_unban [SteamID] - Unban a player.
		rpa_changebanlength [SteamID] [duration] - Change a ban's length for a player.
		rpa_goto [player] - Teleport to a player.
		rpa_bring [player] - Teleport a player to you.
		rpa_namewarn [player] - Give a player a name warning.
		rpa_setname [player] [new name] - Change a player's name.
		rpa_setcharmodel [player] [model] - Change a player's model. You can use citizen IDs ("male_01", for example) instead of the full path.
		rpa_seeall - Toggle admin ESP mode.
		
		rpa_editinventory [player] - Open a character's inventory for editing.
		
		rpa_setcombineflag [player] [flag] - Set a player's combine flag.
		rpa_setcharflags [player] [flag(s)] - Set a player's character flags.
		rpa_setcombinesquad [player] [squad] - Set a player's combine squad.
		rpa_setcombinesquadid [player] [id #] - Set a player's combine ID number.
		rpa_combineroster - See all characters with combine flags.
		rpa_flagsroster - See all characters with player flags.
		
		rpa_settooltrust [tt] - Set a player's tooltrust. 0 is none, 1 is basic, 2 is advanced.
		rpa_setphystrust [0/1] - Set a player's phystrust. Default is 1, set to 0 to take away the physgun.
		rpa_setproptrust [0/1] - Set a player's proptrust. Default is 1, set to 0 to take away the ability to spawn props.
		
		rpa_togglesaved - Toggle the prop you're looking at's static property. If static, it will glow pink in SeeAll and will save across restarts.
		
		rpa_playmusic [music/0/1/2] - Play music. 0 is calm, 1 is alert, 2 is action. Alternatively you can specify a song by filename.
		rpa_stopmusic - Stop any playing music.
		rpa_playoverwatch [id] - Play an overwatch line. If you don't enter an id, a list of valid ids and lines will display instead.
		
		rpa_createitem [item] - Spawn an item.
		rpa_givemoney [player] [amount] - Give a player credits.
		
		rpa_spawncanister [number headcrabs] [regular/fast/poison] - Send a headcrab canister to wherever you're looking, from behind you.
		rpa_createexplosion - Create an explosion where you're looking at.
		rpa_createfire [duration] - Create a fire where you're looking at.
		
		rpa_stopsound - Stop all playing sounds for everyone.
		
		rpa_setstatspeed/strength/etc - Set a player's stats.
		rpa_addstatspeed/strength/etc - Add to a player's stats. Use a negative number to subtract.
		
		/ev - Broadcast an IC event.]] } );
		
	end
	
end

function GM:CreateHelpMenu()
	
	self:RefreshHelpMenuContent();
	
	CCP.HelpMenu = vgui.Create( "DFrame" );
	CCP.HelpMenu:SetSize( 800, 600 );
	CCP.HelpMenu:Center();
	CCP.HelpMenu:SetTitle( "Help" );
	CCP.HelpMenu.lblTitle:SetFont( "CombineControl.Window" );
	CCP.HelpMenu:MakePopup();
	CCP.HelpMenu.PerformLayout = CCFramePerformLayout;
	CCP.HelpMenu:PerformLayout();
	
	CCP.HelpMenu.ContentPane = vgui.Create( "DScrollPanel", CCP.HelpMenu );
	CCP.HelpMenu.ContentPane:SetSize( 650, 556 );
	CCP.HelpMenu.ContentPane:SetPos( 140, 34 );
	function CCP.HelpMenu.ContentPane:Paint( w, h )
		
		surface.SetDrawColor( 30, 30, 30, 255 );
		surface.DrawRect( 0, 0, w, h );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( 0, 0, w, h );
		
	end
	
	CCP.HelpMenu.Content = vgui.Create( "CCLabel" );
	CCP.HelpMenu.Content:SetPos( 10, 10 );
	CCP.HelpMenu.Content:SetSize( 630, 14 );
	CCP.HelpMenu.Content:SetFont( "CombineControl.LabelMedium" );
	CCP.HelpMenu.Content:SetText( "Welcome to the help menu! Press a button on the left to select a topic." );
	CCP.HelpMenu.Content:PerformLayout();
	CCP.HelpMenu.ContentPane:AddItem( CCP.HelpMenu.Content );
	
	local y = 34;
	
	for _, v in pairs( self.HelpContent ) do
		
		local but = vgui.Create( "DButton", CCP.HelpMenu );
		but:SetPos( 10, y );
		but:SetSize( 120, 20 );
		but:SetText( v[1] );
		but:PerformLayout();
		function but:DoClick()
			
			CCP.HelpMenu.Content:SetText( string.gsub( v[2], "\t", "" ) );
			
			CCP.HelpMenu.Content:InvalidateLayout( true );
			CCP.HelpMenu.ContentPane:PerformLayout();
			
		end
		
		y = y + 30;
		
	end
	
end