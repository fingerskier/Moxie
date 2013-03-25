<!---
--->
<cfset thisn = entitynew("role")>
<cfset thatn = entityNew("role")>

<cfset thisn.setName("admin")>
<cfset thisn.setSuperuser(true)>
<cfset thatn.setName("client")>
<cfset thatn.setSuperuser(true)>

<cfset entitySave(thisn)>
<cfset entitySave(thatn)>

<cfset ormFlushAll()>

<cfset root = entitynew("User")>
<cfset root.setUsername("admin")>
<cfset root.setPassword("secret")>
<cfset root.setFullName("Matt Currier")>
<cfset root.setEmail("fingerskier@gmail.com")>
<cfset root.setPhone("970-216-6630")>
<cfset entitysave(root)>

<cfset ormFlushAll()>

<cfset adminRole = entityload("Role", {Name="admin"})>
<cfset adminRole = adminRole[1]>
<cfset adminUser = entityLoad("User", {Username="admin"})>
<cfset adminUser = adminUser[1]>

<cfset rootRole = entityNew("Users_Roles", {
	UserID=adminUser.getID(),
	RoleID=adminRole.getID()
})>
<cfset entitySave(rootRole)>
