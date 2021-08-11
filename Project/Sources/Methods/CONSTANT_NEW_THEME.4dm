//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONSTANT_NEW_THEME
// ID[ED4B4667C5934350B1B4509A10906B7C]
// Created 24/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_themes; $Txt_id; $Txt_label; $Txt_resname)

If (False:C215)
	C_TEXT:C284(CONSTANT_NEW_THEME; $1)
	C_TEXT:C284(CONSTANT_NEW_THEME; $2)
	C_TEXT:C284(CONSTANT_NEW_THEME; $3)
	C_TEXT:C284(CONSTANT_NEW_THEME; $4)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4; "Missing parameter"))
	
	$Dom_themes:=DOM Find XML element:C864($1; "xliff/file/body/group")
	
	$Txt_id:=$2
	$Txt_resname:=$3
	$Txt_label:=$4
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (OK=1)
	
	DOM SET XML ELEMENT VALUE:C868(\
		DOM Create XML element:C865(\
		DOM Create XML element:C865(\
		$Dom_themes; "trans-unit"; \
		"id"; $Txt_id; \
		"resname"; $Txt_resname; \
		"translate"; "no"); \
		"source"); \
		$Txt_label)
	
End if 

// ----------------------------------------------------
// End