//%attributes = {"invisible":true}
var mess_Request_Input : Text
var bEscape; bDone : Integer

var mess_Message_1; mess_Message_2 : Text
var mess_Parameter_List : Integer
var Lon_Platform; Lon_System : Integer

If (False:C215)
	_O_C_LONGINT:C283(mess_Confirm; $0)
	_O_C_TEXT:C284(mess_Confirm; $1)
	_O_C_TEXT:C284(mess_Confirm; $2)
	_O_C_TEXT:C284(mess_Confirm; $3)
	_O_C_LONGINT:C283(mess_Confirm; $4)
	
	_O_C_TEXT:C284(mess_gTxt_Request; $0)
	_O_C_TEXT:C284(mess_gTxt_Request; $1)
	_O_C_TEXT:C284(mess_gTxt_Request; $2)
	_O_C_TEXT:C284(mess_gTxt_Request; $3)
	_O_C_TEXT:C284(mess_gTxt_Request; $4)
	_O_C_TEXT:C284(mess_gTxt_Request; $5)
	_O_C_TEXT:C284(mess_gTxt_Request; $6)
	_O_C_LONGINT:C283(mess_gTxt_Request; $7)
	
End if 