//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : mnu_SET_ENABLED
// ID[05A5154F2C5D4933B0665098E44E4C3C]
// Created 23/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_LONGINT:C283($2)
C_BOOLEAN:C305($3)

C_BOOLEAN:C305($Boo_enabled)
C_LONGINT:C283($Lon_line; $Lon_parameters)
C_TEXT:C284($Mnu_ref)

If (False:C215)
	C_TEXT:C284(mnu_SET_ENABLED; $1)
	C_LONGINT:C283(mnu_SET_ENABLED; $2)
	C_BOOLEAN:C305(mnu_SET_ENABLED; $3)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	$Mnu_ref:=$1
	$Lon_line:=$2
	
	If ($Lon_parameters>=3)
		
		$Boo_enabled:=$3
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

If ($Boo_enabled)
	
	ENABLE MENU ITEM:C149($Mnu_ref; $Lon_line)
	
Else 
	
	DISABLE MENU ITEM:C150($Mnu_ref; $Lon_line)
	
End if 

// ----------------------------------------------------
// End