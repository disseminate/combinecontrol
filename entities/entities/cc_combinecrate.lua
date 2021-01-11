AddCSLuaFile();

ENT.Base = "base_anim";
ENT.Type = "anim";

ENT.PrintName		= "";
ENT.Author			= "";
ENT.Contact			= "";
ENT.Purpose			= "";
ENT.Instructions	= "";

ENT.Spawnable				= false;
ENT.AdminSpawnable			= false;

ENT.AutomaticFrameAdvance	= true;

function ENT:PostEntityPaste( ply, ent, tab )
	
	GAMEMODE:LogSecurity( ply:SteamID(), "n/a", ply:VisibleRPName(), "Tried to duplicate " .. ent:GetClass() .. "!" );
	ent:Remove();
	
end

function ENT:Initialize()
	
	self:SetModel( "models/Items/ammocrate_smg1.mdl" );
	
	if( SERVER ) then
		
		self:PhysicsInit( SOLID_VPHYSICS );
		self:SetMoveType( MOVETYPE_VPHYSICS );
		self:SetSolid( SOLID_VPHYSICS );
		
		local phys = self:GetPhysicsObject();
		
		if( phys and phys:IsValid() ) then
			
			phys:EnableMotion( false );
			
		end
		
		self:SetUseType( SIMPLE_USE );
		
	end
	
end

function ENT:Use( ply )
	
	if( SERVER ) then
		
		local flag = GAMEMODE:LookupCombineFlag( ply:CombineFlag() );
		
		if( flag ) then
			
			if( self.Open ) then
				
				self.StartOpen = CurTime() - 1;
				
			else
				
				self:EmitSound( "AmmoCrate.Open" );
				self:ResetSequence( self:LookupSequence( "Open" ) );
				self.Open = true;
				self.StartOpen = CurTime();
				
			end
			
			net.Start( "nCombineCrate" );
			net.Send( ply );
			
		else
			
			net.Start( "nCombineCrateNotCP" );
			net.Send( ply );
			
		end
		
	end
	
end

function ENT:Think()
	
	if( self.Open ) then
		
		if( self.StartOpen and CurTime() - self.StartOpen > 2 ) then
			
			self:EmitSound( "AmmoCrate.Close" );
			self:ResetSequence( self:LookupSequence( "Close" ) );
			self.Open = false;
			
		end
		
	end
	
	self:NextThink( CurTime() );
	return true;
	
end

