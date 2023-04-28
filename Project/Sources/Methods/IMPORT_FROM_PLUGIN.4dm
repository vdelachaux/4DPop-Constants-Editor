//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : IMPORT_FROM_PLUGIN
// ID[8F216181DE1B4128A02777E22C243B9D]
// Created 23/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Create the XLIFF file from the plugin "User Constants.bundle"
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_OK)
C_LONGINT:C283($Lon_parameters)
C_TIME:C306($Gmt_resourceFile)
C_TEXT:C284($Txt_pluginPath; $Txt_resourcesPath; $Txt_targetPath)

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		//______________________________________________________
	: (Structure file:C489=Structure file:C489(*))
		
		//______________________________________________________
	: (Application type:C494=4D Remote mode:K5:5)
		
		//______________________________________________________
	Else 
		
		//Get the Plugins folder path
		$Txt_pluginPath:=Folder:C1567(fk database folder:K87:14; *).folder("Plugins/User Constants.bundle").platformPath
		
		If (Test path name:C476($Txt_pluginPath)=Is a folder:K24:2)
			
			$Txt_resourcesPath:=$Txt_pluginPath+"Contents"+Folder separator:K24:12+"Resources"+Folder separator:K24:12+"User Constants.rsrc"
			
			$Gmt_resourceFile:=Open resource file:C497($Txt_resourcesPath; ".rsrc")
			
			If (OK=1)
				
				ARRAY LONGINT:C221($tLon_resID; 0x0000)
				ARRAY TEXT:C222($tTxt_resName; 0x0000)
				
				RESOURCE LIST:C500("4DK#"; $tLon_resID; $tTxt_resName; $Gmt_resourceFile)
				CLOSE RESOURCE FILE:C498($Gmt_resourceFile)
				
				If (Size of array:C274($tLon_resID)>0)
					
					CONFIRM:C162(Get localized string:C991("DoYouWantToConvert"))
					
					$Boo_OK:=(OK=1)
					
					If ($Boo_OK)
						
						$Boo_OK:=Import_from_resources_file($Txt_resourcesPath; "User Constants.xlf")
						
					End if 
					
					If ($Boo_OK)
						
						$Txt_targetPath:=Folder:C1567(fk database folder:K87:14; *).folder("Plugins (inactivated)").platformPath
						
						If (Test path name:C476($Txt_targetPath)#Is a folder:K24:2)
							
							CREATE FOLDER:C475($Txt_targetPath; *)
							
						End if 
						
						COPY DOCUMENT:C541($Txt_pluginPath; $Txt_targetPath; *)
						
						doc_Delete_folder($Txt_pluginPath)
						
						If (mess_Confirm("¿"+Get localized string:C991("ConstantsLastStep_2"); Get localized string:C991("YesButton"); Get localized string:C991("NoButton"))=1)
							
							OPEN DATA FILE:C312(Data file:C490)
							
						End if 
					End if 
				End if 
			End if 
		End if 
		
		//______________________________________________________
End case 

// ----------------------------------------------------
// End

