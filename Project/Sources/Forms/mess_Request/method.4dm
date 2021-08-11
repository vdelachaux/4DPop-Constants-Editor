// ----------------------------------------------------
// Method : Méthode formulaire : mess_Request
// Created 09/08/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_LONGINT:C283($Lon_OS)
C_TEXT:C284($Txt_Cancel; $Txt_Filter; $Txt_Font; $Txt_OK)

GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "main_message"; mess_Message_1)
GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "second_message"; mess_Message_2)

GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "ok_label"; $Txt_OK)
If (Length:C16($Txt_OK)>0)
	OBJECT SET TITLE:C194(*; "Button_Yes"; $Txt_OK)
End if 

GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "cancel_label"; $Txt_Cancel)
If (Length:C16($Txt_Cancel)>0)
	OBJECT SET TITLE:C194(*; "Bouton_Escape"; $Txt_Cancel)
End if 

GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "filter"; $Txt_Filter)
If (Length:C16($Txt_Filter)>0)
	OBJECT SET FILTER:C235(mess_Request_Input; $Txt_Filter)
End if 

GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "font"; $Txt_Font)
If (Length:C16($Txt_Font)>0)
	OBJECT SET FONT:C164(mess_Request_Input; $Txt_Font)
End if 

$Lon_OS:=3*Num:C11(Macintosh option down:C545 & Shift down:C543)  //Test VISTA
If ($Lon_OS=0)
	$Lon_OS:=2*Num:C11(Macintosh option down:C545)  //Test XP
	If ($Lon_OS=0)
		$Lon_OS:=Num:C11(Lon_Platform#Windows:K25:3)  //Mac OS
		If ($Lon_OS=0)
			$Lon_OS:=2+Num:C11((Lon_System%256)>=6)  //XP | VISTA
		End if 
	End if 
End if 

FORM GOTO PAGE:C247($Lon_OS)

