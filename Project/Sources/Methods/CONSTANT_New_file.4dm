//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONSTANT_New_file
// ID[E805727E8C624C769AF993CA01DF509F]
// Created 24/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Dom_root; $kTxt_path; $kTxt_version; $Txt_build; $Txt_version)

ARRAY TEXT:C222($tTxt_buffer; 0)

If (False:C215)
	C_TEXT:C284(CONSTANT_New_file; $0)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	$kTxt_version:="13.0"
	
	COMPONENT LIST:C1001($tTxt_buffer)
	
	If (Find in array:C230($tTxt_buffer; "4DPop AppMaker")>0)
		
		EXECUTE METHOD:C1007("_o_AppMaker_Get_infoPlistKey"; $Txt_version; "CFBundleShortVersionString"; Get 4D folder:C485(Database folder:K5:14)+"Info.plist")
		EXECUTE METHOD:C1007("_o_AppMaker_Get_infoPlistKey"; $Txt_build; "CFBundleVersion"; Get 4D folder:C485(Database folder:K5:14)+"Info.plist")
		
		$kTxt_version:=$Txt_version+" ("+$Txt_build+")"
		
	End if 
	
	$kTxt_path:=Get 4D folder:C485(Current resources folder:K5:16)+"constants.tmpl"
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If (Test path name:C476($kTxt_path)=Is a document:K24:1)
	
	$Dom_root:=DOM Parse XML source:C719($kTxt_path)
	
	If (Asserted:C1132(OK=1; "Error when creating a DOM tree"))
		
		DOM SET XML ELEMENT VALUE:C868(DOM Find XML element:C864($Dom_root; "xliff/file/header/prop-group/prop"); $kTxt_version)
		
		If (OK=1)
			
			$0:=$Dom_root
			
		End if 
	End if 
End if 

// ----------------------------------------------------
// End