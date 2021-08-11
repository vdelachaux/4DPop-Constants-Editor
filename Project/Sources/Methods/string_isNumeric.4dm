//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : string_isNumeric
// ID[BCCD30381BF54AF3A79DD8FFB4CD617B]
// Created 12/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Return true if the string $1 is a numeric
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_decimalSeparator; $Txt_target)

If (False:C215)
	C_BOOLEAN:C305(string_isNumeric; $0)
	C_TEXT:C284(string_isNumeric; $1)
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
If (Position:C15(" "; $Txt_target)=0)
	
	GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $Txt_decimalSeparator)
	
	$0:=(Rgx_MatchText("^[-+]?\\d+(?:["+$Txt_decimalSeparator+"]+\\d*)?(?:[-+ e\\d]*)?$"; $Txt_target)=0)
	
End if 

// ----------------------------------------------------
// End
