//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : LSTH_COLLAPSE
// ID[45D091E4D08C4930BF3947120AC1BFF7]
// Created 20/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_i; $Lon_id; $Lon_parameters; $Lst_constant; $Lst_main)
C_TEXT:C284($Txt_label)

If (False:C215)
	C_LONGINT:C283(Lsth_COLLAPSE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Lst_main:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

For ($Lon_i; 1; Count list items:C380($Lst_main); 1)
	
	GET LIST ITEM:C378($Lst_main; $Lon_i; $Lon_id; $Txt_label; $Lst_constant; $Boo_expanded)
	
	If ($Boo_expanded)
		
		SET LIST ITEM:C385($Lst_main; $Lon_id; $Txt_label; $Lon_id; $Lst_constant; False:C215)
		SET LIST ITEM PARAMETER:C986($Lst_main; $Lon_id; "expanded"; False:C215)
		
		$Lon_i:=$Lon_i+Count list items:C380($Lst_constant)
		
	End if 
	
End for 

// ----------------------------------------------------
// End