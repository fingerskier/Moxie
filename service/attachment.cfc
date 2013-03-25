<cfcomponent>
	<cffunction name="add">
		<cfargument name="issueID" type="numeric">
		<cfargument name="note" type="string">
		<cfargument name="file">

		<cfset var attachment = entityNew("Attachment")>
		<cfset var binaryData = "">

		<cfset attachment.setIssueID(arguments.issueID)>
		<cfset attachment.setNote(arguments.note)>

		<cffile accept="application/pdf,application/msexcel,application/msword,application/x-zip-compressed,image/gif,image/jpeg,image/jpg,image/tiff,image/x-MS-bmp,image/x-png,image/x-portablebitmap,image/x-portable-greymap,image/x-portable-pixmap,image/x-rgb,text/html,text/plain,video/quicktime,video/x-mpeg2"
				action="upload" destination="c:/uploads" filefield="data" nameconflict="makeunique">
		<cffile action="readbinary" file="#serverFile#" variable="binaryData">

		<cfset attachment.setData(binaryData)>
	</cffunction>
</cfcomponent>