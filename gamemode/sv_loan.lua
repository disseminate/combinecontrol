function nTakeLoan( len, ply )
	
	if( ply:HasAnyCombineFlag() ) then return end
	
	local amt = net.ReadUInt( 32 );
	
	if( ply:Loan() + amt <= GAMEMODE.MaxLoan ) then
		
		ply:SetLoan( ply:Loan() + amt );
		ply:AddMoney( amt );
		
		ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
		ply:UpdateCharacterField( "Loan", tostring( ply:Loan() ) );
		
	end
	
end
net.Receive( "nTakeLoan", nTakeLoan );

function nGiveLoan( len, ply )
	
	if( ply:HasAnyCombineFlag() ) then return end
	
	local amt = net.ReadUInt( 32 );
	
	if( ply:Loan() >= amt and ply:Money() >= amt ) then
		
		ply:SetLoan( ply:Loan() - amt );
		ply:AddMoney( amt * -1 );
		
		ply:UpdateCharacterField( "Money", tostring( ply:Money() ) );
		ply:UpdateCharacterField( "Loan", tostring( ply:Loan() ) );
		
	end
	
end
net.Receive( "nGiveLoan", nGiveLoan );

function nDeductLoan( len, ply )
	
	if( !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ) or !GAMEMODE:LookupCombineFlag( ply:CombineFlag() ).CanEditLoans ) then return end
	
	local targ = net.ReadEntity();
	local amt = net.ReadUInt( 32 );
	
	if( targ:Loan() >= amt ) then
		
		targ:SetLoan( targ:Loan() - amt );
		targ:UpdateCharacterField( "Loan", tostring( targ:Loan() ) );
		
		net.Start( "nLoanDeducted" );
			net.WriteEntity( ply );
			net.WriteUInt( amt, 32 );
		net.Send( targ );
		
	end
	
end
net.Receive( "nDeductLoan", nDeductLoan );