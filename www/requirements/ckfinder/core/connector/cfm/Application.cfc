<!---
 * CKFinder
 * ========
 * http://cksource.com/ckfinder
 * Copyright (C) 2007-2015, CKSource - Frederico Knabben. All rights reserved.
 *
 * The software, this file and its contents are subject to the CKFinder
 * License. Please read the license.txt file before using, installing, copying,
 * modifying or distribute this file or part of its contents. The contents of
 * this file is part of the Source Code of CKFinder.
--->

<cfcomponent displayname="Application" output="false" hint="Pre-page processing for the application">

	<cfinclude template="../../../../../config/applicationSettings.cfm">
    <cfinclude template="../../../../../config/mappings.cfm">
    <cfinclude template="../../../../../plugins/mappings.cfm">
    
    <cfscript>
    THIS.mappings["/CKFinder_Connector"] = mapPrefix & BaseDir & "/requirements/ckfinder/core/connector/cfm/";
    </cfscript>

	<!--- Include the CFC creation proxy. --->
	<cfinclude template="createcfc.udf.cfm" />

	<cffunction name="OnRequestStart" access="public" returntype="boolean" output="false" hint="Pre-page processing for the page request.">
		<!---
		Store the CreateCFC method in the application
		scope.
		--->
		<cfset APPLICATION.CreateCFC = THIS.CreateCFC />
		<cfset APPLICATION.CFVersion = Left(SERVER.COLDFUSION.PRODUCTVERSION,Find(",",SERVER.COLDFUSION.PRODUCTVERSION)-1) />
		<cfreturn true />
	</cffunction>

</cfcomponent>
