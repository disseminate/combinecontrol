function nCharacterList( len )
	
	GAMEMODE.Characters = net.ReadTable();
	
end
net.Receive( "nCharacterList", nCharacterList );

function GM:CharCreateThink()
	
	if( self.QueueCharCreate ) then
		
		if( !self.IntroCamStart or !self:InIntroCam() ) then
			
			if( !CCP.Quiz or !CCP.Quiz:IsValid() ) then
				
				self.QueueCharCreate = false;
				cookie.Set( "cc_doneintro", 2 );
				
				self:CreateCharEditor();
				
			end
			
		end
		
	end
	
end

function GM:CreateQuiz()
	
	if( CCP.Quiz and CCP.Quiz:IsValid() ) then
		
		CCP.Quiz:Remove();
		CCP.Quiz = nil;
		
	end
	
	CCP.Quiz = vgui.Create( "DFrame" );
	CCP.Quiz:SetSize( 510, 220 );
	CCP.Quiz:Center();
	CCP.Quiz:SetTitle( "IQ Test" );
	CCP.Quiz:ShowCloseButton( false );
	CCP.Quiz:SetDraggable( false );
	CCP.Quiz.lblTitle:SetFont( "CombineControl.Window" );
	CCP.Quiz:MakePopup();
	
	CCP.Quiz.Q1L = vgui.Create( "DLabel", CCP.Quiz );
	CCP.Quiz.Q1L:SetText( self.QuizQuestions[1][1] );
	CCP.Quiz.Q1L:SetPos( 10, 34 );
	CCP.Quiz.Q1L:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q1L:SizeToContents();
	CCP.Quiz.Q1L:PerformLayout();
	
	CCP.Quiz.Q2L = vgui.Create( "DLabel", CCP.Quiz );
	CCP.Quiz.Q2L:SetText( self.QuizQuestions[2][1] );
	CCP.Quiz.Q2L:SetPos( 10, 64 );
	CCP.Quiz.Q2L:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q2L:SizeToContents();
	CCP.Quiz.Q2L:PerformLayout();
	
	CCP.Quiz.Q3L = vgui.Create( "DLabel", CCP.Quiz );
	CCP.Quiz.Q3L:SetText( self.QuizQuestions[3][1] );
	CCP.Quiz.Q3L:SetPos( 10, 94 );
	CCP.Quiz.Q3L:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q3L:SizeToContents();
	CCP.Quiz.Q3L:PerformLayout();
	
	CCP.Quiz.Q4L = vgui.Create( "DLabel", CCP.Quiz );
	CCP.Quiz.Q4L:SetText( self.QuizQuestions[4][1] );
	CCP.Quiz.Q4L:SetPos( 10, 124 );
	CCP.Quiz.Q4L:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q4L:SizeToContents();
	CCP.Quiz.Q4L:PerformLayout();
	
	CCP.Quiz.Q5L = vgui.Create( "DLabel", CCP.Quiz );
	CCP.Quiz.Q5L:SetText( self.QuizQuestions[5][1] );
	CCP.Quiz.Q5L:SetPos( 10, 154 );
	CCP.Quiz.Q5L:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q5L:SizeToContents();
	CCP.Quiz.Q5L:PerformLayout();
	
	CCP.Quiz.Q1 = vgui.Create( "DComboBox", CCP.Quiz );
	CCP.Quiz.Q1:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q1:SetValue( "" );
	CCP.Quiz.Q1:SetPos( 350, 34 );
	CCP.Quiz.Q1:SetSize( 150, 20 );
	CCP.Quiz.Q1:PerformLayout();
	for _, v in pairs( self.QuizQuestions[1][2] ) do
		CCP.Quiz.Q1:AddChoice( v, v );
	end
	
	function CCP.Quiz.Q1:OnSelect( index, val, data )
		
		CCP.Quiz.Q1.DataVal = data;
		
	end
	
	CCP.Quiz.Q2 = vgui.Create( "DComboBox", CCP.Quiz );
	CCP.Quiz.Q2:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q2:SetValue( "" );
	CCP.Quiz.Q2:SetPos( 350, 64 );
	CCP.Quiz.Q2:SetSize( 150, 20 );
	CCP.Quiz.Q2:PerformLayout();
	for _, v in pairs( self.QuizQuestions[2][2] ) do
		CCP.Quiz.Q2:AddChoice( v, v );
	end
	
	function CCP.Quiz.Q2:OnSelect( index, val, data )
		
		CCP.Quiz.Q2.DataVal = data;
		
	end
	
	CCP.Quiz.Q3 = vgui.Create( "DComboBox", CCP.Quiz );
	CCP.Quiz.Q3:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q3:SetValue( "" );
	CCP.Quiz.Q3:SetPos( 350, 94 );
	CCP.Quiz.Q3:SetSize( 150, 20 );
	CCP.Quiz.Q3:PerformLayout();
	for _, v in pairs( self.QuizQuestions[3][2] ) do
		CCP.Quiz.Q3:AddChoice( v, v );
	end
	
	function CCP.Quiz.Q3:OnSelect( index, val, data )
		
		CCP.Quiz.Q3.DataVal = data;
		
	end
	
	CCP.Quiz.Q4 = vgui.Create( "DComboBox", CCP.Quiz );
	CCP.Quiz.Q4:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q4:SetValue( "" );
	CCP.Quiz.Q4:SetPos( 350, 124 );
	CCP.Quiz.Q4:SetSize( 150, 20 );
	CCP.Quiz.Q4:PerformLayout();
	for _, v in pairs( self.QuizQuestions[4][2] ) do
		CCP.Quiz.Q4:AddChoice( v, v );
	end
	
	function CCP.Quiz.Q4:OnSelect( index, val, data )
		
		CCP.Quiz.Q4.DataVal = data;
		
	end
	
	CCP.Quiz.Q5 = vgui.Create( "DComboBox", CCP.Quiz );
	CCP.Quiz.Q5:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Q5:SetValue( "" );
	CCP.Quiz.Q5:SetPos( 350, 154 );
	CCP.Quiz.Q5:SetSize( 150, 20 );
	CCP.Quiz.Q5:PerformLayout();
	for _, v in pairs( self.QuizQuestions[5][2] ) do
		CCP.Quiz.Q5:AddChoice( v, v );
	end
	
	function CCP.Quiz.Q5:OnSelect( index, val, data )
		
		CCP.Quiz.Q5.DataVal = data;
		
	end
	
	CCP.Quiz.Submit = vgui.Create( "DButton", CCP.Quiz );
	CCP.Quiz.Submit:SetFont( "CombineControl.LabelSmall" );
	CCP.Quiz.Submit:SetText( "Submit" );
	CCP.Quiz.Submit:SetPos( 350, 184 );
	CCP.Quiz.Submit:SetSize( 100, 26 );
	CCP.Quiz.Submit.DoClick = function( self )
		
		if( !CCP.Quiz.Q1.DataVal or
			!CCP.Quiz.Q2.DataVal or
			!CCP.Quiz.Q3.DataVal or
			!CCP.Quiz.Q4.DataVal or
			!CCP.Quiz.Q5.DataVal ) then return end
		
		self:SetDisabled( true );
		
		if( CCP.Quiz.Q1.DataVal == GAMEMODE.QuizQuestions[1][3] and
			CCP.Quiz.Q2.DataVal == GAMEMODE.QuizQuestions[2][3] and
			CCP.Quiz.Q3.DataVal == GAMEMODE.QuizQuestions[3][3] and
			CCP.Quiz.Q4.DataVal == GAMEMODE.QuizQuestions[4][3] and
			CCP.Quiz.Q5.DataVal == GAMEMODE.QuizQuestions[5][3] ) then
			
			CCP.Quiz:Remove();
			CCP.Quiz = nil;
			GAMEMODE:StartIntroCam();
			
		else
			
			if( cookie.GetNumber( "cc_doneintro", 0 ) == 0 ) then
				
				cookie.Set( "cc_doneintro", 1 );
				
				net.Start( "nQuizBan" );
					net.WriteBit( false );
				net.SendToServer();
				
			elseif( cookie.GetNumber( "cc_doneintro", 0 ) == 1 ) then
				
				net.Start( "nQuizBan" );
					net.WriteBit( true );
				net.SendToServer();
				
			end
			
		end
		
	end
	CCP.Quiz.Submit:PerformLayout();
	
