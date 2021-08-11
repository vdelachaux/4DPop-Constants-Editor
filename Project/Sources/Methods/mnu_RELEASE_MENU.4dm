//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : MNU_RELEASE_MENU
// Created 21/07/06 by vdl
// ----------------------------------------------------
// Description
// Clears from memory  the menu $1 and all menu called from this one
//----------------------------------------------------
_O_C_STRING:C293(16; $1)

C_LONGINT:C283($Lon_i)

_O_C_STRING:C293(16; $a16_Menu)
$a16_Menu:=$1

//TABLEAU ALPHA(32;$ta32_Labels;0)
//TABLEAU ALPHA(16;$ta16_References;0)
ARRAY TEXT:C222($ta32_Labels; 0)
ARRAY TEXT:C222($ta16_References; 0)

If (Length:C16($a16_Menu)>0)
	GET MENU ITEMS:C977($a16_Menu; $ta32_Labels; $ta16_References)
	For ($Lon_i; 1; Size of array:C274($ta16_References); 1)
		If (Length:C16($ta16_References{$Lon_i})>0)
			MNU_RELEASE_MENU($ta16_References{$Lon_i})  //<-- Recursive
		End if 
	End for 
	RELEASE MENU:C978($a16_Menu)
End if 
