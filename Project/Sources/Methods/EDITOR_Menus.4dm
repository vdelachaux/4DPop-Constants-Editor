//%attributes = {"invisible":true}
// ----------------------------------------------------
// Method :EDITOR_Menus
// Created 26/10/06 by vdl
// ----------------------------------------------------
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_local)
C_TEXT:C284($Mnu_bar; $Mnu_menu; $Mnu_submenu; $Txt_entryPoint)

If (False:C215)
	C_TEXT:C284(EDITOR_Menus; $1)
End if 

If (Count parameters:C259>=1)
	
	$Txt_entryPoint:=$1
	
End if 

Case of 
		
		//_____________________________________________________________________
	: ($Txt_entryPoint="install")
		
		$Boo_local:=Not:C34(Application type:C494=4D Remote mode:K5:5)
		
		//Create menu bar {
		$Mnu_bar:=Create menu:C408
		
		//Create FILE menu {
		$Mnu_menu:=Create menu:C408
		
		//New {
		$Mnu_submenu:=Create menu:C408
		
		APPEND MENU ITEM:C411($Mnu_submenu; Get localized string:C991("newFile"))
		SET MENU ITEM SHORTCUT:C423($Mnu_submenu; -1; "N"; Shift key mask:K16:3)
		SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "menu.new.file")
		mnu_SET_ENABLED($Mnu_menu; -1; $Boo_local)
		
		APPEND MENU ITEM:C411($Mnu_submenu; Get localized string:C991("NewTheme"))
		SET MENU ITEM SHORTCUT:C423($Mnu_submenu; -1; Character code:C91("N"))
		SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "menu.new.theme")
		mnu_SET_ENABLED($Mnu_menu; -1; $Boo_local)
		
		APPEND MENU ITEM:C411($Mnu_submenu; Get localized string:C991("NewConstant"))
		SET MENU ITEM PARAMETER:C1004($Mnu_submenu; -1; "menu.new.constant")
		SET MENU ITEM METHOD:C982($Mnu_submenu; -1; "EDITOR_Menus")
		SET MENU ITEM SHORTCUT:C423($Mnu_submenu; -1; Character code:C91("L"))
		mnu_SET_ENABLED($Mnu_menu; -1; $Boo_local)
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonNew"); $Mnu_submenu)
		//}
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("Import..."))
		SET MENU ITEM SHORTCUT:C423($Mnu_menu; -1; Character code:C91("O"))
		SET MENU ITEM PARAMETER:C1004($Mnu_menu; -1; "menu.import")
		mnu_SET_ENABLED($Mnu_menu; -1; $Boo_local)
		
		APPEND MENU ITEM:C411($Mnu_menu; "(-")
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonSave"))  //Save
		SET MENU ITEM SHORTCUT:C423($Mnu_menu; -1; Character code:C91("S"))
		SET MENU ITEM PARAMETER:C1004($Mnu_menu; -1; "menu.save")
		mnu_SET_ENABLED($Mnu_menu; -1; False:C215)
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonRevert"))  //Revert to Saved
		SET MENU ITEM PARAMETER:C1004($Mnu_menu; -1; "menu.revert")
		mnu_SET_ENABLED($Mnu_menu; -1; False:C215)
		
		APPEND MENU ITEM:C411($Mnu_menu; "(-")
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonClose"))  //Close
		SET MENU ITEM SHORTCUT:C423($Mnu_menu; -1; Character code:C91("W"))
		SET MENU ITEM PARAMETER:C1004($Mnu_menu; -1; "menu.close")
		
		//Install
		APPEND MENU ITEM:C411($Mnu_bar; Get localized string:C991("CommonMenuFile"); $Mnu_menu)
		//}
		
		//Create EDIT menu {
		$Mnu_menu:=Create menu:C408
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonMenuItemUndo"))
		SET MENU ITEM SHORTCUT:C423($Mnu_menu; -1; Character code:C91("Z"))
		SET MENU ITEM PROPERTY:C973($Mnu_menu; -1; Associated standard action:K56:1; _o_Undo action:K59:16)
		
		APPEND MENU ITEM:C411($Mnu_menu; "(-")
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonMenuItemCut"))
		SET MENU ITEM SHORTCUT:C423($Mnu_menu; -1; Character code:C91("X"))
		SET MENU ITEM PROPERTY:C973($Mnu_menu; -1; Associated standard action:K56:1; _o_Cut action:K59:18)
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonMenuItemCopy"))
		SET MENU ITEM SHORTCUT:C423($Mnu_menu; -1; Character code:C91("C"))
		SET MENU ITEM PROPERTY:C973($Mnu_menu; -1; Associated standard action:K56:1; _o_Copy action:K59:19)
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonMenuItemPaste"))
		SET MENU ITEM SHORTCUT:C423($Mnu_menu; -1; Character code:C91("V"))
		SET MENU ITEM PROPERTY:C973($Mnu_menu; -1; Associated standard action:K56:1; _o_Paste action:K59:20)
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonMenuItemClear"))
		SET MENU ITEM PROPERTY:C973($Mnu_menu; -1; Associated standard action:K56:1; _o_Clear action:K59:21)
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonMenuItemSelectAll"))
		SET MENU ITEM SHORTCUT:C423($Mnu_menu; -1; Character code:C91("A"))
		SET MENU ITEM PROPERTY:C973($Mnu_menu; -1; Associated standard action:K56:1; _o_Select all action:K59:22)
		
		APPEND MENU ITEM:C411($Mnu_menu; "(-")
		
		APPEND MENU ITEM:C411($Mnu_menu; Get localized string:C991("CommonMenuItemShowClipboard"))
		SET MENU ITEM PROPERTY:C973($Mnu_menu; -1; Associated standard action:K56:1; _o_Show clipboard action:K59:23)
		
		//Install
		APPEND MENU ITEM:C411($Mnu_bar; Get localized string:C991("CommonMenuEdit"); $Mnu_menu)
		//}
		
		//Install
		SET MENU BAR:C67($Mnu_bar)
		//}
		
		//_____________________________________________________________________
	: ($Txt_entryPoint="release")
		
		$Mnu_bar:=Get menu bar reference:C979(Current process:C322)
		
		If ($Mnu_bar#"")
			
			mnu_RELEASE_MENU($Mnu_bar)
			
		End if 
		
		//_____________________________________________________________________
End case 
