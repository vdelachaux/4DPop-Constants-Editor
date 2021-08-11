// ----------------------------------------------------
// Object method : Editor.name.group.item.box - (4DPop Constants Editor.4DB)
// Created 13/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_formEvent; $Lon_sublist; $Lon_UID)
C_TEXT:C284($Txt_box; $Txt_buffer)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		$Txt_box:=Get edited text:C655
		
		GET LIST ITEM:C378(<>Lst_constants; *; $Lon_UID; $Txt_buffer; $Lon_sublist; $Boo_expanded)
		
		If ($Txt_buffer#$Txt_box)
			
			//$Lon_theme:=Element parent(<>Lst_constants;*)
			//Si ($Lon_theme#0)  //Theme
			
			If (Is a list:C621($Lon_sublist))  //Theme
				
				SET LIST ITEM:C385(<>Lst_constants; $Lon_UID; $Txt_box; $Lon_UID; $Lon_sublist; $Boo_expanded)
				
			Else   //Constant
				
				If (Length:C16($Txt_box)>31)
					
					ALERT:C41(Get localized string:C991("TheConstantsNameCannotContainMoreThan31Characters"))
					
					obj_pointer->:=Substring:C12($Txt_box; 1; 31)
					
				End if 
				
				SET LIST ITEM:C385(<>Lst_constants; $Lon_UID; $Txt_box; $Lon_UID)
				
			End if 
			
			SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "modified"; True:C214)
			
		End if 
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 