//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Obj_spinner
// ID[6BB08028F9DB440B89A639DD9148B299]
// Created 20/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_enable)
C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_object)

If (False:C215)
	C_BOOLEAN:C305(Obj_spinner; $1)
	C_TEXT:C284(Obj_spinner; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	$Txt_object:="spinner"
	
	If ($Lon_parameters>=1)
		
		$Boo_enable:=$1
		
		If ($Lon_parameters>=2)
			
			$Txt_object:=$2
			
		End if 
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
(OBJECT Get pointer:C1124(Object named:K67:5; $Txt_object))->:=Num:C11($Boo_enable)
OBJECT SET VISIBLE:C603(*; $Txt_object; $Boo_enable)

// ----------------------------------------------------
// End