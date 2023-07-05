//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Import_from_resources_file
// ID[D2D721720A4847F4962606D5AC71B6C7]
// Created 23/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Create the XLIFF file from the resources '4DK#' found in the file $1
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($0)
C_TEXT:C284($1)
C_TEXT:C284($2)

C_BLOB:C604($Blb_buffer)
C_LONGINT:C283($Lon_constantId; $Lon_i; $Lon_j; $Lon_parameters; $Lon_themeId)
C_TIME:C306($Gmt_resourceFile; $Gmt_tempoResources)
C_TEXT:C284($Dom_constants; $Dom_root; $Txt_buffer; $Txt_groupName; $Txt_resourcesPath; $Txt_target; $Txt_tempoFile)

If (False:C215)
	C_BOOLEAN:C305(Import_from_resources_file; $0)
	C_TEXT:C284(Import_from_resources_file; $1)
	C_TEXT:C284(Import_from_resources_file; $2)
End if 

ARRAY TEXT:C222($tTxt_segments; 0x0000)
ARRAY TEXT:C222($tTxt_str; 0x0000)

// ----------------------------------------------------
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_resourcesPath:=$1
	
	If ($Lon_parameters>=2)
		
		$Txt_target:=Choose:C955($2#"@.xlf"; $2+".xlf"; $2)
		
	Else 
		
		$Txt_target:="User Constants.xlf"
		
	End if 
	
	OK:=Num:C11(Test path name:C476(Folder:C1567("/RESOURCES/"; *).file($Txt_target).platformPath)#Is a document:K24:1)
	
	If (OK=0)
		
		CONFIRM:C162(\
			Replace string:C233(\
			Get localized string:C991("fileExist"); \
			"{fileName}"; \
			$Txt_target)\
			+"\r\r"\
			+Get localized string:C991("DoYouWantToReplaceIt")\
			)
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (OK=1)
	
	If (Asserted:C1132(\
		Test path name:C476($Txt_resourcesPath)=Is a document:K24:1; \
		Replace string:C233(Get localized string:C991("fileNotFound"); "fileName"; $Txt_resourcesPath)\
		))
		
		$Gmt_resourceFile:=Open resource file:C497($Txt_resourcesPath)  //;".rsrc")
		
		If (Asserted:C1132(OK=1; "Error when opening resources file \""+$Txt_resourcesPath+"\""))
			
			$Txt_tempoFile:=doc_Temporary_file("4DPop Constant Editor.rsrc")
			$Gmt_tempoResources:=_O_Create resource file:C496($Txt_tempoFile; ".rsrc")
			
			If (Asserted:C1132(OK=1; "Error when creating temporary resources file \""+$Txt_tempoFile+"\""))
				
				$Dom_root:=CONSTANT_New_file
				
				If (OK=1)
					
					ARRAY LONGINT:C221($tLon_resID; 0x0000)
					ARRAY TEXT:C222($tTxt_resName; 0x0000)
					RESOURCE LIST:C500("4DK#"; $tLon_resID; $tTxt_resName; $Gmt_resourceFile)
					
					For ($Lon_i; 1; Size of array:C274($tLon_resID); 1)
						
						GET RESOURCE:C508("4DK#"; $tLon_resID{$Lon_i}; $Blb_buffer; $Gmt_resourceFile)
						
						//create the theme
						$Lon_themeId:=$Lon_themeId+1
						$Txt_groupName:=Generate UUID:C1066
						$Txt_buffer:=$tTxt_resName{$Lon_i}
						
						CONSTANT_NEW_THEME($Dom_root; "thm_"+String:C10($Lon_themeId); $Txt_groupName; Choose:C955(Length:C16($Txt_buffer)>0; $Txt_buffer; "thm_"+String:C10($Lon_i)))
						
						If (OK=1)
							
							//create the constants' group
							$Dom_constants:=CONSTANT_New_group($Dom_root; $Txt_groupName)
							
							_O_SET RESOURCE:C509("STR#"; 8858; $Blb_buffer; $Gmt_tempoResources)
							SET BLOB SIZE:C606($Blb_buffer; 0)
							
							STRING LIST TO ARRAY:C511(8858; $tTxt_str; $Gmt_tempoResources)
							
							For ($Lon_j; 1; Size of array:C274($tTxt_str); 1)
								
								If (Rgx_SplitText(":"; $tTxt_str{$Lon_j}; ->$tTxt_segments)=0) & (Size of array:C274($tTxt_segments)>=3)
									
									If (string_isNumeric($tTxt_segments{2}))
										
										If ($tTxt_segments{3}="S")  //http://forums.4d.fr/Post/FR/7469568/1/7469569#7469569
											
											$tTxt_segments{2}:=$tTxt_segments{2}+":"+$tTxt_segments{3}
											
										Else 
											
											//we must replace "," by "."
											$tTxt_segments{2}:=String:C10(Num:C11($tTxt_segments{2}); "&xml")
											
										End if 
										
									Else 
										
										If (Size of array:C274($tTxt_segments)=4)  //colon #ACI0080834
											
											$tTxt_segments{2}:="::S"
											
										End if 
									End if 
									
									$Lon_constantId:=$Lon_constantId+1
									CONSTANT_NEW_CONSTANT($Dom_constants; $tTxt_segments{2}; "k_"+String:C10($Lon_constantId); $tTxt_segments{1})
									
								End if 
							End for 
						End if 
					End for 
					
					CLOSE RESOURCE FILE:C498($Gmt_tempoResources)
					DELETE DOCUMENT:C159($Txt_tempoFile)
					
					DOM EXPORT TO FILE:C862($Dom_root; Folder:C1567("/RESOURCES/"; *).file($Txt_target).platformPath)
					DOM CLOSE XML:C722($Dom_root)
					
					$0:=True:C214
					
				End if 
			End if 
		End if 
		
		CLOSE RESOURCE FILE:C498($Gmt_resourceFile)
		
	End if 
End if 

// ----------------------------------------------------
// End