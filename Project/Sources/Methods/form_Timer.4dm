//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : form_Timer
// ID[E1FA3D37AF6546E9A3B4525A1900C685]
// Created 23/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)

C_LONGINT:C283($Lon_parameters; $Lon_timerEvent)

If (False:C215)
	C_LONGINT:C283(form_Timer; $0)
	C_LONGINT:C283(form_Timer; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Lon_timerEvent:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

// ----------------------------------------------------
// End
If ($Lon_timerEvent#0)
	
	<>Lon_timerEvent:=$Lon_timerEvent
	SET TIMER:C645(-1)
	
Else 
	
	SET TIMER:C645(0)
	$0:=<>Lon_timerEvent
	<>Lon_timerEvent:=0
	
End if 