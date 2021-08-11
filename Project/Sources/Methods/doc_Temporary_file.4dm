//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : doc_Temporary_file
// ID[AE65ACFC38784591BBB6F56AAEE9AA30]
// Created 23/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_TEXT:C284($0)
C_TEXT:C284($1)

C_LONGINT:C283($Lon_parameters)
C_TEXT:C284($Txt_fileName; $Txt_tempoPath)

If (False:C215)
	C_TEXT:C284(doc_Temporary_file; $0)
	C_TEXT:C284(doc_Temporary_file; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_fileName:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Txt_tempoPath:=Temporary folder:C486+$Txt_fileName

If (Test path name:C476($Txt_tempoPath)=Is a document:K24:1)
	
	DELETE DOCUMENT:C159($Txt_tempoPath)
	
End if 

$0:=$Txt_tempoPath

// ----------------------------------------------------
// End