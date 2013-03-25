<cfcomponent persistent="true">
	<cfproperty name="ID"  fieldtype="id" generator="increment" setter="false">
	<cfproperty name="Created" ormtype="timestamp">
	<cfproperty name="Updated" ormtype="timestamp">

	<cfproperty name="IssueID" ormtype="integer">

	<cfproperty name="Note" ormtype="string">
	<cfproperty name="Details" ormtype="text">

	<cffunction name="preInsert">
		<cfset this.setCreated(now())>
		<cfset this.setUpdated(now())>
	</cffunction>

	<cffunction name="preUpdate">
		<cfargument name="oldData">

		<cfset this.setUpdated(now())>
	</cffunction>
</cfcomponent>