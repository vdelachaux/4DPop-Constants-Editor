//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONSTANT_NEW_CONSTANT
// ID[6CE211C4683C43C0B5821B50D79408DD]
// Created 24/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_constants; $Txt_id; $Txt_label; $Txt_value)

If (False:C215)
	C_TEXT:C284(CONSTANT_NEW_CONSTANT; $1)
	C_TEXT:C284(CONSTANT_NEW_CONSTANT; $2)
	C_TEXT:C284(CONSTANT_NEW_CONSTANT; $3)
	C_TEXT:C284(CONSTANT_NEW_CONSTANT; $4)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=4; "Missing parameter"))
	
	$Dom_constants:=$1
	$Txt_value:=$2
	$Txt_id:=$3
	$Txt_label:=$4
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
DOM SET XML ELEMENT VALUE:C868(\
DOM Create XML element:C865(\
DOM Create XML element:C865(\
$Dom_constants; "trans-unit"; \
"d4:value"; $Txt_value; \
"id"; $Txt_id); \
"source"); \
$Txt_label)

// ----------------------------------------------------
// End