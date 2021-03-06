'#####################################################################################
'#		PEDAL - Portable Event-Driven Automation Library
'#		SpeedTest, Inc. copyright 2009
'#		If you have any questions or need support,
'#		contact:
'#				SpeedTest Inc.
'#				7017 Eden Mill Road  Woodbine, MD 21797
'#				410-627-7373, info@speedtestinc.com
'#
'#      This code is the property of SpeedTest Inc. and is conveyed tas a  component
'#      of a services contract, without restrictions on its use.
'#      Use by anyone other than client personnel in support of the project for which SpeedTest is contracted
'#      is a copyright infringement.
'#      Client bears sole responsibility for the use and implementation of this code.  It is conveyed by 
'#      SpeedTest without license, warranty or support beyond the services contract period.
'#####################################################################################
 
'#####################################################################################		
'#		The following is the Project Function Library for the ST automated test framework
'#		It uses an event-driven approach to read data from a data table and 
'#		execute the test based upon that data.  The functions in this library
'#		perform the utility type operations that are specific tothe project or appliaction under test  and 
'# 		are not related to a GUI object.
'#
'#	Data array key:
'#	Data(0) = DataTable("Application", dtGlobalSheet)
'#	Data(1) = DataTable("Page", dtGlobalSheet)
'#	Data(2) = DataTable("Field", dtGlobalSheet)
'#	Data(3) = DataTable("Action", dtGlobalSheet)
'#	Data(4) = DataTable("Value", dtGlobalSheet)
'#	Data(5) = DataTable("ObjectNameOrKeyword", dtGlobalSheet)
'#	Data(6) = DataTable("ObjectType", dtGlobalSheet)
'#	Data(7) = DataTable("ObjPar1", dtGlobalSheet)
'#	Data(8) = DataTable("ObjPar2", dtGlobalSheet)
'#	Data(9) = DataTable("SynchPar1", dtGlobalSheet)
'#	Data(10) = DataTable("SynchPar2", dtGlobalSheet)
'#	Data(11) = DataTable("comment", dtGlobalSheet)
'#	Data(12) = DataTable("debug", dtGlobalSheet)
'# 
'#####################################################################################
'*******************************************************************************************************************************************
Public Function ProjFunc_Handler (Data,CurrentRow,ResultsFileObj)
	GUIObjRef = "Browser(Data(0)).Page(Data(1))."
	If Data(2) <> "" Then
		GUIObjRef = GUIObjRef & "Frame(Data(2))."
	End If
	'GUIObjRef = GUIObjRef & "Link(Data(5))."
	GUIObjRef = GUIObjRef & Data(6) & "(Data(5))."


	Select Case LCase(Data(6))
		Case "projfunc_expandcolapsenodesintree"
			status = expandColapseNodesInTree(Data,CurrentRow,ResultsFileObj)
		Case "projfunc_selectnodeintree"
			status = selectNodeInTree(Data,CurrentRow,ResultsFileObj)
		Case Else
			Reporter.ReportEvent micFail, Data(5), "The object type was not found!"
	End Select
End Function
'*******************************************************************************************************************************************
Public Function expandColapseNodesInTree (Data,CurrentRow,ResultsFileObj) ' use this function to expand or colapse a tree node
'*********************************************************************************************************************************************
'	ARGUMENTS TO DATA(4) VALUE COLUMN
'	1. NODENAME - NAME OF THE NODE TO EXPAND OR COLAPSE
'	2. CLICKIDX - VALID VALUES ARE 0,2,4,6 ETC FOR LEVEL 1, LEVEL 2, LEVEL 3 & LEVEL 4 RESPECTIVELY
'*********************************************************************************************************************************************
	funcArg = parseData4(Data(4))
	nodeName = funcArg(0)
	clickIdx = funcArg(1)
	Set oDesc = Description.Create()
	oDesc("micClass").value = "webtable"
	Set tabObj = Browser(Data(0)).Page(Data(1)).ChildObjects(oDesc)

	For i=0 to tabObj.count -1
		tableName = tabObj(i).GetROProperty("innertext")
		If tableName = nodeName Then
			Set weDesc = Description.Create
			weDesc("micClass").value = "WebElement"
			weDesc("innertext").value = ""
			Set weObj = Browser(Data(0)).Page(Data(1)).WebTable("innertext:="&tableName).ChildObjects(weDesc)
			weObj(clickIdx).Click
			Set oDesc = Nothing
			Set tabObj = Nothing
			Set weDesc = Nothing
			Set weObj = Nothing
			Exit For
		End If
	Next
	expandColapseNodesInTree = "Done"
End Function

Public Function selectNodeInTree(Data,CurrentRow,ResultsFileObj) 'use this function to click on the nodeLink
'*********************************************************************************************************************************************
'	ARGUMENTS TO DATA(4) VALUE COLUMN
'	1. NODENAME - NAME OF THE NODE TO CLICK / SELECT
'*********************************************************************************************************************************************
   nodeName = Data(4)
	Set lnkDesc = Description.Create
	lnkDesc("micClass").Value = "Link"
	lnkDesc("text").Value = nodeName
	Set lnkObj = Browser(Data(0)).Page(Data(1)).ChildObjects(lnkDesc)
	lnkObj(0).Click

	Set lnkObj = Nothing
	Set lnkDesc = Nothing
	selectNodeInTree = "Done"
End Function