end

function nOpenCharCreate( len )
	
	GAMEMODE.CCMode = net.ReadUInt( 3 );
	GAMEMODE.QueueCharCreate = true;
	
end
net.Receive( "nOpenCharCreate", nOpenCharCreate );

GM.CCModel = GM.CCModel or "";

function GM:CreateCharEditor()
	
	self.CharCreate = true;
	self.CharCreateOpened = true;
	
	if( self.CCMode == CC_CREATE ) then
		
		self:CreateCharCreate();
		
	elseif( self.CCMode == CC_CREATESELECT ) then
		
		self:CreateCharCreate();
		self:CreateCharSelect();
		
	elseif( self.CCMode == CC_CREATESELECT_C ) then
		
		self:CreateCharCreate();
		self:CreateCharSelect();
		self:CreateCharDeleteCancel();
		
	elseif( self.CCMode == CC_SELECT ) then
		
		self:CreateCharSelect( true );
		
	elseif( self.CCMode == CC_SELECT_C ) then
		
		self:CreateCharSelect( true );
		self:CreateCharDeleteCancel();
		
	end
	
end

GM.CharCreateSelectedModel = GM.CharCreateSelectedModel or "";

local matHover = Material( "vgui/spawnmenu/hover" );

local allowedChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ -";

function GM:CreateCharCreate()
	
	CCP.CharCreatePanel = vgui.Create( "DFrame" );
	CCP.CharCreatePanel:SetSize( 800, 500 );
	if( self.CCMode == CC_CREATE ) then
		CCP.CharCreatePanel:Center();
	else
		CCP.CharCreatePanel:SetPos( ScrW() / 2 - 800 / 2 - 100, ScrH() / 2 - 500 / 2 );
	end
	CCP.CharCreatePanel:SetTitle( "Character Creation" );
	CCP.CharCreatePanel:ShowCloseButton( false );
	CCP.CharCreatePanel:SetDraggable( false );
	CCP.CharCreatePanel.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CharCreatePanel:MakePopup();
	
	CCP.CharCreatePanel.NameLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.NameLabel:SetText( "Name" );
	CCP.CharCreatePanel.NameLabel:SetPos( 10, 30 );
	CCP.CharCreatePanel.NameLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.NameLabel:SizeToContents();
	CCP.CharCreatePanel.NameLabel:PerformLayout();
	
	CCP.CharCreatePanel.NameEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel );
	CCP.CharCreatePanel.NameEntry:SetFont( "CombineControl.LabelBig" );
	CCP.CharCreatePanel.NameEntry:SetPos( 150, 30 );
	CCP.CharCreatePanel.NameEntry:SetSize( 300, 20 );
	CCP.CharCreatePanel.NameEntry:PerformLayout();
	function CCP.CharCreatePanel.NameEntry:AllowInput( val )
		
		if( !string.find( allowedChars, val, 1, true ) ) then
			
			return true
			
		end
		
		return false;
		
	end
	
	CCP.CharCreatePanel.RandomMale = vgui.Create( "DButton", CCP.CharCreatePanel );
	CCP.CharCreatePanel.RandomMale:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.RandomMale:SetText( "Random Male" );
	CCP.CharCreatePanel.RandomMale:SetPos( 150, 60 );
	CCP.CharCreatePanel.RandomMale:SetSize( 100, 20 );
	function CCP.CharCreatePanel.RandomMale:DoClick()
		
		CCP.CharCreatePanel.NameEntry:SetValue( table.Random( GAMEMODE.MaleFirstNames ) .. " " .. table.Random( GAMEMODE.LastNames ) );
		
	end
	CCP.CharCreatePanel.RandomMale:PerformLayout();
	
	CCP.CharCreatePanel.RandomFemale = vgui.Create( "DButton", CCP.CharCreatePanel );
	CCP.CharCreatePanel.RandomFemale:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.RandomFemale:SetText( "Random Female" );
	CCP.CharCreatePanel.RandomFemale:SetPos( 260, 60 );
	CCP.CharCreatePanel.RandomFemale:SetSize( 100, 20 );
	function CCP.CharCreatePanel.RandomFemale:DoClick()
		
		CCP.CharCreatePanel.NameEntry:SetValue( table.Random( GAMEMODE.FemaleFirstNames ) .. " " .. table.Random( GAMEMODE.LastNames ) );
		
	end
	CCP.CharCreatePanel.RandomFemale:PerformLayout();
	
	CCP.CharCreatePanel.DescLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.DescLabel:SetText( "Description" );
	CCP.CharCreatePanel.DescLabel:SetPos( 10, 90 );
	CCP.CharCreatePanel.DescLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.DescLabel:SizeToContents();
	CCP.CharCreatePanel.DescLabel:PerformLayout();
	
	CCP.CharCreatePanel.DescEntry = vgui.Create( "DTextEntry", CCP.CharCreatePanel );
	CCP.CharCreatePanel.DescEntry:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.DescEntry:SetPos( 150, 90 );
	CCP.CharCreatePanel.DescEntry:SetSize( 300, 200 );
	CCP.CharCreatePanel.DescEntry:SetMultiline( true );
	CCP.CharCreatePanel.DescEntry:PerformLayout();
	
	CCP.CharCreatePanel.ModelLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.ModelLabel:SetText( "Model" );
	CCP.CharCreatePanel.ModelLabel:SetPos( 10, 300 );
	CCP.CharCreatePanel.ModelLabel:SetFont( "CombineControl.LabelGiant" );
	CCP.CharCreatePanel.ModelLabel:SizeToContents();
	CCP.CharCreatePanel.ModelLabel:PerformLayout();
	
	local x = 0;
	local y = 0;
	
	local si = { };
	
	for _, v in pairs( self.CitizenModels ) do
		
		local model = vgui.Create( "SpawnIcon", CCP.CharCreatePanel );
		model:SetPos( 150 + x, 300 + y );
		model:SetSize( 58, 58 );
		model:SetModel( v );
		model.ModelPath = v;
		function model:DoClick()
			
			for _, v in pairs( si ) do
				
				v.Selected = false;
				
			end
			
			self.Selected = true;
			
			GAMEMODE.CharCreateSelectedModel = self.ModelPath;
			
		end
		function model:PaintOver( w, h )
			
			self:DrawSelections();
			
			if( self.Hovered or self.Selected ) then
				
				surface.SetDrawColor( 255, 255, 255, 255 );
				surface.SetMaterial( matHover );
				self:DrawTexturedRect();
				
			end
			
		end
		function model:Paint( w, h )
			
			surface.SetDrawColor( 40, 40, 40, 255 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 30, 30, 30, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		model:SetTooltip( "" );
		
		table.insert( si, model );
		
		x = x + 60;
		
		if( x > 300 - 60 ) then
			
			x = 0;
			y = y + 60;
			
		end
		
	end
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Stats" );
	label:SetPos( 470, 30 );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	local y = 0;
	
	for _, v in pairs( GAMEMODE.Stats ) do
		
		local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
		label:SetText( v );
		label:SetPos( 470, 70 + y );
		label:SetFont( "CombineControl.LabelMedium" );
		label:SizeToContents();
		label:PerformLayout();
		
		CCP.CharCreatePanel["StatBar" .. v] = vgui.Create( "CCProgressBar", CCP.CharCreatePanel );
		CCP.CharCreatePanel["StatBar" .. v]:SetPos( 586, 70 + y );
		CCP.CharCreatePanel["StatBar" .. v]:SetSize( 178, 16 );
		CCP.CharCreatePanel["StatBar" .. v]:SetProgress( 0 );
		CCP.CharCreatePanel["StatBar" .. v]:SetProgressText( tostring( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() * 100 ) .. "/100" );
		
		local a = vgui.Create( "DButton", CCP.CharCreatePanel );
		a:SetFont( "CombineControl.LabelSmall" );
		a:SetText( "<" );
		a:SetPos( 560, 70 + y );
		a:SetSize( 16, 16 );
		function a:DoClick()
			
			if( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() > 0 ) then
				
				CCP.CharCreatePanel.StatBarRemain:SetProgress( math.Clamp( CCP.CharCreatePanel.StatBarRemain:GetProgress() + 0.01, 0, 1 ) );
				CCP.CharCreatePanel.StatBarRemain:SetProgressText( tostring( math.Round( CCP.CharCreatePanel.StatBarRemain:GetProgress() * 100 ) ) .. "/100" );
				
				CCP.CharCreatePanel["StatBar" .. v]:SetProgress( math.Clamp( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() - 0.01, 0, 1 ) );
				CCP.CharCreatePanel["StatBar" .. v]:SetProgressText( tostring( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() * 100 ) .. "/100" );
				
			end
			
		end
		a:PerformLayout();
		
		local b = vgui.Create( "DButton", CCP.CharCreatePanel );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( ">" );
		b:SetPos( 774, 70 + y );
		b:SetSize( 16, 16 );
		function b:DoClick()
			
			if( CCP.CharCreatePanel.StatBarRemain:GetProgress() > 0 ) then
				
				CCP.CharCreatePanel.StatBarRemain:SetProgress( math.Clamp( CCP.CharCreatePanel.StatBarRemain:GetProgress() - 0.01, 0, 1 ) );
				CCP.CharCreatePanel.StatBarRemain:SetProgressText( tostring( math.Round( CCP.CharCreatePanel.StatBarRemain:GetProgress() * 100 ) ) .. "/100" );
				
				CCP.CharCreatePanel["StatBar" .. v]:SetProgress( math.Clamp( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() + 0.01, 0, 1 ) );
				CCP.CharCreatePanel["StatBar" .. v]:SetProgressText( tostring( CCP.CharCreatePanel["StatBar" .. v]:GetProgress() * 100 ) .. "/100" );
				
			end
			
		end
		b:PerformLayout();
		
		y = y + 30;
		
	end
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Remaining" );
	label:SetPos( 470, 70 + y );
	label:SetFont( "CombineControl.LabelMedium" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.StatBarRemain = vgui.Create( "CCProgressBar", CCP.CharCreatePanel );
	CCP.CharCreatePanel.StatBarRemain:SetPos( 586, 70 + y );
	CCP.CharCreatePanel.StatBarRemain:SetSize( 178, 16 );
	CCP.CharCreatePanel.StatBarRemain:SetProgress( GAMEMODE.StatsAvailable / 100 );
	CCP.CharCreatePanel.StatBarRemain:SetProgressText( tostring( CCP.CharCreatePanel.StatBarRemain:GetProgress() * 100 ) .. "/100" );
	
	local label = vgui.Create( "DLabel", CCP.CharCreatePanel );
	label:SetText( "Trait" );
	label:SetPos( 470, 300 );
	label:SetFont( "CombineControl.LabelGiant" );
	label:SizeToContents();
	label:PerformLayout();
	
	CCP.CharCreatePanel.TraitLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TraitLabel:SetText( GAMEMODE.Traits[TRAIT_NONE][1] );
	CCP.CharCreatePanel.TraitLabel:SetPos( 586, 303 );
	CCP.CharCreatePanel.TraitLabel:SetSize( 178, 16 );
	CCP.CharCreatePanel.TraitLabel:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.TraitLabel:PerformLayout();
	CCP.CharCreatePanel.TraitLabel.Value = TRAIT_NONE;
	
	local a = vgui.Create( "DButton", CCP.CharCreatePanel );
	a:SetFont( "CombineControl.LabelSmall" );
	a:SetText( "<" );
	a:SetPos( 560, 303 );
	a:SetSize( 16, 16 );
	function a:DoClick()
		
		local n = CCP.CharCreatePanel.TraitLabel.Value / 2;
		
		if( n < TRAIT_NONE ) then
			
			n = 2 ^ #GAMEMODE.Traits;
			
		end
		
		CCP.CharCreatePanel.TraitLabel.Value = n;
		CCP.CharCreatePanel.TraitLabel:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][1] );
		CCP.CharCreatePanel.TraitDesc:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][2] );
		
	end
	a:PerformLayout();
	
	local b = vgui.Create( "DButton", CCP.CharCreatePanel );
	b:SetFont( "CombineControl.LabelSmall" );
	b:SetText( ">" );
	b:SetPos( 774, 303 );
	b:SetSize( 16, 16 );
	function b:DoClick()
		
		local n = CCP.CharCreatePanel.TraitLabel.Value * 2;
		
		if( n > 2 ^ #GAMEMODE.Traits ) then
			
			n = TRAIT_NONE;
			
		end
		
		CCP.CharCreatePanel.TraitLabel.Value = n;
		CCP.CharCreatePanel.TraitLabel:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][1] );
		CCP.CharCreatePanel.TraitDesc:SetText( GAMEMODE.Traits[CCP.CharCreatePanel.TraitLabel.Value][2] );
		
	end
	b:PerformLayout();
	
	CCP.CharCreatePanel.TraitDesc = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.TraitDesc:SetText( GAMEMODE.Traits[TRAIT_NONE][2] );
	CCP.CharCreatePanel.TraitDesc:SetPos( 470, 329 );
	CCP.CharCreatePanel.TraitDesc:SetSize( 320, 14 );
	CCP.CharCreatePanel.TraitDesc:SetFont( "CombineControl.LabelTiny" );
	CCP.CharCreatePanel.TraitDesc:SetAutoStretchVertical( true );
	CCP.CharCreatePanel.TraitDesc:SetWrap( true );
	CCP.CharCreatePanel.TraitDesc:PerformLayout();
	
	if( self.CCMode == CC_CREATE ) then
		
		CCP.CharCreatePanel.NewbLabel = vgui.Create( "DLabel", CCP.CharCreatePanel );
		CCP.CharCreatePanel.NewbLabel:SetText( "Are you an inexperienced roleplayer?" );
		CCP.CharCreatePanel.NewbLabel:SetPos( 470, 435 );
		CCP.CharCreatePanel.NewbLabel:SetFont( "CombineControl.LabelSmall" );
		CCP.CharCreatePanel.NewbLabel:SetSize( 294, 16 );
		CCP.CharCreatePanel.NewbLabel:SetAutoStretchVertical( true );
		CCP.CharCreatePanel.NewbLabel:SetWrap( true );
		CCP.CharCreatePanel.NewbLabel:PerformLayout();
		
		net.Start( "nSetNewbieStatus" );
			net.WriteBit( true );
		net.SendToServer();
		
		CCP.CharCreatePanel.Newbie = vgui.Create( "DCheckBoxLabel", CCP.CharCreatePanel );
		CCP.CharCreatePanel.Newbie:SetText( "" );
		CCP.CharCreatePanel.Newbie:SetPos( 774, 434 );
		CCP.CharCreatePanel.Newbie:SetValue( true );
		CCP.CharCreatePanel.Newbie:PerformLayout();
		function CCP.CharCreatePanel.Newbie:OnChange( val )
			
			net.Start( "nSetNewbieStatus" );
				net.WriteBit( val );
			net.SendToServer();
			
		end
		
	end
	
	CCP.CharCreatePanel.BadChar = vgui.Create( "DLabel", CCP.CharCreatePanel );
	CCP.CharCreatePanel.BadChar:SetText( "" );
	CCP.CharCreatePanel.BadChar:SetPos( 470, 466 );
	CCP.CharCreatePanel.BadChar:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.BadChar:SetSize( 720, 14 );
	CCP.CharCreatePanel.BadChar:PerformLayout();
	
	CCP.CharCreatePanel.OK = vgui.Create( "DButton", CCP.CharCreatePanel );
	CCP.CharCreatePanel.OK:SetFont( "CombineControl.LabelSmall" );
	CCP.CharCreatePanel.OK:SetText( "OK" );
	CCP.CharCreatePanel.OK:SetPos( 740, 460 );
	CCP.CharCreatePanel.OK:SetSize( 50, 30 );
	function CCP.CharCreatePanel.OK:DoClick()
		
		local name = CCP.CharCreatePanel.NameEntry:GetValue();
		local desc = CCP.CharCreatePanel.DescEntry:GetValue();
		local model = GAMEMODE.CharCreateSelectedModel;
		local trait = CCP.CharCreatePanel.TraitLabel.Value;
		
		local stats = { };
		local sum = 0;
		
		for _, v in pairs( GAMEMODE.Stats ) do
			
			stats[v] = CCP.CharCreatePanel["StatBar" .. v]:GetProgress() * 100;
			sum = sum + stats[v];
			
		end
		
		local r, err = GAMEMODE:CheckCharacterValidity( name, desc, model, math.Round( sum ), trait );
		
		if( r ) then
			
			GAMEMODE:CloseCharCreate();
			
			net.Start( "nCreateCharacter" );
				net.WriteString( name );
				net.WriteString( desc );
				net.WriteString( model );
				net.WriteTable( stats );
				net.WriteUInt( trait, 32 );
			net.SendToServer();
			
			if( !GAMEMODE.AutoMOTD ) then
				
				GAMEMODE.AutoMOTD = true;
				GAMEMODE:CreateMOTD();
				
			end
			
		else
			
			CCP.CharCreatePanel.BadChar:SetText( err );
			
		end
		
	end
	CCP.CharCreatePanel.OK:PerformLayout();
	
