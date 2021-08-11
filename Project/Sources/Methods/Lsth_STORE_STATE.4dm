//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : LSTH_STORE_STATE
// ID[873C544DE7714ACA879AABB561C8F189]
// Created 20/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_formEvent; $Lon_parameter; $Lon_parameters; $Lst_buffer)

If (False:C215)
	C_LONGINT:C283(Lsth_STORE_STATE; $0)
	C_LONGINT:C283(Lsth_STORE_STATE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	If ($Lon_parameter>=1)
		
		$Lst_buffer:=$1
		
	Else 
		
		$Lst_buffer:=OBJECT Get pointer:C1124(Object current:K67:2)->
		
	End if 
	
	$Lon_formEvent:=Form event code:C388
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Expand:K2:41)
		
		SET LIST ITEM PARAMETER:C986($Lst_buffer; *; "expanded"; True:C214)
		
		//______________________________________________________
	: ($Lon_formEvent=On Collapse:K2:42)
		
		SET LIST ITEM PARAMETER:C986($Lst_buffer; *; "expanded"; False:C215)
		
		//______________________________________________________
End case 

$0:=$Lon_formEvent

// ----------------------------------------------------
// End