<cfset ajaxOnLoad("focuser")>

<cfparam name="projectID" type="integer">
<cfparam name="ID" type="integer">

<cfset project = entityLoadByPK("Project", projectID)>

<cfif ID lt 0>
	<cfset issueID = -7>
	<cfset issue = entityNew("Issue")>
<cfelse>
	<cfset issueID = ID>
	<cfset issue = entityLoadByPK("Issue", ID)>

	<cfquery name="announcements">
		select ID, Note from ANNOUNCEMENT where ISSUEID = #issueID#
	</cfquery>

	<cfquery name="attachments">
		select ID, Note from ATTACHMENT where ISSUEID = #issueID#
	</cfquery>

	<cfquery name="items">
		select ID, Updated, 'announcement' as Type from ANNOUNCEMENT where ISSUEID = #issueID#
		union
		select ID, Updated, 'attachment' as Type from ATTACHMENT where ISSUEID = #issueID#
		order by UPDATED
	</cfquery>
</cfif>

<cfoutput>
	<h3>#project.getName()#</h3>

	<cfform action="issues.cfm" name="issueForm">
		<input name="projectID" type="hidden" value="#projectID#">
		<input name="ID" type="hidden" value="#issueID#">
		<input name="userID" type="hidden" value="#session.userID#">

		<label>
			Description:
			<input name="description" size="77" type="text" value="#issue.getDescription()#">
		</label>
		<br>
		<fieldset>
			<legend>New Announcement</legend>
			<label>
				Subject:
				<input name="announcementNote" size="66" type="text">
			</label>
			<br>
			<label>
				Details:
				<textarea name="announcementDetails"></textarea>
			</label>
		</fieldset>
		<br>
		<fieldset>
			<legend>New Attachment</legend>
			<label>
				Note:
				<input name="attachmentNote" size="66" type="text">
			</label>
			<br>
			<label>
				File:
				<input name="attachmentFile" type="file">
			</label>
		</fieldset>
		<br>
		<input type="submit" value="Save">
	</cfform>

	<cfif isDefined("items")>
		<cfloop query="items">
			<cfif type is "announcement">
				<cfquery dbtype="query" name="thisItem">
					select * from announcements where ID = #ID#
				</cfquery>

				<cfset thisStyle = "ui-state-highlight">
			<cfelseif type is "attachment">
				<cfquery dbtype="query" name="thisItem">
					select * from attachments where ID = #ID#
				</cfquery>

				<cfset thisStyle = "ui-state-default">
			</cfif>

			<div class="#type# #thisStyle#">
				#left(thisItem.note, 100)#
			</div>
		</cfloop>
	</cfif>
</cfoutput>