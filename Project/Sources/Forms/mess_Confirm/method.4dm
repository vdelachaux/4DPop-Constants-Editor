// ----------------------------------------------------
// Method : Méthode formulaire : mess_Confirm
// Created 09/08/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------
C_BOOLEAN:C305($Boo_Escape)
C_LONGINT:C283($Lon_; $Lon_Bottom; $Lon_Bottom_2; $Lon_Height; $Lon_Left; $Lon_New_Left; $Lon_Offset; $Lon_OS; $Lon_Right; $Lon_Top)
C_LONGINT:C283($Lon_Top_2; $Lon_Width)
C_TEXT:C284($Txt_Buffer; $Txt_Filter)

GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "main_message"; mess_Message_1)
GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "second_message"; mess_Message_2)

GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "yes_label"; $Txt_Buffer)
OBJECT SET TITLE:C194(OK; $Txt_Buffer)
GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "no_label"; $Txt_Buffer)
OBJECT SET TITLE:C194(bDone; $Txt_Buffer)

GET LIST ITEM PARAMETER:C985(mess_Parameter_List; 1; "bEscape"; $Boo_Escape)
OBJECT SET VISIBLE:C603(bEscape; $Boo_Escape)

//$Lon_OS:=3*Num(Macintosh option enfoncee & Majuscule enfoncee)  `Test VISTA
//Si ($Lon_OS=0)
//$Lon_OS:=2*Num(Macintosh option enfoncee)  `Test XP
//Si ($Lon_OS=0)
$Lon_OS:=Num:C11(Lon_Platform#Windows:K25:3)  //Mac OS
If ($Lon_OS=0)
	$Lon_OS:=2+Num:C11((Lon_System%256)>=6)  //XP | VISTA
End if 
//Fin de si 
//Fin de si 

FORM GOTO PAGE:C247($Lon_OS)

Case of 
		//…………………………………
	: ($Lon_OS=1)
		//…………………………………
	: ($Lon_OS=2)
		//…………………………………
	: ($Lon_OS=3)
		If (Not:C34($Boo_Escape))
			// Modified by Vincent de Lachaux (24/11/08)
			// Scott MOXHAM bug report
			// http://forums.4d.fr/Post/FR/2271200/1/2271201#2271201
			//{
			//LIRE RECT OBJET(*;"3.Button.bEscape";$Lon_;$Lon_;$Lon_Left;$Lon_)
			OBJECT GET COORDINATES:C663(*; "3.Button.Escape"; $Lon_; $Lon_; $Lon_Left; $Lon_)
			//}
			OBJECT GET COORDINATES:C663(*; "3.Button.No"; $Lon_; $Lon_; $Lon_New_Left; $Lon_)
			$Lon_Offset:=$Lon_Left-$Lon_New_Left
			OBJECT MOVE:C664(*; "3.Button.@"; $Lon_Offset; 0)
		End if 
		//…………………………………
End case 

OBJECT GET COORDINATES:C663(*; String:C10($Lon_OS)+".Message.1"; $Lon_Left; $Lon_Top; $Lon_Right; $Lon_Bottom)
$Lon_Width:=$Lon_Right-$Lon_Left
OBJECT GET COORDINATES:C663(*; String:C10($Lon_OS)+".Message.2"; $Lon_; $Lon_; $Lon_Top_2; $Lon_Bottom_2)

If (Length:C16(mess_Message_2)=0)
	$Lon_Offset:=$Lon_Bottom_2-$Lon_Bottom
	OBJECT MOVE:C664(*; String:C10($Lon_OS)+".Message.1"; 0; 0; 0; $Lon_Offset)
Else 
	OBJECT GET BEST SIZE:C717(*; String:C10($Lon_OS)+".Message.1"; $Lon_Width; $Lon_Height; $Lon_Width)
	$Lon_Offset:=$Lon_Height-($Lon_Bottom-$Lon_Top)
	OBJECT MOVE:C664(*; String:C10($Lon_OS)+".Message.1"; 0; 0; 0; $Lon_Offset)
	OBJECT MOVE:C664(*; String:C10($Lon_OS)+".Message.2"; 0; $Lon_Offset; 0; -$Lon_Offset)
End if 
