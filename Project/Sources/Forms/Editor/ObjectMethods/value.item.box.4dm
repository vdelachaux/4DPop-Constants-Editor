// ----------------------------------------------------
// Object method : Editor.value.item.box - (4DPop Constants Editor.4DB)
// Created 13/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_fixed)
C_LONGINT:C283($Lon_formEvent; $Lon_value)
C_REAL:C285($Num_value)
C_TEXT:C284($Txt_buffer; $Txt_decimalSeparator; $Txt_type; $Txt_value)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

GET LIST ITEM PARAMETER:C985(<>Lst_constants; *; "fixed"; $Boo_fixed)

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On After Edit:K2:43)
		
		$Txt_value:=Get edited text:C655
		
		Case of 
				
				//…………………………………………………………………………
			: ($Boo_fixed)
				
				GET LIST ITEM PARAMETER:C985(<>Lst_constants; *; "type"; $Txt_type)
				SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; "value"; $Txt_value)
				
				//…………………………………………………………………………
			: (string_isLongint($Txt_value))
				
				$Txt_type:="L"
				$Lon_value:=Num:C11($Txt_value)
				SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; "value"; $Lon_value)
				
				$Txt_value:=String:C10($Lon_value)
				(OBJECT Get pointer:C1124(Object named:K67:5; "value.item.box"))->:=$Txt_value
				
				//…………………………………………………………………………
			: (string_isNumeric($Txt_value))
				
				GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $Txt_decimalSeparator)
				$Txt_type:="R"
				$Num_value:=Num:C11($Txt_value)
				SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; "value"; $Num_value)
				//$Num_value:=Num($Txt_value; $Txt_decimalSeparator)
				//SET LIST ITEM PARAMETER(<>Lst_constants; *; "value"; String($Num_value; "&xml"))
				
				$Txt_buffer:=String:C10(Dec:C9($Num_value); "0.############################")
				$Txt_value:=String:C10(Int:C8($Num_value))+$Txt_decimalSeparator+Substring:C12($Txt_buffer; 3)
				(OBJECT Get pointer:C1124(Object named:K67:5; "value.item.box"))->:=$Txt_value
				
				//…………………………………………………………………………
			Else 
				
				$Txt_type:="S"
				SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; "value"; $Txt_value)
				
				//…………………………………………………………………………
		End case 
		
		SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; "type"; $Txt_type)
		
		SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; Additional text:K28:7; $Txt_value)
		SET LIST ITEM ICON:C950(<>Lst_constants; *; (OBJECT Get pointer:C1124(Object named:K67:5; $Txt_type+".icon"))->)
		
		SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "modified"; True:C214)
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Unnecessarily activated form event")
		
		//______________________________________________________
End case 