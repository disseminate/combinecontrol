GM.FontFace = "Myriad Pro";

GM.FontHeight = { };

function surface.CreateFontCC( name, tab )
	
	surface.CreateFont( name, tab );
	GM.FontHeight[name] = tab.size;
	
end

surface.CreateFontCC( "CombineControl.Window", {
	font = GM.FontFace,
	size = 14,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.GUIClose", {
	font = GM.FontFace,
	size = 16,
	weight = 900 } );

surface.CreateFontCC( "CombineControl.LabelTiny", {
	font = GM.FontFace,
	size = 12,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelSmall", {
	font = GM.FontFace,
	size = 14,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelSmallItalic", {
	font = GM.FontFace,
	size = 14,
	weight = 500,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.LabelMedium", {
	font = GM.FontFace,
	size = 16,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelBig", {
	font = GM.FontFace,
	size = 18,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelGiant", {
	font = GM.FontFace,
	size = 22,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.LabelMassive", {
	font = GM.FontFace,
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.LabelStupid", {
	font = GM.FontFace,
	size = 50,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.ChatSmall", {
	font = GM.FontFace,
	size = 14,
	weight = 100 } );
	
surface.CreateFontCC( "CombineControl.ChatSmallItalic", {
	font = GM.FontFace,
	size = 14,
	weight = 500,
	italic = true } );

surface.CreateFontCC( "CombineControl.ChatNormal", {
	font = GM.FontFace,
	size = 16,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.ChatNormalItalic", {
	font = GM.FontFace,
	size = 16,
	weight = 500,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.ChatRadio", {
	font = "Lucida Console",
	size = 12,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.CombineCamera", {
	font = "Courier New",
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.CombineCameraSmall", {
	font = "Courier New",
	size = 15,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.ChatBig", {
	font = GM.FontFace,
	size = 21,
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.ChatBigItalic", {
	font = GM.FontFace,
	size = 21,
	weight = 700,
	italic = true } );
	
surface.CreateFontCC( "CombineControl.ChatHuge", {
	font = GM.FontFace,
	size = 20,
	weight = 700 } );

surface.CreateFontCC( "CombineControl.HL2CreditText", {
	font = "Trebuchet MS",
	size = 20,
	weight = 900 } );
	
surface.CreateFontCC( "CombineControl.PlayerFont", {
	font = GM.FontFace,
	size = 17,
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.HUDAmmo", {
	font = GM.FontFace,
	size = 50,
	weight = 500 } );

surface.CreateFontCC( "CombineControl.HUDAmmoSmall", {
	font = GM.FontFace,
	size = 30,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.WepSelectHeader", {
	font = GM.FontFace,
	size = 20,
	weight = 700 } );
	
surface.CreateFontCC( "CombineControl.WepSelectWep", {
	font = GM.FontFace,
	size = 18,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.WepSelectInfo", {
	font = GM.FontFace,
	size = 16,
	weight = 500 } );
	
surface.CreateFontCC( "CombineControl.Written", {
	font = "Comic Sans MS",
	size = 20,
	weight = 700 } );

language.Add( "npc_clawscanner", "Claw Scanner" );
language.Add( "npc_combine_camera", "Combine Camera" );
language.Add( "npc_helicopter", "Helicopter" );
language.Add( "npc_barnacle_tongue_tip", "Barnacle Tongue Tip" );
language.Add( "prop_vehicle_apc", "APC" );
language.Add( "npc_fisherman", "Fisherman" );
	
function draw.DrawTextShadow( text, font, x, y, col1, col2, align )
	
	if( align != 0 ) then
		
		draw.DrawText( text, font, x + 1, y + 1, col2, align ); -- Less efficient than surface, so we only use this if we need special alignment stuff.
		draw.DrawText( text, font, x, y, col1, align );
		
	else
		
		surface.SetFont( font );
		
		surface.SetTextColor( col2 );
		surface.SetTextPos( x + 1, y + 1 );
		surface.DrawText( text );
		surface.SetTextColor( col1 );
		surface.SetTextPos( x, y );
		surface.DrawText( text );
		
	end
	
end

local matBlurScreen = Material( "pp/blurscreen" );

function draw.DrawBackgroundBlur( frac )
	
	DisableClipping( true );
	
	surface.SetMaterial( matBlurScreen );
	surface.SetDrawColor( 255, 255, 255, 255 );
	
	for i = 1, 3 do
		
		matBlurScreen:SetFloat( "$blur", frac * 5 * ( i / 3 ) )
		matBlurScreen:Recompute();
		render.UpdateScreenEffectTexture();
		surface.DrawTexturedRect( 0, 0, ScrW(), ScrH() );
		
	end
	
	DisableClipping( false );

end

GM.ThirdCurPos = Vector();
GM.ThirdCurAng = Angle();
GM.ThirdDestPos = Vector();
GM.ThirdDestAng = Angle();

function GM:ShouldDoThirdPerson( ply )
	
	local wep = ply:GetActiveWeapon();
	
	if( wep and wep:IsValid() and wep != NULL ) then
		
		if( wep.InScope and wep:InScope() ) then
			
			return false;
			
		end
		
	end
	
	if( ply:GetMoveType() == MOVETYPE_NOCLIP ) then
		
		return false;
		
	end
	
	if( ply:GetViewEntity() != ply ) then
		
		return false;
		
	end
	
	return true;
	
end

GM.IntroCamDelay = 15;

function GM:StartIntroCam()
	
	if( !self.IntroCamData ) then return end
	
	self.IntroCamStart = CurTime();
	self:PlayMusic( self.IntroCinematicMusic or "music/hl2_song26_trainstation1.mp3", 0 );
	
end

function nIntroStart()
	
	local force = net.ReadBit();
	
	if( force == 0 and GAMEMODE.QuizEnabled ) then
		
		if( cookie.GetNumber( "cc_doneintro", 0 ) < 2 ) then
			
			GAMEMODE:CreateQuiz();
			
		end
		
	else
		
		if( GAMEMODE.IntroCinematicEnabled ) then
			
			GAMEMODE:StartIntroCam();
			
		else
			
			GAMEMODE.QueueCharCreate = false;
			cookie.Set( "cc_doneintro", 2 );
			
			GAMEMODE:CreateCharEditor();
			
		end
		
	end
	
end
net.Receive( "nIntroStart", nIntroStart );

