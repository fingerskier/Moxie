<cfif isdefined("logout")>
	<h1>Logged Out</h1>

	<cfset structDelete(session, "user")>

	<cflogout>

	<cfabort>
</cfif>

<cfoutput>
	<a href="#ajaxLink('account.cfm?logout')#">Logout</a>
</cfoutput>
<br>
<cfdump var="#getauthUser()#">
<br>
<cfdump var="#getuserRoles()#">