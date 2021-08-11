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
			
			$Lst_target:=Copy list:C626($Lst_constant)
			
			For ($Lon_i; 1; Count list items:C380($Lst_constant); 1)
				
				SELECT LIST ITEMS BY POSITION:C381($Lst_constant; 1)
				DELETE FROM LIST:C624($Lst_constant; *)
				
			End for 
			
			$Lon_count:=Count list items:C380($Lst_target)
			
			ARRAY LONGINT:C221($tLon_values; $Lon_count)
			ARRAY TEXT:C222($tTxt_values; $Lon_count)
			ARRAY LONGINT:C221($tLon_references; $Lon_count)
			ARRAY TEXT:C222($tTxt_types; $Lon_count)
			
			$Boo_num:=True:C214
			
			For ($Lon_i; 1; $Lon_count; 1)
				
				GET LIST ITEM:C378($Lst_target; $Lon_i; $tLon_references{$Lon_i}; $Txt_buffer)
				GET LIST ITEM PARAMETER:C985($Lst_target; $tLon_references{$Lon_i}; "value"; $tTxt_values{$Lon_i})
				GET LIST ITEM PARAMETER:C985($Lst_target; $tLon_references{$Lon_i}; "value"; $tLon_values{$Lon_i})
				GET LIST ITEM PARAMETER:C985($Lst_target; $tLon_references{$Lon_i}; "type"; $tTxt_types{$Lon_i})
				$Boo_num:=($Boo_num & ($tTxt_types{$Lon_i}#"S"))
				
			End for 
			
			If (Shift down:C543)
				
				If ($Boo_num)
					
					SORT ARRAY:C229($tLon_values; $tLon_references; <)
					
				Else 
					
					SORT ARRAY:C229($tTxt_values; $tLon_references; <)
					
				End if 
				
			Else 
				
				If ($Boo_num)
					
					SORT ARRAY:C229($tLon_values; $tLon_references)
					
				Else 
					
					SORT ARRAY:C229($tTxt_values; $tLon_references)
					
				End if 
				
			End if 
			
			For ($Lon_i; 1; $Lon_count; 1)
				
				GET LIST ITEM:C378($Lst_target; List item position:C629($Lst_target; $tLon_references{$Lon_i}); $Lon_buffer; $Txt_buffer)
				APPEND TO LIST:C376($Lst_constant; $Txt_buffer; $tLon_references{$Lon_i})
				
				GET LIST ITEM ICON:C951($Lst_target; $tLon_references{$Lon_i}; $Pic_buffer)
				SET LIST ITEM ICON:C950($Lst_constant; 0; $Pic_buffer)
				
				GET LIST ITEM PARAMETER ARRAYS:C1195($Lst_target; $tLon_references{$Lon_i}; $tTxt_selectors; $tTxt_values)
				For ($Lon_j; 1; Size of array:C274($tTxt_selectors); 1)
					
					SET LIST ITEM PARAMETER:C986($Lst_constant; 0; $tTxt_selectors{$Lon_j}; $tTxt_values{$Lon_j})
					
				End for 
				
			End for 
			
			CLEAR LIST:C377($Lst_target)
			
		End if 
		
		SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_constants; $Lon_id)
		
		form_Timer(1)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 