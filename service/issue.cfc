<cfcomponent>
	<cffunction name="save">
		<cfargument name="ID" type="numeric">
		<cfargument name="projectID" type="numeric">
		<cfargument name="description" type="string">

		<cfif ID lt 0>
			<cfset var issue = entityNew("Issue")>
			<cfset issue.setProjectID(projectID)>
			<cfset issue.setDescription(description)>
			<cfset entitySave(issue)>
			<cfset ORMflushAll()>
		<cfelse>
			<cfset var issue = entityLoadByPK("Issue", ID)>
			<cfset issue.setProjectID(projectID)>
			<cfset issue.setDescription(description)>
			<cfset entitySave(issue)>
		</cfif>

		<cfreturn issue.getID()>
	</cffunction>
</cfcomponent>