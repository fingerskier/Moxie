<cfif isDefined("URL.scope")>
	<cfif (URL.scope contains "error") or (URL.scope contains "debug")>
		<cfset thisn = evaluate(URL.scope & '[#URL.key#]')>
	<cfelse>
		<cfset thisn = evaluate(URL.scope & '.' & URL.key)>
	</cfif>

	<cfdump var="#thisn#">
</cfif>

<cfif isDefined("URL.log")>
	<cffile action="read" file="#application.Clouseau.logPath#/#URL.log#" variable="logFile">

	<cfset logLength = listLen(logFile, "#chr(10)#,#chr(13)#")>
	<cfset startLine = logLength - 99>
	<cfif startLine lt 1>
		<cfset startLine = 1>
	</cfif>

	<cfoutput>
		<cfset thisStyle = "">
		<div>
		<cfloop from="#startLine#" to="#logLength#" index="I">
			<cfset thisLine = listGetAt(logFile, I, "#chr(10)#,#chr(13)#")>
			<cfset thisLine = mid(thisLine, 2, len(thisLine)-2)>

			<cfif "Information,Error" contains thisLine>
				<cfset thisStyle = "">
				</div>
				<div>
				<br>
			</cfif>

			<cfif thisLine eq application.applicationName>
				<cfset thisStyle = "color: darkgreen; font-weight: bold;">
			</cfif>

			<cfif not isDate(thisLine)>
				<br>
			</cfif>

			<span style="#thisStyle#">#thisLine#</span>
		</cfloop>
	</cfoutput>
</cfif>