end

function GM:CharSelectPopulateCharacters()
	
	if( !self.CharSelectCharacterButtons ) then self.CharSelectCharacterButtons = { }; end
	
	for _, v in pairs( self.CharSelectCharacterButtons ) do
		
		v:Remove();
		
	end
	
	self.CharSelectCharacterButtons = { };
	
	local y = 0;
	
	for k, v in pairs( self.Characters ) do
		
		local b = vgui.Create( "DButton", CCP.CharSelectPanel );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( v.RPName );
		b:SetPos( 10, 30 + y );
		b:SetSize( 180, 20 );
		b.CharID = v.id;
		b.Location = v.Location;
		function b:DoClick()
			
			if( CCP.CharSelectPanel.DeleteMode ) then
				
				if( tonumber( v.Loan ) and tonumber( v.Loan ) > 0 ) then
					
					CCP.CharCreatePanel.BadChar:SetText( "You can't delete a character with a loan." );
					return;
					
				end
				
				net.Start( "nDeleteCharacter" );
					net.WriteUInt( self.CharID, 32 );
				net.SendToServer();
				
				for m, n in pairs( GAMEMODE.Characters ) do
					
					if( n.id == self.CharID ) then
						
						table.remove( GAMEMODE.Characters, m );
						
					end
					
				end
				
				GAMEMODE:CharSelectPopulateCharacters();
				
			else
				
				GAMEMODE:CloseCharCreate();
				
				net.Start( "nSelectCharacter" );
					net.WriteUInt( self.CharID, 32 );
				net.SendToServer();
				
				if( !GAMEMODE.AutoMOTD ) then
					
					GAMEMODE.AutoMOTD = true;
					GAMEMODE:CreateMOTD();
					
				end
				
			end
			
		end
		b:PerformLayout();
		
		if( LocalPlayer().CharID and b.CharID == LocalPlayer():CharID() ) then
			
			b:SetDisabled( true );
			
		end
		
		if( GAMEMODE.CurrentLocation and b.Location != GAMEMODE.CurrentLocation and !LocalPlayer():IsAdmin() ) then
			
			b:SetDisabled( true );
			
		end
		
		table.insert( self.CharSelectCharacterButtons, b );
		
		y = y + 30;
		
	end
	
