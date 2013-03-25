<cfcomponent persistent="true">
	<cfproperty name="ID"  fieldtype="id" generator="increment" setter="false">
	<cfproperty name="Created" ormtype="timestamp">
	<cfproperty name="Updated" ormtype="timestamp">

	<cfproperty name="Username" ormtype="string">
	<cfproperty name="Password" ormtype="string">
	<cfproperty name="FullName" ormtype="string">
	<cfproperty name="Phone" ormtype="string">
	<cfproperty name="Email" ormtype="string">

	<cffunction name="addProject">
		<cfargument name="projectID" type="numeric">

		<cfset var thisProject = entityLoad("Users_Projects", {ProjectID=arguments.projectID, UserID=getID()})>

		<cfif not arrayLen(thisProject)>
			<cfset entitySave(entityNew("Users_Projects", {ProjectID=arguments.projectID, UserID=getID()}))>
		</cfif>
	</cffunction>

	<cffunction name="addRole">
		<cfargument name="roleID" type="numeric">

		<cfset var thisRole = entityLoad("Users_Roles", {RoleID=arguments.roleID, UserID=getID()})>

		<cfif not arrayLen(thisRole)>
			<cfset entitySave(entityNew("Users_Roles", {RoleID=arguments.roleID, UserID=getID()}))>
		</cfif>
	</cffunction>

	<cffunction name="getProjects">
		<cfset var projectIDs = getProjectIDs()>
		<cfset var temp = arrayNew(1)>

		<cfif len(projectIDs)>
			<cfquery name="temp" dbtype="hql">
				from Project where ID in (#projectIDs#)
			</cfquery>
		</cfif>

		<cfreturn temp>
	</cffunction>

	<cffunction name="getProjectIDs">
		<cfset var project = "">
		<cfset var projects = entityLoad("Users_Projects", {UserID=getID()})>
		<cfset var result = "">

		<cfloop array="#projects#" index="project">
			<cfset result = listAppend(result, project.getProjectID())>
		</cfloop>

		<cfreturn result>
	</cffunction>

	<cffunction name="getRoles">
		<cfset var roleIDs = getRoleIDs()>
		<cfset var temp = arrayNew(1)>

		<cfif len(roleIDs)>
			<cfquery name="temp" dbtype="hql">
				from Role where ID in (#getRoleIDs()#)
			</cfquery>
		</cfif>

		<cfreturn temp>
	</cffunction>

	<cffunction name="getRoleIDs">
		<cfset var role = "">
		<cfset var roles = entityLoad("Users_Roles", {UserID=getID()})>
		<cfset var result = "">

		<cfloop array="#roles#" index="role">
			<cfset result = listAppend(result, role.getRoleID())>
		</cfloop>

		<cfreturn result>
	</cffunction>

	<cffunction name="hasProject">
		<cfargument name="projectID" type="numeric">

		<cfset var userProjects = entityLoad("Users_Projects", {ProjectID=arguments.projectID, UserID=getID()})>

		<cfif arrayLen(userProjects)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="hasRole">
		<cfargument name="roleID" type="numeric">

		<cfset var userRoles = entityLoad("Users_Roles", {RoleID=arguments.roleID, UserID=getID()})>

		<cfif arrayLen(userRoles)>
			<cfreturn true>
		<cfelse>
			<cfreturn false>
		</cfif>
	</cffunction>

	<cffunction name="preInsert">
		<cfset this.setCreated(now())>
		<cfset this.setUpdated(now())>
	</cffunction>

	<cffunction name="preUpdate">
		<cfargument name="oldData">

		<cfset this.setUpdated(now())>
	</cffunction>

	<cffunction name="removeProject">
		<cfargument name="projectID" type="numeric">

		<cfset var thisProject = entityLoad("Users_Projects", {ProjectID=arguments.projectID, UserID=getID()})>

		<cfif arrayLen(thisProject)>
			<cfset entityDelete(thisProject[1])>
		</cfif>
	</cffunction>

	<cffunction name="removeRole">
		<cfargument name="roleID" type="numeric">

		<cfset var thisRole = entityLoad("Users_Roles", {RoleID=arguments.roleID, UserID=getID()})>

		<cfif arrayLen(thisRole)>
			<cfset entitydelete(thisRole[1])>
		</cfif>
	</cffunction>
</cfcomponent>