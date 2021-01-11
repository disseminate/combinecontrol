function nBuyBusinessLicense( len, ply )
	
	local t = net.ReadUInt( 10 );
	
	if( GAMEMODE.BusinessLicenses[t] and GAMEMODE.BusinessLicenses[t][2] and bit.band( ply:BusinessLicenses(), t ) != t ) then
		
		if( ply:Money() >= GAMEMODE.BusinessLicenses[t][2] ) then
			
			ply:AddMoney( -1 * GAMEMODE.BusinessLicenses[t][2] );
			ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
			
			ply:SetBusinessLicenses( ply:BusinessLicenses() + t );
			ply:UpdateCharacterField( "BusinessLicenses", ply:BusinessLicenses() );
			
			net.Start( "nPopulateBusiness" );
			net.Send( ply );
			
		end
		
	end
	
end
net.Receive( "nBuyBusinessLicense", nBuyBusinessLicense );

function nBuyItem( len, ply )
	
	local id = net.ReadString();
	
	local item = GAMEMODE:GetItemByID( id );
	local lic = ply:BusinessLicenses();
	
	if( ply:HasCharFlag( "X" ) ) then lic = lic + LICENSE_BLACK end
	
	if( item and bit.band( lic, item.License or -1 ) == item.License ) then
		
		if( item.SinglePrice ) then
			
			if( ply:Money() >= item.SinglePrice ) then
				
				if( ply:InventoryWeight() < ply:InventoryMaxWeight() ) then
					
					ply:AddMoney( -1 * item.SinglePrice );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, 1 );
					
				end
				
			end
			
		else
			
			if( ply:Money() >= item.BulkPrice ) then
				
				if( ply:InventoryWeight() < ply:InventoryMaxWeight() ) then
					
					ply:AddMoney( -1 * item.BulkPrice );
					ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
					
					ply:GiveItem( id, 5 );
					
				end
				
			end
			
		end
		
	end
	
end
net.Receive( "nBuyItem", nBuyItem );