//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : Lsth_Select_parent
// ID[CC0DD07D3D074FCA8B340BFB702B49B4]
// Created 20/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
// Returns the reference of the list to which an element belongs
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)
C_LONGINT:C283($1)
C_LONGINT:C283($2)

C_BOOLEAN:C305($Boo_expanded; $Boo_selected)
C_LONGINT:C283($Lon_id; $Lon_parameters; $Lon_selected; $Lon_x; $Lst_main; $Lst_sublist)
C_TEXT:C284($Txt_label)

If (False:C215)
	C_LONGINT:C283(Lsth_Get_list; $0)
	C_LONGINT:C283(Lsth_Get_list; $1)
	C_LONGINT:C283(Lsth_Get_list; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	If ($Lon_parameters>=1)
		
		$Lst_main:=$1
		
		If ($Lon_parameters>=2)
			
			$Boo_selected:=True:C214
			$Lon_selected:=$2
			
		End if 
		
	Else 
		
		$Lst_main:=OBJECT Get pointer:C1124(Object current:K67:2)->
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
If ($Boo_selected)
	
	GET LIST ITEM:C378($Lst_main; $Lon_selected; $Lon_id; $Txt_label; $Lst_sublist; $Boo_expanded)
	
Else 
	
	GET LIST ITEM:C378($Lst_main; *; $Lon_id; $Txt_label; $Lst_sublist; $Boo_expanded)
	
End if 

If (Not:C34(Is a list:C621($Lst_sublist)))
	
	$Lon_id:=List item parent:C633($Lst_main; $Lon_id)
	$Lon_x:=List item position:C629($Lst_main; $Lon_id)
	
	GET LIST ITEM:C378($Lst_main; $Lon_x; $Lon_id; $Txt_label; $Lst_sublist; $Boo_expanded)
	
End if 

$0:=$Lst_sublist

// ----------------------------------------------------
// End