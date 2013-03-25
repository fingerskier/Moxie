<cfset ajaxOnLoad("focuser")>

<cfif structCount(form)>
	<cfobject type="component" name="userService" component="service.user">

	<cfif isdefined("save")>
		<cfset userService.save(argumentcollection="#form#")>
	<cfelseif isDefined("delete")>
		<cfset userService.delete(argumentcollection="#form#")>
	</cfif>
</cfif>

<cfset users = entityload("User")>

<cfmenu type="vertical">
	<cfloop array="#users#" index="user">
		<cfmenuitem display="#user.getFullName()#" href="javascript:ColdFusion.navigate('admin.user.cfm?ID=#user.getID()#', 'mainContent')" />
	</cfloop>

	<cfmenuitem divider="true" />

	<cfmenuitem display="New User" href="javascript:ColdFusion.navigate('admin.user.cfm?ID=-7', 'mainContent')" />
</cfmenu>