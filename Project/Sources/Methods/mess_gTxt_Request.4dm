//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : mess_gTxt_Request
// Created 15/11/06 by vdl
// ----------------------------------------------------
// Description
// Displays a request dialog box composed of a message, a text input area, an OK button, and a Cancel Button
// ----------------------------------------------------
C_TEXT:C284($0)
C_TEXT:C284($1)
C_TEXT:C284($2)
C_TEXT:C284($3)
C_TEXT:C284($4)
C_TEXT:C284($5)
C_TEXT:C284($6)
C_LONGINT:C283($7)

C_LONGINT:C283($Lon_Bottom; $Lon_Height; $Lon_Left; $Lon_Options; $Lon_Parameters; $Lon_Right; $Lon_Top; $Lon_Width; $Lon_Window; $Lon_x)

If (False:C215)
	C_TEXT:C284(mess_gTxt_Request; $0)
	C_TEXT:C284(mess_gTxt_Request; $1)
	C_TEXT:C284(mess_gTxt_Request; $2)
	C_TEXT:C284(mess_gTxt_Request; $3)
	C_TEXT:C284(mess_gTxt_Request; $4)
	C_TEXT:C284(mess_gTxt_Request; $5)
	C_TEXT:C284(mess_gTxt_Request; $6)
	C_LONGINT:C283(mess_gTxt_Request; $7)
End if 

$Lon_Parameters:=Count parameters:C259

mess_Request_Input:=""
mess_Message_1:=""
mess_Message_2:=""

mess_Parameter_List:=New list:C375
APPEND TO LIST:C376(mess_Parameter_List; "param"; 1)

If ($Lon_Parameters>=1)
	$Lon_x:=Position:C15("\\"; $1)
	If ($Lon_x>0)
		SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "main_message"; Substring:C12($1; 1; $Lon_x-1))
		SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "second_message"; Substring:C12($1; $Lon_x+1))
	Else 
		SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "main_message"; $1)
	End if 
	If ($Lon_Parameters>=2)
		SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "default"; $2)
		If ($Lon_Parameters>=3)
			SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "ok_label"; $3)
			If ($Lon_Parameters>=4)
				SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "cancel_label"; $4)
				If ($Lon_Parameters>=5)
					SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "font"; $5)
					If ($Lon_Parameters>=6)
						SET LIST ITEM PARAMETER:C986(mess_Parameter_List; 1; "filter"; $6)
						If ($Lon_Parameters>=7)
							$Lon_Options:=$7
						End if 
					End if 
				End if 
			End if 
		End if 
	End if 
End if 

_O_PLATFORM PROPERTIES:C365(Lon_Platform; Lon_System)

If (Lon_Platform=Windows:K25:3) | ($Lon_Options ?? 0)
	FORM GET PROPERTIES:C674("mess_Request"; $Lon_Width; $Lon_Height)
	GET WINDOW RECT:C443($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; Frontmost window:C447)
	$Lon_Left:=($Lon_Left+(($Lon_Right-$Lon_Left)/2))-($Lon_Width/2)
	$Lon_Right:=$Lon_Left+$Lon_Width
	$Lon_Top:=$Lon_Top+(($Lon_Bottom-$Lon_Top)/3)
	$Lon_Bottom:=$Lon_Top+$Lon_Height
	$Lon_Window:=Open window:C153($Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom; Movable dialog box:K34:7)
Else 
	$Lon_Window:=Open form window:C675("mess_Request"; Sheet form window:K39:12)
End if 

DIALOG:C40("mess_Request")
CLOSE WINDOW:C154

CLEAR LIST:C377(mess_Parameter_List)

$0:=mess_Request_Input*Num:C11(OK=1)
