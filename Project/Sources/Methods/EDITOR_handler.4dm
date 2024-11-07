//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_handler
// ID[7ADDE0F8E47343EE8336535D0B6E860F]
// Created 03/10/07 by Vincent de Lachaux
// ----------------------------------------------------
// Modified by vdl (20/05/08)
// 1.2 Lock in CS mode
// ----------------------------------------------------
// Modified by Vincent de Lachaux (23/01/12)
// v13
// ----------------------------------------------------
// Description:
// Main method of the component
// ----------------------------------------------------
// Declarations
C_TEXT:C284($1)

C_BOOLEAN:C305($Boo_expanded; $Boo_OK)
C_LONGINT:C283($Lon_action; $Lon_currentFile; $Lon_parameters; $Lon_uid; $Lon_Window; $Lon_x; $Lst_buffer; $Lst_constant)
var $Lon_constantIndex; $tLon_itemRef : Integer
C_PICTURE:C286($Pic_file)
C_TEXT:C284($Txt_entryPoint; $Txt_fileName; $Txt_Message; $Txt_name; $Txt_path)

If (False:C215)
	C_TEXT:C284(EDITOR_handler; $1)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=0; "Missing parameter"))
	
	//NO PARAMETERS REQUIRED
	
	If ($Lon_parameters>=1)
		
		$Txt_entryPoint:=$1
		
	End if 
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: (Length:C16($Txt_entryPoint)=0)
		
		Case of 
				//..................................................................................
			: (Method called on error:C704=Current method name:C684)
				
				//No Error
				
				//..................................................................................
			Else 
				
				//Get the editor
				BRING TO FRONT:C326(New process:C317(Current method name:C684; 0; "$4DPop Constant Editor"; "Run"; *))
				
				//..................................................................................
		End case 
		
		//______________________________________________________
	: ($Txt_entryPoint="Run")
		
		COMPILER_main
		
		EDITOR_Menus("install")
		
		$Lon_Window:=Open form window:C675(\
			"Editor"; \
			Plain form window:K39:10\
			+_o_Compositing mode form window:K39:13\
			+_o_Has toolbar button Mac:K34:19; \
			Horizontally centered:K39:1; \
			Vertically centered:K39:4; *)
		
		RECOVER_WINDOW
		
		DIALOG:C40("Editor")
		CLOSE WINDOW:C154
		
		EDITOR_Menus("release")
		
		//______________________________________________________
	: ($Txt_entryPoint="menu.save")
		
		$Lon_currentFile:=Selected list items:C379(<>Lst_files; *)
		
		GET LIST ITEM:C378(<>Lst_files; \
			List item position:C629(<>Lst_files; $Lon_currentFile); \
			$Lon_currentFile; \
			$Txt_fileName)
		
		$Boo_OK:=CONSTANT_Save_file(<>Lst_constants; $Txt_fileName)
		SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_currentFile; "needToRestart"; $Boo_OK)
		SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_currentFile; "modified"; Not:C34($Boo_OK))
		
		//______________________________________________________
	: ($Txt_entryPoint="menu.close")
		
		If (EDITOR_Save)
			
			CANCEL:C270
			
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="menu.new.file")
		
		$Boo_OK:=EDITOR_Save
		
		If ($Boo_OK)
			
			$Txt_fileName:=Request:C163(Get localized string:C991("fileName"))
			$Boo_OK:=((OK=1) & (Length:C16($Txt_fileName)>0))
			
			If ($Boo_OK)
				
				$Txt_fileName:=Choose:C955($Txt_fileName="@.xlf"; $Txt_fileName; $Txt_fileName+".xlf")
				$Txt_path:=Folder:C1567("/RESOURCES/"; *).file($Txt_fileName).platformPath
				//$Txt_path:=4DPop_hostDatabaseFolder(kResources)+$Txt_fileName
				$Boo_OK:=(Test path name:C476($Txt_path)#Is a document:K24:1)
				
				If (Not:C34($Boo_OK))
					
					$Txt_Message:=Replace string:C233(Get localized string:C991("fileExist"); "{fileName}"; $Txt_fileName)
					
				End if 
			End if 
		End if 
		
		If ($Boo_OK)
			
			Repeat 
				
				$Lon_uid:=$Lon_uid+1
				$Lon_x:=List item position:C629(<>Lst_files; $Lon_uid)
				
			Until ($Lon_x=0)
			
			APPEND TO LIST:C376(<>Lst_files; $Txt_fileName; $Lon_uid)
			SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "path"; $Txt_path)
			READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"file.png"; $Pic_file)
			CREATE THUMBNAIL:C679($Pic_file; $Pic_file; 16)
			SET LIST ITEM ICON:C950(<>Lst_files; 0; $Pic_file)
			
			SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_uid; "list"; New list:C375)
			
			SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_files; $Lon_uid)
			
			form_Timer(-2)
			
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="menu.import")
		
		$Boo_OK:=EDITOR_Save
		
		If ($Boo_OK)
			
			$Txt_name:=Select document:C905(""; "*"; ""; Package open:K24:8+Use sheet window:K24:11)
			$Boo_OK:=(OK=1)
			
			If ($Boo_OK)
				
				$Txt_fileName:=Request:C163(Get localized string:C991("fileName"); ".xlf")
				$Boo_OK:=((OK=1) & (Length:C16($Txt_fileName)>0))
				
				If ($Boo_OK)
					
					$Txt_fileName:=Choose:C955($Txt_fileName="@.xlf"; $Txt_fileName; $Txt_fileName+".xlf")
					
					$Boo_OK:=Import_from_resources_file(DOCUMENT; $Txt_fileName)
					
				End if 
			End if 
		End if 
		
		If ($Boo_OK)
			
			If (mess_Confirm("¿"+Get localized string:C991("ConstantsLastStep_2"); Get localized string:C991("YesButton"); Get localized string:C991("NoButton"))=1)
				
				OPEN DATA FILE:C312(Data file:C490)
				
			Else 
				
				Repeat 
					
					$Lon_uid:=$Lon_uid+1
					$Lon_x:=List item position:C629(<>Lst_files; $Lon_uid)
					
				Until ($Lon_x=0)
				
				APPEND TO LIST:C376(<>Lst_files; $Txt_fileName; $Lon_uid)
				SET LIST ITEM PARAMETER:C986(<>Lst_files; 0; "path"; $Txt_path)
				READ PICTURE FILE:C678(Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12+"file.png"; $Pic_file)
				CREATE THUMBNAIL:C679($Pic_file; $Pic_file; 16)
				SET LIST ITEM ICON:C950(<>Lst_files; 0; $Pic_file)
				
				SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_uid; "list"; New list:C375)
				
				SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_files; $Lon_uid)
				
				form_Timer(-2)
				
			End if 
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="menu.new.theme")
		
		$Lon_uid:=obj_pointer("UID")->+1
		
		$Lst_constant:=New list:C375
		Form:C1466.lastThemeIndex:=Num:C11(Form:C1466.lastThemeIndex)+1
		
		$Txt_name:=Get localized string:C991("NewTheme")
		APPEND TO LIST:C376(<>Lst_constants; $Txt_name; -$Lon_uid; $Lst_constant; True:C214)
		SET LIST ITEM PROPERTIES:C386(<>Lst_constants; 0; False:C215; Bold:K14:2; 0; 0x00ABABAB)
		SET LIST ITEM PARAMETER:C986(<>Lst_constants; 0; "index"; Form:C1466.lastThemeIndex)
		
		SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "modified"; True:C214)
		
		SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_constants; -$Lon_uid)
		
		obj_pointer("UID")->:=$Lon_uid
		form_Timer(1)
		
		GOTO OBJECT:C206(*; "name.group.item.box")
		
		//______________________________________________________
	: ($Txt_entryPoint="menu.new.constant")
		
		$Lst_constant:=Lsth_Get_list(<>Lst_constants)
		GET LIST ITEM:C378(<>Lst_constants; *; $tLon_itemRef; $Txt_name)
		GET LIST ITEM PARAMETER:C985(<>Lst_constants; $tLon_itemRef; "nextConstantIndex"; $Lon_constantIndex)
		SET LIST ITEM PARAMETER:C986(<>Lst_constants; $tLon_itemRef; "nextConstantIndex"; $Lon_constantIndex+1)
		
		$Lon_uid:=obj_pointer("UID")->+1
		
		$Txt_name:=Replace string:C233(Get localized string:C991("ConstantNumber"); "{ID}"; String:C10($Lon_uid))
		APPEND TO LIST:C376($Lst_constant; $Txt_name; $Lon_uid)
		SET LIST ITEM PARAMETER:C986($Lst_constant; 0; "type"; "S")
		SET LIST ITEM PARAMETER:C986($Lst_constant; 0; "index"; $Lon_constantIndex)
		
		SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "modified"; True:C214)
		
		SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_constants; $Lon_uid)
		
		obj_pointer("UID")->:=$Lon_uid
		form_Timer(1)
		
		GOTO OBJECT:C206(*; "name.group.item.box")
		
		//______________________________________________________
	: ($Txt_entryPoint="menu.revert")
		
		If (mess_Confirm("¿"+Get localized string:C991("RevertConfirmation"))=1)
			
			$Lon_uid:=obj_pointer("currentFile")->
			SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_currentFile; "modified"; False:C215)
			GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_uid; "list"; $Lst_buffer)
			CLEAR LIST:C377($Lst_buffer; *)
			
			<>Lst_constants:=New list:C375
			
			Obj_spinner(True:C214)
			form_Timer(-3)
			
		End if 
		
		//______________________________________________________
	: ($Txt_entryPoint="delete")
		
		$Lon_x:=Selected list items:C379(<>Lst_constants)
		
		GET LIST ITEM:C378(<>Lst_constants; \
			$Lon_x; \
			$Lon_uid; \
			$Txt_name; \
			$Lst_buffer; \
			$Boo_expanded)
		
		If (Is a list:C621($Lst_buffer))
			
			$Lon_action:=mess_Confirm("¿"+Replace string:C233(Get localized string:C991("AreYouSureToWantToDeleteTheTopic"); "{Name}"; $Txt_name); \
				Get localized string:C991("Delete"))
			
		Else 
			
			$Lon_action:=mess_Confirm("¿"+Replace string:C233(Get localized string:C991("AreYouSureToWantToDeleteTheConstant"); "{Name}"; $Txt_name); \
				Get localized string:C991("Delete"))
			
		End if 
		
		If ($Lon_action=1)
			
			If (Is a list:C621($Lst_buffer))
				
				CLEAR LIST:C377($Lst_buffer)
				
			End if 
			
			DELETE FROM LIST:C624(<>Lst_constants; $Lon_uid)
			
			$Lon_x:=Choose:C955($Lon_x>Count list items:C380(<>Lst_constants); Count list items:C380(<>Lst_constants); $Lon_x)
			SELECT LIST ITEMS BY POSITION:C381(<>Lst_constants; $Lon_x)
			
			SET LIST ITEM PARAMETER:C986(<>Lst_files; *; "modified"; True:C214)
			
			form_Timer(1)
			
		End if 
		
		//______________________________________________________
End case 

If (Length:C16($Txt_Message)>0)
	
	ALERT:C41($Txt_Message)
	
End if 

// ----------------------------------------------------
// End