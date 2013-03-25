<cfset ajaxOnLoad("focuser")>

<cfif structCount(form)>
	<cftransaction>
		<cfif isdefined("save")>
			<cfinvoke component="service.project" method="save" argumentcollection="#form#">
		<cfelseif isDefined("delete")>
			<cfinvoke component="service.project" method="delete" argumentcollection="#form#">
		</cfif>
	</cftransaction>
</cfif>

<cfset projects = entityload("Project")>

<cfmenu type="vertical">
	<cfloop array="#projects#" index="project">
		<cfmenuitem display="#project.getName()#" href="javascript:ColdFusion.navigate('admin.project.cfm?ID=#project.getID()#', 'mainContent')" />
	</cfloop>

	<cfmenuitem divider="true" />

	<cfmenuitem display="New Project" href="javascript:ColdFusion.navigate('admin.project.cfm?ID=-7', 'mainContent')" />
</cfmenu>