//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_Save
// ID[0D4F5EC0CFEC40F7B3BA4E88CFEF7D9F]
// Created 25/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_LONGINT:C283($1)

C_BOOLEAN:C305($Boo_modified; $Boo_OK)
C_LONGINT:C283($Lon_action; $Lon_currentFile; $Lon_parameters)
C_TEXT:C284($Txt_fileName)

If (False:C215)
	C_BOOLEAN:C305(EDITOR_Save; $0)
	C_LONGINT:C283(EDITOR_Save; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Lon_currentFile:=$1
		
	Else 
		
		$Lon_currentFile:=Selected list items:C379(<>Lst_files; *)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_currentFile; "modified"; $Boo_modified)

$Boo_OK:=Not:C34($Boo_modified)

If (Not:C34($Boo_OK))
	
	$Lon_action:=mess_Confirm(Get localized string:C991("BackUpTheModifications"))
	
	$Boo_OK:=($Lon_action>=0)
	
	Case of 
			
			//…………………………………
		: ($Lon_action=0)  //do not save
			
			SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_currentFile; "modified"; False:C215)
			
			//…………………………………
		: ($Lon_action=1)  //save
			
			GET LIST ITEM:C378(<>Lst_files; \
				List item position:C629(<>Lst_files; $Lon_currentFile); \
				$Lon_currentFile; \
				$Txt_fileName)
			
			$Boo_OK:=CONSTANT_Save_file(<>Lst_constants; $Txt_fileName)
			
			SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_currentFile; "needToRestart"; $Boo_OK)
			SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_currentFile; "modified"; Not:C34($Boo_OK))
			
	End case 
End if 

$0:=$Boo_OK

// ----------------------------------------------------
// End