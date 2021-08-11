//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Lsth_DISPLAY_SCROLLBAR
// ID[D0D1BF379EB44E4A8F47150862CFEF09]
// Created 07/11/06 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Automatic display of the vertical scrollbar
// ----------------------------------------------------
// Declarations
C_POINTER:C301($1)

C_LONGINT:C283($Lon_appearance; $Lon_bottom; $Lon_dummy; $Lon_icon; $Lon_lineHeight; $Lon_parameters; $Lon_top)
C_POINTER:C301($Ptr_list)

If (False:C215)
	C_POINTER:C301(Lsth_DISPLAY_SCROLLBAR; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Ptr_list:=$1
		
	Else 
		
		$Ptr_list:=OBJECT Get pointer:C1124(Object current:K67:2)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
GET LIST PROPERTIES:C632($Ptr_list->; $Lon_appearance; $Lon_icon; $Lon_lineHeight)
OBJECT GET COORDINATES:C663($Ptr_list->; $Lon_dummy; $Lon_top; $Lon_dummy; $Lon_bottom)
OBJECT SET SCROLLBAR:C843($Ptr_list->; False:C215; ((Count list items:C380($Ptr_list->)*$Lon_lineHeight)>($Lon_bottom-$Lon_top)))

// ----------------------------------------------------
// End