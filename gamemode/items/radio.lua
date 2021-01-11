ITEM.ID				= "radio";
ITEM.Name			= "Radio";
ITEM.Description	= "A radio, with controllable frequency.";
ITEM.Model			= "models/items/combine_rifle_cartridge01.mdl";
ITEM.Weight 		= 1;
ITEM.FOV 			= 10;
ITEM.CamPos 		= Vector( -0.08, 50, 50 );
ITEM.LookAt 		= Vector( 0, 0, 0 );

ITEM.BulkPrice		= 250;
ITEM.License		= LICENSE_BLACK;

ITEM.Usable			= true;
ITEM.UseText		= "Channel";
ITEM.OnPlayerUse	= function( self, ply )
	
	if( CLIENT ) then
		
		if( GAMEMODE:LookupCombineFlag( ply:ActiveFlag() ) ) then
			
			GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Your Combine radio channel is hardcoded...", { CB_ALL, CB_IC } );
			return;
			
		end
		
		CCP.RadioSelector = vgui.Create( "DFrame" );
		CCP.RadioSelector:SetSize( 250, 114 );
		CCP.RadioSelector:Center();
		CCP.RadioSelector:SetTitle( "Change Channel (0-999)" );
		CCP.RadioSelector.lblTitle:SetFont( "CombineControl.Window" );
		CCP.RadioSelector:MakePopup();
		CCP.RadioSelector.PerformLayout = CCFramePerformLayout;
		CCP.RadioSelector:PerformLayout();
		
		CCP.RadioSelector.Entry = vgui.Create( "DTextEntry", CCP.RadioSelector );
		CCP.RadioSelector.Entry:SetFont( "CombineControl.LabelBig" );
		CCP.RadioSelector.Entry:SetPos( 10, 34 );
		CCP.RadioSelector.Entry:SetSize( 100, 30 );
		CCP.RadioSelector.Entry:PerformLayout();
		CCP.RadioSelector.Entry:RequestFocus();
		CCP.RadioSelector.Entry:SetNumeric( true );
		CCP.RadioSelector.Entry:SetValue( ply:RadioFreq() );
		CCP.RadioSelector.Entry:SetCaretPos( string.len( CCP.RadioSelector.Entry:GetValue() ) );
		
		CCP.RadioSelector.OK = vgui.Create( "DButton", CCP.RadioSelector );
		CCP.RadioSelector.OK:SetFont( "CombineControl.LabelSmall" );
		CCP.RadioSelector.OK:SetText( "OK" );
		CCP.RadioSelector.OK:SetPos( 190, 74 );
		CCP.RadioSelector.OK:SetSize( 50, 30 );
		function CCP.RadioSelector.OK:DoClick()
			
			local val = tonumber( CCP.RadioSelector.Entry:GetValue() );
			
			if( val >= 0 ) then
				
				if( val <= 999 ) then
					
					CCP.RadioSelector:Remove();
					
					GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "Your radio channel is now " .. tostring( val ) .. ".", { CB_ALL, CB_IC } );
					
					net.Start( "nChangeRadio" );
						net.WriteFloat( val );
					net.SendToServer();
					
				else
					
					GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Highest channel is 999.", { CB_ALL, CB_IC } );
					
				end
				
			else
				
				GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Lowest channel is 0.", { CB_ALL, CB_IC } );
				
			end
			
		end
		CCP.RadioSelector.OK:PerformLayout();
		
		CCP.RadioSelector.Entry.OnEnter = CCP.RadioSelector.OK.DoClick;
		
	end
	
end