function GM:InIntroCam()
	
	if( !self.IntroCamData ) then return false end
	
	if( self.IntroCamStart and CurTime() - self.IntroCamStart < self.IntroCamDelay * #self.IntroCamText ) then
		
		return true;
		
	end
	
	return false;
	
end

function GM:CalcView( ply, pos, ang, fov, znear, zfar )
	
	local view = self.BaseClass:CalcView( ply, pos, ang, fov, znear, zfar );
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		local n = self.CombineCameraView;
		local attach = n:GetAttachment( 2 );
		
		if( n:GetClass() == "npc_combine_camera" ) then
			
			attach.Ang:RotateAroundAxis( attach.Ang:Forward(), -90 );
			attach.Ang:RotateAroundAxis( attach.Ang:Up(), -90 );
			
		end
		
		attach.Pos = attach.Pos + attach.Ang:Forward() * 5;
		
		view.origin = attach.Pos;
		view.angles = attach.Ang;
		
		return view;
		
	end
	
	if( LocalPlayer():APC() and LocalPlayer():APC():IsValid() ) then
		
		local mn, mx = LocalPlayer():APC():GetRenderBounds();
		local radius = ( mn - mx ):Length();
		
		local target = LocalPlayer():APC():GetPos() + ( mn + mx ) / 2 + view.angles:Forward() * -radius;
		
		local trace = { };
		trace.start = view.origin;
		trace.endpos = target;
		trace.filter = { LocalPlayer():APC(), LocalPlayer() }
		trace.mins = Vector( -4, -4, -4 );
		trace.maxs = Vector( 4, 4, 4 );
		local tr = util.TraceHull( trace );
		
		view.origin = tr.HitPos;
		view.drawviewer = true;
		
		if( tr.Hit and !tr.StartSolid ) then
			
			view.origin = view.origin + tr.HitNormal * 4;
			
		end
		
		return view;
		
	end
	
	if( self.IntroCamStart and self.IntroCamData ) then
		
		if( CurTime() - self.IntroCamStart < self.IntroCamDelay * #self.IntroCamText ) then
			
			local stage = math.Clamp( math.ceil( ( CurTime() - self.IntroCamStart ) / self.IntroCamDelay ), 1, #self.IntroCamText );
			
			if( self.IntroCamData ) then
				
				local p1, p2, a1, a2;
				
				if( self.IntroCamData[stage] ) then
					
					p1 = self.IntroCamData[stage][1][1];
					p2 = self.IntroCamData[stage][1][2];
					a1 = self.IntroCamData[stage][2][1];
					a2 = self.IntroCamData[stage][2][2];
					
				else
					
					p1 = self.IntroCamData[#self.IntroCamData][1][1];
					p2 = self.IntroCamData[#self.IntroCamData][1][2];
					a1 = self.IntroCamData[#self.IntroCamData][2][1];
					a2 = self.IntroCamData[#self.IntroCamData][2][2];
					
				end
				
				local mul = ( ( CurTime() - self.IntroCamStart ) / self.IntroCamDelay ) - ( stage - 1 );
				
				view.origin = LerpVector( mul, p1, p2 );
				view.angles = LerpAngle( mul, a1, a2 );
				
				return view;
				
			end
			
		end
		
	end
	
	if( self.CharCreate or CCP.Quiz ) then
		
		if( self.GetHL2CamPos ) then
			
			tab = self:GetHL2CamPos();
			
			self.ThirdCurPos = view.origin;
			self.ThirdCurAng = view.angles;
			
			view.origin = tab[1];
			view.angles = tab[2];
			
			return view;
			
		end
		
	end
	
	if( cookie.GetNumber( "cc_headbob", 0 ) == 1 ) then
		
		local hmul = 0;
		local len2d = ply:GetVelocity():Length2D();
		
		if( len2d > 5 and ply:GetMoveType() != MOVETYPE_NOCLIP and ply:OnGround() ) then
			
			hmul = math.Clamp( len2d / 200, 0, 1 );
			
		end
		
		if( hmul > 0 ) then
			
			view.angles.p = view.angles.p + math.sin( CurTime() * 5 ) * hmul;
			view.angles.y = view.angles.y + math.cos( CurTime() * 4 ) * 0.5 * hmul;
			
		end
		
	end
	
	if( cookie.GetNumber( "cc_thirdperson", 0 ) == 1 and ply:Alive() ) then
		
		if( self:ShouldDoThirdPerson( ply ) ) then
			
			local hitpos = ply:GetEyeTrace().HitPos;
			local targetpos = view.origin;
			
			local distance = 50;
			
			local wep = ply:GetActiveWeapon();
			
			if( !ply:Holstered() and wep and wep:IsValid() and wep != NULL ) then
				
				if( ply:KeyDown( IN_ATTACK2 ) and wep.IronMode ) then
					
					distance = 25;
					
				end
				
			end
			
			self.ThirdDestAng = view.angles;
			self.ThirdDestPos = targetpos - self.ThirdDestAng:Forward() * distance;
			
			local trace = { };
			trace.start = view.origin;
			trace.endpos = self.ThirdDestPos;
			trace.filter = ply;
			
			local tr = util.TraceLine( trace );
			
			self.ThirdDestPos = view.origin + tr.Normal * ( distance - 2 ) * tr.Fraction;
			
			self.ThirdCurPos = LerpVector( 0.08, self.ThirdCurPos, self.ThirdDestPos );
			self.ThirdCurAng = LerpAngle( 0.08, self.ThirdCurAng, self.ThirdDestAng );
			
			view.angles = self.ThirdCurAng;
			view.origin = self.ThirdCurPos;
			
		else
			
			self.ThirdCurPos = view.origin;
			self.ThirdCurAng = view.angles;
			
		end
		
	else
		
		self.ThirdCurPos = view.origin;
		self.ThirdCurAng = view.angles;
		
	end
	
	local wep = ply:GetActiveWeapon();
	
	if( wep and wep:IsValid() ) then
		
		if( wep.TranslateFOV ) then
			
			view.fov = wep:TranslateFOV( view.fov );
			
		end
		
	end
	
	return view;
	
end

function GM:ShouldDrawLocalPlayer( ply )
	
	if( self:InIntroCam() ) then
		
		return true;
		
	end
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		return true;
		
	end
	
	if( cookie.GetNumber( "cc_thirdperson", 0 ) == 1 ) then
		
		return self:ShouldDoThirdPerson( ply );
		
	end
	
	return false;
	
end

function GM:DrawCharCreate()
	
	if( self.CharCreate ) then
		
		if( !self.GetHL2CamPos ) then
			
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
			
		else
			
			draw.DrawBackgroundBlur( 1 );
			
		end
		
	end
	
end

function GM:DrawFancyIntro()
	
	if( self.IntroCamStart and self.IntroCamData ) then
		
		if( CurTime() - self.IntroCamStart < self.IntroCamDelay * #self.IntroCamText ) then
			
			local stage = math.Clamp( math.ceil( ( CurTime() - self.IntroCamStart ) / self.IntroCamDelay ), 1, #self.IntroCamText );
			
			if( self.IntroCamText[stage] ) then
				
				local timesince = ( CurTime() - self.IntroCamStart ) - ( ( stage - 1 ) * self.IntroCamDelay );
				local a = 1;
				
				if( timesince < 2.5 ) then
					
					a = timesince / 2.5;
					
				end
				
				if( timesince > self.IntroCamDelay - 1 ) then
					
					a = 1 - ( timesince - ( self.IntroCamDelay - 1 ) );
					
				end
				
				local _, h = surface.GetTextSize( self.IntroCamText[stage] );
				
				h = h + 20;
				
				draw.RoundedBox( 0, 0, ScrH() * ( 360 / 480 ) - 10, ScrW(), h, Color( 30, 30, 30, a * 200 ) );
				
				draw.DrawText( self.IntroCamText[stage], "CombineControl.HL2CreditText", ScrW() * ( 96 / 640 ), ScrH() * ( 360 / 480 ), Color( 255, 255, 255, a * 128 ), 0 );
				
			end
			
		end
		
	end
	
end

function GM:DrawQuiz()
	
	draw.DrawBackgroundBlur( 1 );
	
end

function GM:DrawCombineCamera()
	
	local text = "REC " .. os.date( "!%m/%d/%y %H:%M:%S" );
	
	local pos = self.CombineCameraView:GetPos();
	pos.x = math.floor( pos.x );
	pos.y = math.floor( pos.y );
	pos.z = math.floor( pos.z );
	
	local attach = self.CombineCameraView:GetAttachment( 2 );
	
	if( self.CombineCameraView:GetClass() == "npc_combine_camera" ) then
		
		attach.Ang:RotateAroundAxis( attach.Ang:Forward(), -90 );
		attach.Ang:RotateAroundAxis( attach.Ang:Up(), -90 );
		
	end
	
	attach.Ang.p = math.floor( attach.Ang.p );
	attach.Ang.y = math.floor( attach.Ang.y );
	attach.Ang.r = math.floor( attach.Ang.r );
	
	text = text .. "\nCAMERA #" .. self.CombineCameraView:EntIndex() .. "-18";
	text = text .. "\nCOORD " .. pos.x .. " " .. pos.y .. " " .. pos.z;
	text = text .. "\nANG " .. attach.Ang.p .. " " .. attach.Ang.y .. " " .. attach.Ang.r;
	
	draw.DrawText( text, "CombineControl.CombineCamera", 10, 10, Color( 255, 0, 0, 255 ), 0 );
	
	for _, v in pairs( player.GetAll() ) do
		
		local poss = ( v:EyePos() + Vector( 0, 0, 10 ) ):ToScreen();
		
		if( v:Ragdoll() and v:Ragdoll():IsValid() ) then
			
			poss = ( v:Ragdoll():EyePos() + Vector( 0, 0, 10 ) ):ToScreen();
			
		end
		
		if( ( poss.visible and GAMEMODE:CanSeePos( pos, v:EyePos(), { self.CombineCameraView, v } ) and pos:Distance( v:GetPos() ) < 1024 ) and v:Alive() ) then
			
			draw.DrawText( v:VisibleRPName(), "CombineControl.CombineCameraSmall", poss.x, poss.y, Color( 200, 200, 200, 255 ), 1 );
			
		end
		
	end
	
end

function GM:DrawConsciousness()
	
	if( !LocalPlayer():PassedOut() and LocalPlayer():Consciousness() < 60 ) then
		
		draw.DrawBackgroundBlur( 1 - LocalPlayer():Consciousness() / 60 );
		
		surface.SetDrawColor( Color( 0, 0, 0, 150 * ( 1 - LocalPlayer():Consciousness() / 60 ) ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
	end
	
	if( LocalPlayer().DrawWakeUp and CurTime() - LocalPlayer().DrawWakeUp <= 3 ) then
		
		local frac = ( CurTime() - LocalPlayer().DrawWakeUp ) / 3;
		
		draw.DrawBackgroundBlur( 1 - frac );
		
		surface.SetDrawColor( Color( 0, 0, 0, 255 * ( 1 - frac ) ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
	end
	
end

function GM:DrawTimedProgress()
	
	local yc = 0;
	
	if( !self.TimedProgressBars ) then self.TimedProgressBars = { } end
	
	for k, v in pairs( self.TimedProgressBars ) do
		
		if( v.Start and CurTime() < v.End ) then
			
			if( !v.Player or !v.Player:IsValid() or v.Player:GetPos():Distance( LocalPlayer():GetPos() ) > 100 or v.Player:GetVelocity():Length() > 5 or LocalPlayer():GetVelocity():Length() > 5 ) then
				
				table.remove( self.TimedProgressBars, k );
				continue;
				
			end
			
			surface.SetDrawColor( 30, 30, 30, 200 );
			surface.DrawRect( ScrW() / 2 - 400 / 2, ScrH() / 2 + 40 + yc, 400, 40 );
			
			surface.SetDrawColor( 150, 20, 20, 255 );
			surface.DrawRect( ScrW() / 2 - 400 / 2 + 1, ScrH() / 2 + 40 + 1 + yc, ( 400 - 2 ) * math.min( ( CurTime() - v.Start ) / ( v.End - v.Start ), 1 ), 40 - 2 );
			
			local y = self.FontHeight["CombineControl.LabelBig"];
			
			draw.DrawText( v.Text, "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2 + yc, Color( 200, 200, 200, 255 ), 1 );
			
		end
		
		if( v.End and CurTime() >= v.End ) then
			
			v.CB( self );
			
			table.remove( self.TimedProgressBars, k );
			
		end
		
		yc = yc + 60;
		
	end
	
end

function GM:DrawPassedOut()
	
	if( LocalPlayer():PassedOut() ) then
		
		if( !LocalPlayer():Alive() ) then
			
			surface.SetDrawColor( Color( 0, 0, 0, 255 ) );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
			
			draw.DrawText( "You have died.", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color( 200, 200, 200, 255 ), 1 );
			
			return;
			
		end
		
		surface.SetDrawColor( Color( 0, 0, 0, 255 ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
		draw.DrawText( "You are unconscious.", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color( 200, 200, 200, 255 ), 1 );
		
		surface.SetDrawColor( 30, 30, 30, 150 );
		surface.DrawRect( ScrW() / 2 - 400 / 2, ScrH() / 2 + 40, 400, 40 );
		
		surface.SetDrawColor( 20, 20, 20, 100 );
		surface.DrawOutlinedRect( ScrW() / 2 - 400 / 2, ScrH() / 2 + 40, 400, 40 );
		
		surface.SetDrawColor( 150, 20, 20, 255 );
		surface.DrawRect( ScrW() / 2 - 400 / 2 + 1, ScrH() / 2 + 40 + 1, ( 400 - 2 ) * math.min( LocalPlayer():Consciousness() / 100, 1 ), 40 - 2 );
		
		local y = self.FontHeight["CombineControl.LabelBig"];
		
		if( LocalPlayer():Ragdoll() and LocalPlayer():Ragdoll():IsValid() ) then
			
			if( LocalPlayer():Ragdoll():GetVelocity():Length() > 15 ) then
				
				draw.DrawText( "You're being moved.", "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2, Color( 200, 200, 200, 255 ), 1 );
				return;
				
			end
			
		end
		
		draw.DrawText( tostring( LocalPlayer():Consciousness() ) .. "%", "CombineControl.LabelBig", ScrW() / 2, ScrH() / 2 + 40 + y / 2, Color( 200, 200, 200, 255 ), 1 );
		
	end
	
end

function GM:DrawPlayerInfo()
	
	local w = 220;
	
	surface.SetFont( "CombineControl.LabelGiant" );
	local x, y = surface.GetTextSize( LocalPlayer():VisibleRPName() );
	
	if( x + 8 > w ) then
		
		w = x + 8;
		
	end
	
	draw.RoundedBox( 0, 20, ScrH() - 102, w, 82, Color( 30, 30, 30, 200 ) );
	
	draw.DrawTextShadow( LocalPlayer():VisibleRPName(), "CombineControl.LabelGiant", w + 20 - 4, ScrH() - 102 + 4, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 2 );
	draw.DrawTextShadow( tostring( LocalPlayer():Money() ) .. " Credits", "CombineControl.LabelGiant", w + 20 - 4, ScrH() - 102 + 4 + 22 + 4, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 2 );
	draw.DrawTextShadow( "CID #" .. LocalPlayer():FormattedCID(), "CombineControl.LabelGiant", w + 20 - 4, ScrH() - 102 + 4 + 22 + 4 + 22 + 4, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 2 );
	
end

function GM:DrawHealthBars()
	
	if( !self.HPDraw ) then self.HPDraw = 100 end
	if( !self.ARDraw ) then self.ARDraw = 0 end
	if( !self.HGDraw ) then self.HGDraw = 0 end
	
	local hp = LocalPlayer():Health();
	local ar = LocalPlayer():Armor();
	local hg = LocalPlayer():Hunger();
	
	if( self.HPDraw > hp ) then
		
		self.HPDraw = self.HPDraw - 0.5;
		
	elseif( self.HPDraw < hp ) then
		
		self.HPDraw = self.HPDraw + 0.5;
		
	end
	
	if( math.abs( self.HPDraw - hp ) < 1 ) then
		
		self.HPDraw = hp;
		
	end
	
	if( self.ARDraw > ar ) then
		
		self.ARDraw = self.ARDraw - 0.5;
		
	elseif( self.ARDraw < ar ) then
		
		self.ARDraw = self.ARDraw + 0.5;
		
	end
	
	if( math.abs( self.ARDraw - ar ) < 1 ) then
		
		self.ARDraw = ar;
		
	end
	
	if( self.HGDraw > hg ) then
		
		self.HGDraw = self.HGDraw - 0.1;
		
	elseif( self.HGDraw < hg ) then
		
		self.HGDraw = self.HGDraw + 0.1;
		
	end
	
	if( math.abs( self.HGDraw - hg ) < 1 ) then
		
		self.HGDraw = hg;
		
	end
	
	self.HPDraw = math.Clamp( self.HPDraw, 0, 100 );
	self.ARDraw = math.Clamp( self.ARDraw, 0, 100 );
	self.HGDraw = math.Clamp( self.HGDraw, 0, 100 );
	
	local w = 220;
	
	surface.SetFont( "CombineControl.LabelGiant" );
	local x, y = surface.GetTextSize( LocalPlayer():VisibleRPName() );
	
	if( x + 8 > w ) then
		
		w = x + 8;
		
	end
	
	local y = ScrH() - 102 - 24;
	
	draw.RoundedBox( 0, 20, y, w, 14, Color( 30, 30, 30, 200 ) );
	
	if( self.HPDraw > 0 ) then
		
		draw.RoundedBox( 0, 22, y + 2, ( w - 4 ) * ( self.HPDraw / 100 ), 10, Color( 150, 20, 20, 255 ) );
		
	end
	
	y = y - 16;
	
	if( self.ARDraw > 0 ) then
		
		draw.RoundedBox( 0, 20, y, w, 14, Color( 30, 30, 30, 200 ) );
		draw.RoundedBox( 0, 22, y + 2, ( w - 4 ) * ( math.Clamp( self.ARDraw, 1, 100 ) / 100 ), 10, Color( 37, 84, 158, 255 ) );
		
		if( LocalPlayer():Armor() > 100 ) then
			
			draw.RoundedBox( 0, 22, y + 2, ( w - 4 ) * ( math.Clamp( self.ARDraw - 100, 1, 100 ) / 100 ), 10, Color( 240, 240, 240, 255 ) );
			
		end
		
		y = y - 16;
		
	end
	
	local b = 15 - ( LocalPlayer():Toughness() / 100 * 15 );
	b = b + ( LocalPlayer():Hunger() / 100 ) * 10;
	
	if( CurTime() - LocalPlayer():LastLegShot() < b + 5 ) then
		
		local mul = 1 - ( CurTime() - LocalPlayer():LastLegShot() ) / ( b + 5 );
		
		draw.RoundedBox( 0, 20, y, w, 14, Color( 30, 30, 30, 200 ) );
		draw.RoundedBox( 0, 22, y + 2, ( w - 4 ) * mul, 10, Color( 150, 150, 100, 255 ) );
		
		y = y - 16;
		
	end
	
	if( self.UseHunger ) then
		
		draw.RoundedBox( 0, 20, y, w, 14, Color( 30, 30, 30, 200 ) );
		
		if( self.HGDraw > 0 ) then
			
			draw.RoundedBox( 0, 22, y + 2, ( w - 4 ) * ( math.Clamp( self.HGDraw, 1, 100 ) / 100 ), 10, Color( 37, 150, 37, 255 ) );
			
			y = y - 16;
			
		end
		
	end
	
end

function GM:GetPlayerSight()
	
	local range = 256;
	range = range + ( LocalPlayer():Perception() + LocalPlayer():DrugPerceptionMod() ) * 20.48;
	range = range - ( LocalPlayer():Hunger() / 100 ) * 200;
	
	return range;
	
end

GM.NPCDrawBlacklist = {
	"npc_antlion_grub",
	"npc_barnacle_tongue_tip",
	"npc_bullseye",
	"monster_generic"
}

function GM:DrawEntities()
	
	if( self.SeeAll and !LocalPlayer():IsAdmin() ) then
		
		self.SeeAll = false;
		
		return;
		
	end
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v != LocalPlayer() or LocalPlayer():GetViewEntity() != LocalPlayer() ) then
			
			if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
			
			local pos = ( v:EyePos() + Vector( 0, 0, 10 ) ):ToScreen();
			
			if( v:Ragdoll() and v:Ragdoll():IsValid() ) then
				
				pos = ( v:Ragdoll():EyePos() + Vector( 0, 0, 10 ) ):ToScreen();
				
				if( ( self.SeeAll or ( pos.visible and LocalPlayer():CanSee( v:Ragdoll() ) and LocalPlayer():GetPos():Distance( v:GetPos() ) < self:GetPlayerSight() ) ) and v:Alive() ) then
					
					v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
					
				elseif( v.HUDAlpha > 0 ) then
					
					v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
					
				end
				
			else
				
				if( ( self.SeeAll or ( pos.visible and LocalPlayer():CanSee( v ) and LocalPlayer():GetPos():Distance( v:GetPos() ) < self:GetPlayerSight() and !v:GetNoDraw() ) ) and v:Alive() ) then
					
					v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
					
				elseif( v.HUDAlpha > 0 ) then
					
					v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
					
				end
				
			end
			
			if( v.HUDAlpha > 0 ) then
				
				local c = team.GetColor( v:Team() );
				draw.DrawTextShadow( v:VisibleRPName(), "CombineControl.PlayerFont", pos.x, pos.y, Color( c.r, c.g, c.b, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
				pos.y = pos.y + 20;
				
				if( v:TiedUp() ) then
					
					draw.DrawTextShadow( "They're tied up.", "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
				
				if( v:Typing() > 0 ) then
					
					draw.DrawTextShadow( "Typing...", "CombineControl.LabelSmallItalic", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
				
				if( v:NewbieStatus() < NEWBIE_STATUS_OLD ) then
					
					draw.DrawTextShadow( "Inexperienced Roleplayer", "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
				
				if( self.SeeAll ) then
					
					draw.DrawTextShadow( tostring( v:Health() ) .. "%", "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 0, 0, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
				
			end
			
		end
		
	end
	
	for _, v in pairs( ents.FindByClass( "prop_physics" ) ) do
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local pos = ( v:GetPos() + Vector( 0, 0, 10 ) ):ToScreen();
		
		if( ( pos.visible and LocalPlayer():CanSee( v ) and LocalPlayer():GetPos():Distance( v:GetPos() ) < 512 ) and LocalPlayer():GetActiveWeapon() and LocalPlayer():GetActiveWeapon():IsValid() and LocalPlayer():GetActiveWeapon() != NULL and LocalPlayer():GetActiveWeapon():GetClass() == "weapon_physgun" ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif( v.HUDAlpha > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			draw.DrawTextShadow( v:PropCreator(), "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			draw.DrawTextShadow( v:PropSteamID(), "CombineControl.LabelSmall", pos.x, pos.y + 24, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			
		end
		
	end
	
	for _, v in pairs( ents.FindByClass( "cc_item" ) ) do
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local pos = v:GetPos():ToScreen();
		
		if( self.SeeAll or ( pos.visible and LocalPlayer():CanSee( v ) and LocalPlayer():GetPos():Distance( v:GetPos() ) < self:GetPlayerSight() / 2 ) ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif( v.HUDAlpha > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			draw.DrawTextShadow( GAMEMODE:GetItemByID( v:GetItem() ).Name, "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
			draw.DrawTextShadow( "Weight - " .. tostring( GAMEMODE:GetItemByID( v:GetItem() ).Weight ), "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 16;
			
		end
		
	end
	
	for _, v in pairs( ents.FindByClass( "cc_paper" ) ) do
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local a, b = v:GetRotatedAABB( v:OBBMins(), v:OBBMaxs() );
		local wpos = ( v:GetPos() + ( a + b ) / 2 );
		local pos = wpos:ToScreen();
		
		if( self.SeeAll or ( pos.visible and LocalPlayer():CanSee( v ) and LocalPlayer():GetPos():Distance( v:GetPos() ) < self:GetPlayerSight() / 2 ) ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif( v.HUDAlpha > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			draw.DrawTextShadow( "Paper", "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
			draw.DrawTextShadow( "Press C to read.", "CombineControl.LabelSmall", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 16;
			
		end
		
	end
	
	for _, v in pairs( ents.FindByClass( "npc_*" ) ) do
		
		if( table.HasValue( self.NPCDrawBlacklist, v:GetClass() ) ) then continue; end
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local pos = ( v:EyePos() + Vector( 0, 0, 10 ) ):ToScreen();
		
		if( self.SeeAll and v:Health() > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
			
		elseif( v.HUDAlpha > 0 ) then
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			draw.DrawTextShadow( "#" .. v:GetClass(), "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 100, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
		end
		
	end
	
end

function GM:DrawDoors()
	
	for _, v in pairs( game.GetDoors() ) do
		
		if( !v.HUDAlpha ) then v.HUDAlpha = 0; end
		
		local a, b = v:GetRotatedAABB( v:OBBMins(), v:OBBMaxs() );
		local wpos = ( v:GetPos() + ( a + b ) / 2 );
		
		local pos = wpos:ToScreen();
		
		if( pos.visible and v:GetPos():Distance( LocalPlayer():GetPos() ) <= self:GetPlayerSight() ) then
			
			local trace = { };
			trace.start = LocalPlayer():EyePos();
			trace.endpos = trace.start + LocalPlayer():GetAimVector() * self:GetPlayerSight();
			trace.filter = LocalPlayer();
			trace.mask = MASK_SOLID;
			local tr = util.TraceLine( trace );
			
			if( tr.Entity == v ) then
				
				v.HUDAlpha = math.Clamp( v.HUDAlpha + FrameTime(), 0, 1 );
				
			elseif( v.HUDAlpha > 0 ) then
				
				v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
				
			end
			
		else
			
			v.HUDAlpha = math.Clamp( v.HUDAlpha - FrameTime(), 0, 1 );
			
		end
		
		if( v.HUDAlpha > 0 ) then
			
			local name = v:DoorOriginalName();
			
			if( v:DoorName() != "" ) then
				
				name = v:DoorName();
				
			end
			
			draw.DrawTextShadow( name, "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
			pos.y = pos.y + 20;
			
			if( ( v:DoorType() == DOOR_BUYABLE or v:DoorType() == DOOR_BUYABLE_ASSIGNABLE ) and #v:DoorOwners() == 0 and #v:DoorAssignedOwners() == 0 ) then
				
				draw.DrawTextShadow( v:DoorPrice() .. " credits", "CombineControl.PlayerFont", pos.x, pos.y, Color( 226, 205, 95, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
				pos.y = pos.y + 20;
				
			end
			
			if( self.SeeAll ) then
				
				local tab = v:DoorOwners();
				table.Merge( tab, v:DoorAssignedOwners() );
				
				for _, owner in pairs( tab ) do
					
					local ply = nil;
					
					for _, l in pairs( player.GetAll() ) do
						
						if( l:CharID() == owner ) then
							
							ply = l;
							
						end
						
					end
					
					local text = "Owner: CharID #" .. owner;
					
					if( ply and ply:IsValid() ) then
						
						text = "Owner: " .. ply:VisibleRPName();
						
					end
					
					draw.DrawTextShadow( text, "CombineControl.PlayerFont", pos.x, pos.y, Color( 200, 200, 200, v.HUDAlpha * 255 ), Color( 0, 0, 0, v.HUDAlpha * 255 ), 1 );
					pos.y = pos.y + 20;
					
				end
				
			end
			
		end
		
	end
	
end

GM.WeaponOutText = { };
GM.WeaponOutText["weapon_physgun"] = "Your physgun is out! Switch to your hands when you're done building.";
GM.WeaponOutText["weapon_physcannon"] = "Your gravgun is out! Switch to your hands when you're done moving things.";
GM.WeaponOutText["gmod_tool"] = "Your toolgun is out! Switch to your hands when you're done building.";

function GM:DrawAmmo()
	
	if( LocalPlayer():InVehicle() ) then
		
		return;
		
	end
	
	local w = LocalPlayer():GetActiveWeapon();
	
	if( w != NULL ) then
		
		if( LocalPlayer():TiedUp() ) then
			
			surface.SetFont( "CombineControl.LabelGiant" );
			local x1, y1 = surface.GetTextSize( "You're tied up." );
			
			draw.RoundedBox( 0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color( 30, 30, 30, 200 ) );
			draw.DrawTextShadow( "You're tied up.", "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() - 22 - y1, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 0 );
			
			return;
			
		elseif( LocalPlayer():Holstered() and w.Holsterable ) then
			
			surface.SetFont( "CombineControl.LabelGiant" );
			local x1, y1 = surface.GetTextSize( "Press B to unholster." );
			
			draw.RoundedBox( 0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color( 30, 30, 30, 200 ) );
			draw.DrawTextShadow( "Press B to unholster.", "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() - 22 - y1, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 0 );
			
			return;
			
		elseif( w.UnholsterText ) then
			
			surface.SetFont( "CombineControl.LabelGiant" );
			local x1, y1 = surface.GetTextSize( w.UnholsterText );
			
			draw.RoundedBox( 0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color( 30, 30, 30, 200 ) );
			draw.DrawTextShadow( w.UnholsterText, "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() - 22 - y1, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 0 );
			
			return;
			
		elseif( self.WeaponOutText[w:GetClass()] ) then
			
			surface.SetFont( "CombineControl.LabelMassive" );
			local x1, y1 = surface.GetTextSize( self.WeaponOutText[w:GetClass()] );
			
			draw.RoundedBox( 0, ScrW() - 24 - x1, ScrH() - 24 - y1, x1 + 4, y1 + 4, Color( 30, 30, 30, 200 ) );
			draw.DrawTextShadow( self.WeaponOutText[w:GetClass()], "CombineControl.LabelMassive", ScrW() - 22 - x1, ScrH() - 22 - y1, Color( 200, 0, 0, 255 ), Color( 0, 0, 0, 255 ), 0 );
			
			return;
			
		end
		
		if( w.Firearm ) then
			
			if( w.Primary.ClipSize > -1 ) then
				
				local clip = w:Clip1();
				local ammo = w:Ammo1();
				
				surface.SetFont( "CombineControl.HUDAmmo" );
				local x1, y1 = surface.GetTextSize( clip );
				local y2 = self.FontHeight["CombineControl.HUDAmmo"];
				
				local x = x1;
				local y = math.max( y1, y2 );
				
				draw.RoundedBox( 0, ScrW() - 24 - x, ScrH() - 24 - y, x + 4, y + 4, Color( 30, 30, 30, 200 ) );
				draw.DrawTextShadow( clip, "CombineControl.HUDAmmo", ScrW() - 22 - x, ScrH() - 22 - y, Color( 200, 200, 200, 255 ), Color( 0, 0, 0, 255 ), 0 );
				
			end
			
		end
		
	end
	
end

function nWarnName( len )
	
	GAMEMODE.NameWarning = true;
	GAMEMODE.NameWarningStart = CurTime();
	
end
net.Receive( "nWarnName", nWarnName );

function GM:DrawWarnings()
	
	if( self.NameWarning and CurTime() - self.NameWarningStart < 15 ) then
		
		local t = CurTime() - self.NameWarningStart;
		local a = 1;
		
		if( t < 1 ) then
			
			a = t;
			
		elseif( t > 14 ) then
			
			a = 1 - ( t - 14 );
			
		end
		
		local h = 250;
		local dh = ( ScrH() - h ) / 2;
		
		draw.RoundedBox( 0, 0, dh, ScrW(), h, Color( 30, 30, 30, 200 * a ) );
		
		draw.DrawText( "YOU HAVE BEEN ISSUED A NAME WARNING", "CombineControl.LabelStupid", ScrW() / 2, dh + 20, Color( 150, 20, 20, 255 * a ), 1 );
		
		draw.DrawText( "An administrator considers your character's name to be inappropriate for Half-Life 2 RP.\n\nPlease change it through the player menu (F3) to a proper, realistic first and last name.\n\nIf you ignore this warning, you may be subject to a kick or ban.", "CombineControl.LabelGiant", ScrW() / 2, dh + 100, Color( 200, 200, 200, 255 * a ), 1 );
		
	end
	
end

function GM:DrawUnconnected()
	
	if( !self.CharCreateOpened ) then
		
		surface.SetDrawColor( Color( 0, 0, 0, 150 ) );
		surface.DrawRect( 0, 0, ScrW(), ScrH() );
		
		draw.DrawBackgroundBlur( 1 );
		
		draw.DrawText( "Please wait...", "CombineControl.LabelGiant", ScrW() / 2, ScrH() / 2, Color( 200, 200, 200, 255 ), 1 );
		
	end
	
end

function nFlashRed( len )
	
	GAMEMODE.FlashRedStart = CurTime();
	
end
net.Receive( "nFlashRed", nFlashRed );

function GM:DrawDamage()
	
	if( self.FlashRedStart and LocalPlayer():Alive() ) then
		
		local t = CurTime() - self.FlashRedStart;
		local a = 0;
		
		if( t < 0.1 ) then
			
			a = 0.5;
			
		elseif( t < 0.6 ) then
			
			a = 0.5 - ( t - 0.1 );
			
		end
		
		if( a > 0 ) then
			
			surface.SetDrawColor( 128, 0, 0, 255 * a );
			surface.DrawRect( 0, 0, ScrW(), ScrH() );
			
		end
		
	end
	
end

GM.Notifications = { };

function nAddNotification( len )
	
	local str = net.ReadString();
	GAMEMODE:AddNotification( str );
	
end
net.Receive( "nAddNotification", nAddNotification );

function GM:AddNotification( text, col )
	
	local n = 0;
	
	for _, m in pairs( self.Notifications ) do
		
		for _, v in pairs( self.Notifications ) do
			
			if( v[3] == n ) then
				
				n = v[3] + 1;
				
			end
			
		end
		
	end
	
	table.insert( self.Notifications, { text, CurTime(), n, col } );
	
end

function GM:DrawNotifications()
	
	for k, v in pairs( self.Notifications ) do
		
		local t = v[2];
		local n = v[3];
		local col = v[4];
		
		if( CurTime() - t > 10 ) then
			
			table.remove( self.Notifications, k );
			continue;
			
		end
		
		local a = 1;
		
		if( CurTime() - t < 0.5 ) then
			
			a = ( CurTime() - t ) / 0.5;
			
		elseif( CurTime() - t > 6 ) then
			
			a = 1 - ( CurTime() - t - 6 ) / 4;
			
		end
		
		if( !col ) then
			
			col = Color( 200, 200, 200, 255 * a )
			
		else
			
			col = Color( col.r, col.g, col.b, 255 * a )
			
		end
		
		surface.SetFont( "CombineControl.LabelGiant" );
		local x1, y1 = surface.GetTextSize( v[1] );
		
		draw.RoundedBox( 0, ScrW() - 24 - x1, ScrH() * ( 3 / 4 ) - ( n * ( y1 + 8 ) ), x1 + 4, y1 + 4, Color( 30, 30, 30, 200 * a ) );
		draw.DrawTextShadow( v[1], "CombineControl.LabelGiant", ScrW() - 22 - x1, ScrH() * ( 3 / 4 ) - ( n * ( y1 + 8 ) ) + 2, Color( 200, 200, 200, 255 * a ), Color( 0, 0, 0, 255 * a ), 0 );
		
	end
	
end

function GM:HUDPaint()
	
	if( !CCP ) then return end
	
	if( self:InIntroCam() ) then
		
		self:DrawFancyIntro();
		return;
		
	end
	
	if( CCP.Quiz ) then
		
		self:DrawQuiz();
		return;
		
	end
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		self:DrawCombineCamera();
		
		if( cookie.GetNumber( "cc_chat", 1 ) == 1 ) then
			
			self:DrawChat();
			
		end
		
		return;
		
	end
	
	self:DrawCharCreate();
	
	if( !self.CharCreate ) then
		
		if( cookie.GetNumber( "cc_hud", 1 ) == 1 and !self.Mastermind ) then
			
			self:DrawDamage();
			self:DrawDrugs();
			self:DrawConsciousness();
			self:DrawDoors();
			self:DrawEntities();
			self:DrawPlayerInfo();
			self:DrawHealthBars();
			self:DrawAmmo();
			self:DrawWeaponSelect();
			self:DrawTimedProgress();
			self:DrawPassedOut();
			self:DrawNotifications();
			
		end
		
		if( self.Mastermind ) then
			
			self:DrawEntities();
			
		end
		
		if( cookie.GetNumber( "cc_chat", 1 ) == 1 ) then
			
			self:DrawChat();
			
		end
		
		if( cookie.GetNumber( "cc_hud", 1 ) != 1 ) then
			
			self:DrawConsciousness();
			self:DrawWeaponSelect();
			self:DrawPassedOut();
			
		end
		
		self:DrawWarnings();
		self:DrawUnconnected();
		
	end
	
end

function GM:HUDShouldDraw( str )
	
	if( str == "CHudWeaponSelection" ) then return false end
	if( str == "CHudAmmo" ) then return false end
	if( str == "CHudAmmoSecondary" ) then return false end
	if( str == "CHudHealth" ) then return false end
	if( str == "CHudBattery" ) then return false end
	if( str == "CHudChat" ) then return false end
	if( str == "CHudDamageIndicator" ) then return false end
	
	if( str == "CHudCrosshair" ) then
		
		local wep = LocalPlayer():GetActiveWeapon();
		
		if( wep and wep:IsValid() and wep != NULL ) then
			
			if( wep:GetClass() == "gmod_tool" or wep:GetClass() == "weapon_physgun" or wep:GetClass() == "weapon_physcannon" ) then
				
				return true
				
			end
			
		end
		
		return false;
		
	end
	
	return true
	
end

GM.MastermindMat = Material( "vgui/white" );

function GM:RenderNPCTargets()
	
	if( self.Mastermind ) then
		
		for _, v in pairs( ents.GetNPCs() ) do
			
			if( v:NPCTargetPos() != Vector() ) then
				
				local col = v:NPCMastermindColor();
				
				cam.Start3D2D( v:NPCTargetPos() + Vector( 0, 0, 1 ), Angle(), 1 );
					
					surface.SetTexture( surface.GetTextureID( "effects/select_ring" ) );
					surface.SetDrawColor( col.x, col.y, col.z, 255 );
					surface.DrawTexturedRect( -10, -10, 20, 20 );
					
				cam.End3D2D();
				
				render.DrawLine( v:GetPos(), v:NPCTargetPos(), Color( col.x, col.y, col.z, 255 ), false );
				
			end
			
		end
		
		if( self.MastermindSelected and self.MastermindSelected:IsValid() ) then
			
			local trace = { };
			trace.start = LocalPlayer():GetShootPos();
			trace.endpos = trace.start + gui.ScreenToVector( gui.MousePos() ) * 32768;
			trace.filter = LocalPlayer();
			
			if( self.MastermindMouse and self.MastermindMouse == 109 ) then
				
				trace.endpos = LocalPlayer():GetPos();
				
			end
			
			local tr = util.TraceLine( trace );
			
			cam.Start3D2D( tr.HitPos + Vector( 0, 0, 1 ), Angle(), 1 );
				
				surface.SetTexture( surface.GetTextureID( "effects/select_ring" ) );
				surface.SetDrawColor( 200, 200, 200, 255 );
				surface.DrawTexturedRect( -10, -10, 20, 20 );
				
			cam.End3D2D();
			
			render.DrawLine( self.MastermindSelected:GetPos(), tr.HitPos, Color( 200, 200, 200, 255 ), false );
			
		end
		
	end
	
end

function GM:PostDrawOpaqueRenderables()
	
	for _, v in pairs( player.GetAll() ) do
		
		if( v:GetActiveWeapon() and v:GetActiveWeapon():IsValid() and v:GetActiveWeapon() != NULL ) then
			
			if( v:GetActiveWeapon().PostDrawOpaqueRenderables ) then
				
				v:GetActiveWeapon():PostDrawOpaqueRenderables();
				
			end
			
		end
		
	end
	
	self:RenderNPCTargets();
	
	if( self.MapPostDrawOpaqueRenderables ) then
		
		self:MapPostDrawOpaqueRenderables();
		
	end
	
	self:DrugPostDrawOpaqueRenderables();
	
end

function GM:GetCursorNPC( max )
	
	local dist = max;
	local ent = nil;
	
	for _, v in pairs( ents.GetNPCs() ) do
		
		local pos = v:GetPos():ToScreen();
		local x, y = gui.MousePos();
		
		local d = math.sqrt( ( pos.x - x ) ^ 2 + ( pos.y - y ) ^ 2 );
		
		if( d < dist ) then
			
			ent = v;
			dist = d;
			
		end
		
	end
	
	return ent;
	
end

function GM:GetCursorEnt()
	
	local trace = { };
	trace.start = LocalPlayer():GetShootPos();
	trace.endpos = trace.start + gui.ScreenToVector( gui.MousePos() ) * 32768;
	trace.filter = LocalPlayer();
	local tr = util.TraceLine( trace );
	
	if( tr.Entity and tr.Entity:IsValid() ) then
		
		return tr.Entity;
		
	end
	
end

function GM:PreDrawHalos()
	
	if( self.Mastermind ) then
		
		local hEnt = nil;
		
		if( vgui.IsHoveringWorld() and !self.MastermindSelected ) then
			
			hEnt = self:GetCursorNPC( 200 );
			
		end
		
		local tab = { };
		
		if( hEnt ) then
			
			if( hEnt.GetActiveWeapon and hEnt:GetActiveWeapon() and hEnt:GetActiveWeapon():IsValid() ) then
				
				halo.Add( { hEnt, hEnt:GetActiveWeapon() }, Color( 255, 255, 255, 255 ), 4, 4, 2, true, true );
				
			else
				
				halo.Add( { hEnt }, Color( 255, 255, 255, 255 ), 4, 4, 2, true, true );
				
			end
			
		end
		
		for _, v in pairs( ents.GetNPCs() ) do
			
			if( v != hEnt ) then
				
				if( !tab[v:NPCMastermindColor()] ) then
					
					tab[v:NPCMastermindColor()] = { };
					
				end
				
				table.insert( tab[v:NPCMastermindColor()], v );
				
				if( v.GetActiveWeapon and v:GetActiveWeapon() and v:GetActiveWeapon():IsValid() ) then
					
					table.insert( tab[v:NPCMastermindColor()], v:GetActiveWeapon() );
					
				end
				
			end
			
		end
		
		for _, v in pairs( ents.FindByClass( "prop_vehicle_apc" ) ) do
			
			if( v != hEnt ) then
				
				if( !tab[v:NPCMastermindColor()] ) then
					
					tab[v:NPCMastermindColor()] = { };
					
				end
				
				table.insert( tab[v:NPCMastermindColor()], v );
				
			end
			
		end
		
		for k, v in pairs( tab ) do
			
			halo.Add( { v }, Color( k.x, k.y, k.z, 255 ), 2, 2, 1, true, true );
			
		end
		
	end
	
	if( GAMEMODE.SeeAll ) then
		
		local tab = { };
		
		for _, v in pairs( ents.GetAll() ) do
			
			if( v:PropSaved() ) then
				
				table.insert( tab, v );
				
			end
			
		end
		
		halo.Add( tab, Color( 255, 0, 255, 255 ), 1, 1, 1, true, false );
		
	end
	
end

function GM:RenderScreenspaceEffects()
	
	self.BaseClass:RenderScreenspaceEffects();
	
	if( self:InIntroCam() ) then return end
	
	if( LocalPlayer():PassedOut() ) then
		
		local tab = { };
		
		tab[ "$pp_colour_addr" ] 		= 0;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= -1;
		tab[ "$pp_colour_contrast" ] 	= 1;
		tab[ "$pp_colour_colour" ] 		= 1;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
		
	end
	
	if( self.FlashbangStart and LocalPlayer():Alive() ) then
		
		local t = CurTime() - self.FlashbangStart;
		local a = 0;
		
		if( t < 5 ) then
			
			a = 1;
			
		elseif( t < 7 ) then
			
			a = 1 - ( t - 5 ) / 2;
			
		end
		
		local tab = { };
		
		tab[ "$pp_colour_addr" ] 		= 0;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= a;
		tab[ "$pp_colour_contrast" ] 	= 1;
		tab[ "$pp_colour_colour" ] 		= 1;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
		
	end
	
	if( self.CombineCameraView and self.CombineCameraView:IsValid() ) then
		
		DrawMaterialOverlay( "effects/combine_binocoverlay", 0 )
		
		local tab = { };
		
		tab[ "$pp_colour_addr" ] 		= 0;
		tab[ "$pp_colour_addg" ] 		= 0;
		tab[ "$pp_colour_addb" ] 		= 0;
		tab[ "$pp_colour_brightness" ] 	= 0;
		tab[ "$pp_colour_contrast" ] 	= 1;
		tab[ "$pp_colour_colour" ] 		= 0;
		tab[ "$pp_colour_mulr" ] 		= 0;
		tab[ "$pp_colour_mulg" ] 		= 0; 
		tab[ "$pp_colour_mulb" ] 		= 0;
		
		DrawColorModify( tab );
		
	end
	
	self:RenderScreenspaceDrugs();
	
end

function GM:PlayerStartVoice( ply )
	
	if( !game.IsDedicated() ) then
		
		self.BaseClass:PlayerStartVoice( ply );
		
	end
	
end

function GM:PlayerEndVoice( ply )
	
	if( !game.IsDedicated() ) then
		
		self.BaseClass:PlayerEndVoice( ply );
		
	end
	
end