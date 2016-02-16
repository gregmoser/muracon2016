<!--- This file is part of Mura CMS.

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
<cfparam name="local" default="#structNew()#">
<cfparam name="application.appInitializedTime" default="" />
<cfparam name="application.appInitialized" default="false" />
<cfparam name="application.appAutoUpdated" default="false" />
<cfparam name="application.appReloadKey" default="appreload" />
<cfparam name="application.broadcastInit" default="false" />
<cfparam name="application.sessionTrackingThrottle" default="true"/>
<cfparam name="application.instanceID" default="#createUUID()#" />
<cfparam name="application.CFVersion" default="#listFirst(SERVER.COLDFUSION.PRODUCTVERSION)#" />
<cfparam name="application.setupComplete" default="false">

<cfset request.muraAppreloaded=true>

<cfif left(server.coldfusion.productversion,5) eq "9,0,0" or listFirst(server.coldfusion.productversion) lt 9>
	<cfoutput>Mura CMS requires Adobe Coldfusion 9.0.1 or greater compatibility</cfoutput>
	<cfabort>
</cfif>
<!--- this is here for CF8 compatibility --->
<cfset variables.baseDir=this.baseDir>
<cfprocessingdirective pageencoding="utf-8"/>
<cfsetting requestTimeout = "1000"> 

<!--- do a settings setup check --->
<cfif NOT application.setupComplete OR (not application.appInitialized or structKeyExists(url,application.appReloadKey) )>
	<cfif getINIProperty(entry="mode",section="settings") eq "production">
		<cfif directoryExists( variables.basedir & "/config/setup" )>
			<cfset application.setupComplete = false />
			<!--- check the settings --->
			<cfparam name="application.setupSubmitButton" default="A#hash( createUUID() )#" />
			<cfparam name="application.setupSubmitButtonComplete" default="A#hash( createUUID() )#" />
			
			<cfif trim( getINIProperty("datasource") ) IS NOT ""
					AND (
						NOT isDefined( "FORM.#application.setupSubmitButton#" )
						AND
						NOT isDefined( "FORM.#application.setupSubmitButtonComplete#" )
						)
				>		
						
				<cfset application.setupComplete = true />
			<cfelse>
				<!--- check to see if the index.cfm page exists in the setup folder --->
				<cfif NOT fileExists( variables.basedir & "/config/setup/index.cfm" )>
					<cfthrow message="Your setup directory is incomplete. Please reset it up from the Mura source." />
				</cfif>
				<cfset application.setupComplete = false />
			</cfif>	
		<cfelse>
			<cfset application.setupComplete = true />
		</cfif>
	<cfelse>		
		<cfset application.setupComplete=true>
	</cfif>
</cfif>	

