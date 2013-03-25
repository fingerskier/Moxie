<cfcomponent>
	<cffunction name="add" roles="admin">
		<cfargument name="FullName" type="string">
		<cfargument name="Username" type="string">
		<cfargument name="Phone" type="string">
		<cfargument name="Email" type="string">

		<cfset var user = entitynew("User")>

		<cfset user.setFullName(arguments.FullName)>
		<cfset user.setUsername(arguments.Username)>
		<cfset user.setPhone(arguments.Phone)>
		<cfset user.setEmail(arguments.Email)>

		<cfset entitySave(user)>
		<cfset ORMflushAll()>

		<cfreturn user.getID()>
	</cffunction>

	<cffunction name="delete" roles="admin">
		<cfargument name="ID" type="numeric">

		<cfset var temp = "">
		<cfset var thisUser = entityLoadByPK("User", arguments.ID)>
		<cfset var userProjects = entityload("Users_Projects", {UserID=arguments.ID})>
		<cfset var userRoles = entityload("Users_Roles", {UserID=arguments.ID})>

		<cfloop array="#userProjects#" index="temp">
			<cfset entityDelete(temp)>
		</cfloop>

		<cfloop array="#userRoles#" index="temp">
			<cfset entityDelete(temp)>
		</cfloop>

		<cfset entityDelete(thisUser)>

		<cfset ORMflushAll()>
	</cffunction>

	<cffunction name="save" access="remote" roles="admin">
		<cfargument name="ID" type="numeric">
		<cfargument name="FullName" type="string">
		<cfargument name="Username" type="string">
		<cfargument name="Phone" type="string">
		<cfargument name="Email" type="string">
		<cfargument name="Roles" default="" type="string">

		<cfset var thisUserID = arguments.ID>

		<cfif ID lt 0>
			<cfset thisUserID = add(argumentCollection=arguments)>
		<cfelse>
			<cfset update(argumentCollection=arguments)>
		</cfif>
	</cffunction>

	<cffunction name="update" roles="admin">
		<cfargument name="ID" type="numeric">
		<cfargument name="FullName" type="string">
		<cfargument name="Username" type="string">
		<cfargument name="Phone" type="string">
		<cfargument name="Email" type="string">
		<cfargument name="projectIDs" hint="comma-delimited list of integers">
		<cfargument name="roleIDs" hint="comma-delimited list of integers">

		<cfset var projectID = 0>
		<cfset var roleID = 0>
		<cfset var user = entityloadByPK("User", arguments.ID)>

		<cfset user.setFullName(arguments.FullName)>
		<cfset user.setUsername(arguments.Username)>
		<cfset user.setPhone(arguments.Phone)>
		<cfset user.setEmail(arguments.Email)>
		<cfset entitysave(user)>
		<cfset ORMflushAll()>

		<cfloop list="#arguments.projectIDs#" index="projectID">
			<cfset user.addProject(projectID)>
		</cfloop>
		<cfloop list="#user.getProjectIDs()#" index="projectID">
			<cfif not arguments.projects contains projectID>
				<cfset user.removeProject(projectID)>
			</cfif>
		</cfloop>

		<cfloop list="#arguments.roleIDs#" index="roleID">
			<cfset user.addRole(roleID)>
		</cfloop>
		<cfloop list="#user.getRoleIDs()#" index="roleID">
			<cfif not arguments.roles contains roleID>
				<cfset user.removeRole(roleID)>
			</cfif>
		</cfloop>

		<cfset ORMflushAll()>
	</cffunction>
</cfcomponent>