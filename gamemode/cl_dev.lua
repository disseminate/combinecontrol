GM.IronDevPos = GM.IronDevPos or Vector();
GM.IronDevAng = GM.IronDevAng or Vector();

function GM:CreateIronDev()
	
	CCP.IronDev = vgui.Create( "DFrame" );
	CCP.IronDev:SetSize( 200, 300 );
	CCP.IronDev:SetPos( 20, 20 );
	CCP.IronDev:SetTitle( "Ironsights Dev" );
	CCP.IronDev.lblTitle:SetFont( "CombineControl.Window" );
	CCP.IronDev:SetDeleteOnClose( true );
	CCP.IronDev:MakePopup();
	function CCP.IronDev.btnClose:DoClick()
		
		CCP.IronDev:Close();
		CCP.IronDev = nil;
		
	end
	
	local y0 = 34;
	local x0 = 10;
	
	CCP.IronDev.Pos = { };
	CCP.IronDev.Ang = { };
	
	local l = vgui.Create( "DLabel", CCP.IronDev );
	l:SetPos( x0, y0 );
	l:SetText( "Position X" );
	l:SetFont( "CombineControl.LabelSmall" );
	l:SizeToContents();
	local x = vgui.Create( "DNumberScratch", CCP.IronDev );
	x:SetPos( x0 + 150, y0 );
	x:SetValue( LocalPlayer():GetActiveWeapon().AimPos.x );
	x:SetMin( -10 );
	x:SetMax( 10 );
	function x:OnValueChanged( val )
		
		if( !GAMEMODE.IronDevPos ) then GAMEMODE.IronDevPos = Vector() end
		GAMEMODE.IronDevPos.x = val;
		
	end
	
	y0 = y0 + 30;
	
	local l = vgui.Create( "DLabel", CCP.IronDev );
	l:SetPos( x0, y0 );
	l:SetText( "Position Y" );
	l:SetFont( "CombineControl.LabelSmall" );
	l:SizeToContents();
	local y = vgui.Create( "DNumberScratch", CCP.IronDev );
	y:SetPos( x0 + 150, y0 );
	y:SetValue( LocalPlayer():GetActiveWeapon().AimPos.y );
	y:SetMin( -10 );
	y:SetMax( 10 );
	function y:OnValueChanged( val )
		
		if( !GAMEMODE.IronDevPos ) then GAMEMODE.IronDevPos = Vector() end
		GAMEMODE.IronDevPos.y = val;
		
	end
	
	y0 = y0 + 30;
	
	local l = vgui.Create( "DLabel", CCP.IronDev );
	l:SetPos( x0, y0 );
	l:SetText( "Position Z" );
	l:SetFont( "CombineControl.LabelSmall" );
	l:SizeToContents();
	local z = vgui.Create( "DNumberScratch", CCP.IronDev );
	z:SetPos( x0 + 150, y0 );
	z:SetValue( LocalPlayer():GetActiveWeapon().AimPos.z );
	z:SetMin( -10 );
	z:SetMax( 10 );
	function z:OnValueChanged( val )
		
		if( !GAMEMODE.IronDevPos ) then GAMEMODE.IronDevPos = Vector() end
		GAMEMODE.IronDevPos.z = val;
		
	end
	
	y0 = y0 + 30;
	
	local l = vgui.Create( "DLabel", CCP.IronDev );
	l:SetPos( x0, y0 );
	l:SetText( "Angle P" );
	l:SetFont( "CombineControl.LabelSmall" );
	l:SizeToContents();
	local p = vgui.Create( "DNumberScratch", CCP.IronDev );
	p:SetPos( x0 + 150, y0 );
	p:SetValue( LocalPlayer():GetActiveWeapon().AimAng.p );
	p:SetMin( -50 );
	p:SetMax( 50 );
	function p:OnValueChanged( val )
		
		if( !GAMEMODE.IronDevAng ) then GAMEMODE.IronDevAng = Vector() end
		GAMEMODE.IronDevAng.x = val;
		
	end
	
	y0 = y0 + 30;
	
	local l = vgui.Create( "DLabel", CCP.IronDev );
	l:SetPos( x0, y0 );
	l:SetText( "Angle Y" );
	l:SetFont( "CombineControl.LabelSmall" );
	l:SizeToContents();
	local ay = vgui.Create( "DNumberScratch", CCP.IronDev );
	ay:SetPos( x0 + 150, y0 );
	ay:SetValue( LocalPlayer():GetActiveWeapon().AimAng.y );
	ay:SetMin( -50 );
	ay:SetMax( 50 );
	function ay:OnValueChanged( val )
		
		if( !GAMEMODE.IronDevAng ) then GAMEMODE.IronDevAng = Vector() end
		GAMEMODE.IronDevAng.y = val;
		
	end
	
	y0 = y0 + 30;
	
	local l = vgui.Create( "DLabel", CCP.IronDev );
	l:SetPos( x0, y0 );
	l:SetText( "Angle R" );
	l:SetFont( "CombineControl.LabelSmall" );
	l:SizeToContents();
	local r = vgui.Create( "DNumberScratch", CCP.IronDev );
	r:SetPos( x0 + 150, y0 );
	r:SetValue( LocalPlayer():GetActiveWeapon().AimAng.r );
	r:SetMin( -50 );
	r:SetMax( 50 );
	function r:OnValueChanged( val )
		
		if( !GAMEMODE.IronDevAng ) then GAMEMODE.IronDevAng = Vector() end
		GAMEMODE.IronDevAng.z = val;
		
	end
	
	y0 = y0 + 30;
	
	CCP.IronDev.Output = vgui.Create( "DButton", CCP.IronDev );
	CCP.IronDev.Output:SetFont( "CombineControl.LabelSmall" );
	CCP.IronDev.Output:SetText( "Output Ironsights" );
	CCP.IronDev.Output:SetPos( 10, y0 );
	CCP.IronDev.Output:SetSize( 180, 20 );
	function CCP.IronDev.Output:DoClick()
		
		MsgN( "SWEP.AimPos = Vector( " .. tostring( math.ceil( GAMEMODE.IronDevPos.x * 100 ) / 100 ) .. ", " .. tostring( math.ceil( GAMEMODE.IronDevPos.y * 100 ) / 100 ) .. ", " .. tostring( math.ceil( GAMEMODE.IronDevPos.z * 100 ) / 100 ) .. " );" );
		MsgN( "SWEP.AimAng = Vector( " .. tostring( math.ceil( GAMEMODE.IronDevAng.x * 100 ) / 100 ) .. ", " .. tostring( math.ceil( GAMEMODE.IronDevAng.y * 100 ) / 100 ) .. ", " .. tostring( math.ceil( GAMEMODE.IronDevAng.z * 100 ) / 100 ) .. " );" );

		
	end
	CCP.IronDev.Output:PerformLayout();
	
	y0 = y0 + CCP.IronDev.Output:GetTall() + 10;
	
	CCP.IronDev.OutputHolster = vgui.Create( "DButton", CCP.IronDev );
	CCP.IronDev.OutputHolster:SetFont( "CombineControl.LabelSmall" );
	CCP.IronDev.OutputHolster:SetText( "Output Holster" );
	CCP.IronDev.OutputHolster:SetPos( 10, y0 );
	CCP.IronDev.OutputHolster:SetSize( 180, 20 );
	function CCP.IronDev.Output:DoClick()
		
		MsgN( "SWEP.HolsterPos = Vector( " .. tostring( math.ceil( GAMEMODE.IronDevPos.x * 100 ) / 100 ) .. ", " .. tostring( math.ceil( GAMEMODE.IronDevPos.y * 100 ) / 100 ) .. ", " .. tostring( math.ceil( GAMEMODE.IronDevPos.z * 100 ) / 100 ) .. " );" );
		MsgN( "SWEP.HolsterAng = Vector( " .. tostring( math.ceil( GAMEMODE.IronDevAng.x * 100 ) / 100 ) .. ", " .. tostring( math.ceil( GAMEMODE.IronDevAng.y * 100 ) / 100 ) .. ", " .. tostring( math.ceil( GAMEMODE.IronDevAng.z * 100 ) / 100 ) .. " );" );

		
	end
	CCP.IronDev.OutputHolster:PerformLayout();
	
	y0 = y0 + CCP.IronDev.OutputHolster:GetTall() + 10;
	
	CCP.IronDev.Reset = vgui.Create( "DButton", CCP.IronDev );
	CCP.IronDev.Reset:SetFont( "CombineControl.LabelSmall" );
	CCP.IronDev.Reset:SetText( "Reset" );
	CCP.IronDev.Reset:SetPos( 10, y0 );
	CCP.IronDev.Reset:SetSize( 180, 20 );
	function CCP.IronDev.Reset:DoClick()
		
		x:SetValue( 0 );
		y:SetValue( 0 );
		z:SetValue( 0 );
		p:SetValue( 0 );
		ay:SetValue( 0 );
		r:SetValue( 0 );
		
		x:PerformLayout();
		y:PerformLayout();
		z:PerformLayout();
		p:PerformLayout();
		ay:PerformLayout();
		r:PerformLayout();
		
		GAMEMODE.IronDevPos = Vector();
		GAMEMODE.IronDevAng = Vector();
		
	end
	CCP.IronDev.Reset:PerformLayout();
	
	y0 = y0 + CCP.IronDev.Reset:GetTall() + 10;
	
	CCP.IronDev:SetTall( y0 );
	
