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
	
	self:SetModel( "models/props_combine/combine_dispenser.mdl" );
	
	if( SERVER ) then
		
		self:PhysicsInit( SOLID_BBOX );
		self:SetMoveType( MOVETYPE_VPHYSICS );
		self:SetSolid( SOLID_BBOX );
		
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
			
			if( ply:CPRationDate() == "" or util.TimeSinceDate( ply:CPRationDate() ) > 180 ) then
				
				if( !ply:CanTakeItem( "cpration" ) ) then
					
					net.Start( "nCombineRationTooHeavy" );
					net.Send( ply );
					return;
					
				end
				
				self:ResetSequence( self:LookupSequence( "dispense_package" ) );
				
				self:EmitSound( Sound( "Buttons.snd6" ) );
				
				net.Start( "nCombineRation" );
				net.Send( ply );
				
				ply:GiveItem( "cpration" );
				
				ply:SetCPRationDate( os.date( "!%m/%d/%y %H:%M:%S" ) );
				ply:UpdateCharacterField( "CPRationDate", ply:CPRationDate() );
				
			else
				
				self:EmitSound( Sound( "Buttons.snd10" ) );
				
				net.Start( "nCombineRationTooEarly" );
				net.Send( ply );
				
			end
			
		else
			
			self:EmitSound( Sound( "Buttons.snd10" ) );
			
			net.Start( "nCombineRationNotCP" );
			net.Send( ply );
			
		end
		
	end
	
end

function ENT:Think()
	
	self:NextThink( CurTime() );
	return true;
	
end

if( CLIENT ) then
	
	function nCombineRation( len )
		
		GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You take your ration.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCombineRation", nCombineRation );
	
	function nCombineRationNotCP( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "You're not a Civil Protection officer. Stealing is illegal, you know!", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCombineRationNotCP", nCombineRationNotCP );
	
	function nCombineRationTooHeavy( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "Your inventory is too full to carry the ration.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCombineRationTooHeavy", nCombineRationTooHeavy );
	
	function nCombineRationTooEarly( len )
		
		GAMEMODE:AddChat( Color( 200, 0, 0, 255 ), "CombineControl.ChatNormal", "The distribution machine only distributes one ration every three hours.", { CB_ALL, CB_IC } );
		
	end
	net.Receive( "nCombineRationTooEarly", nCombineRationTooEarly );
	
end

function ENT:CanPhysgun()
	
	return false;
	
end