<cfcomponent>
	<cffunction access="remote" name="addUser" roles="admin">
		<cfargument name="projectID" type="numeric">
		<cfargument name="userID" type="numeric">

		<cfset var thisn = entityNew("Users_Projects", {ProjectID=projectID, UserID=userID})>
		<cfset entitysave(thisn)>
	</cffunction>

	<cffunction name="delete" roles="admin">
		<cfargument name="ID" type="numeric">

		<cfset var thisProject = entityLoadByPK("Project", arguments.ID)>
		<cfset var projectUsers = entityLoad("Users_Projects", {ProjectID=arguments.ID})>
		<cfset var projectIssue = "">
		<cfset var projectIssues = entityLoad("Issue", {ProjectID=arguments.ID})>

		<cfloop array="#projectIssues#" index="projectIssue">
			<cfset projectIssue.removeAttachments()>
			<cfset projectIssue.removeAttachments()>
		</cfloop>
		<cfset entityDelete(thisProject)>
	</cffunction>

	<cffunction access="remote" name="removeUser" roles="admin">
		<cfargument name="projectID" type="numeric">
		<cfargument name="userID" type="numeric">

		<cfset var userProject = "">
		<cfset var userProjects = entityLoad("Users_Projects", {ProjectID=projectID, UserID=userID})>

		<cfloop array="#userProjects#" index="userProject">
			<cfset entityDelete(userProject)>
		</cfloop>
	</cffunction>

	<cffunction name="save" access="remote" roles="admin">
		<cfargument name="ID" type="numeric">
		<cfargument name="name" type="string">
		<cfargument name="users" hint="comma-delimited list of integers" default="">

		<cfset var project = "">
		<cfset var userProject = "">
		<cfset var userProjects = entityLoad("Users_Projects", {ProjectID=arguments.ID})>
		<cfset var userID = 0>

		<cfif ID lt 0>
			<cfset project = entitynew("Project")>
		<cfelse>
			<cfset project = entityLoadByPK("Project", arguments.ID)>
		</cfif>

		<cfset project.setName(arguments.name)>
		<cfset entitySave(project)>
		<cfset ORMflushAll()>

		<cfloop list="#arguments.users#" index="userID">
			<cfif isNumeric(userID)>
				<cfset userProject = entityLoad("Users_Projects", {ProjectID=arguments.ID, UserID=userID})>
				<cfif not arrayLen(userProject)>
					<cfset addUser(arguments.ID, userID)>
				</cfif>
			</cfif>
		</cfloop>

		<cfloop array="#userProjects#" index="userProject">
			<cfif not arguments.users contains userProject.getUserID()>
				<cfset project.removeUser(userProject.getUserID())>
			</cfif>
		</cfloop>
	</cffunction>
</cfcomponent>