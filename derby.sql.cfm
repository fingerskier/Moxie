﻿<cfquery>
	create table User (
		ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		Created timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Updated timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Username VARCHAR(33) NOT NULL WITH DEFAULT '',
		Password VARCHAR(33) NOT NULL WITH DEFAULT '',
		FullName VARCHAR(111) NOT NULL WITH DEFAULT '',
		Phone VARCHAR(33) NOT NULL WITH DEFAULT '',
		Email VARCHAR(77) NOT NULL WITH DEFAULT ''
	)
</cfquery>

<cfquery>
	create table Project (
		ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		Created timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Updated timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Name VARCHAR(77) NOT NULL WITH DEFAULT ""
	)
</cfquery>

<cfquery>
	create table Issue (
		ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		Created timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Updated timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Project_ID INTEGER NOT NULL,
		Name VARCHAR(77) NOT NULL WITH DEFAULT ""

		FOREIGN KEY (Project_ID, SEGMENT_NUMBER)
		REFERENCES Project (Project_ID, SEGMENT_NUMBER)
	)
</cfquery>

<cfquery>
	CREATE TABLE Attachment (
		ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		Created timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Updated timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Issue_ID INTEGER NOT NULL,
		Note CLOB NOT NULL WITH DEFAULT '',
		Image BLOB NOT NULL WITH DEFAULT ''

		FOREIGN KEY (Issue_ID, SEGMENT_NUMBER)
		REFERENCES Project (Issue_ID, SEGMENT_NUMBER)
	)
</cfquery>

<cfquery>
	CREATE TABLE Announcement (
		ID INTEGER NOT NULL GENERATED ALWAYS AS IDENTITY (START WITH 1, INCREMENT BY 1),
		Created timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Updated timestamp NOT NULL WITH DEFAULT TIMESTAMP(),
		Issue_ID INTEGER NOT NULL,
		Note VARCHAR(777) NOT NULL WITH DEFAULT '',
		Details CLOB NOT NULL WITH DEFAULT ''

		FOREIGN KEY (Issue_ID, SEGMENT_NUMBER)
		REFERENCES Project (Issue_ID, SEGMENT_NUMBER)
	)
</cfquery>