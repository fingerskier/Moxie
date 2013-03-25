<cfcomponent persistent="true">
	<cfproperty name="ID"  fieldtype="id" generator="increment" setter="false">
	<cfproperty name="Created" ormtype="timestamp">
	<cfproperty name="Updated" ormtype="timestamp">

	<cfproperty name="ProjectID" ormtype="integer">

	<cfproperty name="Description" ormtype="string">
	<cfproperty name="Open" ormtype="boolean">

	<cffunction name="removeAnnouncements">
		<cfset var announcement = "">
		<cfset var announcements = entityLoad("Announcement", {IssueID=getID()})>

		<cfloop array="#announcements#" index="announcement">
			<cfset entityDelete(announcement)>
		</cfloop>
	</cffunction>

	<cffunction name="removeAttachments">
		<cfset var attachment = "">
		<cfset var attachments = entityLoad("Attachment", {IssueID=getID()})>

		<cfloop array="#attachments#" index="attachment">
			<cfset entityDelete(attachment)>
		</cfloop>
	</cffunction>

	<cffunction name="preInsert">
		<cfset this.setCreated(now())>
		<cfset this.setUpdated(now())>
	</cffunction>

	<cffunction name="preUpdate">
		<cfargument name="oldData">

		<cfset this.setUpdated(now())>
	</cffunction>
</cfcomponent>