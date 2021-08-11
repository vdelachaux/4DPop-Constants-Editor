// ----------------------------------------------------
// Object method : Editor.b.sel.collapse - (4DPop Constants Editor.4DB)
// Created 13/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		Lsth_COLLAPSE(<>Lst_constants)
		Lsth_DISPLAY_SCROLLBAR(-><>Lst_constants)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 