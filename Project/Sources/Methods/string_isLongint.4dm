//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : string_isLongint
// ID[BF7059F3D54B4639A7434503131EB7AF]
// Created 12/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Return true if the string $1 is a longint
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_true)
C_LONGINT:C283($Lon_parameters)
C_REAL:C285($Num_buffer)
C_TEXT:C284($Txt_target)

If (False:C215)
	C_BOOLEAN:C305(string_isLongint; $0)
	C_TEXT:C284(string_isLongint; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_target:=Lowercase:C14($1)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Rgx_MatchText("^[-+]?\\d+[-+ e\\d]*$"; $Txt_target)=0)
	
	$Num_buffer:=Num:C11($Txt_target)
	$Boo_true:=(($Num_buffer>=(-2^31)) & ($Num_buffer<=((2^31)-1)))
	
End if 

$0:=$Boo_true

// ----------------------------------------------------
// End