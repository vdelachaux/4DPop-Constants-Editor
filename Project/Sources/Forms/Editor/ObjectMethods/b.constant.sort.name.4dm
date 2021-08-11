// ----------------------------------------------------
// Object method : Editor.b.constant.sort.name - (4DPop Constants Editor.4DB)
// Created 13/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_formEvent; $Lon_id; $Lst_constant)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		$Lon_id:=Selected list items:C379(<>Lst_constants; *)
		$Lst_constant:=Lsth_Get_list(<>Lst_constants)
		
		If (Shift down:C543)
			
			SORT LIST:C391($Lst_constant; <)
			
		Else 
			
			SORT LIST:C391($Lst_constant)
			
		End if 
		
		SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_constants; $Lon_id)
		
		form_Timer(1)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 