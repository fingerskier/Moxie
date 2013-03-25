<cfset thisUser = entityLoadByPK("User", session.userID)>
<cfset projects = thisUser.getProjects()>

<cfif structCount(form)>
	<cfinvoke component="service.issue" method="save" projectID="#projectID#" description="#description#" returnvariable="issueID">

	<cfset ORMflushAll()>

	<cfif isDefined("announcementNote") and len(announcementNote)>
		<cfinvoke component="service.announcement" method="add" issueID="#issueID#" note="#announcementNote#" details="#announcementDetails#">
	</cfif>

	<cfif isDefined("attachmentNote") and len(attachmentNote)>
		<cfinvoke component="service.attachment" method="add" issueID="#issueID#" note="#attachmentNote#" file="#attachmentFile#">
	</cfif>
</cfif>

<cfoutput>
	<cfform>
		<select name="projectID">
			<cfloop array="#projects#" index="project">
				<option value="#project.getID()#">#project.getName()#</option>
			</cfloop>
		</select>

		<cfdiv bind="url:sub/issues.cfm?projectID={projectID}">
	</cfform>
</cfoutput>