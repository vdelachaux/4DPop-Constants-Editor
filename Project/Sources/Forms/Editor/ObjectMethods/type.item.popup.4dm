C_BOOLEAN:C305($Boo_fixed)
C_LONGINT:C283($Lon_x)
C_TEXT:C284($Txt_type; $Txt_types; $Txt_value)



If (Form event code:C388=On Load:K2:1)
	
	Self:C308->{1}:="Auto"
	Self:C308->{2}:=Get localized string:C991("EditorConstantType_3")
	Self:C308->{3}:=Get localized string:C991("EditorConstantType_1")
	Self:C308->{4}:=Get localized string:C991("EditorConstantType_2")
	
Else 
	
	$Txt_value:=(OBJECT Get pointer:C1124(Object named:K67:5; "value.item.box"))->
	$Lon_x:=Self:C308->
	
	If ($Lon_x=1)
		
		$Boo_fixed:=False:C215
		
		Case of 
				
				//…………………………………………………………………………
			: (string_isLongint($Txt_value))
				
				$Txt_type:="L"
				$Txt_value:=String:C10(Num:C11($Txt_value))
				(OBJECT Get pointer:C1124(Object named:K67:5; "value.item.box"))->:=$Txt_value
				
				//…………………………………………………………………………
			: (string_isNumeric($Txt_value))
				
				$Txt_type:="R"
				$Txt_value:=String:C10(Num:C11($Txt_value))
				(OBJECT Get pointer:C1124(Object named:K67:5; "value.item.box"))->:=$Txt_value
				
				//…………………………………………………………………………
			Else 
				
				$Txt_type:="S"
				
				//…………………………………………………………………………
		End case 
		
	Else 
		
		$Boo_fixed:=True:C214
		
		$Txt_types:="-SLR"
		$Txt_type:=$Txt_types[[$Lon_x]]
		
	End if 
	
	SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; "fixed"; $Boo_fixed)
	SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; "type"; $Txt_type)
	SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; "value"; $Txt_value)
	SET LIST ITEM PARAMETER:C986(<>Lst_constants; *; Additional text:K28:7; $Txt_value)
	
	SET LIST ITEM ICON:C950(<>Lst_constants; *; (OBJECT Get pointer:C1124(Object named:K67:5; $Txt_type+".icon"))->)
	
	SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "modified"; True:C214)
	
End if 