end

function GM:CreateCharSelect( o )
	
	CCP.CharSelectPanel = vgui.Create( "DFrame" );
	CCP.CharSelectPanel:SetSize( 200, 500 );
	if( o ) then
		CCP.CharSelectPanel:Center();
	else
		CCP.CharSelectPanel:SetPos( ScrW() / 2 + 800 / 2 - 100, ScrH() / 2 - 500 / 2 );
	end
	CCP.CharSelectPanel:SetTitle( "Character Selection" );
	CCP.CharSelectPanel:ShowCloseButton( false );
	CCP.CharSelectPanel:SetDraggable( false );
	CCP.CharSelectPanel.lblTitle:SetFont( "CombineControl.Window" );
	CCP.CharSelectPanel:MakePopup();
	
	self:CharSelectPopulateCharacters();
	
end

function GM:CreateCharDeleteCancel()
	
	if( CCP.CharSelectPanel ) then
		
		local b = vgui.Create( "DButton", CCP.CharSelectPanel );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( "Delete" );
		b:SetPos( 10, 500 - 60 );
		b:SetSize( 180, 20 );
		function b:DoClick()
			
			if( !CCP.CharSelectPanel.DeleteMode ) then
				
				CCP.CharSelectPanel.DeleteMode = true;
				self:SetTextColor( Color( 200, 0, 0, 255 ) );
				
			else
				
				CCP.CharSelectPanel.DeleteMode = false;
				self:SetTextColor( Color( 200, 200, 200, 255 ) );
				
			end
			
		end
		b:PerformLayout();
		
		local b = vgui.Create( "DButton", CCP.CharSelectPanel );
		b:SetFont( "CombineControl.LabelSmall" );
		b:SetText( "Cancel" );
		b:SetPos( 10, 500 - 30 );
		b:SetSize( 180, 20 );
		function b:DoClick()
			
			GAMEMODE:CloseCharCreate();
			
		end
		b:PerformLayout();
		
	end
	
