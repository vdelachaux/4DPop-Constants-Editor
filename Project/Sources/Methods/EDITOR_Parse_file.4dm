//%attributes = {"invisible":true}
// ----------------------------------------------------
// Project method : EDITOR_PARSE_FILE
// ID[21488508AE974274A5F1DCE41EB504D7]
// Created 13/01/12 by Vincent de Lachaux
// ----------------------------------------------------
// Description:
//
// ----------------------------------------------------
// Declarations
C_LONGINT:C283($0)
C_TEXT:C284($1)
C_POINTER:C301($2)

C_BOOLEAN:C305($Boo_constantsDefinition; $Boo_fixed; $Boo_themeDefinition)
C_LONGINT:C283($Lon_error; $Lon_i; $Lon_ii; $Lon_iii; $Lon_parameters; $Lon_size; $Lon_UID; $Lon_value; $Lon_x; $Lst_buffer)
C_LONGINT:C283($Lst_constants; $Lon_constantIndex)
C_REAL:C285($Num_value)
C_TEXT:C284($Dom_buffer; $Dom_element; $Dom_group; $Dom_root; $Dom_source; $kTxt_decimalSeparator; $Txt_buffer; $Txt_groupName; $Txt_name; $Txt_path)
C_TEXT:C284($Txt_type; $Txt_value; $Txt_groupUuid; $Txt_groupId; $Dom_element2)

If (False:C215)
	C_LONGINT:C283(EDITOR_Parse_file; $0)
	C_TEXT:C284(EDITOR_Parse_file; $1)
	C_POINTER:C301(EDITOR_Parse_file; $2)
End if 

// ----------------------------------------------------
// Initialisations
$Lon_parameters:=Count parameters:C259

If (Asserted:C1132($Lon_parameters>=1; "Missing parameter"))
	
	$Txt_path:=$1
	$Lon_UID:=$2->
	
	GET SYSTEM FORMAT:C994(Decimal separator:K60:1; $kTxt_decimalSeparator)
	
Else 
	
	ABORT:C156
	
End if 

// ----------------------------------------------------
$Lst_constants:=New list:C375

$Dom_root:=DOM Parse XML source:C719($Txt_path)

