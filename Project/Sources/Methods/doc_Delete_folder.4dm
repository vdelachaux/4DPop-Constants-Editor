//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : doc_Delete_folder
// ID[91676BB762ED4052B61CF84DBC4F27CC]
// Created 23/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_i; $Lon_parameters)
C_TEXT:C284($Txt_folder_path; $Txt_path)

If (False:C215)
	C_BOOLEAN:C305(doc_Delete_folder; $0)
	C_TEXT:C284(doc_Delete_folder; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_folder_path:=$1
	
	$Txt_folder_path:=Choose:C955(\
		$Txt_folder_path[[Length:C16($Txt_folder_path)]]#Folder separator:K24:12; \
		$Txt_folder_path+Folder separator:K24:12; \
		$Txt_folder_path)
	
	$Boo_OK:=True:C214
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

If (Asserted:C1132(Test path name:C476($Txt_folder_path)=Is a folder:K24:2; "\""+$Txt_folder_path+"\" is not a folder !"))
	
	ARRAY TEXT:C222($tTxt_files; 0x0000)
	DOCUMENT LIST:C474($Txt_folder_path; $tTxt_files)
	
	ERROR:=0
	ON ERR CALL:C155("NO_ERROR")
	
	For ($Lon_i; 1; Size of array:C274($tTxt_files))
		
		$Txt_path:=$Txt_folder_path+$tTxt_files{$Lon_i}
		
		DELETE DOCUMENT:C159($Txt_path)
		
		$Boo_OK:=(ERROR=0)
		
		If (Not:C34($Boo_OK))
			
			$Lon_i:=MAXLONG:K35:2-1
			
		End if 
		
	End for 
	
	ON ERR CALL:C155("")
	
	If ($Boo_OK)
		
		ARRAY TEXT:C222($tTxt_folders; 0x0000)
		FOLDER LIST:C473($Txt_folder_path; $tTxt_folders)
		
		For ($Lon_i; 1; Size of array:C274($tTxt_folders); 1)
			
			$Boo_OK:=doc_Delete_folder($Txt_folder_path+$tTxt_folders{$Lon_i})
			
			If (Not:C34($Boo_OK))
				
				$Lon_i:=MAXLONG:K35:2-1
				
			End if 
			
		End for 
		
	End if 
	
	If ($Boo_OK)
		
		DELETE FOLDER:C693($Txt_folder_path)
		
	End if 
End if 

$0:=$Boo_OK

// ----------------------------------------------------
// End