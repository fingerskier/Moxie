<cfset ajaxOnLoad("focuser")>

<cfparam name="ID" type="integer">

<cfset users = entityload("User")>

<cfif ID lt 0>
	<cfset project = entitynew("Project")>
<cfelse>
	<cfset project = entityLoadByPK("Project", ID)>
</cfif>

<cfset thisProjectID = -7>
<cfif isNumeric(project.getID())>
	<cfset thisProjectID = project.getID()>
</cfif>

<cfoutput>
	<cfform action="admin.projects.cfm" method="post">
		<input name="ID" type="hidden" value="#thisProjectID#">
		<br>
		<label>
			Project Name:
			<input name="Name" type="text" value="#project.getName()#">
		</label>
		<br>
		<label>
			Users:
			<select name="users" multiple="multiple" size="5">
				<cfloop array="#users#" index="user">
					<cfset userProject = entityLoad("Users_Projects", {UserID=user.getID(), ProjectID=thisProjectID})>

					<cfif arrayLen(userProject)>
						<cfset selectThis = "selected">
					<cfelse>
						<cfset selectThis = "">
					</cfif>

					<option value="#user.getID()#" #selectThis#>#user.getFullname()#</option>
				</cfloop>
			</select>
		</label>
		<br>
		<input name="save" type="submit" value="Save">
	</cfform>

	<cfform action="admin.projects.cfm" method="post">
		<input name="ID" type="hidden" value="#thisProjectID#">
		<button name="delete" type="submit">Delete</button>
	</cfform>

	<cfform action="admin.projects.cfm" method="post">
		<button type="submit">Cancel</button>
	</cfform>
</cfoutput>