If (OK=1)
	
	ARRAY TEXT:C222($tDom_groups; 0x0000)
	$Dom_buffer:=DOM Find XML element:C864($Dom_root; "xliff/file/body/group"; $tDom_groups)
	Form:C1466.lastThemeIndex:=0
	
	For ($Lon_i; 1; Size of array:C274($tDom_groups); 1)
		
		$Boo_constantsDefinition:=False:C215
		$Dom_group:=$tDom_groups{$Lon_i}
		
		ARRAY TEXT:C222($tTxt_groupAttributeName; 0x0000)
		ARRAY TEXT:C222($tTxt_groupAttributeValue; 0x0000)
		
		For ($Lon_ii; 1; DOM Count XML attributes:C727($Dom_group); 1)
			
			DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_group; $Lon_ii; $Txt_name; $Txt_value)
			
			APPEND TO ARRAY:C911($tTxt_groupAttributeName; $Txt_name)
			APPEND TO ARRAY:C911($tTxt_groupAttributeValue; $Txt_value)
			
			Case of 
					
					//………………………………………………………………
				: ($Txt_name="resname")
					
					$Boo_themeDefinition:=($Txt_value="themes")
					
					//………………………………………………………………
				: ($Txt_name="restype")
					
					$Boo_constantsDefinition:=($Txt_value="x-4DK#")
					
					//………………………………………………………………
				: ($Txt_name="d4:groupName")
					$Txt_groupUuid:=$Txt_value
					
					$Lon_x:=Find in array:C230($tTxt_groupResname; $Txt_value)
					
					If ($Lon_x>0)
						
						$Txt_groupName:=$tTxt_groupName{$Lon_x}
						$Txt_groupId:=$tTxt_groupId{$Lon_x}
						
					Else 
						
						$Txt_buffer:=Get localized string:C991($Txt_value)
						$Txt_groupName:=Choose:C955(Length:C16($Txt_buffer)>0; $Txt_buffer; $Txt_value)
						$Txt_groupId:=$Txt_groupUuid
						
					End if 
					
					//………………………………………………………………
			End case 
		End for 
		
		Case of 
				
				//______________________________________________________
			: ($Boo_constantsDefinition)
				
				$Lst_buffer:=New list:C375
				
				Form:C1466.lastThemeIndex+=1
				$Lon_UID:=$Lon_UID+1
				APPEND TO LIST:C376($Lst_constants; $Txt_groupName; -$Lon_UID; $Lst_buffer; False:C215)
				SET LIST ITEM PROPERTIES:C386($Lst_constants; 0; False:C215; Bold:K14:2; 0; 0x00ABABAB)
				SET LIST ITEM PARAMETER:C986($Lst_constants; 0; "groupUuid"; $Txt_groupUuid)
				SET LIST ITEM PARAMETER:C986($Lst_constants; 0; "index"; Form:C1466.lastThemeIndex)
				SET LIST ITEM PARAMETER:C986($Lst_constants; 0; "id"; $Txt_groupId)
				
				ARRAY TEXT:C222($tDom_elements; 0)
				$Dom_buffer:=DOM Find XML element:C864($Dom_group; "group/trans-unit"; $tDom_elements)
				
				For ($Lon_ii; 1; Size of array:C274($tDom_elements); 1)
					
					$Dom_element:=$tDom_elements{$Lon_ii}
					$Txt_type:="S"
					
					$Dom_source:=DOM Find XML element:C864($Dom_element; "trans-unit/source")
					
					If (OK=1)
						
						DOM GET XML ELEMENT VALUE:C731($Dom_source; $Txt_name)
						
					Else 
						
						$Txt_name:="k_"+String:C10($Lon_ii)
						
					End if 
					
					$Lon_UID:=$Lon_UID+1
					APPEND TO LIST:C376($Lst_buffer; $Txt_name; $Lon_UID)
					SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; "index"; $Lon_ii)
					
					For ($Lon_iii; 1; DOM Count XML attributes:C727($Dom_element); 1)
						
						DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_element; $Lon_iii; $Txt_name; $Txt_value)
						SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; $Txt_name; $Txt_value)
						
						Case of 
								
								//----------------------
							: ($Txt_name="d4:valueName")
								
								SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; "type"; "xliff")
								
								//----------------------
							: ($Txt_name="d4:value")
								
								ARRAY TEXT:C222($tTxt_segments; 0x0000)
								$Lon_error:=Rgx_SplitText(":"; $Txt_value; ->$tTxt_segments)
								$Lon_size:=Size of array:C274($tTxt_segments)
								
								$Boo_fixed:=False:C215
								
								Case of 
										
										//…………………………………………………………………………
									: ($Txt_value=":")\
										 | ($Txt_value="::S")  //Mac folder delimitor (new and old mode)
										
										$Txt_value:=":"
										
										//…………………………………………………………………………
									: ($Txt_value="@:L")\
										 & ($Lon_size=2)  //longint (forced mode)
										
										$Txt_type:="L"
										$Txt_value:=Delete string:C232($Txt_value; Length:C16($Txt_value)-1; 2)
										DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_element; $Lon_iii; $Txt_name; $Lon_value)
										$Boo_fixed:=True:C214
										
										//…………………………………………………………………………
									: ($Txt_value="@:R")\
										 & ($Lon_size=2)  //real (forced mode)
										
										$Txt_type:="R"
										$Txt_value:=Delete string:C232($Txt_value; Length:C16($Txt_value)-1; 2)
										DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_element; $Lon_iii; $Txt_name; $Num_value)
										//XML DECODE($Txt_value; $Num_value)
										$Boo_fixed:=True:C214
										
										//…………………………………………………………………………
									: ($Txt_value="@:S")\
										 & ($Lon_size=2)  //string (forced mode)
										
										$Txt_type:="S"
										$Txt_value:=Delete string:C232($Txt_value; Length:C16($Txt_value)-1; 2)
										$Boo_fixed:=True:C214
										
										//…………………………………………………………………………
									: (string_isLongint($Txt_value))
										
										$Txt_type:="L"
										DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_element; $Lon_iii; $Txt_name; $Lon_value)
										
										//…………………………………………………………………………
										//: (string_isNumeric($Txt_value))
									: (Match regex:C1019("\\d*\\.\\d+"; $Txt_value))
										
										$Txt_type:="R"
										DOM GET XML ATTRIBUTE BY INDEX:C729($Dom_element; $Lon_iii; $Txt_name; $Num_value)
										//DOM GET XML ATTRIBUTE BY INDEX($Dom_element; $Lon_iii; $Txt_name; $Txt_value)
										//XML DECODE($Txt_value; $Num_value)
										
										//…………………………………………………………………………
									: (Rgx_SplitText(":"; $Txt_value; ->$tTxt_segments)=0)
										
										If (Size of array:C274($tTxt_segments)>0)
											
											$Txt_value:=$tTxt_segments{1}
											
											If (Size of array:C274($tTxt_segments)>1)
												
												$Txt_type:=$tTxt_segments{2}
												
											End if 
											
										Else 
											
											$Txt_value:=""
											
										End if 
										
										//…………………………………………………………………………
								End case 
								
								SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; "type"; $Txt_type)
								SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; "fixed"; $Boo_fixed)
								
								Case of 
										
										//______________________________________________________
									: ($Txt_type="R")
										
										SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; "value"; $Num_value)
										$Txt_value:=String:C10($Num_value)
										
										//______________________________________________________
									: ($Txt_type="L")
										
										SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; "value"; $Lon_value)
										$Txt_value:=String:C10($Lon_value)
										
										//______________________________________________________
									Else 
										
										SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; "value"; $Txt_value)
										
										//______________________________________________________
								End case 
								
								If (Position:C15($Txt_type; "RL")>0)
									
									$Txt_value:=Replace string:C233($Txt_value; $kTxt_decimalSeparator+"00000e"; "e")
									$Txt_value:=Replace string:C233($Txt_value; $kTxt_decimalSeparator+"0000e"; "e")
									$Txt_value:=Replace string:C233($Txt_value; $kTxt_decimalSeparator+"000e"; "e")
									$Txt_value:=Replace string:C233($Txt_value; $kTxt_decimalSeparator+"00e"; "e")
									$Txt_value:=Replace string:C233($Txt_value; $kTxt_decimalSeparator+"0e"; "e")
									$Txt_value:=Replace string:C233($Txt_value; "e+0"; "")
									$Txt_value:=Replace string:C233($Txt_value; " "; ""; 1)
									
								End if 
								
								SET LIST ITEM PARAMETER:C986($Lst_buffer; 0; Additional text:K28:7; $Txt_value)
								
								//----------------------
								
						End case 
						
						If (Position:C15($Txt_type; "RLS")>0)
							
							SET LIST ITEM ICON:C950($Lst_buffer; 0; (OBJECT Get pointer:C1124(Object named:K67:5; $Txt_type+".icon"))->)
							
						End if 
					End for 
				End for 
				
				SET LIST ITEM PARAMETER:C986($Lst_constants; 0; "nextConstantIndex"; $Lon_ii)
				
				//______________________________________________________
			: ($Boo_themeDefinition)
				
				ARRAY TEXT:C222($tDom_elements; 0)
				$Dom_buffer:=DOM Find XML element:C864($Dom_group; "group/trans-unit"; $tDom_elements)
				
				$Lon_x:=Size of array:C274($tDom_elements)
				
				ARRAY TEXT:C222($tTxt_groupResname; $Lon_x)
				ARRAY TEXT:C222($tTxt_groupName; $Lon_x)
				ARRAY TEXT:C222($tTxt_groupId; $Lon_x)
				
				For ($Lon_ii; 1; $Lon_x; 1)
					
					$Dom_element:=$tDom_elements{$Lon_ii}
					
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "resname"; $tTxt_groupResname{$Lon_ii})
					DOM GET XML ATTRIBUTE BY NAME:C728($Dom_element; "id"; $tTxt_groupId{$Lon_ii})
					
					$Dom_element2:=DOM Find XML element:C864($Dom_element; "trans-unit/source")
					DOM GET XML ELEMENT VALUE:C731($Dom_element2; $tTxt_groupName{$Lon_ii})
					
				End for 
				
				//______________________________________________________
			Else 
				
				// ??
				
				//______________________________________________________
		End case 
	End for   //groups
	
	Lsth_SortByParam($Lst_constants; "_label_")
	
	DOM CLOSE XML:C722($Dom_root)
	
	$2->:=$Lon_UID
	$0:=$Lst_constants
	
End if 

// ----------------------------------------------------
// End