if( CLIENT ) then
	
	function nCombineCrate( len )
		
		local flag = GAMEMODE:LookupCombineFlag( LocalPlayer():CombineFlag() );
		
		CCP.CombineCrate = vgui.Create( "DFrame" );
		CCP.CombineCrate:SetSize( 590, 500 );
		CCP.CombineCrate:Center();
		CCP.CombineCrate:SetTitle( "Civil Protection Loadout" );
		CCP.CombineCrate.lblTitle:SetFont( "CombineControl.Window" );
		CCP.CombineCrate:MakePopup();
		CCP.CombineCrate.PerformLayout = CCFramePerformLayout;
		CCP.CombineCrate:PerformLayout();
		
		CCP.CombineCrate.WarningLabel = vgui.Create( "DLabel", CCP.CombineCrate );
		CCP.CombineCrate.WarningLabel:SetText( "Be sure to only take what you need - you can only carry so much." );
		CCP.CombineCrate.WarningLabel:SetPos( 10, 34 );
		CCP.CombineCrate.WarningLabel:SetSize( 570, 14 );
		CCP.CombineCrate.WarningLabel:SetFont( "CombineControl.LabelSmall" );
		CCP.CombineCrate.WarningLabel:PerformLayout();
		CCP.CombineCrate.WarningLabel:SetWrap( true );
		CCP.CombineCrate.WarningLabel:SetAutoStretchVertical( true );
		
		CCP.CombineCrate.Pane = vgui.Create( "DScrollPanel", CCP.CombineCrate );
		CCP.CombineCrate.Pane:SetSize( 570, 406 );
		CCP.CombineCrate.Pane:SetPos( 10, 84 );
		function CCP.CombineCrate.Pane:Paint( w, h )
			
			surface.SetDrawColor( 30, 30, 30, 255 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 20, 20, 20, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		
		local y = 0;
		
		for _, v in pairs( flag.ItemLoadout ) do
			
			local itemdata = GAMEMODE:GetItemByID( v );
			
			local itempane = vgui.Create( "DPanel" );
			itempane:SetPos( 0, y );
			itempane:SetSize( 556, 64 );
			itempane.Item = v;
			function itempane:Paint( w, h )
				
				surface.SetDrawColor( 0, 0, 0, 70 );
				surface.DrawRect( 0, 0, w, h );
				
				surface.SetDrawColor( 0, 0, 0, 100 );
				surface.DrawOutlinedRect( 0, 0, w, h );
				
			end
			
			local icon = vgui.Create( "DModelPanel", itempane );
			icon:SetPos( 0, 0 );
			icon:SetModel( itemdata.Model );
			icon:SetSize( 64, 64 );
			
			if( itemdata.LookAt ) then
				
				icon:SetFOV( itemdata.FOV );
				icon:SetCamPos( itemdata.CamPos );
				icon:SetLookAt( itemdata.LookAt );
				
			else
				
				local a, b = icon.Entity:GetModelBounds();
				
				icon:SetFOV( 20 );
				icon:SetCamPos( Vector( math.abs( a.x ), math.abs( a.y ), math.abs( a.z ) ) * 5 );
				icon:SetLookAt( ( a + b ) / 2 );
				
			end
			
			if( itemdata.IconMaterial ) then icon.Entity:SetMaterial( itemdata.IconMaterial ) end
			if( itemdata.IconColor ) then icon.Entity:SetColor( itemdata.IconColor ) end
			
			function icon:LayoutEntity() end
			
			local p = icon.Paint;
			
			function icon:Paint( w, h )
				
				if( CCP.CombineCrate.Pane and CCP.CombineCrate.Pane:IsValid() ) then
					
					local pnl = CCP.CombineCrate.Pane;
					local x2, y2 = pnl:LocalToScreen( 0, 0 );
					local w2, h2 = pnl:GetSize();
					render.SetScissorRect( x2, y2, x2 + w2, y2 + h2, true );
					
				end
				
				p( self, w, h );
				
				if( CCP.CombineCrate.Pane and CCP.CombineCrate.Pane:IsValid() ) then
					
					render.SetScissorRect( 0, 0, 0, 0, false );
					
				end
				
			end
			
			local name = vgui.Create( "DLabel", itempane );
			name:SetText( itemdata.Name );
			name:SetPos( 74, 10 );
			name:SetFont( "CombineControl.LabelSmall" );
			name:SizeToContents();
			name:PerformLayout();
			
			local d, n = GAMEMODE:FormatLine( itemdata.Description, "CombineControl.LabelTiny", 416 );
			
			local desc = vgui.Create( "DLabel", itempane );
			desc:SetText( d );
			desc:SetPos( 74, 24 );
			desc:SetFont( "CombineControl.LabelTiny" );
			desc:SizeToContents();
			desc:PerformLayout();
			
			local take = vgui.Create( "DButton", itempane );
			take:SetFont( "CombineControl.LabelSmall" );
			take:SetText( "Take" );
			take:SetPos( 500, 30 );
			take:SetSize( 46, 24 );
			function take:DoClick()
				
				local item = self:GetParent().Item;
				
				if( !LocalPlayer():CanTakeItem( item ) ) then
					
					GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "That's too heavy for you to carry.", { CB_ALL, CB_IC } );
					
					return;
					
				end
				
				if( LocalPlayer():HasItem( item ) ) then
					
					GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You already have one of those.", { CB_ALL, CB_IC } );
					
					return;
					
				end
				
				if( !LocalPlayer()["CombineCrate_Next" .. item] ) then
					
					LocalPlayer()["CombineCrate_Next" .. item] = 0;
					
				end
				
				if( CurTime() >= LocalPlayer()["CombineCrate_Next" .. item] ) then
					
					LocalPlayer()["CombineCrate_Next" .. item] = CurTime() + 7200;
					
					net.Start( "nTakeLoadout" );
						net.WriteString( item );
					net.SendToServer();
					
					self:SetDisabled( true );
					
				end
				
			end
			
			if( LocalPlayer()["CombineCrate_Next" .. itempane.Item] and CurTime() < LocalPlayer()["CombineCrate_Next" .. itempane.Item] or LocalPlayer():HasItem( itempane.Item ) ) then
				
				take:SetDisabled( true );
				
			end
			
			take:PerformLayout();
			
			CCP.CombineCrate.Pane:Add( itempane );
			
			y = y + 64;
			
		end
		
	end
	net.Receive( "nCombineCrate", nCombineCrate );
	
	function nCombineCrateNotCP( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're not a Civil Protection officer. Stealing is illegal, you know!", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCombineCrateNotCP", nCombineCrateNotCP );
	
else
	
	function nTakeLoadout( len, ply )
		
		local item = net.ReadString();
		local flag = GAMEMODE:LookupCombineFlag( ply:CombineFlag() );
		
		if( flag and table.HasValue( flag.ItemLoadout, item ) ) then
			
			if( !ply:CanTakeItem( item ) ) then
				
				return;
				
			end
			
			if( ply:HasItem( item ) ) then
				
				return;
				
			end
			
			if( !ply["CombineCrate_Next" .. item] ) then
				
				ply["CombineCrate_Next" .. item] = 0;
				
			end
			
			if( CurTime() >= ply["CombineCrate_Next" .. item] ) then
				
				ply["CombineCrate_Next" .. item] = CurTime() + 7200;
				ply:GiveItem( item, 1 );
				
			end
			
		end
		
	end
	net.Receive( "nTakeLoadout", nTakeLoadout );
	
end

function ENT:CanPhysgun()
	
	return false;
	
end