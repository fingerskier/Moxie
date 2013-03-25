<cfparam name="application.Clouseau.debug" default="#arrayNew(1)#">

<cfloop collection="#attributes#" item="I">
	<cfset tuple = structNew()>
	<cfset tuple.name = "#I#">
	<cfset tuple.value = evaluate("attributes.#I#")>

	<cfset arrayAppend(application.Clouseau.debug, tuple)>
</cfloop>

<cfexit method="exittag">
