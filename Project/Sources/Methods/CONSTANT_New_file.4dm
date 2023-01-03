//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : CONSTANT_New_file
// ID[E805727E8C624C769AF993CA01DF509F]
// Created 24/01/12 by Vincent de Lachaux
// ----------------------------------------------------
#DECLARE() : Text

If (False:C215)
	C_TEXT:C284(CONSTANT_New_file; $0)
End if 

var $root; $version : Text
var $file; $template : 4D:C1709.File

$template:=File:C1566("/RESOURCES/constants.tmpl")

If ($template.exists)
	
	$file:=File:C1566("/PACKAGE/Info.plist")
	$version:=$file.exists ? String:C10($file.getAppInfo().CFBundleLongVersionString) : "??"
	
	$root:=DOM Parse XML source:C719($template.platformPath)
	
	If (Asserted:C1132(Bool:C1537(OK); "Error while loading the constants template file"))
		
		DOM SET XML ELEMENT VALUE:C868(DOM Find XML element:C864($root; "xliff/file/header/prop-group/prop"); $version)
		
		If (Bool:C1537(OK))
			
			return $root
			
		End if 
	End if 
End if 