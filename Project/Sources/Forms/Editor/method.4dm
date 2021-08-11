// ----------------------------------------------------
// Form method : Editor
// Created 11/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Declarations
C_BOOLEAN:C305($Boo_expanded; $Boo_fixed; $Boo_modified; $Boo_OK; $Boo_selected)
C_LONGINT:C283($Lon_currentFile; $Lon_fileID; $Lon_formEvent; $Lon_i; $Lon_ID; $Lon_index)
C_LONGINT:C283($Lon_line; $Lon_menu; $Lon_timerEvent; $Lon_type; $Lon_value; $Lst_buffer)
C_REAL:C285($Num_value)
C_TEXT:C284($kTxt_decimalSeparator; $Txt_name; $Txt_Path; $Txt_type; $Txt_value)

// ----------------------------------------------------
// Initialisations
$Lon_formEvent:=Form event code:C388

// ----------------------------------------------------
Case of 
		
		//______________________________________________________
	: ($Lon_formEvent=On Load:K2:1)
		
		$Txt_Path:=Get 4D folder:C485(Current resources folder:K5:16)+"Images"+Folder separator:K24:12
		READ PICTURE FILE:C678($Txt_Path+"longint.png"; obj_pointer("L.icon")->)
		READ PICTURE FILE:C678($Txt_Path+"real.png"; obj_pointer("R.icon")->)
		READ PICTURE FILE:C678($Txt_Path+"alpha.png"; obj_pointer("S.icon")->)
		
		OBJECT SET ENABLED:C1123(*; "b.@"; False:C215)
		OBJECT SET ENABLED:C1123(*; "b.new.file"; True:C214)
		OBJECT SET ENABLED:C1123(*; "b.list.@"; True:C214)
		
		// Center the tip label
		Obj_CENTERED("Label.Liste"; "file.list")
		
		// Center the progress wheel
		Obj_CENTERED("spinner"; "lst.parse")
		
		OBJECT SET FONT:C164(*; "@"; OBJECT Get font:C1069(*; ""))
		
		//_O_PLATFORM PROPERTIES($Lon_platform)
		//OBJECT SET VISIBLE(*;"Header.@";$Lon_platform=Windows)
		OBJECT SET VISIBLE:C603(*; "Header.@"; Is Windows:C1573)
		
		<>Lst_files:=New list:C375
		SET LIST PROPERTIES:C387(<>Lst_files; 0; 0; 24)
		
		<>Lst_constants:=0
		
		Obj_spinner(True:C214)
		form_Timer(-1)
		
		//______________________________________________________
	: ($Lon_formEvent=On Unload:K2:2)
		
		CLEAR LIST:C377(<>Lst_constants; *)
		
		// Cleanup
		For ($Lon_i; 1; Count list items:C380(<>Lst_files); 1)
			
			GET LIST ITEM:C378(<>Lst_files; $Lon_i; $Lon_ID; $Txt_name)
			GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_ID; "list"; $Lst_buffer)
			
			If (Is a list:C621($Lst_buffer))
				
				CLEAR LIST:C377($Lst_buffer; *)
				
			End if 
		End for 
		
		// Need to restart ?
		For ($Lon_i; 1; Count list items:C380(<>Lst_files); 1)
			
			GET LIST ITEM:C378(<>Lst_files; $Lon_i; $Lon_ID; $Txt_name)
			GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_ID; "needToRestart"; $Boo_modified)
			
			If ($Boo_modified)
				
				$Lon_i:=MAXLONG:K35:2-1
				
				If (mess_Confirm("¿"+Get localized string:C991("ConstantsLastStep_2"); \
					Get localized string:C991("YesButton"); \
					Get localized string:C991("NoButton"))=1)
					
					OPEN DATA FILE:C312(Data file:C490)
					
				End if 
			End if 
		End for 
		
		CLEAR LIST:C377(<>Lst_files; *)
		
		//______________________________________________________
	: ($Lon_formEvent=On Timer:K2:25)
		
		$Lon_timerEvent:=form_Timer
		
		Case of 
				
				// .....................................................
			: ($Lon_timerEvent=-1)  //INIT
				
				EDITOR_LOAD_FILES
				
				If (Count list items:C380(<>Lst_files)=0)
					
					// Check for old 4DK#
					
					IMPORT_FROM_PLUGIN
					
				End if 
				
				Lsth_DISPLAY_SCROLLBAR(obj_pointer("file.list"))
				
				If (Application type:C494=4D Remote mode:K5:5)
					
					OBJECT SET ENABLED:C1123(*; "b.new.@"; False:C215)
					OBJECT SET ENABLED:C1123(*; "b.sel.delete"; False:C215)
					
					DISABLE MENU ITEM:C150(1; 1)
					DISABLE MENU ITEM:C150(1; 4)
					DISABLE MENU ITEM:C150(1; 5)
					
					OBJECT SET VISIBLE:C603(*; "nonWritable@"; True:C214)
					OBJECT SET ENTERABLE:C238(*; "@.box@"; False:C215)
					OBJECT SET RGB COLORS:C628(*; "@.box@"; -3; -2)
					
				End if 
				
				$Lon_timerEvent:=-2
				
				// .....................................................
			: ($Lon_timerEvent=-2)  //We will work
				
				$Lon_currentFile:=obj_pointer("currentFile")->
				$Lon_fileID:=Selected list items:C379(<>Lst_files; *)
				
				$Boo_OK:=True:C214
				
				Case of 
						
						//___________________________
					: ($Lon_fileID=$Lon_currentFile)
						
						//___________________________
					: ($Lon_currentFile=0)
						
						//___________________________
					Else 
						
						$Boo_OK:=EDITOR_Save($Lon_currentFile)
						
						//___________________________
				End case 
				
				If ($Boo_OK)  //& ($Lon_fileID#0)
					
					SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_currentFile; "modified"; False:C215)
					
					obj_pointer("currentFile")->:=$Lon_fileID
					
					<>Lst_constants:=New list:C375
					
					Obj_spinner($Lon_fileID>0)
					
					$Lon_timerEvent:=-3
					
				Else 
					
					SELECT LIST ITEMS BY REFERENCE:C630(<>Lst_files; $Lon_currentFile)
					
					$Lon_timerEvent:=1
					
				End if 
				
				// .....................................................
			: ($Lon_timerEvent=-3)  //We are working
				
				$Lon_fileID:=obj_pointer("currentFile")->
				
				$Boo_selected:=($Lon_fileID#0)
				
				If ($Boo_selected)
					
					GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_fileID; "list"; $Lst_buffer)
					
					If (Is a list:C621($Lst_buffer))
						
						<>Lst_constants:=$Lst_buffer
						
					Else 
						
						GET LIST ITEM PARAMETER:C985(<>Lst_files; $Lon_fileID; "path"; $Txt_path)
						<>Lst_constants:=EDITOR_Parse_file($Txt_path; obj_pointer("UID"))
						
						SET LIST ITEM PARAMETER:C986(<>Lst_files; $Lon_fileID; "list"; <>Lst_constants)
						
					End if 
					
					Lsth_RESTORE_STATE(<>Lst_constants)
					
				End if 
				
				Lsth_DISPLAY_SCROLLBAR(-><>Lst_constants)
				
				OBJECT SET VISIBLE:C603(*; "lst.parse@"; $Boo_selected)
				OBJECT SET ENABLED:C1123(*; "@.sel.@"; $Boo_selected)
				
				$Lon_timerEvent:=1
				
				// .....................................................
			: ($Lon_timerEvent=1)  //Update screen
				
				Obj_spinner(False:C215)
				
				$Lon_index:=Selected list items:C379(<>Lst_constants)
				
				If ($Lon_index>0)
					
					GET LIST ITEM:C378(<>Lst_constants; $Lon_index; $Lon_ID; $Txt_name; $Lst_buffer; $Boo_expanded)
					
					obj_pointer("name.group.item.box")->:=$Txt_name
					
				End if 
				
				OBJECT SET VISIBLE:C603(*; "@item@"; $Lon_ID>0)
				OBJECT SET VISIBLE:C603(*; "@group@"; $Lon_ID<0)
				
				// 7/10/18 BR: fix for use of mid string @ wildcards
				//OBJECT SET VISIBLE(*;"@group@item@";$Lon_ID#0)
				OBJECT SET VISIBLE:C603(*; "name.group.item.box"; $Lon_ID#0)
				OBJECT SET VISIBLE:C603(*; "group.item.name.label"; $Lon_ID#0)
				
				OBJECT SET ENABLED:C1123(*; "b.constant.@"; $Lon_ID#0)
				OBJECT SET ENABLED:C1123(*; "b.list.@"; Count list items:C380(<>Lst_constants)>0)
				
				If ($Lon_ID>0)
					
					GET LIST ITEM PARAMETER:C985(<>Lst_constants; $Lon_ID; "type"; $Txt_type)
					
					Case of 
							
							//______________________________________________________
						: ($Txt_type="R")
							
							GET LIST ITEM PARAMETER:C985(<>Lst_constants; $Lon_ID; "value"; $Num_value)
							$Txt_value:=String:C10($Num_value)
							$Txt_value:=Replace string:C233($Txt_value; $kTxt_decimalSeparator+"00000e"; "e")
							
							//______________________________________________________
						: ($Txt_type="L")
							
							GET LIST ITEM PARAMETER:C985(<>Lst_constants; $Lon_ID; "value"; $Lon_value)
							$Txt_value:=String:C10($Lon_value)
							
							//______________________________________________________
						Else 
							
							GET LIST ITEM PARAMETER:C985(<>Lst_constants; $Lon_ID; "value"; $Txt_value)
							
							//______________________________________________________
					End case 
					
					obj_pointer("value.item.box")->:=$Txt_value
					
				End if 
				
				GET LIST ITEM PARAMETER:C985(<>Lst_constants; $Lon_ID; "fixed"; $Boo_fixed)
				
				$Lon_type:=Choose:C955($Boo_fixed; Position:C15($Txt_type; "-SLR"); 1)
				(OBJECT Get pointer:C1124(Object named:K67:5; "type.item.popup"))->:=$Lon_type
				
				GET LIST ITEM PARAMETER:C985(<>Lst_files; *; "modified"; $Boo_modified)
				
				If ($Boo_modified)
					
					ENABLE MENU ITEM:C149(1; 4)
					ENABLE MENU ITEM:C149(1; 5)
					
				Else 
					
					DISABLE MENU ITEM:C150(1; 4)
					DISABLE MENU ITEM:C150(1; 5)
					
				End if 
				
				$Lon_timerEvent:=2
				
				// .....................................................
			: ($Lon_timerEvent=2)  //object positioning
				
				// Center the tip label
				Obj_CENTERED("Label.Liste"; "file.list")
				
				// Center the progress wheel
				Obj_CENTERED("spinner"; "lst.parse")
				
				// Do update the vertical scroolbar of lists
				Lsth_DISPLAY_SCROLLBAR(-><>Lst_constants)
				Lsth_DISPLAY_SCROLLBAR(-><>Lst_files)
				
				$Lon_timerEvent:=0
				
				// .....................................................
		End case 
		
		form_Timer($Lon_timerEvent)
		
		//______________________________________________________
	: ($Lon_formEvent=On Menu Selected:K2:14)
		
		// Turn around ACI0075740 {
		//$Txt_value:=Lire parametre ligne menu selectionnee
		// Turn around ACI0075742 {
		// EDITOR_handler (Lire parametre ligne menu (Menu choisi\65536;Menu choisi%65536))
		$Lon_menu:=Menu selected:C152\65536
		$Lon_line:=Menu selected:C152%65536
		$Txt_value:=Get menu item parameter:C1003($Lon_menu; $Lon_line)
		//}
		//}
		
		EDITOR_handler($Txt_value)
		
		//______________________________________________________
	: ($Lon_formEvent=On Resize:K2:27)
		
		// Center the tip label
		Obj_CENTERED("Label.Liste"; "file.list"; Vertically centered:K39:4)
		
		// Center the progress wheel
		Obj_CENTERED("spinner"; "lst.parse")
		
		// Do update the vertical scroolbar of lists
		Lsth_DISPLAY_SCROLLBAR(-><>Lst_files)
		Lsth_DISPLAY_SCROLLBAR(-><>Lst_constants)
		
		If (Count list items:C380(<>Lst_files)>0)
			
			form_Timer(2)
			
		End if 
		
		//______________________________________________________
	: ($Lon_formEvent=On Close Box:K2:21)
		
		EDITOR_handler("menu.close")
		
		//______________________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "Form event activated unnecessarily")
		
		//______________________________________________________
End case 

If (Application type:C494=4D Remote mode:K5:5)
	
	OBJECT SET ENABLED:C1123(*; "b.@"; False:C215)
	OBJECT SET ENABLED:C1123(*; "b.list.@"; True:C214)
	
	DISABLE MENU ITEM:C150(1; 1)
	DISABLE MENU ITEM:C150(1; 4)
	DISABLE MENU ITEM:C150(1; 5)
	
	OBJECT SET VISIBLE:C603(*; "nonWritable@"; True:C214)
	OBJECT SET ENTERABLE:C238(*; "@.box@"; False:C215)
	OBJECT SET RGB COLORS:C628(*; "@.box@"; -3; -2)
	
End if 