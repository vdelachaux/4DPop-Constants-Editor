//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : LSTH_RESTORE_STATE
// ID[A56AA1A511A540C58110C859E8868F0D]
// Created 20/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Restore the state expanded of each element
// (previously stored with LSTH_STORE_STATE)
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($1)

C_BOOLEAN:C305($Boo_expanded)
C_LONGINT:C283($Lon_i; $Lon_id; $Lon_parameters; $Lst_buffer; $Lst_main)
C_TEXT:C284($Txt_label)

If (False:C215)
	C_LONGINT:C283(Lsth_RESTORE_STATE; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Lst_main:=$1
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
For ($Lon_i; Count list items:C380($Lst_main; *); 1; -1)
	
	GET LIST ITEM:C378($Lst_main; $Lon_i; $Lon_id; $Txt_label; $Lst_buffer; $Boo_expanded)
	
	If (Is a list:C621($Lst_buffer))
		
		GET LIST ITEM PARAMETER:C985($Lst_main; $Lon_id; "expanded"; $Boo_expanded)
		SET LIST ITEM:C385($Lst_main; $Lon_id; $Txt_label; $Lon_id; $Lst_buffer; $Boo_expanded)
		
	End if 
	
End for 

// ----------------------------------------------------
// End