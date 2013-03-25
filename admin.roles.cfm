<cfset ajaxOnLoad("focuser")>

<cfif structCount(form)>
	<cfobject type="component" name="roleService" component="service.role">

	<cfif isdefined("save")>
		<cfset roleService.save(argumentcollection="#form#")>
	<cfelseif isDefined("delete")>
		<cfset roleService.delete(argumentcollection="#form#")>
	</cfif>

	<cfset ORMflushAll()>
</cfif>

<cfset roles = entityload("Role")>

<cfmenu type="vertical">
	<cfloop array="#roles#" index="role">
		<cfmenuitem display="#role.getName()#" href="javascript:ColdFusion.navigate('admin.role.cfm?ID=#role.getID()#', 'mainContent')" />
	</cfloop>

	<cfmenuitem divider="true" />

	<cfmenuitem display="New Role" href="javascript:ColdFusion.navigate('admin.role.cfm?ID=-7', 'mainContent')" />
</cfmenu>