<cfajaximport tags="CFFORM" />

<!doctype html>
<html>
	<head>
		<link href="css/jquery-ui.css" rel="stylesheet" type="text/css">
		<link href="css/application.css" rel="stylesheet" type="text/css">

		<script src="js/jquery.js" type="application/javascript"></script>
		<script src="js/application.js" ty></script>
	</head>

	<body>
		<h1>Moxie <i>Issue Tracker</i></h1>
		<cfdump var="#dateformat(now(), 'full')# #timeFormat(now(), 'full')#">

		<cfmenu type="horizontal">
			<cfif isUserInRole("admin")>
				<cfmenuitem display="Projects" href="#menuLink('admin.projects.cfm')#" />
			</cfif>

			<cfmenuitem display="Issues" href="#menuLink('issues.cfm')#" />

			<cfif isUserInRole("admin")>
				<cfmenuitem display="Roles" href="#menuLink('admin.roles.cfm')#" />

				<cfmenuitem display="Users" href="#menuLink('admin.users.cfm')#" />
			</cfif>

			<cfmenuitem display="Account" href="#menuLink('account.cfm')#" />
		</cfmenu>

		<cfdiv id="mainContent" />
	</body>
</html>

<cffunction name="menuLink">
	<cfargument name="targetPage">

	<cfreturn "javascript:ColdFusion.navigate('#arguments.targetPage#', 'mainContent')">
</cffunction>