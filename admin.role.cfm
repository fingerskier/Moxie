<cfparam name="ID" type="integer">

<cfif ID lt 0>
	<cfset role = entitynew("Role")>
<cfelse>
	<cfset role = entityLoadByPK("Role", ID)>
</cfif>

<cfset thisRoleID = -7>
<cfif isNumeric(role.getID())>
	<cfset thisRoleID = role.getID()>
</cfif>

<cfoutput>
	<cfform action="admin.roles.cfm" method="post">
		<input name="ID" type="hidden" value="#thisRoleID#">
		<br>
		<label>
			Role Name:
			<input name="Name" type="text" value="#role.getName()#">
		</label>
		<br>
		<input name="save" type="submit" value="Save">
	</cfform>

	<cfform action="admin.roles.cfm" method="post">
		<input name="ID" type="hidden" value="#thisRoleID#">
		<button name="delete" type="submit">Delete</button>
	</cfform>

	<cfform action="admin.roles.cfm" method="post">
		<button type="submit">Cancel</button>
	</cfform>
</cfoutput>