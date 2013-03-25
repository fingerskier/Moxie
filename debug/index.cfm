<cfparam name="application.Clouseau" default="#structNew()#">

<cfparam name="application.Clouseau.debug" default="#arrayNew(1)#">

<cfparam name="application.Clouseau.error" default="#arrayNew(1)#">

<cfajaximport tags="CFFORM">

<cflayout type="border" fittowindow="true">
	<cflayoutarea position="top">
		<h1>Clouseau Inspector</h1>
	</cflayoutarea>

	<cflayoutarea collapsible="true" initcollapsed="false" position="left" splitter="true" >
		<cflayout height="" style="float: left;" type="accordion" width="222">
			<cflayoutarea refreshonactivate="true" source="nav.cfc?method=errorNav&cfdebug=true" title="Errors" />
			<cflayoutarea refreshonactivate="true" source="nav.cfc?method=debugNav" title="Debugs" />
			<cflayoutarea refreshonactivate="true" source="nav.cfc?method=logNav" title="Logs" />
			<cflayoutarea refreshonactivate="true" source="nav.cfc?method=sessionNav" title="Session" />
			<cflayoutarea refreshonactivate="true" source="nav.cfc?method=clientNav" title="Client" />
			<cflayoutarea refreshonactivate="true" source="nav.cfc?method=applicationNav" title="Application" />
			<cflayoutarea refreshonactivate="true" source="nav.cfc?method=cookieNav" title="Cookies" />
			<cflayoutarea refreshonactivate="true" source="nav.cfc?method=serverNav" title="Server" />
		</cflayout>
	</cflayoutarea>

	<cflayoutarea name="viewer" position="center" overflow="auto" />
</cflayout>