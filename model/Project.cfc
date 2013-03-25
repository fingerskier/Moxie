<cfcomponent persistent="true">
	<cfproperty name="ID"  fieldtype="id" generator="increment" setter="false">
	<cfproperty name="Created" ormtype="timestamp">
	<cfproperty name="Updated" ormtype="timestamp">

	<cfproperty name="Name" ormtype="string">

	<cffunction name="addUser">
		<cfargument name="userID" type="numeric">

		<cfset var thisUser = entityLoad("Users_Projects", {ProjectID=variables.ID, UserID=arguments.userID})>

		<cfif not arrayLen(thisUser)>
			<cfset entitysave(entityNew("Users_Projects", {ProjectID=variables.ID, UserID=arguments.userID}))>
		</cfif>
	</cffunction>

	<cffunction name="hasUser">
		<cfargument name="userID" type="numeric">

		<cfset var userProjects = entityLoad("Users_Projects", {ProjectID=variables.ID, UserID=arguments.userID})>

		<cfif arrayLen(userProjects)>
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

	<cffunction name="removeUser">
		<cfargument name="userID" type="numeric">

		<cfset var thisUser = entityLoad("Users_Projects", {ProjectID=variables.ID, UserID=arguments.userID})>

		<cfif arrayLen(thisUser)>
			<cfset entityDelete(thisUser[1])>
		</cfif>
	</cffunction>
</cfcomponent>