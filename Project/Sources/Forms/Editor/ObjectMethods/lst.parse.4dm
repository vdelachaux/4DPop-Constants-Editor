// ----------------------------------------------------
// Object method : Editor.lst.parse - (4DPop Constants Editor.4DB)
// Created 20/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Lsth_STORE_STATE

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Expand:K2:41) | ($Lon_formEvent=On Collapse:K2:42)
		//______________________________________________________
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		form_Timer(1)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 