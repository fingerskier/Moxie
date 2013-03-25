<cfcomponent>
	<cffunction name="add">
		<cfargument name="issueID" type="numeric">
		<cfargument name="note" type="string">
		<cfargument name="details" type="string">

		<cfset var announcement = entityNew("Announcement")>
		<cfset announcement.setIssueID(arguments.issueID)>
		<cfset announcement.setNote(arguments.note)>
		<cfset announcement.setDetails(arguments.details)>
		<cfset entitySave(announcement)>
	</cffunction>
</cfcomponent>