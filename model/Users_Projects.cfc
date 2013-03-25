<cfcomponent persistent="true">
	<cfproperty name="ID" fieldtype="ID" generator="increment" setter="false">

	<cfproperty name="UserID" getter="true" ormtype="integer">
	<cfproperty name="ProjectID" getter="true" ormtype="integer">
</cfcomponent>