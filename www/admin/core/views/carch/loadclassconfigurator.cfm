﻿ <!--- This file is part of Mura CMS.

Mura CMS is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, Version 2 of the License.

Mura CMS is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Mura CMS. If not, see <http://www.gnu.org/licenses/>.

Linking Mura CMS statically or dynamically with other modules constitutes the preparation of a derivative work based on 
Mura CMS. Thus, the terms and conditions of the GNU General Public License version 2 ("GPL") cover the entire combined work.

However, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with programs
or libraries that are released under the GNU Lesser General Public License version 2.1.

In addition, as a special exception, the copyright holders of Mura CMS grant you permission to combine Mura CMS with 
independent software modules (plugins, themes and bundles), and to distribute these plugins, themes and bundles without 
Mura CMS under the license of your choice, provided that you follow these specific guidelines: 

Your custom code 

• Must not alter any default objects in the Mura CMS database and
• May not alter the default display of the Mura CMS logo within Mura CMS and
• Must not alter any files in the following directories.

 /admin/
 /tasks/
 /config/
 /requirements/mura/
 /Application.cfc
 /index.cfm
 /MuraProxy.cfc

You may copy and distribute Mura CMS with a plug-in, theme or bundle that meets the above guidelines as a combined work 
under the terms of GPL for Mura CMS, provided that you include the source code of that other code when and as the GNU GPL 
requires distribution of source code.

For clarity, if you create a modified version of Mura CMS, you are not obligated to grant this special exception for your 
modified version; it is your choice whether to do so, or to make such modified version available under the GNU General Public License 
version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS.
--->
<cfsilent>
	<cfset request.layout=false>
	<cfparam name="rc.layoutmanager" default="false">
	<cfparam name="rc.container" default="">
	<cfparam name="rc.contentid" default="">
	<cfparam name="rc.parentid" default="">
	<cfparam name="rc.contenthistid" default="">
	<cfparam name="rc.objectid" default=""/>
	<cfset contentRendererUtility=rc.$.getBean('contentRendererUtility')>
	<cfset rc.classid=listLast(replace(rc.classid, "\", "/", "ALL"),"/")>
	<cfset rc.container=listLast(replace(rc.container, "\", "/", "ALL"),"/")>
	<cfif isDefined("form.params") and isJSON(form.params)>
		<cfset objectParams=deserializeJSON(form.params)>
	<cfelse>
		<cfset objectParams={}>
	</cfif>
	<cfset data=structNew()>
	<cfset filefound=false>
	<cfset $=rc.$>

	<cfset $.event('contentBean',$.getBean('content').loadBy(contehistid=rc.contenthistid))>

	<cfif rc.classid eq "category_summary" and not application.configBean.getValue(property='allowopenfeeds',defaultValue=false)>
		<cfset rc.classid='navigation'>
	</cfif>

	<cfif rc.classid eq 'form_responses'>
		<cfset rc.classid='form'>
	<cfelseif rc.classid eq 'mailing_list_master'>
		<cfset rc.classid='mailing_list'>
	<cfelseif listFindNoCase('comments,favorites,forward_email,event_reminder_form,rater,payPalCart,user_tools,goToFirstChild',rc.classid)>
		<cfset rc.classid='system'>
	<cfelseif listFindNoCase('sub_nav,peer_nav,standard_nav,portal_nav,folder_nav,multilevel_nav,seq_nav,top_nav,calendar_nav,archive_nav',rc.classid)>
		<cfset rc.classid='navigation'>
	</cfif>

	<cfif rc.container eq 'layout'>
		<cfset configFileSuffix="#rc.classid#/layout/index.cfm">
	<cfelse>
		<cfset configFileSuffix="#rc.classid#/configurator.cfm">
	</cfif>

	<cfset configFile=rc.$.siteConfig().lookupDisplayObjectFilePath(configFileSuffix)>
</cfsilent>

<cfif len(configFile)>
	<cfinclude template="#configFile#">
<cfelse>
	<cfswitch expression="#rc.classid#">	
		<cfcase value="feed">
			<cfinclude template="objectclass/legacy/dsp_feed_configurator.cfm">
		</cfcase>
		<cfcase value="feed_slideshow">
			<cfinclude template="objectclass/legacy/dsp_slideshow_configurator.cfm">
		</cfcase>
		<cfcase value="related_content,related_section_content">
			<cfinclude template="objectclass/legacy/dsp_related_content_configurator.cfm">
		</cfcase>
		<cfdefaultcase>
			<cfif rc.$.useLayoutManager()>
				<cf_objectconfigurator></cf_objectconfigurator>
			<cfelse>
				<cfoutput>
					<p class="alert">This display object is not configurable.</p>
				</cfoutput>
			</cfif>	
		</cfdefaultcase>
	</cfswitch>
</cfif>