end

function GM:CloseCharCreate()
	
	self.CharCreate = false;
	
	if( CCP.CharCreatePanel ) then
		
		CCP.CharCreatePanel:Remove();
		
	end
	
	if( CCP.CharSelectPanel ) then
		
		CCP.CharSelectPanel:Remove();
		
	end
	
	CCP.CharCreatePanel = nil;
	CCP.CharSelectPanel = nil;
	
end

function GM:LoadMOTD()
	
	if( self.MOTDURL != "" ) then
		
		local function LoadMOTD( contents, size, headers, code )
			
			self.MOTDText = contents;
			
		end
		
		http.Fetch( self.MOTDURL, LoadMOTD, function() end );
		
	end
	
end

function GM:CreateMOTD()
	
	if( !self.MOTDText ) then return end
	
	if( cookie.GetNumber( "cc_motd", 1 ) == 1 ) then
		
		CCP.MOTD = vgui.Create( "DFrame" );
		CCP.MOTD:SetSize( 400, 600 );
		CCP.MOTD:Center();
		CCP.MOTD:SetTitle( "MOTD" );
		CCP.MOTD.lblTitle:SetFont( "CombineControl.Window" );
		CCP.MOTD:MakePopup();
		CCP.MOTD.PerformLayout = CCFramePerformLayout;
		CCP.MOTD:PerformLayout();
		
		CCP.MOTD.Content = vgui.Create( "CCLabel", CCP.MOTD );
		CCP.MOTD.Content:SetPos( 10, 34 );
		CCP.MOTD.Content:SetSize( 400 - 20, 14 );
		CCP.MOTD.Content:SetFont( "CombineControl.LabelSmall" );
		CCP.MOTD.Content:SetText( self.MOTDText );
		CCP.MOTD.Content:PerformLayout();
		
	end
	
end
