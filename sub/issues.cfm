<cfparam name="projectID" pattern="[\d,]*" type="regex">

<cfif listLen(projectID)>
	<cfset issues = entityLoad("Issue", {ProjectID=projectID})>

	<cfmenu type="vertical">
		<cfloop array="#issues#" index="issue">
			<cfmenuitem display="#issue.getDescription()#" href="javascript:ColdFusion.navigate('issue.cfm?projectID=#projectID#&ID=#issue.getID()#', 'mainContent')" />
		</cfloop>

		<cfmenuitem display="Raise New Issue" href="javascript:ColdFusion.navigate('issue.cfm?projectID=#projectID#&ID=-7', 'mainContent')" />
	</cfmenu>
</cfif>