<cfif application.setupComplete>
	<cfset application.appInitialized=false>
	<cfset request.muraShowTrace=true>
	
	<cfset application.appInitialized=false>
	<cfset request.muraShowTrace=true>
		
	<cfset variables.iniPath = "#variables.basedir#/config/settings.ini.cfm" />
		
	<cfset variables.iniSections=getProfileSections(variables.iniPath)>
		
	<cfset variables.iniProperties=structNew()>
	<cfloop list="#variables.iniSections.settings#" index="variables.p">
		<cfset variables.iniProperties[variables.p]=getProfileString("#variables.basedir#/config/settings.ini.cfm","settings",variables.p)>			
		<cfif left(variables.iniProperties[variables.p],2) eq "${"
			and right(variables.iniProperties[variables.p],1) eq "}">
			<cfset variables.iniProperties[variables.p]=mid(variables.iniProperties[variables.p],3,len(variables.iniProperties[variables.p])-3)>
			<cfset variables.iniProperties[variables.p] = evaluate(variables.iniProperties[variables.p])>
		<cfelseif left(variables.iniProperties[variables.p],2) eq "{{"
			and right(variables.iniProperties[variables.p],2) eq "}}">
			<cfset variables.iniProperties[variables.p]=mid(variables.iniProperties[variables.p],3,len(variables.iniProperties[variables.p])-4)>
			<cfset variables.iniProperties[variables.p] = evaluate(variables.iniProperties[variables.p])>
		</cfif>		
	</cfloop>		
		
	<cfloop list="#variables.iniSections[ variables.iniProperties.mode]#" index="variables.p">
		<cfset variables.iniProperties[variables.p]=getProfileString("#variables.basedir#/config/settings.ini.cfm", variables.iniProperties.mode,variables.p)>
		<cfif left(variables.iniProperties[variables.p],2) eq "${"
			and right(variables.iniProperties[variables.p],1) eq "}">
			<cfset variables.iniProperties[variables.p]=mid(variables.iniProperties[variables.p],3,len(variables.iniProperties[variables.p])-3)>
			<cfset variables.iniProperties[variables.p] = evaluate(variables.iniProperties[variables.p])>
		<cfelseif left(variables.iniProperties[variables.p],2) eq "{{"
			and right(variables.iniProperties[variables.p],2) eq "}}">
			<cfset variables.iniProperties[variables.p]=mid(variables.iniProperties[variables.p],3,len(variables.iniProperties[variables.p])-4)>
			<cfset variables.iniProperties[variables.p] = evaluate(variables.iniProperties[variables.p])>
		</cfif>		
	</cfloop>
	
	<cfset variables.iniProperties.webroot = expandPath("/muraWRM") />
	<cfset variables.mode = variables.iniProperties.mode />
	<cfset variables.mapdir = variables.iniProperties.mapdir />
	<cfset variables.webroot = variables.iniProperties.webroot />
		
	<cfif not structKeyExists(variables.iniProperties,"useFileMode")>
		<cfset variables.iniProperties.useFileMode=true>
	</cfif>

	<cfif not StructKeyExists(variables.iniProperties, 'fileDelim')>
		<cfset variables.iniProperties.fileDelim = '' />
	</cfif>
		
	<cfset application.appReloadKey = variables.iniProperties.appreloadkey />
		
	<cfset variables.iniProperties.webroot = expandPath("/muraWRM") />
		
	<cfset variables.tracer=createObject("component","mura.cfobject").init()>
	
	<cfset variables.tracepoint=variables.tracer.initTracepoint("Instantiating DI1")> 
		
	<cfscript>
		if(directoryExists(expandPath("/mura/content/file/imagecfc"))){
	    	directoryDelete(expandPath("/mura/content/file/imagecfc") ,true);
	    }

	    if(fileExists(expandPath("/mura/content/file/image.cfc"))){
	    	fileDelete(expandPath("/mura/content/file/image.cfc"));
	    }
	    
		application.configBean=new mura.configBean().set(variables.iniProperties);

		variables.serviceFactory=new mura.bean.beanFactory("/mura",{
				recurse=true,
				exclude=["/.","/mura/autoUpdater/global","/mura/bean/beanFactory.cfc"],
				strict=application.configBean.getStrictFactory(),
				transientPattern = "(Iterator|Bean|MuraScope|Event|dbUtility|extendObject)$" 
				});

		variables.serviceFactory.addBean("useFileMode",application.configBean.getUseFileMode());
		variables.serviceFactory.addBean("tempDir",application.configBean.getTempDir());
		variables.serviceFactory.addBean("configBean",application.configBean);
		variables.serviceFactory.addBean("data","");
		variables.serviceFactory.addBean("settings",{});
		variables.serviceFactory.addBean("resourceDirectory","");
		variables.serviceFactory.addBean("locale","en_us");
		variables.serviceFactory.addBean("parentFactory","");

		if(server.coldfusion.productName eq 'Coldfusion Server'){
			variables.serviceFactory.addAlias("contentGateway","contentGatewayAdobe");
		} else {
			variables.serviceFactory.addAlias("contentGateway","contentGatewayLucee");
		}

		if(getINIProperty("javaEnabled",true)){
			variables.serviceFactory.addBean('javaLoader',
					new mura.javaloader.JavaLoader(
						loadPaths=[
									expandPath('/mura/lib/jBCrypt-0.3'),
									expandPath('/mura/lib/diff_match_patch.jar')
								]
					)
				);
		}

		variables.serviceFactory.addBean("fileWriter",
			new mura.fileWriter()
		);

		variables.serviceFactory.declareBean("beanValidator", "mura.bean.beanValidator", true);
		
		variables.serviceFactory.addAlias("scriptProtectionFilter","Portcullis");
		variables.serviceFactory.addAlias("eventManager","pluginManager");
		variables.serviceFactory.addAlias("permUtility","permission");
		variables.serviceFactory.addAlias("content","contentBean");
		variables.serviceFactory.addAlias("contentCategoryAssign","contentCategoryAssignBean");
		variables.serviceFactory.addAlias("HTMLExporter","contentHTMLExporter");
		variables.serviceFactory.addAlias("feed","feedBean");
		variables.serviceFactory.addAlias("contentFeed","feedBean");
		variables.serviceFactory.addAlias("site","settingsBean");
		variables.serviceFactory.addAlias("user","userBean");
		variables.serviceFactory.addAlias("group","userBean");
		variables.serviceFactory.addAlias("address","addressBean");
		variables.serviceFactory.addAlias("category","categoryBean");
		variables.serviceFactory.addAlias("categoryFeed","categoryFeedBean");
		variables.serviceFactory.addAlias("userFeed","userFeedBean");
		variables.serviceFactory.addAlias("comment","contentCommentBean");
		variables.serviceFactory.addAlias("commentFeed","contentCommentFeedBean");
		variables.serviceFactory.addAlias("stats","contentStatsBean");
		variables.serviceFactory.addAlias("changeset","changesetBean");
		variables.serviceFactory.addAlias("bundle","settingsBundle");
		variables.serviceFactory.addAlias("mailingList","mailingListBean");
		variables.serviceFactory.addAlias("mailingListMember","memberBean");
		variables.serviceFactory.addAlias("groupDAO","userDAO");

		//The ad manager has been removed, but may be there in certain legacy conditions
		if(variables.serviceFactory.containsBean('placementBean')){
			variables.serviceFactory.addAlias("placement","placementBean");
			variables.serviceFactory.addAlias("creative","creativeBean");
			variables.serviceFactory.addAlias("adZone","adZoneBean");
			variables.serviceFactory.addAlias("campaign","campaignBean");
		}
	
		variables.serviceFactory.addAlias("rate","rateBean");
		variables.serviceFactory.addAlias("favorite","favoriteBean");
		variables.serviceFactory.addAlias("email","emailBean");
		variables.serviceFactory.addAlias("imageSize","settingsImageSizeBean");
		variables.serviceFactory.addAlias("imageSizeIterator","settingsImageSizeIterator");
		variables.serviceFactory.addAlias("$","MuraScope");
		variables.serviceFactory.addAlias("approvalchain","approvalchainBean");
		variables.serviceFactory.addAlias("approvalRequest","approvalRequestBean");
		variables.serviceFactory.addAlias("approvalAction","approvalActionBean");
		variables.serviceFactory.addAlias("approvalChainMembership","approvalChainMembershipBean");
		variables.serviceFactory.addAlias("approvalChainAssignment","approvalChainAssignmentBean");
		variables.serviceFactory.addAlias("changesetRollBack","changesetRollBackBean");
		variables.serviceFactory.addAlias("contentSourceMap","contentSourceMapBean");
		variables.serviceFactory.addAlias("relatedContentSet","extendRelatedContentSetBean");
		variables.serviceFactory.addAlias("fileMetaData","contentFileMetaDataBean");
		variables.serviceFactory.addAlias("file","fileBean");
		variables.serviceFactory.addAlias("razunaSettings","razunaSettingsBean");
		variables.serviceFactory.addAlias("contentFilenameArchive","contentFilenameArchiveBean");
		variables.serviceFactory.addAlias("commenter","contentCommenterBean");
		variables.serviceFactory.addAlias("changesetCategoryAssignment","changesetCategoryAssignmentBean");
		variables.serviceFactory.addAlias("changesetTagAssignment","changesetTagAssignmentBean");
		variables.serviceFactory.addAlias("userDevice","userDeviceBean");
		application.serviceFactory=variables.serviceFactory;
	</cfscript>

	<cfif listfindnocase('oracle,postgresql,nuodb', application.configBean.getDbType()) >
		<cfset application.configBean.setDbCaseSensitive(true)>
	</cfif>
	
	<cftry>
		<cfif not application.configBean.getDbCaseSensitive() and application.serviceFactory.getBean('dbUtility').version().database_productname eq 'h2'>
			<cfset application.configBean.setDbCaseSensitive(true)>
		</cfif>
		<cfcatch></cfcatch>
	</cftry>

	<cfset variables.tracer.commitTracepoint(variables.tracepoint)>
	

	<cftry>
		<cfobjectcache action="clear" />
		<cfcatch></cfcatch>
	</cftry>
	
	<!---You can create an onGlobalConfig.cfm file that runs after the initial configBean loads, but before anything else is loaded --->
	<cfif fileExists(ExpandPath("/muraWRM/config/onGlobalConfig.cfm"))>
		<cfinclude template="/muraWRM/config/onGlobalConfig.cfm">
	</cfif>

	<cfset application.objectMappings={}>
	<cfset application.objectMappings.bundleableBeans="">
	<cfset application.objectMappings.versionedBeans="">

	<cfif application.appAutoUpdated or isdefined('url.applyDBUpdates')>
		<cfset variables.tracepoint=variables.tracer.initTracepoint("Checking/Applying DB updates")> 
		<cfset application.configBean.applyDbUpdates() />
		<cfset variables.tracer.commitTracepoint(variables.tracepoint)>
	<cfelseif fileExists(ExpandPath("/muraWRM/config/objectMappings.json.cfm"))>
		<cffile variable="variables.objectMappingJSON" action="read" file="#ExpandPath("/muraWRM/config/objectMappings.json.cfm")#"  />
		<cfset application.objectMappings=deserializeJSON(variables.objectMappingJSON)>
	<cfelse>
		<cfscript>
			variables.serviceFactory.getBean('approvalChain');
			variables.serviceFactory.getBean('approvalChainMembership');
			variables.serviceFactory.getBean('approvalRequest');
			variables.serviceFactory.getBean('approvalAction');
			variables.serviceFactory.getBean('approvalChainAssignment');
			variables.serviceFactory.getBean('changesetRollBack');
			variables.serviceFactory.getBean('contentSourceMap');
			variables.serviceFactory.getBean('relatedContentSet');
			variables.serviceFactory.getBean('fileMetaData');
			variables.serviceFactory.getBean('file');
			variables.serviceFactory.getBean('razunaSettings');
			variables.serviceFactory.getBean('contentFilenameArchive');
			variables.serviceFactory.getBean('commenter');
			variables.serviceFactory.getBean('userDevice');
		</cfscript>
	</cfif>
		
	<cfset application.appAutoUpdated=false>
				
	<cfset variables.serviceList="utility,pluginManager,settingsManager,contentManager,eventManager,contentRenderer,contentUtility,contentGateway,categoryManager,clusterManager,contentServer,changesetManager,scriptProtectionFilter,permUtility,emailManager,loginManager,mailinglistManager,userManager,dataCollectionManager,feedManager,sessionTrackingManager,favoriteManager,raterManager,dashboardManager,autoUpdater">
		
	<!--- The ad manager has been removed, but may be there in certain legacy conditions --->
	<cfif application.serviceFactory.containsBean('advertiserManager')>
		<cfset variables.serviceList=listAppend(variables.serviceList,'advertiserManager')>
	</cfif>

	<!--- These application level services use the beanServicePlaceHolder to lazy load the bean --->
	<cfloop list="#variables.serviceList#" index="variables.i">			
		<cfset variables.tracepoint=variables.tracer.initTracepoint("Instantiating #variables.i#")> 	
		<cftry>
			<cfset application["#variables.i#"]=application.serviceFactory.getBean("#variables.i#") />
			<cfcatch>
				<cfif application.configBean.getDebuggingEnabled()>
					<cfdump var="#variables.i#">
					<cfdump var="#cfcatch#" abort="true">
				</cfif>
			</cfcatch>
		</cftry>
		<cfset variables.tracer.commitTracepoint(variables.tracepoint)>
	</cfloop>	
	

	<!--- End beanServicePlaceHolders --->

	<cfsavecontent variable="variables.temp"><cfoutput><cfinclude template="/mura/bad_words.txt"></cfoutput></cfsavecontent>
	<cfset application.badwords = ReReplaceNoCase(trim(variables.temp), "," , "|" , "ALL")/> 

	<cfset variables.tracepoint=variables.tracer.initTracepoint("Instantiating classExtensionManager")> 
	<cfset application.classExtensionManager=application.configBean.getClassExtensionManager() />
	<cfset variables.tracer.commitTracepoint(variables.tracepoint)>

	<cfset variables.tracepoint=variables.tracer.initTracepoint("Instantiating resourceBundleFactory")> 
	<cfset application.rbFactory=new mura.resourceBundle.resourceBundleFactory() />
	<cfset variables.tracer.commitTracepoint(variables.tracepoint)>
			
	<!---settings.custom.managers.cfm reference is for backwards compatibility --->
	<cfif fileExists(ExpandPath("/muraWRM/config/settings.custom.managers.cfm"))>
		<cfinclude template="/muraWRM/config/settings.custom.managers.cfm">
	</cfif>		
					
	<cfset variables.basedir=expandPath("/muraWRM")/>
	<cfset variables.mapprefix="" />
		
	<cfif len(application.configBean.getValue('encryptionKey'))>
		<cfset application.encryptionKey=application.configBean.getValue('encryptionKey')>
	</cfif>
					
	<cfdirectory action="list" directory="#variables.basedir#/requirements/" name="variables.rsRequirements">

	<cfloop query="variables.rsRequirements">
		<cfif variables.rsRequirements.type eq "dir" and variables.rsRequirements.name neq '.svn' and not structKeyExists(this.mappings,"/#variables.rsRequirements.name#")>
			<cfset application.serviceFactory.getBean("fileWriter").appendFile(file="#variables.basedir#/config/mappings.cfm", output='<cfset this.mappings["/#variables.rsRequirements.name#"] = variables.basedir & "/requirements/#variables.rsRequirements.name#">')>				
		</cfif>
	</cfloop>	

	<cfif application.configBean.getValue("autoDiscoverPlugins") and not isdefined("url.safemode")>
		<cfset application.pluginManager.discover()>
	</cfif>
		
	<cfset application.cfstatic=structNew()>			
	<cfset application.appInitialized=true/>
	<cfset application.appInitializedTime=now()>
	<cfset application.clusterManager.reload(broadcast=application.broadcastInit)>
	<cfset application.broadcastInit=true/>
	<cfset structDelete(application,"muraAdmin")>
	<cfset structDelete(application,"proxyServices")>
	<cfset structDelete(application,"CKFinderResources")>
		
	<!--- Set up scheduled tasks --->
	<cfif (len(application.configBean.getServerPort())-1) lt 1>
		<cfset variables.port=80/>
	<cfelse>
		<cfset variables.port=right(application.configBean.getServerPort(),len(application.configBean.getServerPort())-1) />
	</cfif>
			
	<cfif listFindNoCase('Railo,Lucee',application.configBean.getCompiler())>
		<cfset variables.siteMonitorTask="siteMonitor"/>
	<cfelse>
		<cfset variables.siteMonitorTask="#application.configBean.getWebRoot()#/index.cfm/_api/sitemonitor/"/>
	</cfif>
			
	<cftry>
		<cfif variables.iniProperties.ping eq 1>
			<cfschedule action = "update"
				task = "#variables.siteMonitorTask#"
				operation = "HTTPRequest"
				url = "http://#listFirst(cgi.http_host,":")##application.configBean.getContext()#/index.cfm/_api/sitemonitor/"
				port="#variables.port#"
				startDate = "#dateFormat(now(),'mm/dd/yyyy')#"
				startTime = "#createTime(0,15,0)#"
				publish = "No"
				interval = "900"
				requestTimeOut = "600"
			/>
		</cfif>
		<cfcatch></cfcatch>
	</cftry>
						
	<cfif application.configBean.getCreateRequiredDirectories()>
		<cfif not directoryExists("#application.configBean.getWebRoot()#/plugins")> 
			<cftry>
				<cfdirectory action="create" mode="777" directory="#application.configBean.getWebRoot()#/plugins"> 
				<cfcatch>
					<cfdirectory action="create" directory="#application.configBean.getWebRoot()#/plugins"> 
				</cfcatch>
			</cftry>
		</cfif>
		
		<cfif not fileExists(variables.basedir & "/robots.txt")>	
			<cfset application.serviceFactory.getBean("fileWriter").copyFile(source="#variables.basedir#/config/templates/robots.template.cfm", destination="#variables.basedir#/robots.txt")>
		</cfif>

		<cfif not fileExists(variables.basedir & "/web.config")>	
			<cfset application.serviceFactory.getBean("fileWriter").copyFile(source="#variables.basedir#/config/templates/web.config.template.cfm", destination="#variables.basedir#/web.config")>
		</cfif>

		<cfif not fileExists(variables.basedir & "/requirements/cfformprotect/cffp.ini.cfm")>	
			<cfset application.serviceFactory.getBean("fileWriter").copyFile(source="#variables.basedir#/config/templates/cffp.ini.template.cfm", destination="#variables.basedir#/requirements/cfformprotect/cffp.ini.cfm")>
		</cfif>
	</cfif>
		
	<cfif not structKeyExists(application,"plugins")>
		<cfset application.plugins=structNew()>
	</cfif>
	<cfset application.pluginstemp=application.plugins>
	<cfset application.plugins=structNew()>
	<cfset variables.pluginEvent=createObject("component","mura.event").init()>		

	<!---
	<cfset application.pluginManager.discoverBeans()>
	--->
	<cftry>	
		<cfset application.pluginManager.executeScripts(runat='onApplicationLoad',event= variables.pluginEvent)>
		<cfcatch>
			<cfset structAppend(application.plugins,application.pluginstemp,false)>
			<cfset structDelete(application,"pluginstemp")>
			<cfrethrow>
		</cfcatch>
	</cftry>

	<cfset structDelete(application,"pluginstemp")>

	<!--- Fire local onApplicationLoad events--->
	<cfset variables.rsSites=application.settingsManager.getList() />
		
	<cfloop query="variables.rsSites">	
		<cfset variables.siteBean=application.settingsManager.getSite(variables.rsSites.siteID)>
		<cfset variables.themedir=expandPath(variables.siteBean.getThemeIncludePath())>

		<cfif fileExists(variables.themedir & '/config.xml.cfm')>
			<cfset variables.themeConfig='config.xml.cfm'>
		<cfelseif fileExists(variables.themedir & '/config.xml')>
			<cfset variables.themeConfig='config.xml'>
		<cfelse>
			<cfset variables.themeConfig="">
		</cfif>

		<cfif len(variables.themeConfig)>
			<cfif variables.themeConfig eq "config.xml.cfm">
				<cfsavecontent variable="variables.themeConfig">
					<cfinclude template="#variables.siteBean.getThemeIncludePath()#/config.xml.cfm">
				</cfsavecontent>
			<cfelse>
				<cfset variables.themeConfig=fileRead(variables.themedir & "/" & variables.themeConfig)>
			</cfif>

			<cfif IsValid('xml', variables.themeConfig)>
				<cfset variables.themeConfig=xmlParse(variables.themeConfig)>
				<cfset application.configBean.getClassExtensionManager().loadConfigXML(variables.themeConfig,variables.rsSites.siteid)>
			</cfif>

		</cfif>

		<cfset variables.localHandler=variables.siteBean.getLocalHandler()>

		<cfif isObject(variables.localHandler)>
			<cfif structKeyExists(variables.localhandler,"onApplicationLoad")>		
				<cfset variables.pluginEvent.setValue("siteID",variables.rsSites.siteID)>
				<cfset variables.pluginEvent.loadSiteRelatedObjects()>

				<cfif not isDefined('variables.localhandler.injectMethod')>
					<cfset variables.localhandler.injectMethod=variables.pluginEvent.injectMethod>
				</cfif>

				<cfif not isDefined('variables.localhandler.getValue')>
					<cfset variables.localhandler.injectMethod('getValue',variables.pluginEvent.getValue)>
				</cfif>

				<cfif not isDefined('variables.localhandler.setValue')>
					<cfset variables.localhandler.injectMethod('setValue',variables.pluginEvent.setValue)>
				</cfif>

				<cfset variables.tracepoint=application.pluginManager.initTracepoint("#variables.localhandler.getValue('_objectName')#.onApplicationLoad")>
				<cfset variables.localhandler.onApplicationLoad(event=variables.pluginEvent,$=variables.pluginEvent.getValue("muraScope"),mura=variables.pluginEvent.getValue("muraScope"))>
				<cfset application.pluginManager.commitTracepoint(variables.tracepoint)>
			</cfif>
		</cfif>

		<cfset variables.expandedPath=expandPath(variables.siteBean.getThemeIncludePath()) & "/eventHandler.cfc">
		<cfif fileExists(variables.expandedPath)>
			<cfset variables.themeHandler=createObject("component","#variables.siteBean.getThemeAssetMap()#.eventHandler").init()>
			<cfif structKeyExists(variables.themeHandler,"onApplicationLoad")>		
				<cfset variables.pluginEvent.setValue("siteID",variables.rsSites.siteID)>
				<cfset variables.pluginEvent.loadSiteRelatedObjects()>

				<cfif not isDefined('variables.themeHandler.injectMethod')>
					<cfset variables.themeHandler.injectMethod=variables.pluginEvent.injectMethod>
				</cfif>

				<cfif not isDefined('variables.themeHandler.getValue')>
					<cfset variables.themeHandler.injectMethod('getValue',variables.pluginEvent.getValue)>
				</cfif>

				<cfif not isDefined('variables.themeHandler.setValue')>
					<cfset variables.themeHandler.injectMethod('setValue',variables.pluginEvent.setValue)>
				</cfif>
				
				<cfset variables.themeHandler.setValue("_objectName","#variables.siteBean.getThemeAssetMap()#.eventHandler")>
				<cfset variables.tracepoint=application.pluginManager.initTracepoint("#variables.themeHandler.getValue('_objectName')#.onApplicationLoad")>
				<cfset variables.themeHandler.onApplicationLoad(event=variables.pluginEvent,$=variables.pluginEvent.getValue("muraScope"),mura=variables.pluginEvent.getValue("muraScope"))>
				<cfset application.pluginManager.commitTracepoint(variables.tracepoint)>
			</cfif>
			<cfset application.pluginManager.addEventHandler(variables.themeHandler,variables.rsSites.siteID)>
		</cfif>	
	</cfloop>

	<!--- This looks for and update File and Link nodes that legacy urls --->
	<cfquery name="variables.legacyURLs" datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDbUserName()#" password="#application.configBean.getDbPassword()#">
		select contenthistID, contentID,parentId,siteID,filename,urlTitle,filename from tcontent where type in ('File','Link')
		and active=1
		and body is null
		and filename is not null
	</cfquery>
		
	<cfset variables.legacyURLsIterator=application.serviceFactory.getBean("contentIterator").setQuery(variables.legacyURLs)>

	<cfloop condition="variables.legacyURLsIterator.hasNext()">
		<cfset variables.item=variables.legacyURLsIterator.next()>

		<cfquery  datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDbUserName()#" password="#application.configBean.getDbPassword()#">
			update tcontent set body=filename where 
			contentID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.item.getContentID()#">
			and siteID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.item.getSiteID()#">
			and body is null
		</cfquery>

		<cfset application.serviceFactory.getBean("contentUtility").setUniqueFilename(variables.item)>

		<cftry>
			<cfquery  datasource="#application.configBean.getDatasource()#" username="#application.configBean.getDbUserName()#" password="#application.configBean.getDbPassword()#">
				update tcontent set filename=<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.item.getFilename()#">,
				urlTitle=<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.item.getURLTitle()#">  where 
				contentid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.item.getContentID()#">
				and siteID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#variables.item.getSiteID()#">
			</cfquery>
			<cfcatch>
				<cfthrow message="An error occurred trying to create a filename for #variables.item.getFilename()#">
			</cfcatch>
		</cftry>
	</cfloop>

	<!--- Clean root admin directory --->
	<cfdirectory action="list" directory="#expandPath('/muraWRM/admin/')#" name="local.rs">
	<cfset local.tempDir=expandPath('/muraWRM/admin/temp/')>
	<cfset local.fileWriter=application.serviceFactory.getBean('fileWriter')>
	<cfloop query="local.rs">
		<cfif not listFind('.gitignore,.svn,Application.cfc,assets,common,core,framework.cfc,index.cfm,temp,custom',local.rs.name)>
			<cftry>
			<cfset local.fileWriter.touchDir(local.tempDir)>
			<cfif local.rs.type eq 'dir'>
				<cfset local.fileWriter.renameDir(directory=local.rs.directory & "/" & local.rs.name,newDirectory=local.rs.directory & "/temp/" & local.rs.name )>
			<cfelse>
				<cfset local.fileWriter.renameFile(source=local.rs.directory & "/" & local.rs.name,destination=local.rs.directory & "/temp/" & local.rs.name )>
			</cfif>
			<cfcatch></cfcatch>
			</cftry>
		</cfif>
	</cfloop>

	<cfset local.bundleLoc=expandPath("/muraWRM/config/setup/deploy/bundle.zip")>
	<cfif fileExists(local.bundleLoc) and application.contentGateway.getPageCount('default').counter eq 1>
		<cfset application.settingsManager.restoreBundle(
			bundleFile=local.bundleLoc, 
			keyMode='publish',
			siteID='default',
			contentMode='all',
			pluginMode='all'
		)>
		<cfset application.serviceFactory.getBean('fileWriter').renameFile(source=local.bundleLoc,destination=expandPath("/muraWRM/config/setup/deploy/#createUUID()#.zip"))>
	</cfif>

	<cfset application.sessionTrackingThrottle=false>

	<!-- Clean out old cluster commands --->
	<cfset application.clusterManager.clearOldCommands()>
</cfif> 