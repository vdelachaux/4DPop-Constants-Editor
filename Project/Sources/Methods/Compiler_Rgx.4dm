//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method : Compliler_Rgx
// Created 01/10/07 by Vincent de Lachaux
// ----------------------------------------------------
// Description
// 
// ----------------------------------------------------

C_LONGINT:C283(rgx_Lon_Error)

If (False:C215)
	
	C_LONGINT:C283(Rgx_ExtractText; $0)
	C_TEXT:C284(Rgx_ExtractText; $1)
	C_TEXT:C284(Rgx_ExtractText; $2)
	C_TEXT:C284(Rgx_ExtractText; $3)
	C_POINTER:C301(Rgx_ExtractText; $4)
	C_LONGINT:C283(Rgx_ExtractText; $5)
	
	C_TEXT:C284(rgx_Get_Pattern; $0)
	C_TEXT:C284(rgx_Get_Pattern; $1)
	C_TEXT:C284(rgx_Get_Pattern; $2)
	C_POINTER:C301(rgx_Get_Pattern; $3)
	
	C_LONGINT:C283(Rgx_MatchText; $0)
	C_TEXT:C284(Rgx_MatchText; $1)
	C_TEXT:C284(Rgx_MatchText; $2)
	C_POINTER:C301(Rgx_MatchText; $3)
	C_LONGINT:C283(Rgx_MatchText; $4)
	
	C_LONGINT:C283(Rgx_SplitText; $0)
	C_TEXT:C284(Rgx_SplitText; $1)
	C_TEXT:C284(Rgx_SplitText; $2)
	C_POINTER:C301(Rgx_SplitText; $3)
	C_LONGINT:C283(Rgx_SplitText; $4)
	
	C_LONGINT:C283(Rgx_SubstituteText; $0)
	C_TEXT:C284(Rgx_SubstituteText; $1)
	C_TEXT:C284(Rgx_SubstituteText; $2)
	C_POINTER:C301(Rgx_SubstituteText; $3)
	C_LONGINT:C283(Rgx_SubstituteText; $4)
	
	
	//Private ----------------------------
	C_TEXT:C284(rgx_Options; $0)
	C_LONGINT:C283(rgx_Options; $1)
	
End if 
