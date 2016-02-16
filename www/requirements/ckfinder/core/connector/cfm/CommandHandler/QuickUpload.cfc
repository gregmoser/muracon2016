<cfcomponent output="false" extends="FileUpload">
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

<cfset THIS.command = "QuickUpload" >

<cffunction name="throwError" access="public" hint="throw file upload error" returntype="boolean" output="true" description="throw file upload error">
	<cfargument name="errorCode" type="Numeric" required="true">
	<cfargument name="errorMsg" type="String" required="false" default="">
	<cfargument name="fileName" type="String" required="false" default="">
	<cfset var funcNum = 0>
	<cfcontent reset="true" type="text/html; charset=UTF-8">
	<cfif isDefined('URL.responseType') and URL.responseType eq "json">
		<cfcontent reset="true" type="application/json; charset=UTF-8">
		<cfset var data = structNew() >
		<cfset data["fileName"] = fileName>
		<cfif ARGUMENTS.errorCode eq REQUEST.constants.CKFINDER_CONNECTOR_ERROR_UPLOADED_FILE_RENAMED or
		ARGUMENTS.errorCode eq REQUEST.constants.CKFINDER_CONNECTOR_ERROR_NONE>
			<cfset data["uploaded"] = 1>
			<cfset data["url"] = THIS.currentFolder.getUrl() & APPLICATION.CreateCFC("Utils.Misc").encodeUriComponent(ARGUMENTS.fileName)>
		<cfelse>
			<cfset data["uploaded"] = 0>
		</cfif>
		<cfif ARGUMENTS.errorCode neq REQUEST.constants.CKFINDER_CONNECTOR_ERROR_NONE>
			<cfset data["error"] = structNew()>
			<cfset data["error"]["number"] = ARGUMENTS.errorCode>
			<cfif not Len(errorMsg)>
				<cfset errorMsg = APPLICATION.CreateCFC("Utils.Misc").getErrorMessage(errorCode, fileName)>
			</cfif>
			<cfset data["error"]["message"] = errorMsg>
		</cfif>
		<cfoutput>#serializeJson(data)#</cfoutput>
	<cfelseif not isDefined('URL.CKEditor')>
		<cfif ARGUMENTS.errorCode eq REQUEST.constants.CKFINDER_CONNECTOR_ERROR_UPLOADED_FILE_RENAMED or
		ARGUMENTS.errorCode eq REQUEST.constants.CKFINDER_CONNECTOR_ERROR_NONE>
		<cfoutput>
		<script type="text/javascript">window.parent.OnUploadCompleted(#ARGUMENTS.errorCode#, '#THIS.currentFolder.getUrl()##replace(APPLICATION.CreateCFC("Utils.Misc").encodeUriComponent(ARGUMENTS.fileName), "'", "\'")#','#replace(ARGUMENTS.fileName, "'", "\'")#','');</script>
		</cfoutput>
		<cfelse>
		<cfoutput>
		<script type="text/javascript">window.parent.OnUploadCompleted(#ARGUMENTS.errorCode#, '#replace(ARGUMENTS.errorMsg, "'", "\'")#');</script>
		</cfoutput>
		</cfif>
	<cfelse>
		<cfif not Len(errorMsg) and errorCode >
			<cfset errorMsg = APPLICATION.CreateCFC("Utils.Misc").getErrorMessage(errorCode, fileName)>
		</cfif>
		<cfset funcNum = ReReplace(URL.CKEditorFuncNum, "[^0-9]", "", "all")>
		<cfif ARGUMENTS.errorCode eq REQUEST.constants.CKFINDER_CONNECTOR_ERROR_UPLOADED_FILE_RENAMED or
		ARGUMENTS.errorCode eq REQUEST.constants.CKFINDER_CONNECTOR_ERROR_NONE>
		<cfoutput>
		<script type="text/javascript">window.parent.CKEDITOR.tools.callFunction(#funcNum#, '#THIS.currentFolder.getUrl()##replace(APPLICATION.CreateCFC("Utils.Misc").encodeUriComponent(ARGUMENTS.fileName), "'", "\'")#', '#replace(errorMsg, "'", "\'")#') ;</script>
		</cfoutput>
		<cfelse>
		<cfoutput>
		<script type="text/javascript">window.parent.CKEDITOR.tools.callFunction(#funcNum#, '', '#replace(errorMsg, "'", "\'")#') ;</script>
		</cfoutput>
		</cfif>
	</cfif>
	<cfreturn true />
</cffunction>

</cfcomponent>
