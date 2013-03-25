<cfset ajaxOnLoad("focuser")>

<cfparam name="ID" type="integer">

<cfset projects = entityLoad("Project")>
<cfset userProjects = entityLoad("Users_Projects", {UserID=ID})>
<cfset roles = entityLoad("Role")>
<cfset userRoles = entityLoad("Users_Roles", {UserID=ID})>

<cfif ID lt 0>
	<cfset user = entitynew("User")>
<cfelse>
	<cfset user = entityLoadByPK("User", ID)>
</cfif>

<cfset thisUserID = -7>
<cfif isNumeric(user.getID())>
	<cfset thisUserID = user.getID()>
</cfif>

<cf_debugger proj="#projects#">

<cfoutput>
	<cfform action="admin.users.cfm" method="post">
		<input name="ID" type="hidden" value="#thisUserID#">
		<br>
		<label>
			Full Name:
			<input name="FullName" type="text" value="#user.getFullName()#">
		</label>
		<br>
		<label>
			Username:
			<input name="username" type="text" value="#user.getUsername()#">
		</label>
		<br>
		<label>
			Phone:
			<input name="phone" type="text" value="#user.getPhone()#">
		</label>
		<br>
		<label>
			Email:
			<input name="email" type="text" value="#user.getEmail()#">
		</label>
		<br>
		<label>
			Roles:
			<select name="roleIDs" multiple="multiple" size="5">
				<cfloop array="#roles#" index="role">
					<cfif user.hasRole(role.getID())>
						<cfset selectit = "selected">
					<cfelse>
						<cfset selectit = "">
					</cfif>

					<option value="#role.getID()#" #selectit#>#role.getName()#</option>
				</cfloop>
			</select>
		</label>
		<br>
		<label>
			Projects:
			<select name="projectIDs" multiple="multiple" size="5">
				<cfloop array="#projects#" index="project">
					<cfif user.hasProject(project.getID())>
						<cfset selectit = "selected">
					<cfelse>
						<cfset selectit = "">
					</cfif>

					<option value="#project.getID()#" #selectit#>#project.getName()#</option>
				</cfloop>
			</select>
		</label>
		<br>
		<input name="save" type="submit" value="Save">
	</cfform>

	<cfform action="admin.users.cfm" method="post">
		<input name="ID" type="hidden" value="#thisUserID#">
		<button name="delete" type="submit">Delete</button>
	</cfform>

	<cfform action="admin.users.cfm" method="post">
		<button type="submit">Cancel</button>
	</cfform>
</cfoutput>