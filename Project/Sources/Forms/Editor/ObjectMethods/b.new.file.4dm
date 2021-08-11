// ----------------------------------------------------
// Object method : Editor.b.new.file - (4DPop Constants Editor.4DB)
// Created 11/01/12 by Vincent de Lachaux
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
		
		EDITOR_handler("menu.new.file")
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 