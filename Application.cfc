<cfcomponent>
	<cfset this.name = hash(getCurrentTemplatePath())>

	<cfset this.clientManagement = true>
	<cfset this.customTagPaths = expandPath("./tags")>
	<cfset this.datasource = "Moxie">
	<cfset this.ormenabled = true>
	<cfset this.ormsettings.cfclocation = "model">
	<cfset this.ormsettings.dbcreate = "update">
	<cfset this.ormsettings.dialect = "Derby">
	<cfset this.ormsettings.eventHandling = true>
	<cfset this.ormsettings.logsql = true>
	<cfset this.path = expandPath("./")>
	<cfset this.sessionManagement = true>

	<cffunction name="onApplicationStart">
		<cfset application.path = this.path>
	</cffunction>

	<cffunction name="onRequestStart">
		<cfargument name="targetPage">

		<cfif isDefined("URL.restart") and (URL.restart is "goober")>
			<cfset applicationStop()>
		</cfif>

		<cfif isDefined("URL.restart") and (URL.restart is "hibernate")>
			<cfset ORMreload()>
		</cfif>

		<cfif not ((targetPage contains "index.cfm") or (targetPage contains "install.cfm"))>
			<cflogin>
			    <cfif not IsDefined("cflogin")>
			        <cfinclude template="login.cfm">

			        <cfabort>
			    <cfelse>
					<cfset thisUser = entityload("User", {Username=cflogin.name, Password=cflogin.password})>

					<cfif arraylen(thisUser)>
						<cfset thisUser = thisUser[1]>
						<cfset session.userID = thisUser.getID()>

						<cfset var role = "">
						<cfset var roleID = "">
						<cfset var rolesList = "">

						<cfloop list="#thisUser.getRoleIDs()#" index="roleID">
							<cfset role = entityLoadByPK("Role", roleID)>
							<cfset rolesList = listAppend(rolesList, role.getName())>
						</cfloop>

				        <cfloginuser name="#thisUser.getUsername()#" password="#thisUser.getPassword()#" roles="#rolesList#">
					<cfelse>
						<h1 style="color: red;">Invalid Credentials</h1>

						<cfinclude template="login.cfm">

						<cfabort>
					</cfif>
			    </cfif>
			</cflogin>
		</cfif>

		<cfif (targetPage contains "admin") and not (isUserInRole("admin"))>
			<h1>Not Allowed</h1>

			<cfabort>
		</cfif>
	</cffunction>

	<cffunction name="onError">
		<cfparam name="application.Clouseau.error" default="#arrayNew(1)#">

		<cfset arrayAppend(application.Clouseau.error, arguments)>

		<div style="border: thin solid red;">ERROR</div>
	</cffunction>
</cfcomponent>