// ----------------------------------------------------
// Object method : Editor.b.constant.sort.value - (4DPop Constants Editor.4DB)
// Created 13/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_expanded; $Boo_num)
C_LONGINT:C283($Lon_buffer; $Lon_count; $Lon_formEvent; $Lon_i; $Lon_id; $Lon_j; $Lst_constant; $Lst_target)
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Txt_buffer; $Txt_label)

ARRAY TEXT:C222($tTxt_selectors; 0)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Clicked:K2:4)
		
		GET LIST ITEM:C378(<>Lst_constants; *; $Lon_id; $Txt_label; $Lst_constant; $Boo_expanded)
		
		If (Not:C34(Is a list:C621($Lst_constant)))
			
			$Lon_id:=List item parent:C633(<>Lst_constants; $Lon_id)
			$Lon_id:=List item position:C629(<>Lst_constants; $Lon_id)
			
			GET LIST ITEM:C378(<>Lst_constants; $Lon_id; $Lon_id; $Txt_label; $Lst_constant; $Boo_expanded)
			
		End if 
		
		If (Is a list:C621($Lst_constant))
			Lsth_SortByParam($Lst_constant)
		End if 
		
		SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_constants; $Lon_id)
		
		form_Timer(1)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 