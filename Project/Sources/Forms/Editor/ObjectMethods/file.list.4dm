// ----------------------------------------------------
// Object method : Editor.file.list - (4DPop Constants Editor.4DB)
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
		
		
		If (Contextual click:C713)
			
			
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Selection Change:K2:29)
		
		form_Timer(-2)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 