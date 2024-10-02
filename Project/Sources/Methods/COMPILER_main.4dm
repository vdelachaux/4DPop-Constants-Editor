//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : COMPILER_main
// ID[6A6D35C6C6E14995B8248A3DB25AB98C]
// ----------------------------------------------------
// Declarations
var <>Lst_files : Integer
var <>Lst_constants : Integer
var <>Lon_timerEvent : Integer

// ----------------------------------------------------
// Initialisations

// ----------------------------------------------------
If (False:C215)
	_O_C_TEXT:C284(CONSTANT_NEW_CONSTANT; $1)
	_O_C_TEXT:C284(CONSTANT_NEW_CONSTANT; $2)
	_O_C_TEXT:C284(CONSTANT_NEW_CONSTANT; $3)
	_O_C_TEXT:C284(CONSTANT_NEW_CONSTANT; $4)
	
	_O_C_TEXT:C284(CONSTANT_New_file; $0)
	
	_O_C_TEXT:C284(CONSTANT_New_group; $0)
	_O_C_TEXT:C284(CONSTANT_New_group; $1)
	_O_C_TEXT:C284(CONSTANT_New_group; $2)
	
	_O_C_TEXT:C284(CONSTANT_NEW_THEME; $1)
	_O_C_TEXT:C284(CONSTANT_NEW_THEME; $2)
	_O_C_TEXT:C284(CONSTANT_NEW_THEME; $3)
	_O_C_TEXT:C284(CONSTANT_NEW_THEME; $4)
	
	_O_C_TEXT:C284(EDITOR_handler; $1)
	
	_O_C_BOOLEAN:C305(CONSTANT_Save_file; $0)
	_O_C_LONGINT:C283(CONSTANT_Save_file; $1)
	_O_C_TEXT:C284(CONSTANT_Save_file; $2)
End if 

If (False:C215)
	_O_C_TEXT:C284(EDITOR_Menus; $1)
	
	_O_C_LONGINT:C283(EDITOR_Parse_file; $0)
	_O_C_TEXT:C284(EDITOR_Parse_file; $1)
	_O_C_POINTER:C301(EDITOR_Parse_file; $2)
	
	_O_C_BOOLEAN:C305(EDITOR_Save; $0)
	_O_C_LONGINT:C283(EDITOR_Save; $1)
	
	_O_C_BOOLEAN:C305(Import_from_resources_file; $0)
	_O_C_TEXT:C284(Import_from_resources_file; $1)
	_O_C_TEXT:C284(Import_from_resources_file; $2)
End if 

// ----------------------------------------------------

// End