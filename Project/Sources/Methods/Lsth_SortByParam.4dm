//%attributes = {"invisible":true}
#DECLARE($Lst_constant : Integer; $tTxt_SortParam : Text)

C_BOOLEAN:C305($Boo_expanded; $Boo_num)
C_LONGINT:C283($Lon_buffer; $Lon_count; $Lon_formEvent; $Lon_i; $Lon_id; $Lon_j; $Lst_constant; $Lst_target)
var $Lon_subList : Integer
C_PICTURE:C286($Pic_buffer)
C_TEXT:C284($Txt_buffer; $Txt_label)

ARRAY TEXT:C222($tTxt_selectors; 0)

If ($tTxt_SortParam="")
	$tTxt_SortParam:="value"
End if 

$Lst_target:=Copy list:C626($Lst_constant)

For ($Lon_i; 1; Count list items:C380($Lst_constant); 1)
	
	SELECT LIST ITEMS BY POSITION:C381($Lst_constant; 1)
	DELETE FROM LIST:C624($Lst_constant; *)
	
End for 

$Lon_count:=Count list items:C380($Lst_target)

ARRAY LONGINT:C221($tLon_values; $Lon_count)
ARRAY TEXT:C222($tTxt_values; $Lon_count)
ARRAY LONGINT:C221($tLon_references; $Lon_count)
ARRAY LONGINT:C221($tLon_index; $Lon_count)
ARRAY TEXT:C222($tTxt_label; $Lon_count)
ARRAY TEXT:C222($tTxt_types; $Lon_count)

$Boo_num:=True:C214

For ($Lon_i; 1; $Lon_count; 1)
	
	GET LIST ITEM:C378($Lst_target; $Lon_i; $tLon_references{$Lon_i}; $tTxt_label{$Lon_i})
	GET LIST ITEM PARAMETER:C985($Lst_target; $tLon_references{$Lon_i}; "value"; $tTxt_values{$Lon_i})
	GET LIST ITEM PARAMETER:C985($Lst_target; $tLon_references{$Lon_i}; "value"; $tLon_values{$Lon_i})
	GET LIST ITEM PARAMETER:C985($Lst_target; $tLon_references{$Lon_i}; "type"; $tTxt_types{$Lon_i})
	$Boo_num:=($Boo_num & ($tTxt_types{$Lon_i}#"S"))
	
	If ($tTxt_SortParam#"value") && ($tTxt_SortParam#"_label_")
		GET LIST ITEM PARAMETER:C985($Lst_target; $tLon_references{$Lon_i}; $tTxt_SortParam; $tLon_index{$Lon_i})
	End if 
	
End for 

Case of 
	: ($tTxt_SortParam="_label_")
		SORT ARRAY:C229($tTxt_label; $tLon_references)
		
	: ($tTxt_SortParam="index")
		SORT ARRAY:C229($tLon_index; $tLon_references)
		
	Else 
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
End case 

For ($Lon_i; 1; $Lon_count; 1)
	
	GET LIST ITEM:C378($Lst_target; List item position:C629($Lst_target; $tLon_references{$Lon_i}); $Lon_buffer; $Txt_buffer\
		; $Lon_subList; $Boo_expanded)
	APPEND TO LIST:C376($Lst_constant; $Txt_buffer; $tLon_references{$Lon_i}; $Lon_subList; $Boo_expanded)
	
	GET LIST ITEM ICON:C951($Lst_target; $tLon_references{$Lon_i}; $Pic_buffer)
	SET LIST ITEM ICON:C950($Lst_constant; 0; $Pic_buffer)
	
	GET LIST ITEM PARAMETER ARRAYS:C1195($Lst_target; $tLon_references{$Lon_i}; $tTxt_selectors; $tTxt_values)
	For ($Lon_j; 1; Size of array:C274($tTxt_selectors); 1)
		
		SET LIST ITEM PARAMETER:C986($Lst_constant; 0; $tTxt_selectors{$Lon_j}; $tTxt_values{$Lon_j})
		
	End for 
	
End for 

CLEAR LIST:C377($Lst_target)
