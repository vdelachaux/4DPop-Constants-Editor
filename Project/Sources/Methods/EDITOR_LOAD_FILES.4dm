//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_LOAD_FILES
// ID[1C908FFEB4FB47AB9455FF3443B1E34C]
// Created 13/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Gets the xliff files at the root of the resources' folder
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($Lon_i; $Lon_id; $Lon_ii; $Lon_parameters; $Lst_localized)
C_PICTURE:C286($Pic_file; $Pic_folder)
C_TEXT:C284($Dom_file; $Dom_root; $Txt_file; $Txt_folder; $Txt_path; $Txt_resourceFolder; $Txt_value)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	ARRAY TEXT:C222($tTxt_files; 0x0000)
	
	READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"folder.png"; $Pic_folder)
	CREATE THUMBNAIL:C679($Pic_folder; $Pic_folder; 16)
	
	READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"file.png"; $Pic_file)
	CREATE THUMBNAIL:C679($Pic_file; $Pic_file; 16)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------

$Txt_resourceFolder:=Get 4D folder:C485(Current resources folder:K5:16; *)

DOCUMENT LIST:C474($Txt_resourceFolder; $tTxt_files; Ignore invisible:K24:16)
SORT ARRAY:C229($tTxt_files)

For ($Lon_i; 1; Size of array:C274($tTxt_files); 1)
	
	$Txt_file:=$tTxt_files{$Lon_i}
	
	If ($Txt_file="@.xlf")
		
		$Txt_path:=$Txt_resourceFolder+$Txt_file
		$Dom_root:=DOM Parse XML source:C719($Txt_path)
		
		If (OK=1)
			
			$Dom_file:=DOM Find XML element:C864($Dom_root; "xliff/file")
			
			If (OK=1)
				
				DOM GET XML ATTRIBUTE BY NAME:C728($Dom_file; "datatype"; $Txt_value)
				
				If ($Txt_value="x-4DK#")
					
					$Lon_id:=$Lon_id+1
					APPEND TO LIST:C376(<>Lst_files; $Txt_file; $Lon_id)
					SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "path"; $Txt_path)
					SET LIST ITEM ICON:C950(<>Lst_files; 0; $Pic_file)
					
				End if 
			End if 
			
			DOM CLOSE XML:C722($Dom_root)
			
		End if 
	End if 
End for 

If (False:C215)  //add the localised files
	ARRAY TEXT:C222($tTxt_folders; 0x0000)
	FOLDER LIST:C473($Txt_resourceFolder; $tTxt_folders)
	
	For ($Lon_i; 1; Size of array:C274($tTxt_folders); 1)
		
		$Txt_folder:=$tTxt_folders{$Lon_i}
		
		If ($Txt_folder="@.lproj")
			
			$Lst_localized:=New list:C375
			
			DOCUMENT LIST:C474($Txt_resourceFolder+$Txt_folder; $tTxt_files; Ignore invisible:K24:16)
			SORT ARRAY:C229($tTxt_files)
			
			For ($Lon_ii; 1; Size of array:C274($tTxt_files); 1)
				
				$Txt_file:=$tTxt_files{$Lon_ii}
				
				If ($Txt_file="@.xlf")
					
					$Txt_path:=$Txt_resourceFolder+$Txt_folder+Folder separator:K24:12+$Txt_file
					$Dom_root:=DOM Parse XML source:C719($Txt_path)
					
					If (OK=1)
						
						$Dom_file:=DOM Find XML element:C864($Dom_root; "xliff/file")
						
						If (OK=1)
							
							DOM GET XML ATTRIBUTE BY NAME:C728($Dom_file; "datatype"; $Txt_value)
							
							If ($Txt_value="x-4DK#")
								
								$Lon_id:=$Lon_id+1
								APPEND TO LIST:C376($Lst_localized; $Txt_file; $Lon_id)
								SET LIST ITEM PARAMETER:C986($Lst_localized; 0; "path"; $Txt_path)
								
							End if 
						End if 
						
						DOM CLOSE XML:C722($Dom_root)
						
					End if 
				End if 
			End for 
			
			If (Count list items:C380($Lst_localized)>0)
				
				$Lon_id:=$Lon_id+1
				APPEND TO LIST:C376(<>Lst_files; Uppercase:C13($Txt_folder); -$Lon_id; $Lst_localized; True:C214)
				SET LIST ITEM PROPERTIES:C386(<>Lst_files; 0; False:C215; Bold:K14:2; 0; 0x007F7F7F)
				SET LIST ITEM ICON:C950(<>Lst_files; 0; $Pic_folder)
				
			Else 
				
				CLEAR LIST:C377($Lst_localized)
				
			End if 
		End if 
	End for 
End if 

// ----------------------------------------------------
// End