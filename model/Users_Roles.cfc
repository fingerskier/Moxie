<cfcomponent persistent="true">
	<cfproperty name="ID" fieldtype="ID" generator="increment" setter="false">

	<cfproperty name="UserID" ormtype="integer">
	<cfproperty name="RoleID" ormtype="integer">
</cfcomponent>