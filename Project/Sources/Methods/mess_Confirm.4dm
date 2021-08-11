//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : mess_gLon_Confirm
// Created 02/11/06 by vdl
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_LONGINT:C283($4)

C_BOOLEAN:C305($Boo_Escape)
C_LONGINT:C283($Lon_Bottom; $Lon_Height; $Lon_Left; $Lon_Options; $Lon_Right; $Lon_Top; $Lon_Width; $Lon_Window; $Lon_Window_Reference; $Lon_x)
C_TEXT:C284($Txt_message; $Txt_No; $Txt_Yes)

If (False:C215)
	C_LONGINT:C283(mess_Confirm; $0)
	C_TEXT:C284(mess_Confirm; $1)
	C_TEXT:C284(mess_Confirm; $2)
	C_TEXT:C284(mess_Confirm; $3)
	C_LONGINT:C283(mess_Confirm; $4)
End if 

If (Count parameters:C259>=1)
	$Txt_message:=$1
	If (Count parameters:C259>=2)
		$Txt_Yes:=$2
		If (Count parameters:C259>=3)
			$Txt_No:=$3
			If (Count parameters:C259>=4)
				$Lon_Options:=$4
			End if 
		End if 
	End if 
End if 

$Boo_Escape:=True:C214

If ($Txt_message="")
	$Txt_message:=Get localized string:C991("AreYouSure")
Else 
	If ($Txt_message[[1]]="¿")  //Pas de bouton annuler
		$Txt_message:=Substring:C12($Txt_message; 2)
		$Boo_Escape:=False:C215
	End if 
End if 

If ($Txt_Yes="")
	$Txt_Yes:=Get localized string:C991("YesButton")
End if 

If ($Txt_No="")
	$Txt_No:=Get localized string:C991("NoButton")
End if 

mess_Message_1:=""
mess_Message_2:=""

mess_Parameter_List:=New list:C375
APPEND TO LIST:C376(mess_Parameter_List; "param"; 1)

$Lon_x:=Position:C15("\\"; $Txt_message)
If ($Lon_x>0)
	SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "main_message"; Substring:C12($Txt_message; 1; $Lon_x-1))
	SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "second_message"; Substring:C12($Txt_message; $Lon_x+1))
Else 
	SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "main_message"; $Txt_message)
End if 
SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "yes_label"; $Txt_Yes)
SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "no_label"; $Txt_No)
SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "bEscape"; $Boo_Escape)

_O_PLATFORM PROPERTIES:C365(Lon_Platform; Lon_System)

If (Lon_Platform=Windows:K25:3) | ($Lon_Options ?? 0)
	FORM GET PROPERTIES:C674("mess_Confirm"; $Lon_Width; $Lon_Height)
	GET WINDOW RECT:C443($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; Frontmost window:C447)
	$Lon_Left:=($Lon_Left+(($Lon_Right-$Lon_Left)/2))-($Lon_Width/2)
	$Lon_Right:=$Lon_Left+$Lon_Width
	$Lon_Top:=$Lon_Top+(($Lon_Bottom-$Lon_Top)/3)
	$Lon_Bottom:=$Lon_Top+$Lon_Height
	$Lon_Window:=Open window:C153($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; Movable dialog box:K34:7)
Else 
	$Lon_Window:=Open form window:C675("mess_Confirm"; Sheet form window:K39:12)
End if 

DIALOG:C40("mess_Confirm")
CLOSE WINDOW:C154

Case of 
		//______________________________________________________
	: (OK=1)  //Valider
		$0:=1
		//______________________________________________________
	: (bDone=1)  //Ne pas valider
		$0:=0
		//______________________________________________________
	: (bEscape=1)  //Annulation
		$0:=-1
		//______________________________________________________
End case 

CLEAR LIST:C377(mess_Parameter_List)
