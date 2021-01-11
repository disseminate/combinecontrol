function nDonationProcess( len )
	
	GAMEMODE:AddChat( Color( 229, 201, 98, 255 ), "CombineControl.ChatNormal", "Your donation has been processed and applied!", { CB_ALL, CB_OOC } );
	
end
net.Receive( "nDonationProcess", nDonationProcess );