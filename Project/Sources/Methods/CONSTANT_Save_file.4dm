//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONSTANT_Save_file
// ID[B7D3A10061F041E3A6811CC72E59FBA1]
// Created 13/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)
C_TEXT:C284($2)

C_BOOLEAN:C305($Boo_expanded; $Boo_fixed)
C_LONGINT:C283($Lon_constantId; $Lon_i; $Lon_j; $Lon_parameters; $Lon_themeId; $Lon_UID; $Lon_value; $Lst_buffer; $Lst_constants)
var $Lon_nbConstants : Integer
C_REAL:C285($Num_value)
C_TEXT:C284($Dom_constants; $Dom_root; $Txt_fileName; $Txt_groupName; $Txt_label; $Txt_type; $Txt_value)
var $Txt_constantId; $Txt_themeId : Text

If (False:C215)
	C_BOOLEAN:C305(CONSTANT_Save_file; $0)
	C_LONGINT:C283(CONSTANT_Save_file; $1)
	C_TEXT:C284(CONSTANT_Save_file; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Lst_buffer:=$1
	$Txt_fileName:=$2
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

$Dom_root:=CONSTANT_New_file

If (OK=1)
	$Lst_buffer:=Copy list:C626($Lst_buffer)
	Lsth_SortByParam($Lst_buffer; "index")
	
	For ($Lon_i; 1; Count list items:C380($Lst_buffer; *); 1)
		
		GET LIST ITEM:C378($Lst_buffer; $Lon_i; $Lon_UID; $Txt_label; $Lst_constants; $Boo_expanded)
		
		If (Is a list:C621($Lst_constants))  //theme
			
			//create the theme
			$Lon_themeId:=$Lon_themeId+1
			$Txt_groupName:=""
			GET LIST ITEM PARAMETER:C985($Lst_buffer; $Lon_UID; "groupUuid"; $Txt_groupName)
			If ($Txt_groupName="")
				$Txt_groupName:=Generate UUID:C1066
			End if 
			GET LIST ITEM PARAMETER:C985($Lst_buffer; $Lon_UID; "id"; $Txt_themeId)
			If ($Txt_themeId="")
				$Txt_themeId:=$Txt_groupName
			End if 
			CONSTANT_NEW_THEME($Dom_root; $Txt_themeId; $Txt_groupName; $Txt_label)
			
			If (OK=1)
				//create the constants' group
				$Dom_constants:=CONSTANT_New_group($Dom_root; $Txt_groupName)
				
				$Lon_nbConstants:=Count list items:C380($Lst_constants; *)
				
				If ($Lon_nbConstants>0)
					Lsth_SortByParam($Lst_constants; "index")
					
					For ($Lon_j; 1; $Lon_nbConstants; 1)
						
						If (OK=1)
							
							GET LIST ITEM:C378($Lst_constants; $Lon_j; $Lon_UID; $Txt_label)
							GET LIST ITEM PARAMETER:C985($Lst_constants; $Lon_UID; "type"; $Txt_type)
							
							Case of 
									//______________________________________________________
								: ($Txt_type="R")
									
									//GET LIST ITEM PARAMETER($Lst_constants; $Lon_UID; "value"; $Num_value)
									//$Txt_value:=String($Num_value)
									GET LIST ITEM PARAMETER:C985($Lst_constants; $Lon_UID; "value"; $Txt_value)
									XML DECODE:C1091($Txt_value; $Num_value)
									
									//______________________________________________________
								: ($Txt_type="L")
									
									GET LIST ITEM PARAMETER:C985($Lst_constants; $Lon_UID; "value"; $Lon_value)
									$Txt_value:=String:C10($Lon_value)
									
									//______________________________________________________
								Else 
									
									GET LIST ITEM PARAMETER:C985($Lst_constants; $Lon_UID; "value"; $Txt_value)
									
									//______________________________________________________
							End case 
							
							If (Position:C15($Txt_type; "RL")>0)
								
								$Txt_value:=Replace string:C233($Txt_value; ","; ".")
								$Txt_value:=Replace string:C233($Txt_value; ".00000e"; "e")
								$Txt_value:=Replace string:C233($Txt_value; ".0000e"; "e")
								$Txt_value:=Replace string:C233($Txt_value; ".000e"; "e")
								$Txt_value:=Replace string:C233($Txt_value; ".00e"; "e")
								$Txt_value:=Replace string:C233($Txt_value; ".0e"; "e")
								$Txt_value:=Replace string:C233($Txt_value; "e+0"; "")
								$Txt_value:=Replace string:C233($Txt_value; " "; ""; 1)
								
							End if 
							
							GET LIST ITEM PARAMETER:C985($Lst_constants; $Lon_UID; "fixed"; $Boo_fixed)
							$Txt_value:=Choose:C955($Boo_fixed; $Txt_value+":"+$Txt_type; $Txt_value)
							
							//$Lon_constantId:=$Lon_constantId+1
							GET LIST ITEM PARAMETER:C985($Lst_constants; $Lon_UID; "id"; $Txt_constantId)
							If ($Txt_constantId="")
								$Txt_constantId:=Generate UUID:C1066
							End if 
							CONSTANT_NEW_CONSTANT($Dom_constants; $Txt_value; $Txt_constantId; $Txt_label)
							
						End if 
					End for 
					
					If ($Boo_expanded)
						
						$Lon_i:=$Lon_i+$Lon_j-1
						
					End if 
				End if 
			End if 
			
		Else 
			
			If ($Lst_constants#0)
				TRACE:C157
			End if 
			
		End if 
	End for 
	
	If (OK=1)
		
		DOM EXPORT TO FILE:C862($Dom_root; Get 4D folder:C485(Current resources folder:K5:16; *)+$Txt_fileName)
		
	End if 
	
	$0:=(OK=1)
	
	DOM CLOSE XML:C722($Dom_root)
	
	CLEAR LIST:C377($Lst_buffer)
End if 

// ----------------------------------------------------
// End