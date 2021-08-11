//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : obj_pointer
// ID[F484333BD2DE4D18A63A93C53F10C6E3]
// Created 20/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_POINTER:C301($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)

If (False:C215)
	C_POINTER:C301(obj_pointer; $0)
	C_TEXT:C284(obj_pointer; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$0:=OBJECT Get pointer:C1124(Object named:K67:5; $1)
		
	Else 
		
		$0:=OBJECT Get pointer:C1124(Object current:K67:2)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
// End