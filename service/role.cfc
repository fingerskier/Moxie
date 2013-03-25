<cfcomponent>
	<cffunction name="add" roles="admin">
		<cfargument name="name" type="string">

		<cfset var role = entitynew("Role")>
		<cfset role.setName(arguments.name)>
		<cfset entitySave(role)>
	</cffunction>

	<cffunction name="delete" roles="admin">
		<cfargument name="ID" type="numeric">

		<cfset var thisRole = entityLoadByPK("Role", arguments.ID)>

		<cfset entityDelete(thisRole)>
	</cffunction>

	<cffunction name="save" access="remote" roles="admin">
		<cfargument name="ID" type="numeric">
		<cfargument name="Name" type="string">

		<cfif ID lt 0>
			<cfset add(argumentCollection=arguments)>
		<cfelse>
			<cfset update(argumentCollection=arguments)>
		</cfif>
	</cffunction>

	<cffunction name="update" roles="admin">
		<cfargument name="ID" type="numeric">
		<cfargument name="Name" type="string">

		<cfset var role = entityloadByPK("Role", arguments.ID)>
		<cfset role.setName(arguments.name)>
		<cfset entitysave(role)>
	</cffunction>
</cfcomponent>