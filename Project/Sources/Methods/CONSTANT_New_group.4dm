//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONSTANT_New_group
// ID[82A657FAD9444137824AD86F96B5D96D]
// Created 24/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_body; $Txt_groupName)

If (False:C215)
	C_TEXT:C284(CONSTANT_New_group; $0)
	C_TEXT:C284(CONSTANT_New_group; $1)
	C_TEXT:C284(CONSTANT_New_group; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=2; "Missing parameter"))
	
	$Dom_body:=DOM Find XML element:C864($1; "xliff/file/body")
	$Txt_groupName:=$2
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (OK=1)
	
	$0:=DOM Create XML element:C865($Dom_body; "group"; \
		"d4:groupName"; $Txt_groupName; \
		"restype"; "x-4DK#")
	
End if 

// ----------------------------------------------------
// End