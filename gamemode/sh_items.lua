GM.Items = { };

local files = file.Find( GM.FolderName .. "/gamemode/items/*.lua", "LUA", "namedesc" );

if( #files > 0 ) then

	for _, v in pairs( files ) do
		
		ITEM = { };
		ITEM.ID				= "";
		ITEM.Name 			= "";
		ITEM.Description	= "";
		ITEM.Model			= "";
		ITEM.Weight			= 1;
		
		ITEM.ProcessEntity	= function() end;
		ITEM.ProcessEntity	= function() end;
		ITEM.IconMaterial	= nil;
		ITEM.IconColor		= nil;
		
		ITEM.Usable			= false;
		ITEM.Droppable		= true;
		ITEM.Throwable		= true;
		ITEM.UseText		= nil;
		ITEM.DeleteOnUse	= false;
		
		ITEM.OnPlayerUse	= function() end;
		ITEM.OnPlayerSpawn	= function() end;
		ITEM.OnPlayerPickup	= function() end;
		ITEM.OnPlayerDeath	= function() end;
		ITEM.OnRemoved		= function() end;
		ITEM.Think			= function() end;
		
		AddCSLuaFile( "items/" .. v );
		include( "items/" .. v );
		
		if( ITEM.Clothes ) then
			
			ITEM.Usable			= true;
			ITEM.UseText		= "Wear";
			ITEM.DeleteOnUse	= true;
			
			ITEM.OnPlayerUse	= function( self, ply )
				
				local cur = ply:TranslatePlayerModel();
				
				if( !cur ) then
					
					if( CLIENT ) then
						
						GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You can't wear these with what you're wearing right now.", { CB_ALL, CB_IC } );
						
					end
					
					return true;
					
				end
				
				if( cur == GAMEMODE:GetItemByID( self ).Clothes ) then
					
					if( CLIENT ) then
						
						GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You're already wearing those.", { CB_ALL, CB_IC } );
						
					end
					
					return true;
					
				end
				
				if( CLIENT ) then
					
					GAMEMODE:AddChat( Color( 200, 200, 200, 255 ), "CombineControl.ChatNormal", "You change clothes.", { CB_ALL, CB_IC } );
					
				else
					
					ply:SetModelCC( string.gsub( ply:GetModel(), cur, GAMEMODE:GetItemByID( self ).Clothes ) );
					ply:UpdateCharacterField( "Model", ply:GetModel() );
					ply.CharModel = ply:GetModel();
					
					if( cur == "group01" ) then
						
						ply:GiveItem( "citizenclothes", nil, true );
						
					end
					
					if( cur == "group03" ) then
						
						ply:GiveItem( "rebelclothes", nil, true );
						
					end
					
					if( cur == "group03m" ) then
						
						ply:GiveItem( "medicclothes", nil, true );
						
					end
					
				end
				
			end
			
		end
		
		if( ITEM.Uniform ) then
			
			ITEM.Usable			= true;
			ITEM.UseText		= "Wear";
			
			ITEM.OnPlayerUse	= function( self, ply )
				
				local new = GAMEMODE:GetItemByID( self ).Uniform( self, ply );
				
				if( !new and !ply.Uniform ) then
					
					return;
					
				end
				
				if( SERVER ) then
					
					if( ply.Uniform ) then
						
						ply:SetModelCC( ply.CharModel );
						ply.Uniform = nil;
						
					else
						
						ply:SetModelCC( new );
						ply.Uniform = new;
						
						if( GAMEMODE:GetItemByID( self ).UniformColor ) then
							
							local c = GAMEMODE:GetItemByID( self ).UniformColor;
							ply:SetPlayerColor( Vector( c.r / 255, c.g / 255, c.b / 255 ) );
							
						end
						
					end
					
				end
				
			end
			
		end
		
		table.insert( GM.Items, ITEM );
		
		if( !ITEM.EasterEgg ) then
			
			MsgC( Color( 200, 200, 200, 255 ), "Item " .. v .. " loaded.\n" );
			
		end
		
	end
	
else
	
	if( SERVER ) then
		
		GM:LogBug( "Warning: No items found.", true );
		
	end
	
end

function GM:LoadWeaponItems()

	for _, v in pairs( weapons.GetList() ) do
		
		if( v.Itemize ) then
			
			ITEM = { };
			ITEM.ID				= v.ClassName;
			ITEM.Name 			= v.PrintName;
			ITEM.Description	= v.ItemDescription or "";
			ITEM.Model			= v.WorldModel;
			ITEM.Weight			= v.ItemWeight or 1;
			
			ITEM.EasterEgg		= v.ItemEasterEgg;
			
			ITEM.FOV			= v.ItemFOV;
			ITEM.CamPos			= v.ItemCamPos;
			ITEM.LookAt			= v.ItemLookAt;
			
			ITEM.ProcessEntity	= v.ItemProcessEntity;
			ITEM.PProcessEntity	= v.ItemPProcessEntity;
			ITEM.IconMaterial	= v.ItemIconMaterial;
			ITEM.IconColor		= v.ItemIconColor;
			
			ITEM.BulkPrice		= v.ItemBulkPrice;
			ITEM.SinglePrice	= v.ItemSinglePrice;
			ITEM.License		= v.ItemLicense;
			
			ITEM.Droppable		= true;
			ITEM.Throwable		= true;
			ITEM.Usable			= false;
			ITEM.UseText		= nil;
			
			function ITEM.OnPlayerSpawn( item, ply )
				
				if( SERVER ) then
					
					ply:Give( item );
					
				end
				
			end;
			
			function ITEM.OnPlayerPickup( item, ply )
				
				if( SERVER ) then
					
					ply:Give( item );
					
				end
				
			end;
			
			function ITEM.OnRemoved( item, ply )
				
				if( SERVER and ply:GetNumItems( item ) < 2 ) then
					
					ply:StripWeapon( item );
					
				end
				
			end;
			
			table.insert( self.Items, ITEM );
			
			if( !ITEM.EasterEgg ) then
				
				MsgC( Color( 200, 200, 200, 255 ), "Weapon item " .. v.ClassName .. " loaded.\n" );
				
			end
			
		end
		
	end
	
end

function GM:GetItemByID( id )
	
	for _, v in pairs( self.Items ) do
		
		if( v.ID == id ) then
			
			return v;
			
		end
		
	end
	
end

function GM:CreateItem( ply, item )
	
	local trace = { };
	trace.start = ply:GetShootPos();
	trace.endpos = trace.start + ply:GetAimVector() * 50;
	trace.filter = ply;
	
	local tr = util.TraceLine( trace );
	
	local ent = self:CreatePhysicalItem( item, tr.HitPos + tr.HitNormal * 10, Angle() );
	
	ent:SetPropSteamID( ply:SteamID() );
	
	return ent;
	
end

function GM:CreatePhysicalItem( item, pos, ang )
	
	local e = ents.Create( "cc_item" );
	
	e:SetItem( item );
	
	e:SetModel( GAMEMODE:GetItemByID( item ).Model );
	
	e:SetPos( pos );
	e:SetAngles( ang );
	
	if( GAMEMODE:GetItemByID( item ).ProcessEntity ) then
		
		GAMEMODE:GetItemByID( item ).ProcessEntity( item, e );
		
	end
	
	e:Spawn();
	e:Activate();
	
	if( GAMEMODE:GetItemByID( item ).PProcessEntity ) then
		
		GAMEMODE:GetItemByID( item ).PProcessEntity( item, e );
		
	end
	
	if( e:GetPhysicsObject() and e:GetPhysicsObject():IsValid() ) then
		
		e:GetPhysicsObject():Wake();
		
	end
	
	return e;
	
end

local function LoadBook( contents, size, headers, code )
	
	local lines = string.Explode( "\n", string.gsub( contents, "\t", "     " ) );
	
	local title = lines[1];
	table.remove( lines, 1 );
	
	local desc = lines[1];
	table.remove( lines, 1 );
	
	local model = lines[1];
	table.remove( lines, 1 );
	
	local code = lines[1];
	table.remove( lines, 1 );
	
	GAMEMODE.Books[title] = { };
	
	local nextNewChapter = false;
	local curTitle = "";
	local curText = "";
	
	for k, v in pairs( lines ) do
		
		if( k == #lines ) then
			
			curText = curText .. string.gsub( v, "|", "" );
			
			table.insert( GAMEMODE.Books[title], { curTitle, curText } );
			
			break;
			
		end
		
		local p = string.find( v, "|", nil, true );
		
		if( p == 1 ) then
			
			if( string.len( curTitle ) > 0 ) then
				
				table.insert( GAMEMODE.Books[title], { curTitle, curText } );
				
			end
			
			curTitle = string.gsub( v, "|", "" );
			curText = "";
			
		else
			
			curText = curText .. string.gsub( v, "|", "" ) .. "\n";
			
		end
		
	end
	
	ITEM = { };
	ITEM.ID				= code;
	ITEM.Name 			= title;
	ITEM.Description	= desc;
	ITEM.Model			= model;
	ITEM.Weight			= 1;
	
	ITEM.FOV			= 13;
	ITEM.CamPos 		= Vector( 50, 50, 50 );
	ITEM.LookAt 		= Vector( 0, 0, 5.73 );
	ITEM.BookID			= title;
	
	ITEM.ProcessEntity	= function() end;
	ITEM.ProcessEntity	= function() end;
	ITEM.IconMaterial	= nil;
	ITEM.IconColor		= nil;
	
	ITEM.Usable			= true;
	ITEM.Droppable		= true;
	ITEM.Throwable		= true;
	ITEM.UseText		= "Read";
	ITEM.DeleteOnUse	= false;
	
	ITEM.OnPlayerUse = function( self, ply )
		
		if( SERVER ) then return end
		
		if( CCP.Book ) then CCP.Book:Remove() end
		
		CCP.Book = vgui.Create( "DFrame" );
		CCP.Book:SetSize( 800, 600 );
		CCP.Book:Center();
		CCP.Book:SetTitle( GAMEMODE:GetItemByID( self ).BookID );
		CCP.Book.lblTitle:SetFont( "CombineControl.Window" );
		CCP.Book:MakePopup();
		CCP.Book.PerformLayout = CCFramePerformLayout;
		CCP.Book:PerformLayout();
		CCP.Book.ChapterNum = 1;
		CCP.Book.BookID = GAMEMODE:GetItemByID( self ).BookID;
		
		local scroll = vgui.Create( "DScrollPanel", CCP.Book );
		scroll:SetPos( 10, 64 );
		scroll:SetSize( 780, 526 );
		function scroll:Paint( w, h )
			
			surface.SetDrawColor( 30, 30, 30, 150 );
			surface.DrawRect( 0, 0, w, h );
			
			surface.SetDrawColor( 20, 20, 20, 100 );
			surface.DrawOutlinedRect( 0, 0, w, h );
			
		end
		
		CCP.Book.Text = vgui.Create( "CCLabel", scroll );
		CCP.Book.Text:SetPos( 0, 0 );
		CCP.Book.Text:SetSize( 780, 526 );
		CCP.Book.Text:SetFont( "CombineControl.LabelSmall" );
		CCP.Book.Text:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][1][2] );
		CCP.Book.Text:PerformLayout();
		
		local function UpdateChapter()
			
			CCP.Book.Chapter:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][CCP.Book.ChapterNum][1] );
			CCP.Book.Chapter:SizeToContents();
			CCP.Book.Chapter:PerformLayout();
			CCP.Book.Text:SetText( GAMEMODE.Books[GAMEMODE:GetItemByID( self ).BookID][CCP.Book.ChapterNum][2] );
			CCP.Book.Text:PerformLayout();
			
		end
		
		local left = vgui.Create( "DButton", CCP.Book );
		left:SetFont( "CombineControl.LabelSmall" );
		left:SetText( "<<" );
		left:SetPos( 720, 34 );
		left:SetSize( 30, 20 );
		left.DoClick = function( self )
			
			CCP.Book.ChapterNum = math.Clamp( CCP.Book.ChapterNum - 1, 1, #GAMEMODE.Books[CCP.Book.BookID] );
			UpdateChapter();
			
		end
		left:PerformLayout();
		
		local right = vgui.Create( "DButton", CCP.Book );
		right:SetFont( "CombineControl.LabelSmall" );
		right:SetText( ">>" );
		right:SetPos( 760, 34 );
		right:SetSize( 30, 20 );
		right.DoClick = function( self )
			
			CCP.Book.ChapterNum = math.Clamp( CCP.Book.ChapterNum + 1, 1, #GAMEMODE.Books[CCP.Book.BookID] );
			UpdateChapter();
			
		end
		right:PerformLayout();
		
		CCP.Book.Chapter = vgui.Create( "DLabel", CCP.Book );
		CCP.Book.Chapter:SetText( GAMEMODE.Books[CCP.Book.BookID][1][1] );
		CCP.Book.Chapter:SetPos( 10, 34 );
		CCP.Book.Chapter:SetFont( "CombineControl.LabelBig" );
		CCP.Book.Chapter:SizeToContents();
		CCP.Book.Chapter:PerformLayout();
		
	end
	ITEM.OnPlayerSpawn	= function() end;
	ITEM.OnPlayerPickup	= function() end;
	ITEM.OnPlayerDeath	= function() end;
	ITEM.OnRemoved		= function() end;
	ITEM.Think			= function() end;
	
	table.insert( GAMEMODE.Items, ITEM );
	MsgC( Color( 200, 200, 200, 255 ), "Item " .. code .. " loaded.\n" );
	
end

local function FailedBook( err )
	
	
	
end

function GM:LoadBooks()
	
	self.Books = { };
	
	if( self.BooksURL != "" ) then
		
		http.Fetch( self.BooksURL .. "_index.txt", function( c )
			
			local list = string.Explode( "\n", c );
			
			MsgC( Color( 200, 200, 200, 255 ), "Loading " .. #list .. " books...\n" );
			
			for _, v in pairs( list ) do
				
				http.Fetch( self.BooksURL .. v, LoadBook, FailedBook );
				
			end
			
		end, function( err )
			
			MsgC( Color( 200, 0, 0, 255 ), "Error loading books.\n" );
			
		end );
		
	else
		
		MsgC( Color( 200, 200, 200, 255 ), "No book data specified - skipping...\n" );
		
	end
	
end