end

function ccCreateIronDev( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	GAMEMODE:CreateIronDev();
	
end
concommand.Add( "rp_dev_irondev", ccCreateIronDev );

function GM:CreateItemDev()
	
	CCP.ItemDev = vgui.Create( "DFrame" );
	CCP.ItemDev:SetSize( 400, 250 );
	CCP.ItemDev:Center();
	CCP.ItemDev:SetTitle( "Item Dev" );
	CCP.ItemDev.lblTitle:SetFont( "CombineControl.Window" );
	CCP.ItemDev:SetDeleteOnClose( true );
	CCP.ItemDev:MakePopup();
	function CCP.ItemDev.btnClose:DoClick()
		
		CCP.ItemDev:Close();
		CCP.ItemDev = nil;
		
	end
	
	local icon = vgui.Create( "DModelPanel", CCP.ItemDev );
	icon:SetPos( 10, 30 );
	icon:SetModel( "models/weapons/w_smg1.mdl" );
	icon:SetSize( 160, 160 );
	icon:SetFOV( 20 );
	icon:SetCamPos( Vector( 50, 50, 50 ) );
	icon:SetLookAt( Vector( 0, 0, 0 ) );
	
	function icon:LayoutEntity() end
	
	local n = 0;
	
	CCP.ItemDev.CamPos = { };
	CCP.ItemDev.LookAt = { };
	
	CCP.ItemDev.FOV = vgui.Create( "DNumSlider", CCP.ItemDev );
	CCP.ItemDev.FOV:SetPos( 210, 30 );
	CCP.ItemDev.FOV:SetSize( 180, 16 );
	CCP.ItemDev.FOV:SetText( "FOV" );
	CCP.ItemDev.FOV:SetMin( 1 );
	CCP.ItemDev.FOV:SetMax( 50 );
	CCP.ItemDev.FOV:SetDecimals( 2 );
	CCP.ItemDev.FOV:SetValue( 20 );
	CCP.ItemDev.FOV.PerformLayout = CCSliderPerformLayout;
	CCP.ItemDev.FOV:PerformLayout();
	
	function CCP.ItemDev.FOV:ValueChanged()
		
		icon:SetFOV( CCP.ItemDev.FOV:GetValue() );
		
	end
	
	CCP.ItemDev.Entry = vgui.Create( "DTextEntry", CCP.ItemDev );
	CCP.ItemDev.Entry:SetFont( "CombineControl.LabelSmall" );
	CCP.ItemDev.Entry:SetPos( 10, 200 );
	CCP.ItemDev.Entry:SetSize( 380, 20 );
	CCP.ItemDev.Entry:PerformLayout();
	CCP.ItemDev.Entry:SetValue( "" );
	CCP.ItemDev.Entry:SetCaretPos( string.len( CCP.ItemDev.Entry:GetValue() ) );
	function CCP.ItemDev.Entry:OnEnter()
		
		local val = self:GetValue();
		icon:SetModel( val );
		
	end
	
	n = n + 1;
	
	for _, v in pairs( { "x", "y", "z" } ) do
		
		CCP.ItemDev.CamPos[v] = vgui.Create( "DNumSlider", CCP.ItemDev );
		CCP.ItemDev.CamPos[v]:SetPos( 210, 30 + n * 20 );
		CCP.ItemDev.CamPos[v]:SetSize( 180, 16 );
		CCP.ItemDev.CamPos[v]:SetText( v );
		CCP.ItemDev.CamPos[v]:SetMin( -50 );
		CCP.ItemDev.CamPos[v]:SetMax( 50 );
		CCP.ItemDev.CamPos[v]:SetDecimals( 1 );
		CCP.ItemDev.CamPos[v]:SetValue( 50 );
		CCP.ItemDev.CamPos[v].PerformLayout = CCSliderPerformLayout;
		CCP.ItemDev.CamPos[v]:PerformLayout();
		
		CCP.ItemDev.CamPos[v].ValueChanged = function( self )
			
			icon:SetCamPos( Vector( CCP.ItemDev.CamPos["x"]:GetValue(), CCP.ItemDev.CamPos["y"]:GetValue(), CCP.ItemDev.CamPos["z"]:GetValue() ) );
			
		end
		
		n = n + 1;
		
	end
	
	for _, v in pairs( { "x", "y", "z" } ) do
		
		CCP.ItemDev.LookAt[v] = vgui.Create( "DNumSlider", CCP.ItemDev );
		CCP.ItemDev.LookAt[v]:SetPos( 210, 30 + n * 20 );
		CCP.ItemDev.LookAt[v]:SetSize( 180, 16 );
		CCP.ItemDev.LookAt[v]:SetText( v );
		CCP.ItemDev.LookAt[v]:SetMin( -90 );
		CCP.ItemDev.LookAt[v]:SetMax( 90 );
		CCP.ItemDev.LookAt[v]:SetDecimals( 2 );
		CCP.ItemDev.LookAt[v]:SetValue( 0 );
		CCP.ItemDev.LookAt[v].PerformLayout = CCSliderPerformLayout;
		CCP.ItemDev.LookAt[v]:PerformLayout();
		
		CCP.ItemDev.LookAt[v].ValueChanged = function( self )
			
			icon:SetLookAt( Vector( CCP.ItemDev.LookAt["x"]:GetValue(), CCP.ItemDev.LookAt["y"]:GetValue(), CCP.ItemDev.LookAt["z"]:GetValue() ) );
			
		end
		
		n = n + 1;
		
	end
	
	CCP.ItemDev.Output = vgui.Create( "DButton", CCP.ItemDev );
	CCP.ItemDev.Output:SetFont( "CombineControl.LabelSmall" );
	CCP.ItemDev.Output:SetText( "Output" );
	CCP.ItemDev.Output:SetPos( 210, 30 + n * 20 );
	CCP.ItemDev.Output:SetSize( 180, 20 );
	function CCP.ItemDev.Output:DoClick()
		
		MsgN( "ITEM.FOV \t\t\t= " .. tostring( math.ceil( CCP.ItemDev.FOV:GetValue() ) ) .. ";" );
		MsgN( "ITEM.CamPos \t\t= Vector( " .. tostring( math.ceil( CCP.ItemDev.CamPos.x:GetValue() * 100 ) / 100 ) .. ", " .. tostring( math.ceil( CCP.ItemDev.CamPos.y:GetValue() * 100 ) / 100 ) .. ", " .. tostring( math.ceil( CCP.ItemDev.CamPos.z:GetValue() * 100 ) / 100 ) .. " );" );
		MsgN( "ITEM.LookAt \t\t= Vector( " .. tostring( math.ceil( CCP.ItemDev.LookAt.x:GetValue() * 100 ) / 100 ) .. ", " .. tostring( math.ceil( CCP.ItemDev.LookAt.y:GetValue() * 100 ) / 100 ) .. ", " .. tostring( math.ceil( CCP.ItemDev.LookAt.z:GetValue() * 100 ) / 100 ) .. " );" );
		MsgN( "SWEP.ItemFOV = " .. tostring( math.ceil( CCP.ItemDev.FOV:GetValue() ) ) .. ";" );
		MsgN( "SWEP.ItemCamPos = Vector( " .. tostring( math.ceil( CCP.ItemDev.CamPos.x:GetValue() * 100 ) / 100 ) .. ", " .. tostring( math.ceil( CCP.ItemDev.CamPos.y:GetValue() * 100 ) / 100 ) .. ", " .. tostring( math.ceil( CCP.ItemDev.CamPos.z:GetValue() * 100 ) / 100 ) .. " );" );
		MsgN( "SWEP.ItemLookAt = Vector( " .. tostring( math.ceil( CCP.ItemDev.LookAt.x:GetValue() * 100 ) / 100 ) .. ", " .. tostring( math.ceil( CCP.ItemDev.LookAt.y:GetValue() * 100 ) / 100 ) .. ", " .. tostring( math.ceil( CCP.ItemDev.LookAt.z:GetValue() * 100 ) / 100 ) .. " );" );
		
	end
	CCP.ItemDev.Output:PerformLayout();
	
end

function ccCreateItemDev( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	GAMEMODE:CreateItemDev();
	
end
concommand.Add( "rp_dev_itemdev", ccCreateItemDev );

function ccGetCamPos( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local p = ply:EyePos();
	MsgN( "Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " );" );
	
end
concommand.Add( "rp_dev_getcampos", ccGetCamPos );

function ccGetAntlionPos( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local p = ply:GetEyeTrace().HitPos;
	MsgN( "self:AddAntlionSpawn( Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " ), 5 );" );
	
end
concommand.Add( "rp_dev_getantlionpos", ccGetAntlionPos );

function ccGetIntroCamPos( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local p = ply:EyePos();
	local a = ply:EyeAngles();
	MsgN( "Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " )" );
	MsgN( "Angle( " .. tostring( math.ceil( a.p ) ) .. ", " .. tostring( math.ceil( a.y ) ) .. ", 0 )" );
	
end
concommand.Add( "rp_dev_getintrocampos", ccGetIntroCamPos );

function ccGetHL2CamPos( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local p = ply:EyePos();
	local a = ply:EyeAngles();
	MsgN( "return { Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " ), Angle( " .. tostring( math.ceil( a.p ) ) .. ", " .. tostring( math.ceil( a.y ) ) .. ", " .. tostring( math.ceil( a.r ) ) .. " ) };" );
	
end
concommand.Add( "rp_dev_gethl2campos", ccGetHL2CamPos );

function ccGetCombineCratePos( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local ent = ply:GetEyeTrace().Entity;
	
	if( ent and ent:IsValid() ) then
		
		local p = ent:GetPos();
		local a = ent:GetAngles();
		MsgN( "return { Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " ), Angle( " .. tostring( math.ceil( a.p ) ) .. ", " .. tostring( math.ceil( a.y ) ) .. ", " .. tostring( math.ceil( a.r ) ) .. " ) };" );
		
	end
	
end
concommand.Add( "rp_dev_getcombinecratepos", ccGetCombineCratePos );

function ccGetStovePos( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local ent = ply:GetEyeTrace().Entity;
	
	if( ent and ent:IsValid() ) then
		
		local p = ent:GetPos();
		local a = ent:GetAngles();
		MsgN( "{ Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " ), Angle( 0, " .. tostring( math.ceil( a.y ) ) .. ", 0 ), \"\", true }," );
		
	end
	
end
concommand.Add( "rp_dev_getstovepos", ccGetStovePos );

function ccGetStovePosS( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	for _, v in pairs( ents.FindByClass( "prop_physics" ) ) do
		
		if( v:GetModel() == "models/props_c17/furnitureStove001a.mdl" ) then
			
			local p = v:GetPos();
			local a = v:GetAngles();
			MsgN( "{ Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " ), Angle( 0, " .. tostring( math.ceil( a.y ) ) .. ", 0 ), \"\", true }," );
			
		end
		
	end
	
end
concommand.Add( "rp_dev_getstovepossafe", ccGetStovePosS );

function ccGetCACamPos( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local p = ply:EyePos();
	MsgN( "return Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " );" );
	
end
concommand.Add( "rp_dev_getcacampos", ccGetCACamPos );

function ccGetCombineSpawnpoint( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local p = ply:GetPos();
	MsgN( "Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " )," );
	
	local spawn = ClientsideModel( "models/player/police.mdl", RENDERGROUP_BOTH );
	spawn:SetPos( Vector( math.ceil( p.x ), math.ceil( p.y ), math.ceil( p.z ) ) );
	spawn:SetRenderMode( RENDERMODE_GLOW );
	spawn:SetRenderFX( 16 );
	
end
concommand.Add( "rp_dev_getcombinespawnpoint", ccGetCombineSpawnpoint );

function ccGetMicrophone( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local p = ply:GetPos();
	MsgN( "{ Vector( " .. tostring( math.ceil( p.x ) ) .. ", " .. tostring( math.ceil( p.y ) ) .. ", " .. tostring( math.ceil( p.z ) ) .. " ), MICROPHONE_BIG }," );
	
end
concommand.Add( "rp_dev_getmicrophone", ccGetMicrophone );

function ccGetModel( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local ent = ply:GetEyeTrace().Entity;
	
	if( ent and ent:IsValid() ) then
		
		MsgN( ent:GetModel() );
		SetClipboardText( ent:GetModel() );
		
	end
	
end
concommand.Add( "rp_dev_model", ccGetModel );

function ccGetModelSequenceInfo( ply, cmd, args )
	
	if( !ply:IsAdmin() ) then return end
	
	local list = ply:GetSequenceList();
	
	local namelist = { };
	
	for k, v in pairs( list ) do
		
		MsgN( tostring( ply:LookupSequence( v ) ) .. "\t" .. tostring( v ) .. "\t" .. tostring( ply:GetSequenceActivityName( ply:LookupSequence( v ) ) ) .. "\t" .. tostring( ply:GetSequenceActivity( ply:LookupSequence( v ) ) ) );
		
	end
	
	MsgN();
	
	local ppnum = ply:GetNumPoseParameters();
	
	MsgN( tostring( ply:GetNumPoseParameters() ) .. " POSE PARAMETERS" );
	
	for i = 0, ppnum - 1 do
		
		local a, b = ply:GetPoseParameterRange( i );
		MsgN( tostring( i ) .. "\t" .. ply:GetPoseParameterName( i ) .. "\t" .. tostring( a ) .. "\t" .. tostring( b ) );
		
	end
	
end
concommand.Add( "rp_dev_getseqinfo", ccGetModelSequenceInfo );
--[[
local doorDevCur = 1;
function ccCreateDoorDev( ply, cmd, args )
	
	doorDevCur = 1;
	
	local dev = vgui.Create( "DFrame" );
	dev:SetSize( 800, 600 );
	dev:Center();
	dev:SetTitle( "Door Dev" );
	dev:MakePopup();
	
	local selection = game.GetDoors()[1];
	
	local pos = selection:GetPos();
	local ang = selection:GetAngles();
	
	local newpos = pos + ang:Forward() * 200;
	local newang = ( pos - newpos ):Angle();
	
	local cam = vgui.Create( "CCCamera", dev );
	cam:SetPos( 0, 24 );
	cam:SetSize( 500, 600 - 24 - 50 );
	cam:SetOriginX( newpos.x );
	cam:SetOriginY( newpos.y );
	cam:SetOriginZ( newpos.z );
	cam:SetAngX( newang.p );
	cam:SetAngY( newang.y );
	cam:SetAngZ( newang.r );
	cam:SetFOV( 40 );
	
	local left = vgui.Create( "DButton", dev );
	left:SetFont( "CombineControl.LabelSmall" );
	left:SetText( "<<" );
	left:SetPos( 10, 600 - 40 );
	left:SetSize( 40, 30 );
	function left:DoClick()
		
		doorDevCur = doorDevCur - 1;
		
		if( doorDevCur < 1 ) then
			
			doorDevCur = #game.GetDoors();
			
		end
		
		selection = game.GetDoors()[doorDevCur];
		
		local pos = selection:GetPos();
		local ang = selection:GetAngles();
		
		local newpos = pos + ang:Forward() * 200;
		local newang = ( pos - newpos ):Angle();
		
		cam:SetOriginX( newpos.x );
		cam:SetOriginY( newpos.y );
		cam:SetOriginZ( newpos.z );
		cam:SetAngX( newang.p );
		cam:SetAngY( newang.y );
		cam:SetAngZ( newang.r );
		
	end
	
	local right = vgui.Create( "DButton", dev );
	right:SetFont( "CombineControl.LabelSmall" );
	right:SetText( ">>" );
	right:SetPos( 500 - 50, 600 - 40 );
	right:SetSize( 40, 30 );
	function right:DoClick()
		
		doorDevCur = doorDevCur + 1;
		
		if( doorDevCur > #game.GetDoors() ) then
			
			doorDevCur = 1;
			
		end
		
		selection = game.GetDoors()[doorDevCur];
		
		local pos = selection:GetPos();
		local ang = selection:GetAngles();
		
		local newpos = pos + ang:Forward() * 200;
		local newang = ( pos - newpos ):Angle();
		
		cam:SetOriginX( newpos.x );
		cam:SetOriginY( newpos.y );
		cam:SetOriginZ( newpos.z );
		cam:SetAngX( newang.p );
		cam:SetAngY( newang.y );
		cam:SetAngZ( newang.r );
		
	end
	
end
concommand.Add( "rp_dev_createdoordev", ccCreateDoorDev );
--]]
