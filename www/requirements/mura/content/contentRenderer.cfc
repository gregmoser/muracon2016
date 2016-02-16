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
<cfcomponent extends="mura.cfobject" output="false">

<cfset this.navOffSet=0/>
<cfset this.navDepthLimit=1000/>
<cfset this.navParentIdx=2/>
<cfset this.navGrandParentIdx=3/>
<cfset this.navDepthAdjust=0/>
<cfset this.navSelfIdx=1/>
<cfset this.jslib="jquery"/>
<cfset this.jsLibLoaded=false/>
<cfset this.suppressWhitespace=true/>
<cfset this.longDateFormat="long"/>
<cfset this.shortDateFormat="short"/>
<cfset this.showMetaList="jpg,jpeg,png,gif,svg">
<cfset this.imageInList="jpg,jpeg,png,gif,svg">
<cfset this.directImages=true/>
<cfset this.personalization="user">
<cfset this.hasEditableObjects=false>
<cfset this.asyncObjects=true>
<cfset this.asyncRender=false>
<cfset this.layoutmanager=false>

<!--- Set these to a boolean value to override settings.ini.cfm value--->
<cfset this.siteIDInURLS="">
<cfset this.indexFileInURLS="">
<cfset this.hashURLS="">

<cfif isDefined('url.muraadminpreview')>
	<cfset this.showAdminToolBar=false/>
	<cfset this.showMemberToolBar=false/>
	<cfset this.showEditableObjects=false/>
	<cfset this.showInlineEditor=false/>
<cfelse>
	<cfset this.showAdminToolBar=true/>
	<cfset this.showMemberToolBar=true/>
	<cfset this.showEditableObjects=true/>
	<cfset this.showInlineEditor=true/>
</cfif>
<!--- renderHTMLHead has been deprecated in favor of renderHTMLQueues---->
<cfset this.renderHTMLHead=true/>
<cfset this.renderHTMLQueues=true/>
<cfset this.crumbdata=arrayNew(1)/>
<cfset this.listFormat="dl">
<cfset this.headline="h2"/>
<cfset this.subHead1="h3"/>
<cfset this.subHead2="h4"/>
<cfset this.subHead3="h5"/>
<cfset this.subHead4="h6">
<!--- This is duplicated for when the page title gets set to h1 --->
<cfset this.subHead5="h6">
<!--- This is the preloader markup for async objects--->
<cfset this.preloaderMarkup=''>
<!--- These settings are for navigational display objects --->
<cfset this.navWrapperClass="sidebar-nav well">
<cfset this.navLIClass="">
<cfset this.liHasKidsClass="">
<cfset this.liHasKidsAttributes="">
<cfset this.liCurrentClass="current">
<cfset this.liCurrentAttributes="">
<cfset this.liHasKidsNestedClass="">
<cfset this.aHasKidsClass="">
<cfset this.aHasKidsAttributes="">
<cfset this.aCurrentClass="current">
<cfset this.aCurrentAttributes="">
<cfset this.ulNestedClass="">
<cfset this.ulNestedAttributes="">
<cfset this.ulTopClass="navSecondary">
<cfset this.ulPaginationClass="navSequential">
<cfset this.ulPaginationWrapperClass="pagination">
<cfset this.formWrapperClass="well">
<cfset this.generalWrapperClass="well">
<cfset this.aNotCurrentClass="">
<cfset this.bodyMetaImageSizeArgs={size="medium"}>
<cfset this.bodyMetaImageClass="thumbnail">
<!-- This is temp only for backward compatibility--->
<cfset this.shadowboxattribute="rel">
<!--- this is legacy--->
<cfset this.size=50>
<!-- use this--->
<cfset this.navsize=this.size>

<!--- ===================
General Classes
=================== --->

<!--- Forms --->
<cfset this.formWrapperClass = "well">
<cfset this.formFieldWrapperClass = "control-group">
<cfset this.formFieldLabelClass = "control-label">
<cfset this.formInputWrapperClass = "input-addon">
<cfset this.formInputClass ="form-control">
<cfset this.formCheckboxClass = "">
<cfset this.formButtonWrapperClass = "btn-group">
<cfset this.formButtonInnerClass="">
<cfset this.formButtonClass = "btn btn-default">
<cfset this.formRequiredWrapperClass="">

<!--- Images --->
<cfset this.imageClass="img-thumbnail">

<!--- Tables --->
<cfset this.tableClass = "table table-bordered table-striped">
<cfset this.tableHeadClass = "">
<cfset this.tableHeaderClass = "">
<cfset this.tableBodyClass = "">
<cfset this.tableRowClass = "">
<cfset this.tableCellClass = "">
<cfset this.tableFooterClass = "">

<!--- Alerts --->
<cfset this.alertSuccessClass = "alert alert-success">
<cfset this.alertInfoClass = "alert alert-info">
<cfset this.alertWarningClass = "alert">
<cfset this.alertDangerClass = "alert alert-error">


<!--- ===================
Display Objects
=================== --->

<!--- calendar/dsp_showMonth.cfm --->
<cfset this.calendarWrapperClass="svCalendar">
<cfset this.calendarTableClass="table table-bordered">
<cfset this.calendarTableHeaderClass="">

<!--- calendar/dspList.cfm --->
<cfset this.calendarListWrapperClass="svCalendar">

<!--- Comments/index.cfm --->
<cfset this.commentsWrapperClass="">
<cfset this.commentSortContainerClass="">
<cfset this.commentSortWrapperClass="">
<cfset this.commentSortSelectClass="">
<cfset this.commentFormWrapperClass="">
<cfset this.commentFormClass="well">
<cfset this.commentNewClass="btn">
<cfset this.commentFieldWrapperClass="">
<cfset this.commentFieldLabelClass="">
<cfset this.commentInputWrapperClass="">
<cfset this.commentInputClass="">
<cfset this.commentCheckboxClass="checkbox">
<cfset this.commentPrefsInputWrapperClass="">
<cfset this.commentSubmitButtonWrapperClass="">
<cfset this.commentSubmitButtonClass="btn">
<cfset this.commentMoreCommentsUpClass="btn btn-default icon-arrow-up">
<cfset this.commentMoreCommentsDownClass="btn btn-default icon-arrow-down">
<cfset this.commentRequiredWrapperClass="">
<cfset this.commentAdminButtonWrapperClass="">
<cfset this.commentUserEmailClass="btn">
<cfset this.commentDeleteButtonClass="btn">
<cfset this.commentEditButtonClass="btn">
<cfset this.commentApproveButtonClass="btn">
<cfset this.commentThumbClass="img-polaroid">
<cfset this.commentSpamClass="btn">
<cfset this.commentSpamLinkClass="btn">
<cfset this.commentClass="">
<cfset this.commentDateTimeClass="">
<cfset this.commentReplyClass="">
<cfset this.commentAwaitingApproval="">
<cfset this.commentAdminButtonWrapperClass="btn-group pull-right">
<cfset this.commentUserEmailClass="btn btn-default btn-sm">
<cfset this.commentDeleteButtonClass="btn btn-default btn-sm">
<cfset this.commentEditButtonClass="btn btn-default btn-sm">
<cfset this.commentApproveButtonClass="btn btn-default btn-sm">
<cfset this.commentMoreCommentsContainer="well">

<!--- Comments/dsp_comment.cfm --->
<cfset this.emailLinkClass="btn">
<cfset this.commentsLinkClass="btn">
<cfset this.approveCommentLinkClass="btn">
<cfset this.deleteCommentLinkClass="btn">

<!--- Dataresponses/dsp_detail.cfm --->
<cfset this.dataResponseListClass="dl-horizontal">

<!--- Dataresponses/dsp_list.cfm --->
<cfset this.dataResponseTableClass="table table-hover">
<cfset this.dataResponsePaginationClass="pagination">

<!--- Draggablefeeds/index.cfm --->
<cfset this.draggableBoxWrapperClass="">
<cfset this.draggableBoxHeaderClass="">
<cfset this.draggableBoxRSSWrapperClass="svRSSFeeds">
<cfset this.draggableBoxHeaderButtonClass="btn btn-default">
<cfset this.draggableBoxRSSeditFormClass="">
<cfset this.draggableBoxAddFeedWrapperClass="well clearfix">
<cfset this.draggableBoxNewFeedFormClass="form-horizontal">
<cfset this.draggableBoxSelectFeedWrapperClass="">
<cfset this.draggableBoxSelectFeedRowClass="row">
<cfset this.draggableBoxSelectFeedMenuClass="">
<cfset this.draggableBoxSelectFeedMenuDivClass="">
<cfset this.draggableFeedMenuSelectFieldClass="">
<cfset this.addFeedButtonWrapperDivClass="">
<cfset this.addFeedButtonWrapperDivInnerClass="">
<cfset this.addFeedButtonClass="btn btn-default">

<!--- Dsp_categories_nest.cfm --->
<cfset this.categoriesNestCheckboxClass="checkbox">

<!--- Dsp_content_list.cfm --->
<cfset this.contentListImageStyles=true>
<cfset this.contentListImagePadding=20>
<cfset this.contentListPropertyMap={
		containerEl={tag="div"},
		itemEl={tag="dl",class="clearfix"},
		labelEl={tag="span"},
		title={tag="dt"},
		date={tag="dt"},
		credits={tag="dd",showLabel=true,rbkey="list.by"},
		tags={tag="dd",showLabel=true,labelDelim=":",rbkey="tagcloud.tags"},
		rating={tag="dd",showLabel=true,labelDelim=":",rbkey="list.rating"},
		default={tag="dd"}
	}>

<cfset this.contentListWrapperDivClass="">
<cfset this.contentListItemImageLinkClass="thumbnail">

<!--- dsp_folder.cfm --->
<cfset this.folderWrapperClass="svIndex">

<!--- Dsp_edit_profile.cfm --->
<cfset this.editProfileWrapperClass="">
<cfset this.editProfileFormClass="form-horizontal">
<cfset this.editProfileFormGroupWrapperClass="control-group">
<cfset this.editProfileFieldLabelClass="control-label">
<cfset this.editProfileFormFieldsWrapperClass="">
<cfset this.editProfileFormFieldsClass="">
<cfset this.editProfileHelpBlockClass="help-block">
<cfset this.editProfileExtAttributeFileWrapperClass="">
<cfset this.editProfileExtAttributeFileCheckboxClass="checkbox">
<cfset this.editProfileExtAttributeDownloadClass="">
<cfset this.editProfileExtAttributeDownloadButtonClass="btn btn-default">
<cfset this.editProfileSubmitButtonWrapperClass="">
<cfset this.editProfileSubmitButtonClass="btn btn-primary">
<cfset this.editProfileSuccessMessageClass="alert alert-success">

<!--- Dsp_email_dropdown.cfm --->
<cfset this.emailDropdownSelectClass="dropdown">

<!--- Dsp_event_reminder_form.cfm --->
<cfset this.eventReminderFormWrapperClass="">
<cfset this.eventReminderFormClass="well">
<cfset this.eventReminderFieldWrapperClass="control-group">
<cfset this.eventReminderFormLabelsClass="control-label">
<cfset this.eventReminderSubmitClass="btn btn-default">

<!--- Dsp_features.cfm --->
<cfset this.featuresWrapperClass="svSyndLocal svIndex clearfix">

<!--- Dsp_feed.cfm --->
<cfset this.localIndexWrapperClass="svSyndLocal svFeed svIndex clearfix">
<cfset this.remoteFeedWrapperClass="svSyndRemote svIndex svFeed clearfix">

<!--- Dsp_login.cfm --->
<cfset this.loginWrapperClass="container">
<cfset this.loginWrapperInnerClass="row">
<cfset this.loginFormClass="form-horizontal">
<cfset this.forgotPasswordFormClass="form-horizontal">
<cfset this.loginFormGroupWrapperClass="">
<cfset this.loginFormFieldLabelClass="control-label">
<cfset this.loginFormFieldWrapperClass="">
<cfset this.loginFormFieldClass="">
<cfset this.loginFormPrefsClass="">
<cfset this.loginFormCheckboxClass="checkbox">
<cfset this.loginFormSubmitWrapperClass="">
<cfset this.loginFormSubmitClass="btn btn-default">
<cfset this.notRegisteredLinkClass="btn btn-primary">

<!--- Dsp_mailing_list_master.cfm --->
<cfset this.mailingListWrapperClass="well">
<cfset this.mailingListFormClass="form-horizontal">
<cfset this.mailingListFormGroupWrapperClass="">
<cfset this.mailingListFormLabelClass="control-label">
<cfset this.mailingListFormFieldWrapperClass="">
<cfset this.mailingListFormInputClass="">
<cfset this.mailingListCheckboxWrapperClass="">
<cfset this.mailingListCheckboxClass="checkbox">
<cfset this.mailingListSubmitWrapperClass="">
<cfset this.mailingListSubmitClass="btn btn-default">

<!--- Dsp_nextN.cfm --->
<cfset this.nextNWrapperClass="">
<cfset this.nextNInnerClass="pagination">

<!--- Dsp_search_form.cfm --->
<cfset this.searchFormClass="">
<cfset this.searchFormInputWrapperClass="">
<cfset this.searchFormInputClass="">
<cfset this.searchFormSubmitWrapperClass="">
<cfset this.searchFormSubmitClass="btn btn-default">

<!--- Dsp_search_results.cfm --->
<cfset this.searchShowNumbers=1>
<cfset this.searchResultWrapperClass="container">
<cfset this.searchResultInnerClass="row">
<cfset this.searchResultsRowClass="row">
<cfset this.searchResultsMoreResultsRowClass="row">
<cfset this.searchResultsListClass="svIndex">
<cfset this.searchResultsPagerClass="pager">
<cfset this.searchAgainRowClass="row">
<cfset this.searchAgainInnerClass="">
<cfset this.searchAgainFormClass="">
<cfset this.searchAgainInputWrapperClass="">
<cfset this.searchAgainFormInputClass="">
<cfset this.searchAgainButtonWrapperClass="">
<cfset this.searchAgainSubmitClass="btn btn-default">

<!--- Dsp_user_tools.cfm --->
<cfset this.userToolsLoginWrapperClass="well clearfix">
<cfset this.userToolsLoginFormClass="form-horizontal">
<cfset this.userToolsFormGroupWrapperClass="">
<cfset this.userToolsLoginFormLabelClass="control-label">
<cfset this.userToolsLoginFormInputWrapperClass="">
<cfset this.userToolsLoginFormInputClass="">
<cfset this.userToolsLoginFormFieldInnerClass="">
<cfset this.userToolsLoginFormCheckboxClass="checkbox">
<cfset this.userToolsLoginFormSubmitClass="btn btn-default">
<cfset this.userToolsNotRegisteredLinkClass="btn btn-primary">
<cfset this.userToolsWrapperClass="clearfix">
<cfset this.userToolsEditProfileLinkClass="btn btn-default">
<cfset this.userToolsLogoutLinkClass="btn btn-default">

<!--- Formbuilder/Dsp_form.cfm --->
<cfset this.formBuilderFieldWrapperClass="">
<cfset this.formBuilderButtonWrapperClass="form-actions">
<cfset this.formBuilderSubmitClass="btn btn-default">

<!---
 Formbuilder/Fields/Dsp_checkbox.cfm
 Formbuilder/Fields/Dsp_dropdown.cfm
 Formbuilder/Fields/Dsp_file.cfm
 Formbuilder/Fields/Dsp_radio.cfm
 Formbuilder/Fields/Dsp_textfield.cfm
--->
<cfset this.formBuilderFormFieldsClass="control-group">

<!--- Formbuilder/Fields/field_dropdown.cfm --->
<cfset this.formBuilderTabHeaderClass="dropdown">
<cfset this.formBuilderDisabledInputClass="disabled">
<cfset this.formBuilderCheckboxClass="checkbox">

<!--- Gallery/Index.cfm --->
<cfset this.galleryImageStyles=true>
<cfset this.galleryWrapperClass="">
<cfset this.galleryULClass="clearfix">
<cfset this.galleryLIClass="">
<cfset this.galleryThumbnailClass="thumbnail">

<!--- Nav/CalendarNav/index --->
<cfset this.navCalendarWrapperClass="svCalendar">

<!--- Nav/CalendarNav/NavTools.cfc --->
<cfset this.navCalendarTableClass="table table-bordered">

<!--- Nav/Dsp_sequential.cfm --->
<cfset this.navSequentialWrapperClass="pagination">
<cfset this.navSequentialULClass="">

<!--- Nav/dsp_tag_cloud.cfm --->
<cfset this.tagCloudWrapperClass="svTagCloud">

<!--- NavArchive --->
<cfset this.navArchiveWrapperClass="">
<cfset this.navArchiveListClass="">

<!--- NavBreadcrumb --->
<cfset this.navBreadcrumbULClass="breadcrumb">

<!--- Rater/Index.cfm --->
<cfset this.raterObjectWrapperClass="row clearfix">
<cfset this.raterWrapperClass="">
<cfset this.avgRatingWrapperClass="">

<cffunction name="init" returntype="any" access="public" output="false">
<cfargument name="event" required="true" default="">

	<cfif isObject(arguments.event)>
		<cfset variables.event=arguments.event>
	<cfelse>
		<cfset variables.event=createObject("component","mura.servletEvent")>
	</cfif>

	<cfset variables.$=variables.event.getValue("muraScope")>
	<cfset variables.mura=variables.$>

	<cfif request.muraExportHtml>
		<cfset this.showEditableObjects=false>
		<cfset this.showAdminToolBar=false>
		<cfset this.showMemberToolBar=false>
	</cfif>

	<cfif not isBoolean(this.hashURLS)>
		<cfset this.hashURLS=application.configBean.getHashURLS()>
	</cfif>

	<!---  Backward support --->
	<cfif structKeyExists(this,'liHasKidsCustomString') and len(this.liHasKidsCustomString)>
		<cfset this.liHasKidsAttributes=this.liHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(this,'liCurrentCustomString') and len(this.liCurrentCustomString)>
		<cfset this.liCurrentAttributes=this.liCurrentCustomString>
	</cfif>
	<cfif structKeyExists(this,'aHasKidsCustomString') and len(this.aHasKidsCustomString)>
		<cfset this.aHasKidsAttributes=this.aHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(this,'aCurrentCustomString') and len(this.aCurrentCustomString)>
		<cfset this.aCurrentAttributes=this.aCurrentCustomString>
	</cfif>
	<cfif structKeyExists(this,'ulNestedCustomString') and len(this.ulNestedCustomString)>
		<cfset this.ulNestedAttributes=this.ulNestedCustomString>
	</cfif>

	<cfset variables.contentGateway=getBean('contentGateway')>
	<cfset variables.contentRendererUtility=getBean('contentRendererUtility')>

	<cfif not isDefined('this.enableMuraTag')>
		<cfset this.enableMuraTag=getConfigBean().getEnableMuraTag() />
	</cfif>

	<cfscript>
		this.siteIDInURLs = Len(variables.$.event('siteid')) && variables.$.siteConfig().getValue(property='isRemote',defaultValue=false)
			? false
			: Len(variables.$.event('siteid')) && IsBoolean(this.siteIDInURLs)
				? this.siteIDInURLs
				: application.configBean.getSiteIDInURLs();

		this.indexFileInURLs = Len(variables.$.event('siteid')) && variables.$.siteConfig().getValue(property='isRemote',defaultValue=false)
			? false
			: Len(variables.$.event('siteid')) && IsBoolean(this.indexFileInURLs)
				? this.indexFileInURLs
				: application.configBean.getIndexFileInURLs();

		this.enableFrontEndTools = IsDefined('this.enableFrontEndTools')
			? this.enableFrontEndTools
			: IsBoolean(getConfigBean().getEnableFrontEndTools())
				? getConfigBean().getEnableFrontEndTools()
				: true;
	</cfscript>

	<cfreturn this />
</cffunction>

<cffunction name="postMergeInit" output="false">
	<cfscript>
		this.asyncObjects=request.muraFrontEndRequest && (this.asyncObjects || this.layoutmanager);
		this.asyncRender=!this.asyncObjects;
		return this;
	</cfscript>
</cffunction>

<cffunction name="OnMissingMethod" access="public" returntype="any" output="false" hint="Handles missing method exceptions.">
<cfargument name="MissingMethodName" type="string" required="true" hint="The name of the missing method." />
<cfargument name="MissingMethodArguments" type="struct" required="true" />
	<cfscript>
		var prefix=left(arguments.MissingMethodName,3);

		if(listFindNoCase("set,get",prefix) and len(arguments.MissingMethodName) gt 3){
			var prop=right(arguments.MissingMethodName,len(arguments.MissingMethodName)-3);

			if(prefix eq "get"){
				param name='this.#prop#' default='';
				return this['#prop#'];
			}

			if(not structIsEmpty(arguments.MissingMethodArguments)){
				this['#prop#']=arguments.MissingMethodArguments[1];
				return this;;
			} else {
				throw(message="The method '#arguments.MissingMethodName#' requires a propery value");
			}

		} else {
			throw(message="The method '#arguments.MissingMethodName#' is not defined");
		}
	</cfscript>

</cffunction>

<cffunction name="getHeaderTag" returntype="string" output="false">
<cfargument name="header">
	<cfif listFindNoCase("headline,subHead1,subHead2,subHead3,subHead4,subHead5",arguments.header)>
	<cfreturn this["#arguments.header#"]/>
	<cfelse>
	<cfreturn "Invalid Argument. Must be one of 'headline, subHead1, subHead2, subHead3, subHead4, subHead5'">
	</cfif>
</cffunction>

<cffunction name="setJsLib" returntype="void" output="false">
<cfargument name="jsLib">
	<cfset this.jsLib=arguments.jsLib />
</cffunction>

<cffunction name="setHasEditableObjects" returntype="void" output="false">
<cfargument name="hasEditableObjects">
	<cfset this.hasEditableObjects=arguments.hasEditableObjects />
</cffunction>

<cffunction name="getJsLib" returntype="string" output="false">
	<cfreturn this.jsLib />
</cffunction>

<cffunction name="setRenderHTMLQueues" returntype="void" output="false">
<cfargument name="renderHTMLQueues">
	<cfset this.renderHTMLQueues=arguments.renderHTMLQueues />
</cffunction>

<cffunction name="getRenderHTMLQueues" returntype="string" output="false">
	<cfreturn this.renderHTMLQueues and this.renderHTMLHead />
</cffunction>

<cffunction name="setRenderHTMLHead" returntype="void" output="false" hint="This is deprecated.">
<cfargument name="renderHTMLHead">
	<cfset this.renderHTMLQueues=arguments.renderHTMLHead />
</cffunction>

<cffunction name="getRenderHTMLHead" returntype="string" output="false" hint="This is deprecated.">
	<cfreturn this.renderHTMLQueues />
</cffunction>

<cffunction name="setShowAdminToolBar" returntype="void" output="false">
<cfargument name="showAdminToolBar">
	<cfset this.showAdminToolBar=arguments.showAdminToolBar />
</cffunction>

<cffunction name="getShowAdminToolBar" returntype="string" output="false">
	<cfreturn this.showAdminToolBar />
</cffunction>

<cffunction name="getPersonalization" returntype="string" output="false">
	<cfreturn this.personalization />
</cffunction>

<cffunction name="loadJSLib" returntype="void" output="false">
	<!--- deprecated --->
</cffunction>

<cffunction name="loadPrettify" returntype="void" output="false">
	<cfset addToHTMLHeadQueue("prettify.cfm")>
</cffunction>

<cffunction name="setLongDateFormat" returntype="void" output="false">
<cfargument name="longDateFormat">
	<cfset this.longDateFormat=arguments.longDateFormat />
</cffunction>

<cffunction name="getLongDateFormat" returntype="string" output="false">
	<cfreturn this.longDateFormat />
</cffunction>

<cffunction name="setShortDateFormat" returntype="void" output="false">
<cfargument name="shortDateFormat">
	<cfset this.shortDateFormat=arguments.shortDateFormat />
</cffunction>

<cffunction name="getShortDateFormat" returntype="string" output="false">
	<cfreturn this.shortDateFormat />
</cffunction>

<cffunction name="setNavOffSet" returntype="void" output="false">
<cfargument name="navOffSet">
	<cfif not variables.event.getValue('contentBean').getIsNew()>
		<cfset this.navOffSet=arguments.navOffSet />
	</cfif>
</cffunction>

<cffunction name="getNavOffSet" output="false">
<cfargument name="navOffSet">
		<cfreturn this.navOffSet/>
</cffunction>

<cffunction name="setNavDepthLimit" returntype="void" output="false">
<cfargument name="navDepthLimit">

	<cfset this.navDepthLimit=arguments.navDepthLimit />

	<cfif arrayLen(this.crumbdata) gt this.navDepthLimit >
		<cfset this.navDepthAdjust=arraylen(this.crumbdata)-this.navDepthLimit />
		<cfset this.navGrandParentIdx= 3 + this.navDepthAdjust />
		<cfset this.navParentIdx=2 + this.navDepthAdjust />
		<cfset this.navSelfIdx= 1 + this.navDepthAdjust />
	</cfif>

</cffunction>

<cffunction name="showItemMeta" returntype="any" output="false">
<cfargument name="fileExt">
	<cfif listFind(this.showMetaList,lcase(arguments.fileExt))>
	<cfreturn 1>
	<cfelse>
	<cfreturn variables.event.getValue('showMeta')>
	</cfif>
</cffunction>

<cffunction name="showImageInList" returntype="any" output="false">
<cfargument name="fileExt">
	<cfreturn listFind(this.imageInList,lcase(arguments.fileExt))>
</cffunction>

<cffunction name="dspNestedNav" output="false" returntype="string">
	<cfargument name="contentid" type="string" >
	<cfargument name="viewDepth" type="numeric" required="true" default="1">
	<cfargument name="currDepth" type="numeric"  required="true"  default="1">
	<cfargument name="type" type="string"  default="default">
	<cfargument name="today" type="date"  default="#now()#">
	<cfargument name="class" type="string" default="#this.ulTopClass#">
	<cfargument name="querystring" type="string" default="">
	<cfargument name="sortBy" type="string" default="orderno">
	<cfargument name="sortDirection" type="string" default="asc">
	<cfargument name="context" type="string" default="#application.configBean.getContext()#">
	<cfargument name="stub" type="string" default="#application.configBean.getStub()#">
	<cfargument name="categoryID" type="string" default="">
	<cfargument name="relatedID" type="string" default="">
	<cfargument name="rs" required="true" default="">
	<cfargument name="subNavExpression" required="true" default="">
	<cfargument name="navLIClass" required="true" default="#this.navLIClass#">
	<cfargument name="liHasKidsClass" required="true" default="#this.liHasKidsClass#">
	<cfargument name="liHasKidsAttributes" required="true" default="#this.liHasKidsAttributes#">
	<cfargument name="liCurrentClass" required="true" default="#this.liCurrentClass#">
	<cfargument name="liCurrentAttributes" required="true" default="#this.liCurrentAttributes#">
	<cfargument name="liHasKidsNestedClass" required="true" default="#this.liHasKidsNestedClass#">
	<cfargument name="aHasKidsClass" required="true" default="#this.aHasKidsClass#">
	<cfargument name="aHasKidsAttributes" required="true" default="#this.aHasKidsAttributes#">
	<cfargument name="aCurrentClass" required="true" default="#this.aCurrentClass#">
	<cfargument name="aCurrentAttributes" required="true" default="#this.aCurrentAttributes#">
	<cfargument name="ulNestedClass" required="true" default="#this.ulNestedClass#">
	<cfargument name="ulNestedAttributes" required="true" default="#this.ulNestedAttributes#">
	<cfargument name="openCurrentOnly" required="true" default="false">
	<cfargument name="aNotCurrentClass" required="true" default="#this.aNotCurrentClass#">
	<cfargument name="size" required="true" default="#this.navsize#">

	<cfif structKeyExists(arguments,'liHasKidsCustomString')>
		<cfset arguments.liHasKidsAttributes=arguments.liHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'liCurrentCustomString')>
		<cfset arguments.liCurrentAttributes=arguments.liCurrentCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aHasKidsCustomString')>
		<cfset arguments.aHasKidsAttributes=arguments.aHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aCurrentCustomString')>
		<cfset arguments.aCurrentAttributes=arguments.aCurrentCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'ulNestedCustomString')>
		<cfset arguments.ulNestedAttributes=arguments.ulNestedCustomString>
	</cfif>

	<cfset var rsSection=arguments.rs>
	<cfset var adjust=0>
	<cfset var current=0>
	<cfset var link=''>
	<cfset var itemClass=''>
	<cfset var isCurrent=false>
	<cfset var nest=''>
	<cfset var subnav=false>
	<cfset var theNav="">
	<cfset var nestedArgs=structNew()>
	<cfset var linkArgs=structNew()>
	<cfset var started=false>

	<cfif not isQuery(rsSection)>
		<cfset rsSection=variables.contentGateway.getKids('00000000000000000000000000000000000',variables.event.getValue('siteID'),arguments.contentid,arguments.type,arguments.today,Val(arguments.size),'',0,arguments.sortBy,arguments.sortDirection,arguments.categoryID,arguments.relatedID)>
	</cfif>

	<cfif isDefined("arguments.ulTopClass") and arguments.currDepth eq 1>
		<cfset arguments.class=arguments.ulTopClass>
	</cfif>

	<cfif rsSection.recordcount and ((variables.event.getValue('r').restrict and variables.event.getValue('r').allow) or (not variables.event.getValue('r').restrict))>
		<cfset adjust=rsSection.recordcount>

		<cfsavecontent variable="theNav">
		<cfoutput>
		<cfloop query="rsSection">
		<cfif allowLink(rssection.restricted,rssection.restrictgroups,variables.event.getValue('r').loggedIn)>
		<cfsilent>
			<cfif len(arguments.subNavExpression)>
				<cfset subnav=evaluate(arguments.subNavExpression)>
			<cfelse>
				<cfset subnav=
				(
					(
						ListFind("Page,Folder,Calendar",rsSection.type)
						and arguments.openCurrentOnly
						and ListFindNoCase(ArrayToList(this.crumbData[this.navSelfIdx].parentArray), rsSection.contentid)
					) or (
						ListFindNoCase("Page,Calendar",rsSection.type)
						and not arguments.openCurrentOnly
					)
				)
				and arguments.currDepth lt arguments.viewDepth
				and rsSection.type neq 'Gallery'
				and not (rsSection.restricted and not session.mura.isLoggedIn) />
			</cfif>

			<cfset current=current+1>
			<cfset nest=''>
			<cfif subnav>
				<cfset nestedArgs.contentID=rssection.contentid>
				<cfset nestedArgs.currDepth=arguments.currDepth+1>
				<cfset nestedArgs.type=iif(rssection.type eq 'calendar',de('fixed'),de('default'))>
				<cfset nestedArgs.sortBy=rsSection.sortBy>
				<cfset nestedArgs.sortDirection=rsSection.sortDirection>
				<cfset nestedArgs.class="">
				<cfset nestedArgs.ulTopClass="">
				<cfset structAppend(nestedArgs,arguments,false)>
				<cfset nest=dspNestedNav(argumentCollection=nestedArgs)>
				<cfset subnav=subnav and find("<li",nest)>
			</cfif>

			<cfif subnav and arguments.currDepth gt 1 and len(arguments.liHasKidsNestedClass)>
				<cfset itemClass=arguments.liHasKidsNestedClass>
			<cfelse>
				<cfset itemClass="">
			</cfif>

			<cfif Len(arguments.navLIClass)>
				<cfset itemClass=ListAppend(itemClass, arguments.navLIClass, ' ')>
			</cfif>

			<cfif current eq 1>
				<cfset itemClass=listAppend(itemClass,'first',' ')>
			</cfif>
			<cfif current eq adjust>
				<cfset itemClass=listAppend(itemClass,'last',' ')>
			</cfif>

			<cfset isCurrent=listFind(variables.event.getValue('contentBean').getPath(),"#rsSection.contentid#")>

			<cfif isCurrent and len(arguments.liCurrentClass)>
				<cfset itemClass=listAppend(itemClass,arguments.liCurrentClass," ")>
			</cfif>
			<cfif subnav and len(arguments.liHasKidsClass)>
				<cfset itemClass=listAppend(itemClass,arguments.liHasKidsClass," ")>
			</cfif>

			<cfset linkArgs=structNew()>
			<cfset linkArgs.aHasKidsClass=arguments.aHasKidsClass>
			<cfset linkArgs.aHasKidsAttributes=arguments.aHasKidsAttributes>
			<cfset linkArgs.aNotCurrentClass=arguments.aNotCurrentClass>
			<cfset linkArgs.aCurrentClass=arguments.aCurrentClass>
			<cfset linkArgs.aCurrentAttributes=arguments.aCurrentAttributes>
			<cfset linkArgs.type=rsSection.type>
			<cfset linkArgs.filename=rsSection.filename>
			<cfset linkArgs.title=rsSection.menutitle>
			<cfset linkArgs.contentid=rsSection.contentid>
			<cfset linkArgs.target=rsSection.target>
			<cfset linkArgs.targetParams=rsSection.targetParams>
			<cfset linkArgs.siteID=variables.event.getValue('siteID')>
			<cfset linkArgs.querystring=arguments.querystring>
			<cfset linkArgs.isParent=subnav>
			<cfset link=addlink(argumentCollection=linkArgs)>
		</cfsilent>
		<cfif not started>
			<cfset started=true>
			<ul<cfif arguments.currDepth eq 1 and len(arguments.class)> class="#arguments.class#"<cfelse><cfif len(arguments.ulNestedClass)> class="#arguments.ulNestedClass#"</cfif><cfif len(arguments.ulNestedAttributes)> #arguments.ulNestedAttributes#</cfif></cfif>>
		</cfif>
		<li<cfif len(itemClass)> class="#itemClass#"</cfif><cfif len(arguments.liCurrentAttributes)> #arguments.liCurrentAttributes#</cfif>>#link#<cfif subnav>#nest#</cfif></li><cfelse><cfset adjust=adjust-1></cfif></cfloop>
		<cfif started></ul></cfif></cfoutput>
		</cfsavecontent>
	</cfif>
	<cfreturn theNav />
</cffunction>

<!--- For backward compatibility --->
<cffunction name="dspPortalNav" output="false" returntype="string">
	<cfreturn dspFolderNav(argumentCollection=arguments)>
</cffunction>

<cffunction name="dspFolderNav" output="false" returntype="string">
	<cfargument name="class" default="#this.ulTopClass#" required="true">
	<cfargument name="liHasKidsClass" required="true" default="#this.liHasKidsClass#">
	<cfargument name="liHasKidsAttributes" required="true" default="#this.liHasKidsAttributes#">
	<cfargument name="liCurrentClass" required="true" default="#this.liCurrentClass#">
	<cfargument name="liCurrentAttributes" required="true" default="#this.liCurrentAttributes#">
	<cfargument name="liHasKidsNestedClass" required="true" default="#this.liHasKidsNestedClass#">
	<cfargument name="aHasKidsClass" required="true" default="#this.aHasKidsClass#">
	<cfargument name="aHasKidsAttributes" required="true" default="#this.aHasKidsAttributes#">
	<cfargument name="aCurrentClass" required="true" default="#this.aCurrentClass#">
	<cfargument name="aCurrentAttributes" required="true" default="#this.aCurrentAttributes#">
	<cfargument name="ulNestedClass" required="true" default="#this.ulNestedClass#">
	<cfargument name="ulNestedAttributes" required="true" default="#this.ulNestedAttributes#">

	<cfset var thenav="" />
	<cfset var menutype="" />
	<cfset var nestedArgs=structNew()>
	<cfset var tracepoint=initTracepoint("contentRenderer.dspFolderNav")>

	<!--- Supporting Old Arguments--->
	<cfif structKeyExists(arguments,'liHasKidsCustomString')>
		<cfset arguments.liHasKidsAttributes=arguments.liHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aHasKidsCustomString')>
		<cfset arguments.aHasKidsAttributes=arguments.aHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aCurrentCustomString')>
		<cfset arguments.aCurrentAttributes=arguments.aCurrentCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'ulNestedCustomString')>
		<cfset arguments.ulNestedAttributes=arguments.ulNestedCustomString>
	</cfif>
	<!--- --->

	<cfset nestedArgs.openCurrentOnly=true>
	""
	<cfif variables.event.getValue('contentBean').getType() eq 'Folder' or variables.event.getValue('contentBean').getType() eq 'Gallery'>
		<cfif arraylen(this.crumbdata) gt (this.navParentIdx+this.navOffSet)>
			<cfif arraylen(this.crumbdata) gt (this.navGrandParentIdx+this.navOffSet) and (this.crumbdata[this.navGrandParentIdx].type neq 'Folder' or this.crumbdata[this.navGrandParentIdx].type neq 'Gallery') and not variables.contentGateway.getCount(variables.event.getValue('siteID'),this.crumbdata[this.navSelfIdx].contentID)>
				<cfset nestedArgs.contentID=this.crumbdata[this.navGrandParentIdx].contentid>
				<cfset nestedArgs.viewDepth=2>
				<cfset nestedArgs.currDepth=1>
				<cfset nestedArgs.sortBy=this.crumbdata[this.navGrandParentIdx].sortBy>
				<cfset nestedArgs.sortDirection=this.crumbdata[this.navGrandParentIdx].sortDirection>
				<cfset nestedArgs.categoryID=variables.event.getValue('categoryID')>
				<cfset structAppend(nestedArgs,arguments,false)>
				<cfset theNav = dspNestedNav(argumentCollection=nestedArgs) />
			<cfelse>
				<cfset thenav=dspPeerNav(argumentCollection=arguments) />
			</cfif>
		</cfif>
	<cfelseif arrayLen(this.crumbdata) gt (this.navSelfIdx+this.navOffSet) and this.crumbdata[this.navParentIdx].type eq 'Folder' or (arraylen(this.crumbdata) gt (this.navGrandParentIdx+this.navOffSet) and this.crumbdata[this.navGrandParentIdx].type eq 'Folder')>
		<cfif arraylen(this.crumbdata) gt (this.navGrandParentIdx+this.navOffSet) and this.crumbdata[this.navGrandParentIdx].type neq 'Folder' and not variables.contentGateway.getCount(variables.event.getValue('siteID'),this.crumbdata[this.navSelfIdx].contentID)>
			<cfset nestedArgs.contentID=this.crumbdata[this.navGrandParentIdx].contentid>
			<cfset nestedArgs.viewDepth=1>
			<cfset nestedArgs.currDepth=1>
			<cfset nestedArgs.sortBy=this.crumbdata[this.navGrandParentIdx].sortBy>
			<cfset nestedArgs.sortDirection=this.crumbdata[this.navGrandParentIdx].sortDirection>
			<cfset nestedArgs.categoryID=variables.event.getValue('categoryID')>
			<cfset structAppend(nestedArgs,arguments,false)>

			<cfset theNav = dspNestedNav(argumentCollection=nestedArgs) />
		<cfelse>
			<cfset thenav=dspSubNav(argumentCollection=nestedArgs) />
		</cfif>
	<cfelse>
		<cfset thenav=dspStandardNav(argumentCollection=nestedArgs) />
	</cfif>
	<cfset commitTracePoint(tracePoint)>

	<cfreturn thenav />
</cffunction>

<cffunction name="dspStandardNav" output="false" returntype="string">
	<cfargument name="class" default="#this.ulTopClass#" required="true">
	<cfargument name="liHasKidsClass" required="true" default="#this.liHasKidsClass#">
	<cfargument name="liHasKidsAttributes" required="true" default="#this.liHasKidsAttributes#">
	<cfargument name="liCurrentClass" required="true" default="#this.liCurrentClass#">
	<cfargument name="liCurrentAttributes" required="true" default="#this.liCurrentAttributes#">
	<cfargument name="liHasKidsNestedClass" required="true" default="#this.liHasKidsNestedClass#">
	<cfargument name="aHasKidsClass" required="true" default="#this.aHasKidsClass#">
	<cfargument name="aHasKidsAttributes" required="true" default="#this.aHasKidsAttributes#">
	<cfargument name="aCurrentClass" required="true" default="#this.aCurrentClass#">
	<cfargument name="aCurrentAttributes" required="true" default="#this.aCurrentAttributes#">
	<cfargument name="ulNestedClass" required="true" default="#this.ulNestedClass#">
	<cfargument name="ulNestedAttributes" required="true" default="#this.ulNestedAttributes#">
	<cfset var thenav="" />
	<cfset var menutype="" />
	<cfset var nestedArgs=structNew()>
	<cfset var tracepoint=initTracepoint("contentRenderer.dspStandardNav")>

	<!--- Supporting Old Arguments--->
	<cfif structKeyExists(arguments,'liHasKidsCustomString')>
		<cfset arguments.liHasKidsAttributes=arguments.liHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aHasKidsCustomString')>
		<cfset arguments.aHasKidsAttributes=arguments.aHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aCurrentCustomString')>
		<cfset arguments.aCurrentAttributes=arguments.aCurrentCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'ulNestedCustomString')>
		<cfset arguments.ulNestedAttributes=arguments.ulNestedCustomString>
	</cfif>
	<!--- --->

	<cfset nestedArgs.openCurrentOnly=true>

	<cfif variables.event.getValue('contentBean').getType() neq 'Gallery'>
			<cfif arraylen(this.crumbdata) gt (this.navParentIdx+this.navOffSet)>
				<cfif this.crumbdata[this.navParentIdx].type eq 'calendar'>
					<cfset menutype='fixed'>
				<cfelse>
					<cfset menutype='default'>
				</cfif>
				<cfif arraylen(this.crumbdata) gt (this.navGrandParentIdx+this.navOffSet) and not variables.contentGateway.getCount(variables.event.getValue('siteID'),this.crumbdata[this.navSelfIdx].contentID)>
					<cfset nestedArgs.contentID=this.crumbdata[this.navGrandParentIdx].contentid>
					<cfset nestedArgs.viewDepth=2>
					<cfset nestedArgs.currDepth=1>
					<cfset nestedArgs.type=menutype>
					<cfset nestedArgs.sortBy=this.crumbdata[this.navGrandParentIdx].sortBy>
					<cfset nestedArgs.sortDirection=this.crumbdata[this.navGrandParentIdx].sortDirection>
					<cfset structAppend(nestedArgs,arguments,false)>
					<cfset theNav = dspNestedNav(argumentCollection=nestedArgs) />
				<cfelse>
					<cfset nestedArgs.contentID=this.crumbdata[this.navParentIdx].contentid>
					<cfset nestedArgs.viewDepth=2>
					<cfset nestedArgs.currDepth=1>
					<cfset nestedArgs.type=menutype>
					<cfset nestedArgs.sortBy=this.crumbdata[this.navParentIdx].sortBy>
					<cfset nestedArgs.sortDirection=this.crumbdata[this.navParentIdx].sortDirection>
					<cfset structAppend(nestedArgs,arguments,false)>
					<cfset theNav = dspNestedNav(argumentCollection=nestedArgs) />
				</cfif>
			<cfelse>
				<cfset theNav=dspSubNav(argumentCollection=arguments) />
			</cfif>
	<cfelse>
			<cfset thenav=dspFolderNav(argumentCollection=arguments) />
	</cfif>

	<cfset commitTracePoint(tracePoint)>

	<cfreturn thenav>
</cffunction>

<cffunction name="dspSubNav" output="false" returntype="string">
	<cfargument name="class" default="#this.ulTopClass#" required="true">
	<cfargument name="liHasKidsClass" required="true" default="#this.liHasKidsClass#">
	<cfargument name="liHasKidsAttributes" required="true" default="#this.liHasKidsAttributes#">
	<cfargument name="liCurrentClass" required="true" default="#this.liCurrentClass#">
	<cfargument name="liCurrentAttributes" required="true" default="#this.liCurrentAttributes#">
	<cfargument name="liHasKidsNestedClass" required="true" default="#this.liHasKidsNestedClass#">
	<cfargument name="aHasKidsClass" required="true" default="#this.aHasKidsClass#">
	<cfargument name="aHasKidsAttributes" required="true" default="#this.aHasKidsAttributes#">
	<cfargument name="aCurrentClass" required="true" default="#this.aCurrentClass#">
	<cfargument name="aCurrentAttributes" required="true" default="#this.aCurrentAttributes#">

	<cfset var thenav="" />
	<cfset var nestedArgs=structNew()>
	<cfset var tracepoint=initTracepoint("contentRenderer.dspSubNav")>

	<!--- Supporting Old Arguments--->
	<cfif structKeyExists(arguments,'liHasKidsCustomString')>
		<cfset arguments.liHasKidsAttributes=arguments.liHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aHasKidsCustomString')>
		<cfset arguments.aHasKidsAttributes=arguments.aHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aCurrentCustomString')>
		<cfset arguments.aCurrentAttributes=arguments.aCurrentCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'ulNestedCustomString')>
		<cfset arguments.ulNestedAttributes=arguments.ulNestedCustomString>
	</cfif>
	<!--- --->

	<cfset nestedArgs.openCurrentOnly=true>

	<cfif arraylen(this.crumbdata) gt (this.navSelfIdx+this.navOffSet)>
		<cfset nestedArgs.contentID=this.crumbdata[this.navSelfIdx].contentID>
		<cfset nestedArgs.viewDepth=1>
		<cfset nestedArgs.currDepth=1>
		<cfif this.crumbdata[this.navSelfIdx].type eq 'Calendar'>
			<cfset nestedArgs.type='fixed'>
		<cfelse>
			<cfset nestedArgs.type='default'>
		</cfif>
		<cfset nestedArgs.sortBy=this.crumbdata[this.navSelfIdx].sortBy>
		<cfset nestedArgs.sortDirection=this.crumbdata[this.navSelfIdx].sortDirection>
		<cfset structAppend(nestedArgs,arguments,false)>
		<cfset theNav = dspNestedNav(argumentCollection=nestedArgs) />
	</cfif>

	<cfset commitTracePoint(tracePoint)>

	<cfreturn thenav />
</cffunction>

<cffunction name="dspPeerNav" output="false" returntype="string">
	<cfargument name="class" default="#this.ulTopClass#" required="true">
	<cfargument name="liHasKidsClass" required="true" default="#this.liHasKidsClass#">
	<cfargument name="liHasKidsAttributes" required="true" default="#this.liHasKidsAttributes#">
	<cfargument name="liCurrentClass" required="true" default="#this.liCurrentClass#">
	<cfargument name="liCurrentAttributes" required="true" default="#this.liCurrentAttributes#">
	<cfargument name="liHasKidsNestedClass" required="true" default="#this.liHasKidsNestedClass#">
	<cfargument name="aHasKidsClass" required="true" default="#this.aHasKidsClass#">
	<cfargument name="aHasKidsAttributes" required="true" default="#this.aHasKidsAttributes#">
	<cfargument name="aCurrentClass" required="true" default="#this.aCurrentClass#">
	<cfargument name="aCurrentAttributes" required="true" default="#this.aCurrentAttributes#">

	<cfset var thenav="" />
	<cfset var menutype = "" />
	<cfset var nestedArgs=structNew()>
	<cfset var tracepoint=initTracepoint("contentRenderer.dspPeerNav")>

	<!--- Supporting Old Arguments--->
	<cfif structKeyExists(arguments,'liHasKidsCustomString')>
		<cfset arguments.liHasKidsAttributes=arguments.liHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aHasKidsCustomString')>
		<cfset arguments.aHasKidsAttributes=arguments.aHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aCurrentCustomString')>
		<cfset arguments.aCurrentAttributes=arguments.aCurrentCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'ulNestedCustomString')>
		<cfset arguments.ulNestedAttributes=arguments.ulNestedCustomString>
	</cfif>
	<!--- --->

	<cfset nestedArgs.openCurrentOnly=true>

	<cfif variables.event.getContentBean().getContentID() neq '00000000000000000000000000000000001'
		 and arraylen(this.crumbdata) gt (this.navParentIdx+this.navOffSet)>
		<cfset nestedArgs.contentID=this.crumbdata[this.navParentIdx].contentID>
		<cfset nestedArgs.viewDepth=1>
		<cfset nestedArgs.currDepth=1>
		<cfif this.crumbdata[this.navParentIdx].type eq 'calendar'>
			<cfset nestedArgs.type='fixed'>
		<cfelse>
			<cfset nestedArgs.type='default'>
		</cfif>
		<cfset nestedArgs.sortBy=this.crumbdata[this.navParentIdx].sortBy>
		<cfset nestedArgs.sortDirection=this.crumbdata[this.navParentIdx].sortDirection>
		<cfset structAppend(nestedArgs,arguments,false)>
		<cfset theNav = dspNestedNav(argumentCollection=nestedArgs) />
	</cfif>

	<cfset commitTracePoint(tracePoint)>

	<cfreturn theNav />
</cffunction>

<cffunction name="dspSequentialNav" output="false" returntype="string">
		<cfset var rsSection=variables.contentGateway.getKids('00000000000000000000000000000000000','#variables.event.getValue('siteID')#','#variables.event.getValue('contentBean').getparentid()#','default',now(),0,'',0,'#this.crumbdata[2].sortBy#','#this.crumbdata[2].sortDirection#')>
		<cfset var link=''>
		<cfset var class=''>
		<cfset var itemClass=''>
		<cfset var theNav="">
		<cfset var current=1>
		<cfset var next=1>
		<cfset var prev=1>
		<cfset var tracepoint=initTracepoint("contentRenderer.dspSequentialNav")>

		<cfif rsSection.recordcount and ((variables.event.getValue('r').restrict and variables.event.getValue('r').allow) or (not variables.event.getValue('r').restrict))>
			<cfloop query="rsSection">
			<cfif rssection.filename eq variables.event.getValue('contentBean').getfilename()>
				<cfset prev=iif((rsSection.currentrow - 1) lt 1,de(rsSection.recordcount),de(rsSection.currentrow-1)) />
				<cfset current=rsSection.currentrow />
				<cfset next=iif((rsSection.currentrow + 1) gt rsSection.recordcount,de(1),de(rsSection.currentrow + 1)) />
			</cfif>
			</cfloop>

			<cfsavecontent variable="theNav">
			<cfoutput>
			<ul class="#this.ulPaginationClass#">
			<cfif rsSection.contentID[1] neq variables.event.getValue('contentBean').getContentID()>
			<li ><a href="./index.cfm?linkServID=#rsSection.contentID[prev]#">&laquo; #getSite().getRBFactory().getKey("sitemanager.prev")#</a></li>
			</cfif>
			<cfloop query="rsSection">
			<cfsilent>
				<cfset itemClass=iif(variables.event.getValue('contentBean').getfilename() eq rsSection.filename,de('#this.liCurrentClass#'),de('')) />
				<cfset link=addlink(rsSection.type,rsSection.filename,rssection.currentrow,'','',rsSection.contentid,variables.event.getValue('siteID'),'',application.configBean.getContext(),application.configBean.getStub(),application.configBean.getIndexFile(),showItemMeta(rsSection.fileExt))>
			</cfsilent>
			<li<cfif len(itemClass)> class="#itemClass#"</cfif>>#link#</li>
			</cfloop>
			<cfif rsSection.contentID[rsSection.recordcount] neq variables.event.getValue('contentBean').getContentID()>
			<li><a href="./index.cfm?linkServID=#rsSection.contentID[next]#">#getSite().getRBFactory().getKey("sitemanager.next")# &raquo;</a></li>
			</cfif>
			</ul></cfoutput>
			</cfsavecontent>
		</cfif>

		<cfset commitTracePoint(tracePoint)>

		<cfreturn trim(theNav) />
</cffunction>

<cffunction name="dspGalleryNav" output="false" returntype="string">
		<cfset var rsSection=variables.contentGateway.getKids('00000000000000000000000000000000000',variables.event.getValue('siteID'),variables.event.getValue('contentBean').getcontentID(),'default',now(),0,'',0,variables.event.getValue('contentBean').getsortBy(),variables.event.getValue('contentBean').getsortDirection(),variables.event.getValue('categoryID'),variables.event.getValue('relatedID'))>
		<cfset var link=''>
		<cfset var class=''>
		<cfset var itemClass=''>
		<cfset var theNav="">
		<cfset var current=1>
		<cfset var next=1>
		<cfset var prev=1>
		<cfset var tracepoint=initTracepoint("contentRenderer.dspGalleryNav")>

		<cfif rsSection.recordcount and ((variables.event.getValue('r').restrict and variables.event.getValue('r').allow) or (not variables.event.getValue('r').restrict))>

			<cfloop query="rsSection">
			<cfif rssection.contentID eq variables.event.getValue('galleryItemID')>
				<cfset prev=iif((rsSection.currentrow - 1) lt 1,de(rsSection.recordcount),de(rsSection.currentrow-1)) />
				<cfset current=rsSection.currentrow />
				<cfset next=iif((rsSection.currentrow + 1) gt rsSection.recordcount,de(1),de(rsSection.currentrow + 1)) />
			</cfif>
			</cfloop>

			<cfsavecontent variable="theNav">
			<cfoutput>
			<ul class="#this.navSequentialULClass#">
			<li class="first">
			 <a href="#application.configBean.getIndexFile()#?startrow=#variables.event.getValue('startRow')#&galleryItemID=#rsSection.contentid[prev]#&categoryID=#variables.event.getValue('categoryID')#&relatedID=#variables.event.getValue('relatedID')#">&laquo; Prev</a>
			</li>
			<cfloop query="rsSection">
			<cfsilent>
				<cfset itemClass=iif(variables.event.getValue('galleryItemID') eq rsSection.contentID,de('current'),de('')) />
				<cfset link='<a href="#application.configBean.getIndexFile()#?startrow=#variables.event.getValue('startRow')#&galleryItemID=#rsSection.contentID#&categoryID=#variables.event.getValue('categoryID')#">#rsSection.currentRow#</a>'>
			</cfsilent>
			<li class="#itemClass#">#link#</li>
			</cfloop>
			<li class="last"> <a href="#application.configBean.getIndexFile()#?startrow=#variables.event.getValue('startRow')#&galleryItemID=#rsSection.contentid[next]#&categoryID=#variables.event.getValue('categoryID')#">Next &raquo;</a></li>
			</ul></cfoutput>
			</cfsavecontent>
		</cfif>

		<cfset commitTracePoint(tracePoint)>

		<cfreturn trim(theNav) />
</cffunction>

<cffunction name="dspSessionNav" output="false" returntype="string">
	<cfargument name="id" type="string" default="">
	<cfset var returnUrl = "" />
	<cfset var thenav = "" />

	<cfif variables.event.getValue('returnURL') neq "">
		<cfset returnUrl = variables.event.getValue('returnURL')>
	<cfelse>
		<cfset returnURL = URLEncodedFormat(getCurrentURL())>
	</cfif>

	<cfsavecontent variable="theNav">
		<cfif getSite().getExtranet() eq 1 and session.mura.isLoggedIn>
			<cfoutput><ul id="#arguments.id#"><li><a href="#application.configBean.getIndexFile()#?doaction=logout&nocache=1">Log Out #HTMLEditFormat("#session.mura.fname# #session.mura.lname#")#</a></li><li><a href="#application.settingsManager.getSite(variables.event.getValue('siteID')).getEditProfileURL()#&returnURL=#returnURL#&nocache=1">Edit Profile</a></li></ul></cfoutput>
		</cfif>
	</cfsavecontent>

	<cfreturn trim(thenav) />
</cffunction>

<cffunction name="dspTagCloud" access="public" output="false" returntype="string">
<cfargument name="parentID" type="any"  required="true" default="" />
<cfargument name="categoryID"  type="any" required="true" default="" />
<cfargument name="rsContent"  type="any"  required="true"  default="" />
<cfargument name="taggroup"  type="any"  required="true"  default="" />
	<cfset var theIncludePath = variables.event.getSite().getIncludePath() />
	<cfset var fileDelim = "/" />
	<cfset var filePath = theIncludePath  & fileDelim & "includes" & fileDelim />
	<cfset var theContent = "" />
	<cfset var theme =variables.$.siteConfig("theme")>
	<cfset var expandedPath=expandPath(filePath)>
	<cfset var str="">
	<cfset var tracePoint=0>

	<cfsavecontent variable="str">
	<cfif fileExists(expandedPath & "themes/"  & theme & "/display_objects/nav/dsp_tag_cloud.cfm")>
		<cfset tracePoint=initTracePoint("#filePath#themes/#theme#/display_objects/nav/dsp_tag_cloud.cfm")>
		<cfinclude template="#filePath#themes/#theme#/display_objects/nav/dsp_tag_cloud.cfm" />
	<cfelseif fileExists(expandedPath & "display_objects/custom/nav/dsp_tag_cloud.cfm")>
		<cfset tracePoint=initTracePoint("#filePath#display_objects/custom/nav/dsp_tag_cloud.cfm")>
		<cfinclude template="#filePath#display_objects/custom/nav/dsp_tag_cloud.cfm" />
	<cfelse>
		<cfset tracePoint=initTracePoint("#filePath#display_objects/nav/dsp_tag_cloud.cfm")>
		<cfinclude template="#filePath#display_objects/nav/dsp_tag_cloud.cfm" />
	</cfif>
	</cfsavecontent>

	<cfset commitTracePoint(tracePoint)>

<cfreturn str />
</cffunction>

<cffunction name="dspObject_Render" access="public" output="false">
	<cfargument name="siteid" type="string" />
	<cfargument name="object" type="string" />
	<cfargument name="objectid" type="string" />
	<cfargument name="fileName" type="string" default=''/>
	<cfargument name="cacheKey" type="string" required="false"  />
	<cfargument name="hasSummary" type="boolean" required="false" default="true" />
	<cfargument name="useRss" type="boolean" required="false" default="false" />
	<cfargument name="params" required="false" default="" />
	<cfargument name="assignmentID" type="string" required="true" default="">
	<cfargument name="regionID" required="true" default="0">
	<cfargument name="orderno" required="true" default="0">
	<cfargument name="showEditable" required="true" default="false">
	<cfargument name="isConfigurator" required="true" default="false">
	<cfargument name="objectname" required="true" default="">

	<cfset var theContent=""/>
	<cfset var objectPerm="none">
	<cfset var result="">

	<cfif StructKeyExists(arguments,"cacheKey") and not arguments.showEditable>
		<cfsavecontent variable="theContent">
		<cf_CacheOMatic key="#arguments.cacheKey##request.muraFrontEndRequest#" nocache="#variables.event.getValue('nocache')#">
			<cfset result=dspObject_Include(arguments.siteid,arguments.object,arguments.objectid,arguments.fileName,arguments.hasSummary,arguments.useRss,"none",arguments.params,arguments.assignmentID,arguments.regionID,arguments.orderno,'',true,arguments.showEditable,arguments.isConfigurator,arguments.objectname)>
			<cfif isSimpleValue(result)>
				<cfoutput>#result#</cfoutput>
			<cfelse>
				<cfset request.cacheItem=false>
			</cfif>
		</cf_cacheomatic>
		</cfsavecontent>

		<cfif isSimpleValue(result)>
			<cfreturn trim(theContent)>
		<cfelse>
			<cfreturn result>
		</cfif>
	<cfelse>
		<cfset result = dspObject_Include(arguments.siteid,arguments.object,arguments.objectid,arguments.fileName,arguments.hasSummary,arguments.useRss,objectPerm,arguments.params,arguments.assignmentID,arguments.regionID,arguments.orderno,'',true,arguments.showEditable,arguments.isConfigurator,arguments.objectname) />

		<cfif isSimpleValue(result)>
			<cfreturn trim(result)>
		<cfelse>
			<cfreturn result>
		</cfif>
	</cfif>


</cffunction>

<cffunction name="dspObject_Include" access="public" output="false">
	<cfargument name="siteid" type="string" default="#variables.$.event('siteid')#"/>
	<cfargument name="object" type="string" default="" />
	<cfargument name="objectid" type="string" default=""/>
	<cfargument name="theFile" type="string" />
	<cfargument name="hasSummary" type="boolean" required="true" default="false"/>
	<cfargument name="RSS" type="boolean" required="true" default="false" />
	<cfargument name="objectPerm" type="string" required="true" default="none" />
	<cfargument name="params" required="true" default="" />
	<cfargument name="assignmentID" type="string" required="true" default="">
	<cfargument name="regionID" required="true" default="0">
	<cfargument name="orderno" required="true" default="0">
	<cfargument name="contentHistID" required="true" default="">
	<cfargument name="throwError" default="true">
	<cfargument name="showEditable" required="true" default="false">
	<cfargument name="isConfigurator" required="true" default="false">
	<cfargument name="objectname" required="true" default="">

	<cfset var fileDelim = "/" />
	<cfset var displayObjectPath = variables.$.siteConfig('IncludePath') & fileDelim & "includes"  & fileDelim & "display_objects"/>
	<cfset var themeObjectPath = variables.$.siteConfig('ThemeIncludePath') & fileDelim & "display_objects"/>
	<cfset var themePath = variables.$.siteConfig('themeAssetPath') />
	<cfset var useRss = arguments.RSS />
	<cfset var bean = "" />
	<cfset var theContent = "" />
	<cfset var editableControl = structNew()>
	<cfset var expandedDisplayObjectPath=expandPath(displayObjectPath)>
	<cfset var expandedThemeObjectPath=expandPath(themeObjectPath)>
	<cfset var tracePoint=0>
	<cfset var doLayoutManagerWrapper=request.muraFrontEndRequest and this.layoutmanager and len(arguments.object)>

	<cfif isJSON(arguments.params)>
		<cfset var objectParams=deserializeJSON(arguments.params)>
	<cfelseif isStruct(arguments.params)>
		<cfset var objectParams=arguments.params>
	<cfelse>
		<cfset var objectParams=structNew()>
	</cfif>

	<cfif this.layoutmanager>
		<cfset objectParams.async=false>
		<cfset objectParams.render='server'>
	</cfif>

	<cfif arguments.object eq 'plugin'>
		<cfset result=application.pluginManager.displayObject(regionid=arguments.regionid,object=arguments.objectid,event=variables.$.event(),params=objectParams,isConfigurator=arguments.isConfigurator,objectname=arguments.objectname)>
		<cfif isSimpleValue(result)>
			<cfset theContent=result>
		</cfif>
	<cfelse>
		<!--- For backward compatability with old dsp_feed.cfm files --->
		<cfif arguments.thefile eq "dsp_feed.cfm">
			<cfparam name="objectParams.displaySummaries" default="#arguments.hasSummary#">
		</cfif>

		<cfset var filePath=variables.$.siteConfig().lookupDisplayObjectFilePath(arguments.theFile)>

		<cfsavecontent variable="theContent">
			<cfif len(filepath)>
			<cfset tracePoint=initTracePoint("#filepath#")>
			<cfinclude template="#filepath#" />
			<cfset commitTracePoint(tracePoint)>
			<cfelse>
			<cfset tracePoint=initTracePoint("The requested file '#arguments.theFile#' could not be found.")>
			<cfoutput><cfif arguments.throwError><!-- The requested file '#arguments.theFile#' could not be found.--></cfif></cfoutput>
			<cfset commitTracePoint(tracePoint)>
			</cfif>
		</cfsavecontent>
	</cfif>

	<cfif doLayoutManagerWrapper && not (objectParams.async and objectParams.render eq 'client' and request.returnFormat eq 'json')>
		<cfif objectParams.render eq 'client'>

				<cfreturn variables.contentRendererUtility.renderObjectInManager(object=arguments.object,
				objectid=arguments.objectid,
				content='',
				objectParams=objectParams,
				showEditable=arguments.showEditable,
				isConfigurator=arguments.isConfigurator,
				objectname=arguments.objectname,
				renderer=this) />
		<cfelse>
			<cfreturn variables.contentRendererUtility.renderObjectInManager(object=arguments.object,
				objectid=arguments.objectid,
				content=theContent,
				objectParams=objectParams,
				showEditable=arguments.showEditable,
				isConfigurator=arguments.isConfigurator,
				objectname=arguments.objectname,
				renderer=this) />
		</cfif>'
	<cfelseif isDefined('objectParams.render') and objectParams.render eq 'client'>
		<cfreturn objectParams>
	<cfelse>
		<cfreturn trim(theContent) />
	</cfif>
</cffunction>

<cffunction name="dspBody"  output="false" returntype="string">
	<cfargument name="body" type="string" default="#$.content('body')#">
	<cfargument name="pagetitle" type="string" default="">
	<cfargument name="crumblist" type="boolean" default="1">
	<cfargument name="crumbseparator" type="string" default="&raquo;&nbsp;">
	<cfargument name="showMetaImage" type="boolean" default="1">
	<cfargument name="includeMetaHREF" type="boolean" default="true" />
	<cfargument name="bodyAttribute">
	<cfargument name="titleAttribute">
	<cfargument name="metaImageSizeArgs" default="#this.bodyMetaImageSizeArgs#">
	<cfargument name="metaImageClass" default="#this.bodymetaImageClass#">
	<cfargument name="renderKids" default="true">
	<cfargument name="displayIntervalDesc" type="string" default="">
	<cfargument name="displayIntervalClass" type="string" default="">

	<cfset var theIncludePath = variables.event.getSite().getIncludePath() />
	<cfset var themeIncludePath = variables.event.getSite().getThemeIncludePath() />
	<cfset var str = "" />
	<cfset var fileDelim="/" />
	<cfset var eventOutput="" />
	<cfset var rsPages="">
	<cfset var cacheStub="#variables.event.getValue('contentBean').getcontentID()##variables.event.getValue('pageNum')##variables.event.getValue('startrow')##variables.event.getValue('year')##variables.event.getValue('month')##variables.event.getValue('day')##variables.event.getValue('filterby')##variables.event.getValue('categoryID')##variables.event.getValue('relatedID')#">
	<cfset variables.event.setValue("BodyRenderArgs",arguments)>
	<cfset var doLayoutManagerWrapper=false>
	<cfsavecontent variable="str">
		<cfif (variables.event.getValue('isOnDisplay') and (not variables.event.getValue('r').restrict or (variables.event.getValue('r').restrict and variables.event.getValue('r').allow)))
			or (getSite().getextranetpublicreg() and variables.event.getValue('display') eq 'editprofile' and not session.mura.isLoggedIn)
			or (variables.event.getValue('display') eq 'editprofile' and session.mura.isLoggedIn)>
			<cfif variables.event.getValue('display') neq ''>
				<cfswitch expression="#variables.event.getValue('display')#">
					<cfcase value="editprofile">
						<cfset variables.$.noIndex()>
						<cfset variables.event.setValue('noCache',1)>
						<cfset variables.event.setValue('forceSSL',getSite().getExtranetSSL())/>
						<cfset eventOutput=application.pluginManager.renderEvent("onSiteEditProfileRender",variables.event)>
						<cfif len(eventOutput)>
						<cfoutput>#eventOutput#</cfoutput>
						<cfelse>
						<cfoutput>#dspObject_Include(thefile='dsp_edit_profile.cfm')#</cfoutput>
						</cfif>
					</cfcase>
					<cfcase value="search">
						<cfset variables.$.noIndex()>
						<cfset variables.event.setValue('noCache',1)>
						<cfset eventOutput=application.pluginManager.renderEvent("onSiteSearchRender",variables.event)>
						<cfif len(eventOutput)>
						<cfoutput>#eventOutput#</cfoutput>
						<cfelse>
						<cfoutput>#dspObject_Include(thefile='dsp_search_results.cfm')#</cfoutput>
						</cfif>
					</cfcase>
					<cfcase value="login">
						<cfset variables.$.noIndex()>
						<cfset variables.event.setValue('noCache',1)>
						<cfset eventOutput=application.pluginManager.renderEvent("onSiteLoginPromptRender",variables.event)>
						<cfif len(eventOutput)>
						<cfoutput>#eventOutput#</cfoutput>
						<cfelse>
						<cfoutput>#dspObject_Include(thefile='dsp_login.cfm')#</cfoutput>
						</cfif>
					</cfcase>
					<cfdefaultcase>
						<cfset variables.$.noIndex()>
						<cfset variables.event.setValue('noCache',1)>
						<cfset eventOutput=application.pluginManager.renderEvent("onDisplayRender",variables.event)>
						<cfif len(eventOutput)>
							<cfoutput>#eventOutput#</cfoutput>
						<cfelse>
							<cfoutput><p>The display action that you have requested is not valid.</p></cfoutput>
						</cfif>
					</cfdefaultcase>
				</cfswitch>
			<cfelse>

				 <cfoutput>
				 	<cfif structKeyExists(arguments,'titleAttribute')>
				 		<#getHeaderTag('headline')# class="pageTitle">#renderEditableAttribute(attribute=arguments.titleAttribute,required=true)#</#getHeaderTag('headline')#>
					<cfelseif arguments.pageTitle neq ''>
						<#getHeaderTag('headline')# class="pageTitle"><cfif arguments.pageTitle eq $.content('title')>#renderEditableAttribute(attribute='title',required=true)#<cfelse>#arguments.pageTitle#</cfif></#getHeaderTag('headline')#>
					</cfif>
					<cfif arguments.crumblist>
						#dspCrumbListLinks("crumblist",arguments.crumbseparator)#
					</cfif>
					<cfif variables.$.globalConfig().getValue(property='advancedScheduling',defaultValue=false) and $.hasParent() and $.getParent().getType() eq 'Calendar' and len(arguments.displayIntervalDesc)>
						<p<cfif len(displayIntervalClass)> class="#displayIntervalClass#"</cfif>>#arguments.displayIntervalDesc#</p>
					</cfif>
				</cfoutput>

				<cfset var bodyLookup=variables.contentRendererUtility.processContentTypeBody(variables.$)>

				<cfif isDefined('bodyLookup.eventOutput')>
					<cfoutput>#bodyLookup.eventOutput#</cfoutput>
				<cfelseif isDefined('bodyLookup.filepath')>
					<cfinclude template="#bodyLookup.filepath#">
				<cfelse>
					<cfswitch expression="#variables.event.getValue('contentBean').getType()#">
					<cfcase value="File">
						<cfif variables.event.getValue('contentBean').getContentType() eq "Image"
							and listFind("jpg,jpeg,gif,png",lcase(variables.event.getValue('contentBean').getFileExt()))>
								<cfset loadShadowBoxJS() />
								<cfoutput>
								<div id="svAssetDetail" class="mura-asset-detail image">
								<a href="#variables.$.content().getImageURL(size='large')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" #this.shadowboxattribute#="shadowbox[body]" id="svAsset" class="mura-asset"><img src="#variables.$.content().getImageURL(argumentCollection=arguments.metaImageSizeArgs)#" class="imgMed #arguments.metaImageClass#" alt="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" /></a>
								#renderEditableAttribute(attribute="summary",type="htmlEditor")#
								</div>
								</cfoutput>
						<cfelse>
								<cfoutput>
								<div id="svAssetDetail" class="mura-asset-detail file">
								#renderEditableAttribute(attribute="summary",type="htmlEditor")#
								<a href="#$.content().getURL('showMeta=2&ext=.#$.content().getFileExt()#')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" id="svAsset" class="mura-asset #lcase(variables.event.getValue('contentBean').getFileExt())#">Download File</a>
								</div>
								</cfoutput>
						</cfif>
					</cfcase>
					<cfcase value="Link">
						<cfoutput>
						<div id="svAssetDetail" class="mura-asset-detail link">
							#renderEditableAttribute(attribute="summary",type="htmlEditor")#
							<a href="#$.content().getURL('showMeta=2&ext=.#$.content().getFileExt()#')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" id="svAsset" class="mura-asset url">View Link</a>
						</div>
						</cfoutput>
					</cfcase>
					<cfdefaultcase>
						<cfif arguments.showMetaImage
							and len(variables.event.getValue('contentBean').getFileID())
							and variables.event.getValue('contentBean').getContentType() eq "Image"
							and listFind("jpg,jpeg,gif,png",lcase(variables.event.getValue('contentBean').getFileExt()))>
								<cfif useLayoutManager()>
									<cfoutput>
										<cfif arguments.includeMetaHREF><cfset loadShadowBoxJS() /></cfif>
										<div class="mura-asset">
											<cfif arguments.includeMetaHREF><a href="#variables.$.content().getImageURL(size='large')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" #this.shadowboxattribute#="shadowbox[body]"></cfif><img src="#variables.$.content().getImageURL(argumentCollection=arguments.metaImageSizeArgs)#" class="imgMed #arguments.metaImageClass#" alt="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" /><cfif arguments.includeMetaHREF></a></cfif>
										</div>
									</cfoutput>
								<cfelse>
									<cfoutput>
									<cfif arguments.includeMetaHREF>
										<cfset loadShadowBoxJS() />
										<a href="#variables.$.content().getImageURL(size='large')#" title="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" #this.shadowboxattribute#="shadowbox[body]" id="svAsset" class="mura-asset"><img src="#variables.$.content().getImageURL(argumentCollection=arguments.metaImageSizeArgs)#" class="imgMed #arguments.metaImageClass#" alt="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" /></a>
									<cfelse>
										<div id="svAsset" class="mura-asset">
										<img src="#variables.$.content().getImageURL(argumentCollection=arguments.metaImageSizeArgs)#" class="imgMed #arguments.metaImageClass#" alt="#HTMLEditFormat(variables.event.getValue('contentBean').getMenuTitle())#" />
										</div>
									</cfif>
									</cfoutput>
								</cfif>
						</cfif>
						<cfoutput>
							<cfif structKeyExists(arguments,'bodyAttribute')>
								#renderEditableAttribute(attribute=arguments.bodyAttribute,type="htmlEditor")#
							<cfelseif $.content('body') eq arguments.body>
								#renderEditableAttribute(attribute="body",type="htmlEditor")#
							<cfelse>
								#setDynamicContent(arguments.body)#
							</cfif>
						</cfoutput>
					</cfdefaultcase>
					</cfswitch>

					<cfif arguments.renderKids>
						<cfswitch expression="#variables.event.getValue('contentBean').gettype()#">
						<cfcase value="Folder">
							<cf_CacheOMatic key="FolderBody#cacheStub##getListFormat()#" nocache="#variables.event.getValue('r').restrict#">
							 <cfset filePath=$.siteConfig().lookupDisplayObjectFilePath('dsp_portal.cfm')>

							 <cfif len(filePath)>
							 	<cfoutput>#dspObject_Include(thefile='dsp_portal.cfm')#</cfoutput>
							 <cfelse>
							 	 <cfset filePath=$.siteConfig().lookupDisplayObjectFilePath('dsp_folder.cfm')>
							 	 <cfif len(filePath)>
								 	<cfoutput>#dspObject_Include(thefile='dsp_folder.cfm')#</cfoutput>
								 <cfelse>
								 	<cfoutput>#dspObject_Include(thefile='folder/index.cfm')#</cfoutput>
								 </cfif>
							</cfif>
							</cf_CacheOMatic>
						</cfcase>
						<cfcase value="Calendar">
							 <cf_CacheOMatic key="calendarBody#cacheStub##getListFormat()#" nocache="#variables.event.getValue('r').restrict#">
							 <cfoutput>#dspObject_Include(thefile='calendar/index.cfm')#</cfoutput>
							 </cf_CacheOMatic>
						</cfcase>
						<cfcase value="Gallery">
							<cfset loadShadowBoxJS() />
							<cfset addToHTMLHeadQueue("gallery/htmlhead/gallery.cfm")>
							<cfif not variables.event.valueExists('galleryItemID')><cfset variables.event.setValue('galleryItemID','')></cfif>
							<cf_CacheOMatic key="galleryBody#cacheStub##variables.event.getValue('galleryItemID')##getListFormat()#" nocache="#variables.event.getValue('r').restrict#">
							<cfoutput>#dspObject_Include(thefile='gallery/index.cfm')#</cfoutput>
							</cf_CacheOMatic>
						</cfcase>
						</cfswitch>
					</cfif>
				</cfif>
			</cfif>
		<cfelseif variables.event.getValue('isOnDisplay') and variables.event.getValue('r').restrict and variables.event.getValue('r').loggedIn and not variables.event.getValue('r').allow >
			<cfset variables.$.noIndex()>
			<cfset eventOutput=application.pluginManager.renderEvent("onContentDenialRender",variables.event)>
			<cfif len(eventOutput)>
			<cfoutput>#eventOutput#</cfoutput>
			<cfelse>
			<cfoutput>#dspObject_Include(thefile='dsp_deny.cfm')#</cfoutput>
			</cfif>
		<cfelseif variables.event.getValue('isOnDisplay') and variables.event.getValue('r').restrict and not variables.event.getValue('r').loggedIn>
			<cfset variables.$.noIndex()>
			<cfset variables.event.setValue('noCache',1)>
			<cfset eventOutput=application.pluginManager.renderEvent("onSiteLoginPromptRender",variables.event)>
			<cfif len(eventOutput)>
			<cfoutput>#eventOutput#</cfoutput>
			<cfelse>
			<cfoutput>#dspObject_Include(thefile='dsp_login.cfm')#</cfoutput>
			</cfif>
		<cfelse>
			<cfset variables.$.noIndex()>
			<cfset eventOutput=application.pluginManager.renderEvent("onContentOfflineRender",variables.event)>
			<cfheader statuscode="404" statustext="Content Not Found" />
			<cfif len(eventOutput)>
			<cfoutput>#eventOutput#</cfoutput>
			<cfelse>
			<cfoutput>#dspObject_Include(thefile='dsp_offline.cfm')#</cfoutput>
			</cfif>
		</cfif>
	</cfsavecontent>

	<cfreturn str />
</cffunction>

<cffunction name="dspContentTypeBody" output="false">
	<cfargument name="params" default="#structNew()#">

	<cfset var bodyLookup=variables.contentRendererUtility.processContentTypeBody(variables.$)>
	<cfset var eventOutput="">
	<cfsavecontent variable="eventOutput">
	<cfoutput>
	<cfif isDefined('bodyLookup.eventOutput')>
		#bodyLookup.eventOutput#
	<cfelseif isDefined('bodyLookup.filepath')>
		<cfinclude template="#bodyLookup.filepath#">
	<cfelseif variables.$.content('type') eq 'folder'>
		<cf_CacheOMatic key="folderBody#hash(cgi.query_string)#" nocache="#variables.event.getValue('r').restrict#">
		 <cfset var filePath=$.siteConfig().lookupDisplayObjectFilePath('dsp_portal.cfm')>

		 <cfif len(filePath)>
		 	<cfoutput>#dspObject_Include(thefile='dsp_portal.cfm')#</cfoutput>
		 <cfelse>
		 	 <cfset filePath=$.siteConfig().lookupDisplayObjectFilePath('dsp_folder.cfm')>
		 	 <cfif len(filePath)>
			 	<cfoutput>#dspObject_Include(thefile='dsp_folder.cfm',params=arguments.params)#</cfoutput>
			 <cfelse>
			 	<cfoutput>#dspObject_Include(thefile='folder/index.cfm',params=arguments.params)#</cfoutput>
			 </cfif>
		</cfif>
		</cf_CacheOMatic>
	<cfelseif variables.$.content('type') eq 'calendar'>
		<cf_CacheOMatic key="calendarBody#hash(cgi.query_string)#" nocache="#variables.event.getValue('r').restrict#">
		 	 <cfset filePath=$.siteConfig().lookupDisplayObjectFilePath('calendar/index.cfm')>
		 	 <cfif len(filePath)>
			 	<cfoutput>#dspObject_Include(thefile='calendar/index.cfm',params=arguments.params)#</cfoutput>
			 </cfif>
		</cf_CacheOMatic>
	<cfelseif variables.$.content('type') eq 'gallery'>
		<cf_CacheOMatic key="galleryBody#hash(cgi.query_string)#" nocache="#variables.event.getValue('r').restrict#">
		 	 <cfset filePath=$.siteConfig().lookupDisplayObjectFilePath('gallery/index.cfm')>
		 	 <cfif len(filePath)>
			 	<cfoutput>#dspObject_Include(thefile='gallery/index.cfm',params=arguments.params)#</cfoutput>
			 </cfif>
		</cf_CacheOMatic>
	</cfif>
	</cfoutput>
	</cfsavecontent>
	<cfreturn eventOutput>
</cffunction>

<cffunction name="dspNestedNavPrimary" output="false" returntype="string">
		<cfargument name="contentid" type="string">
		<cfargument name="viewDepth" type="numeric" required="true" default="1">
		<cfargument name="currDepth" type="numeric"  required="true"  default="1">
		<cfargument name="type" type="string"  default="default">
		<cfargument name="today" type="date"  default="#now()#">
		<cfargument name="id" type="string" default="">
		<cfargument name="querystring" type="string" default="">
		<cfargument name="sortBy" type="string" default="orderno">
		<cfargument name="sortDirection" type="string" default="asc">
		<cfargument name="context" type="string" default="#application.configBean.getContext()#">
		<cfargument name="stub" type="string" default="#application.configBean.getStub()#">
		<cfargument name="displayHome" type="string" default="conditional">
		<cfargument name="closeFolders" type="string" default="">
		<cfargument name="openFolders" type="string" default="">
		<cfargument name="menuClass" type="string" default="">
		<cfargument name="showCurrentChildrenOnly" type="boolean" default="false">
		<cfargument name="liHasKidsClass" required="true" default="">
		<cfargument name="liHasKidsAttributes" required="true" default="">
		<cfargument name="liCurrentClass" required="true" default="#this.liCurrentClass#">
		<cfargument name="liCurrentAttributes" required="true" default="">
		<cfargument name="liHasKidsNestedClass" required="true" default="#this.liHasKidsNestedClass#">
		<cfargument name="aHasKidsClass" required="true" default="">
		<cfargument name="aHasKidsAttributes" required="true" default="">
		<cfargument name="aCurrentClass" required="true" default="#this.aCurrentClass#">
		<cfargument name="aCurrentAttributes" required="true" default="">
		<cfargument name="ulNestedClass" required="true" default="">
		<cfargument name="ulNestedAttributes" required="true" default="">
		<cfargument name="aNotCurrentClass" required="true" default="#this.aNotCurrentClass#">
		<cfargument name="siteid" default="#variables.event.getValue('siteID')#">

		<cfset var rsSection=variables.contentGateway.getKids('00000000000000000000000000000000000',arguments.siteid,arguments.contentid,arguments.type,arguments.today,0,'',0,arguments.sortBy,arguments.sortDirection,'','','',0)>
		<cfset var adjust=0>
		<cfset var current=0>
		<cfset var link=''>
		<cfset var itemClass=''>
		<cfset var itemId=''>
		<cfset var nest=''>
		<cfset var subnav=false>
		<cfset var theNav="">
		<cfset var topIndex= arrayLen(this.crumbdata)-this.navOffSet />
		<cfset var rsHome=0>
		<cfset var homeLink = "" />
		<cfset var isLimitingOn = false>
		<cfset var isNotLimited = false>
		<cfset var limitingBy = "">
		<cfset var isNavSecondary=arguments.showCurrentChildrenOnly or (arguments.id eq 'navSecondary' or arguments.menuClass eq 'navSecondary')>
		<cfset var homeDisplayed = false>
		<cfset var nestedArgs=structNew()>
		<cfset var linkArgs=structNew()>
		<cfset var started=false>

		<cfif isDefined("arguments.closePortals")>
			<cfset arguments.closeFolders=arguments.closePortals>
		</cfif>

		<cfif isDefined("arguments.openPortals")>
			<cfset arguments.openFolders=arguments.openPortals>
		</cfif>

		<cfif isDefined("arguments.ulTopClass")>
			<cfset arguments.menuclass=arguments.ulTopClass>
		</cfif>

		<cfif len(arguments.closeFolders)>
			<cfset limitingBy="closed">
			<cfif isBoolean(arguments.closeFolders)>
				<cfset isLimitingOn=arguments.closeFolders />
			</cfif>
		</cfif>

		<cfif len(arguments.openFolders)>
			<cfset limitingBy="open">
			<cfif isBoolean(arguments.openFolders)>
				<cfif arguments.openFolders>
					<cfset isLimitingOn=false />
				<cfelse>
					<cfset isLimitingOn=true />
				</cfif>
			</cfif>
		</cfif>


		<cfif structKeyExists(arguments,'aHasKidsCustomString') and len(arguments.aHasKidsCustomString) and not (arguments.aHasKidsAttributes contains arguments.aHasKidsCustomString)>
			<cfset arguments.aHasKidsAttributes = arguments.aHasKidsAttributes & ' ' & arguments.aHasKidsCustomString>
		</cfif>

		<cfif rsSection.recordcount>
			<cfset adjust=rsSection.recordcount>
			<cfsavecontent variable="theNav"><cfoutput>

			<cfif not homeDisplayed and arguments.currDepth eq 1 and (arguments.displayHome eq "Always" or (arguments.displayHome eq "Conditional" and variables.event.getValue('contentBean').getcontentid() neq "00000000000000000000000000000000001"))>
				<cfsilent>
					<cfquery name="rsHome" datasource="#application.configBean.getReadOnlyDatasource()#" username="#application.configBean.getReadOnlyDbUsername()#" password="#application.configBean.getReadOnlyDbPassword()#">
					select menutitle,filename from tcontent where contentID=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.contentID#"> and siteid=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.siteid#"> and active=1
					</cfquery>
					<cfset homeLink="#application.configBean.getContext()##getURLStem(arguments.siteid,rsHome.filename)#">
					<cfset homeDisplayed = true>
				</cfsilent>

				<cfset started=true>
				<ul<cfif arguments.currDepth eq 1>#iif(arguments.id neq '',de(' id="#arguments.id#"'),de(''))##iif(arguments.menuClass neq '',de(' class="#arguments.menuClass#"'),de(''))#<cfelse><cfif len(arguments.ulNestedClass)> class="#arguments.ulNestedClass#"</cfif><cfif len(arguments.ulNestedAttributes)> #arguments.ulNestedAttributes#</cfif></cfif>>
				<li class="first<cfif variables.event.getValue('contentBean').getcontentid() eq arguments.contentid> #arguments.liCurrentClass#</cfif>" id="navHome"<cfif len(arguments.liCurrentAttributes)> #arguments.liCurrentAttributes#</cfif>><a href="#homeLink#"<cfif len(arguments.aCurrentClass) and $.content('contentID') eq '00000000000000000000000000000000001'> class="#arguments.aCurrentClass#"<cfelseif len(arguments.aNotCurrentClass)> class="#arguments.aNotCurrentClass#"</cfif><cfif len(arguments.aCurrentAttributes)> #arguments.aCurrentAttributes#</cfif>>#HTMLEditFormat(rsHome.menuTitle)#</a></li>
			</cfif>

			<cfloop query="rsSection">
			<cfif allowLink(rssection.restricted,rssection.restrictgroups,variables.event.getValue('r').loggedIn)>
			<cfsilent>

			<cfset current=current+1>
			<cfset nest=''>

			<cfset isNotLimited= rsSection.type eq "Page" or
			not (
				rsSection.type eq "Folder" and
					(isLimitingOn or (
										(limitingBy eq "closed" and listFind(arguments.closeFolders,rsSection.contentid))
									or
										(limitingBy eq "open" and not listFind(arguments.openFolders,rsSection.contentid))
									)

					)
					or listFindNoCase("Calendar,Gallery,Link,File",rsSection.type)
				)
			/>

			<cfset subnav= arguments.currDepth lt arguments.viewDepth
			and (
					(
					isNotLimited and isNavSecondary and (
														listFind(variables.event.getValue('contentBean').getPath(),"#rsSection.contentID#")
														and
														listLen(rsSection.path) lte listLen(variables.event.getValue('contentBean').getPath())
														)
					)
				or (
					isNotLimited and not isNavSecondary
					)
				)
				and not (rsSection.restricted and not session.mura.isLoggedIn)
			/>

			<cfif subnav>
				<cfset nestedArgs.contentID=rssection.contentid>
				<cfset nestedArgs.currDepth=arguments.currDepth+1>
				<cfset nestedArgs.type=iif(rssection.type eq 'calendar',de('fixed'),de('default'))>
				<cfset nestedArgs.sortBy=rssection.sortBy>
				<cfset nestedArgs.sortDirection=rssection.sortDirection>
				<cfset nestedArgs.menuClass="">
				<cfset nestedArgs.ulTopClass="">
				<cfset structAppend(nestedArgs,arguments,false)>
				<cfset nest=dspNestedNavPrimary(argumentCollection=nestedArgs) />
				<cfset subnav=subnav and find("<li",nest)>
			</cfif>

			<cfif subnav and arguments.currDepth gt 1 and len(arguments.liHasKidsNestedClass)>
				<cfset itemClass=arguments.liHasKidsNestedClass>
			<cfelse>
				<cfset itemClass="">
			</cfif>

			<cfif current eq adjust>
				<cfset itemClass=listAppend(itemClass, "last",' ')>
			</cfif>

			<cfif listFind(variables.event.getValue('contentBean').getPath(),"#rsSection.contentid#") and len(arguments.liCurrentClass)>
				<cfset itemClass=listAppend(itemClass,arguments.liCurrentClass," ")/>
			</cfif>

			<cfif subnav and len(arguments.liHasKidsClass)>
				<cfset itemClass=listAppend(itemClass,arguments.liHasKidsClass," ")/>
			</cfif>

			<cfset itemId="nav" & setCamelback(rsSection.menutitle)>

			<cfset linkArgs=structNew()>
			<cfset linkArgs.aHasKidsClass=arguments.aHasKidsClass>
			<cfset linkArgs.aHasKidsAttributes=arguments.aHasKidsAttributes>
			<cfset linkArgs.aNotCurrentClass=arguments.aNotCurrentClass>
			<cfset linkArgs.aCurrentClass=arguments.aCurrentClass>
			<cfset linkArgs.aCurrentAttributes=arguments.aCurrentAttributes>
			<cfset linkArgs.type=rsSection.type>
			<cfset linkArgs.filename=rsSection.filename>
			<cfset linkArgs.title=rsSection.menutitle>
			<cfset linkArgs.contentid=rsSection.contentid>
			<cfset linkArgs.target=rsSection.target>
			<cfset linkArgs.targetParams=rsSection.targetParams>
			<cfset linkArgs.siteID=arguments.siteid>
			<cfset linkArgs.querystring=arguments.querystring>
			<cfset linkArgs.isParent=subnav>
			<cfset link=addlink(argumentCollection=linkArgs)>

			</cfsilent>

			<cfif not started>
				<cfset started=true>
				<cfset itemClass=listAppend(itemClass, "first",' ')>
				<ul<cfif arguments.currDepth eq 1>#iif(arguments.id neq '',de(' id="#arguments.id#"'),de(''))##iif(arguments.menuClass neq '',de(' class="#arguments.menuClass#"'),de(''))#<cfelse><cfif len(arguments.ulNestedClass)> class="#arguments.ulNestedClass#"</cfif><cfif len(arguments.ulNestedAttributes)> #arguments.ulNestedAttributes#</cfif></cfif>>
			</cfif>
			<li<cfif len(itemClass)> class="#itemClass#"</cfif> id="#itemId#"<cfif len(arguments.liCurrentAttributes)> #arguments.liCurrentAttributes#</cfif>>#link#<cfif subnav>#nest#</cfif></li>
			<cfelse><cfset adjust=adjust-1></cfif></cfloop>
			<cfif started></ul></cfif>
			</cfoutput></cfsavecontent>
		</cfif>
		<cfreturn theNav />
</cffunction>

<cffunction name="dspPrimaryNav" returntype="string" access="public">
	<cfargument name="viewDepth" type="numeric" default="1" required="true">
	<cfargument name="id" type="string" required="true" default="navPrimary">
	<cfargument name="displayHome" type="string" required="true" default="conditional">
	<cfargument name="closeFolders" type="string" default="">
	<cfargument name="openFolders" type="string" default="">
	<cfargument name="class" type="string" default="">
	<cfargument name="aHasKidsClass" type="string" default="">
	<cfargument name="aHasKidsAttributes" type="string" default="">
	<cfargument name="siteid" default="#$.event('siteid')#">

	<cfset var thenav="" />
	<cfset var topIndex= arrayLen(this.crumbdata)-this.navOffSet />
	<cfset var tracePoint=0>

	<!--- Supporting Old Arguments--->
	<cfif structKeyExists(arguments,'liHasKidsCustomString')>
		<cfset arguments.liHasKidsAttributes=arguments.liHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aHasKidsCustomString')>
		<cfset arguments.aHasKidsAttributes=arguments.aHasKidsCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'aCurrentCustomString')>
		<cfset arguments.aCurrentAttributes=arguments.aCurrentCustomString>
	</cfif>
	<cfif structKeyExists(arguments,'ulNestedCustomString')>
		<cfset arguments.ulNestedAttributes=arguments.ulNestedCustomString>
	</cfif>
	<!--- --->

	<!--- hack or issue with bootstrap that breaks link with kids --->
	<cfif arguments.aHasKidsClass eq 'dropdown-toggle' and arguments.aHasKidsAttributes eq 'role="button" data-toggle="dropdown" data-target="##"'>
		<cfset arguments.aHasKidsAttributes=''>
	</cfif>

	<cfif isDefined("arguments.closePortals")>
		<cfset arguments.closeFolders=arguments.closePortals>
	</cfif>

	<cfif isDefined("arguments.openPortals")>
		<cfset arguments.openFolders=arguments.openPortals>
	</cfif>

	<cfset arguments.contentid=this.crumbdata[topIndex].contentID>
	<cfset arguments.viewDepth=arguments.viewDepth+1>
	<cfset arguments.currDepth=1>
	<cfset arguments.sortBy="orderno">
	<cfset arguments.sortDirection="asc">
	<cfset arguments.menuClass=arguments.class>
	<cfset tracepoint=initTracepoint("contentRenderer.dspPrimaryNav")>
	<cfset theNav = dspNestedNavPrimary(argumentCollection=arguments) />
	<cfset commitTracePoint(tracePoint)>
	<cfreturn thenav />
</cffunction>

<cffunction name="loadShadowboxJS" returntype="void" output="false">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.loadShadowboxJS(argumentCollection=arguments)>
</cffunction>

<cffunction name="allowLink" output="false" returntype="boolean">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.allowLink(argumentCollection=arguments)>
</cffunction>

<cffunction name="getTopId" output="false" returntype="string">
	<cfargument name="useNavOffset" required="true" default="false"/>
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getTopId(argumentCollection=arguments)>
</cffunction>

<cffunction name="getTopVar" output="false" returntype="string">
	<cfargument name="topVar" required="true" default="" type="String">
	<cfargument name="useNavOffset" required="true" type="boolean" default="false">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getTopVar(argumentCollection=arguments)>
</cffunction>

<cffunction name="getCrumbVarByLevel" output="false" returntype="string">
	<cfargument name="theVar" required="true" default="" type="String">
	<cfargument name="level" required="true" type="numeric" default="1">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getCrumbVarByLevel(argumentCollection=arguments)>
</cffunction>

<cffunction name="dspZoomText" returntype="string" output="false">
	<cfargument name="crumbdata" required="yes" type="array">
	<cfargument name="separator" required="yes" default=">">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.dspZoomText(argumentCollection=arguments)>
</cffunction>

<cffunction name="dspZoom" returntype="string" output="false">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.dspZoom(argumentCollection=arguments)>
</cffunction>

<cffunction name="dspZoomNoLinks" returntype="string" output="false">
	<cfargument name="crumbdata" required="yes" type="array">
	<cfargument name="fileExt" type="string" default="" hint="deprecated, this is now in the crumbData">
	<cfargument name="class" type="string" default="navZoom">
	<cfargument name="charLimit" type="numeric" default="0">
	<cfargument name="minLevels" type="numeric" default="0">
	<cfargument name="maxLevels" type="numeric" default="0">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.dspZoomNoLinks(argumentCollection=arguments) />
</cffunction>

<cffunction name="dspObject" access="public" output="false">
	<cfargument name="object" type="string">
	<cfargument name="objectid" type="string" required="true" default="">
	<cfargument name="siteid" type="string" required="true" default="#variables.event.getValue('siteID')#">
	<cfargument name="params" required="true" default="">
	<cfargument name="assignmentID" type="string" required="true" default="">
	<cfargument name="regionID" required="true" default="0">
	<cfargument name="orderno" required="true" default="0">
	<cfargument name="hasConfigurator" required="true" default="false">
	<cfargument name="assignmentPerm" required="true" default="none">
	<cfargument name="allowEditable" type="boolean" default="#this.showEditableObjects#">
	<cfargument name="cacheKey" type="string" required="false" default="">
	<cfargument name="objectname" default="">
	<cfset arguments.renderer=this>
	<cfset arguments.showEditableObjects=this.showEditableObjects>
	<cfset arguments.layoutmanager=this.layoutmanager>
	<cfreturn variables.contentRendererUtility.dspObject(argumentCollection=arguments)>
</cffunction>

<cffunction name="dspObjects" output="false">
	<cfargument name="columnID" required="yes" type="numeric" default="1">
	<cfargument name="ContentHistID" required="yes" type="string" default="#variables.event.getValue('contentBean').getcontenthistid()#">
	<cfargument name="returnFormat" default="string">
	<cfset arguments.renderer=this>
	<cfset arguments.layoutmanager=this.layoutmanager>
	<cfreturn variables.contentRendererUtility.dspObjects(argumentCollection=arguments)>
</cffunction>

<cffunction name="getPersonalizationID" returntype="string" output="false">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getPersonalizationID(argumentCollection=arguments)>
</cffunction>

<cffunction name="getContentListProperty" output="false">
	<cfargument name="property" default="">
	<cfargument name="contentListPropertyMap" default="#this.contentListPropertyMap#">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getContentListProperty(argumentCollection=arguments)>
</cffunction>

<cffunction name="getContentListPropertyValue" output="false">
	<cfargument name="property" default="">
	<cfargument name="value" default="">
	<cfargument name="contentListPropertyMap" default="#this.contentListPropertyMap#">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getContentListPropertyValue(argumentCollection=arguments)>
</cffunction>

<cffunction name="getContentListLabel" output="false">
	<cfargument name="property" default="">
	<cfargument name="contentListPropertyMap" default="#this.contentListPropertyMap#">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getContentListLabel(argumentCollection=arguments)>
</cffunction>

<cffunction name="getContentListAttributes" returntype="string" output="false">
	<cfargument name="property" default="">
	<cfargument name="class" default="">
	<cfargument name="contentListPropertyMap" default="#this.contentListPropertyMap#">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getContentListAttributes(argumentCollection=arguments)>
</cffunction>

<cffunction name="getListFormat" output="false">
	<cfset arguments.renderer=this>
	<cfset arguments.contentListPropertyMap=this.contentListPropertyMap>
	<cfreturn variables.contentRendererUtility.getListFormat(argumentCollection=arguments)>
</cffunction>

<cffunction name="dspCrumblistLinks"  output="false" returntype="string">
	<cfargument name="id" type="string" default="crumblist">
	<cfargument name="separator" type="string" default="">
	<cfargument name="class" type="string" default="#this.navBreadcrumbULClass#">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.dspCrumblistLinks(argumentCollection=arguments)>
</cffunction>

<cffunction name="renderIcon" returntype="string" output="false">
	<cfargument name="data">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.renderIcon(argumentCollection=arguments)>
</cffunction>

<cffunction name="getURLStem" access="public" output="false" returntype="string">
	<cfargument name="siteID">
	<cfargument name="filename">
	<cfargument name="siteidinurls" default="#this.siteIDInURLS#">
	<cfargument name="indexfileinurls" default="#this.indexFileInURLS#">
	<cfargument name="hashURLS" default="#this.hashURLS#">
	<cfreturn application.contentServer.getURLStem(argumentCollection=arguments)>
</cffunction>

<cffunction name="createHREF" returntype="string" output="false" access="public">
	<cfargument name="type" required="true" default="Page">
	<cfargument name="filename" required="true">
	<cfargument name="siteid" required="true" default="">
	<cfargument name="contentid" required="true" default="">
	<cfargument name="target" required="true" default="">
	<cfargument name="targetParams" required="true" default="" hint="deprecated, does not do anything.  May come be re-introduced for modal params">
	<cfargument name="querystring" required="true" default="">
	<cfargument name="context" type="string" required="true" default="#application.configBean.getContext()#" hint="deprecated">
	<cfargument name="stub" type="string" required="true" default="#application.configBean.getStub()#" hint="deprecated">
	<cfargument name="indexFile" type="string" required="true" default="" hint="deprecated">
	<cfargument name="complete" type="boolean" required="true" default="false">
	<cfargument name="showMeta" type="string" required="true" default="0">
	<cfargument name="bean" hint="The contentBean that link is being generated for">
	<cfargument name="secure" default="false">
	<cfset arguments.renderer=this>
	<cfset arguments.hashUrls=this.hashUrls>
	<cfreturn variables.contentRendererUtility.createHREF(argumentCollection=arguments)>
</cffunction>

<cffunction name="createHREFforRSS" returntype="string" output="false" access="public">
	<cfargument name="type" required="true" default="Page">
	<cfargument name="filename" required="true">
	<cfargument name="siteid" required="true">
	<cfargument name="contentid" required="true" default="">
	<cfargument name="target" required="true" default="">
	<cfargument name="targetParams" required="true" default="" hint="deprecated">
	<cfargument name="context" type="string" default="#application.configBean.getContext()#" hint="deprecated">
	<cfargument name="stub" type="string" default="#application.configBean.getStub()#" hint="deprecated">
	<cfargument name="indexFile" type="string" default="">
	<cfargument name="showMeta" type="string" default="0">
	<cfargument name="fileExt" type="string" default="" required="true">
	<cfargument name="secure" default="false">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.createHREFforRSS(argumentCollection=arguments)>
</cffunction>

<cffunction name="createHREFForImage" output="false" returntype="any">
	<cfargument name="siteID">
	<cfargument name="fileID">
	<cfargument name="fileExt">
	<cfargument name="size" required="true" default="undefined">
	<cfargument name="direct" required="true" default="#this.directImages#">
	<cfargument name="complete" type="boolean" required="true" default="false">
	<cfargument name="height" default=""/>
	<cfargument name="width" default=""/>
	<cfargument name="secure" default="false">
	<cfreturn getBean("fileManager").createHREFForImage(argumentCollection=arguments)>
</cffunction>

<cffunction name="addlink" output="false" returntype="string">
	<cfargument name="type" required="true">
	<cfargument name="filename" required="true">
	<cfargument name="title" required="true">
	<cfargument name="target" type="string"  default="">
	<cfargument name="targetParams" type="string"  default="">
	<cfargument name="contentid" required="true">
	<cfargument name="siteid" required="true">
	<cfargument name="querystring" type="string" required="true" default="">
	<cfargument name="context" type="string" required="true" default="#application.configBean.getContext()#">
	<cfargument name="stub" type="string" required="true" default="#application.configBean.getStub()#">
	<cfargument name="indexFile" type="string" required="true" default="">
	<cfargument name="showMeta" type="string" required="true" default="0">
	<cfargument name="showCurrent" type="string" required="true" default="1">
	<cfargument name="class" type="string" required="true" default="">
	<cfargument name="complete" type="boolean" required="true" default="false">
	<cfargument name="id" type="string" required="true" default="">
	<cfargument name="aHasKidsClass" required="true" default="#this.aHasKidsClass#">
	<cfargument name="aHasKidsAttributes" required="true" default="#this.aHasKidsAttributes#">
	<cfargument name="aCurrentClass" required="true" default="#this.aCurrentClass#">
	<cfargument name="aCurrentAttributes" required="true" default="#this.aCurrentAttributes#">
	<cfargument name="isParent" required="true" default="false">
	<cfargument name="aNotCurrentClass" required="true" default="#this.aNotCurrentClass#">
	<cfargument name="secure" default="false">
	<cfargument name="isBreadCrumb" default="false">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.addlink(argumentCollection=arguments)>
</cffunction>

<cffunction name="queryPermFilter" returntype="query" access="public" output="false">
	<cfargument name="rawQuery" type="query">
	<cfreturn application.permUtility.queryPermFilter(arguments.rawQuery,'',variables.event.getValue('siteID'),variables.event.getValue('r').hasModuleAccess)/>
</cffunction>

<cffunction name="newResultQuery" returntype="query" access="public" output="false">
	<cfreturn application.permUtility.newResultQuery() />
</cffunction>

<cffunction name="setParagraphs" access="public" output="false" returntype="string">
	<cfargument name="theString" type="string">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.setParagraphs(argumentCollection=arguments)>
</cffunction>

<cffunction name="createCSSID"  output="false" returntype="string">
	<cfargument name="title" type="string" required="true" default="">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.createCSSID(argumentCollection=arguments)>
</cffunction>

<cffunction name="createCSSHook"  output="false" returntype="string">
	<cfargument name="text" type="string" required="true">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.createCSSHook(argumentCollection=arguments)>
</cffunction>

<cffunction name="getTemplate"  output="false" returntype="string">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getTemplate(argumentCollection=arguments)>
</cffunction>

<cffunction name="getMetaDesc"  output="false" returntype="string">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getMetaDesc(argumentCollection=arguments)>
</cffunction>

<cffunction name="getMetaKeywords"  output="false" returntype="string">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getMetaKeyWords(argumentCollection=arguments)>
</cffunction>

<cffunction name="stripHTML" returntype="string" output="false">
	<cfargument name="str" type="string">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.stripHTML(argumentCollection=arguments)>
</cffunction>

<cffunction name="addCompletePath" returntype="string" output="false">
	<cfargument name="str" type="string">
	<cfargument name="siteID" type="string">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.addCompletePath(argumentCollection=arguments)>
</cffunction>

<cffunction name="getSite" returntype="any" output="false">
	<cfreturn application.settingsManager.getSite(variables.event.getValue('siteID')) />
</cffunction>

<cffunction name="getCurrentURLArray" output="false">
	<cfreturn variables.contentRendererUtility.getCurrentURLArray(renderer=this)>
</cffunction>

<cffunction name="renderFile" output="true" access="public">
	<cfargument name="fileID" type="string">
	<cfargument name="method" type="string" required="true" default="inline">
	<cfargument name="size" type="string" required="true" default="">
	<cfset getBean('fileManager').renderFile(arguments.fileid,arguments.method,arguments.size) />
</cffunction>

<cffunction name="renderSmall" output="true" access="public">
	<cfargument name="fileID" type="string">
	<cfset getBean('fileManager').renderSmall(arguments.fileid) />
</cffunction>

<cffunction name="renderMedium" output="true" access="public">
	<cfargument name="fileID" type="string">
	<cfset getBean('fileManager').renderMedium(arguments.fileid) />
</cffunction>

<cffunction name="jsonencode" access="public" output="false" returntype="string">
	<cfargument name="arg" default="" required="yes" type="any"/>
	<cfreturn createObject("component","mura.json").init().jsonencode(arguments.arg)>
</cffunction>

<cffunction name="getCurrentURL" access="public" returntype="string" output="false">
	<cfargument name="complete" required="true" type="boolean" default="true" />
	<cfargument name="injectVars" required="true" type="string" default="" />
	<cfargument name="filterVars" required="true" type="boolean" default="true" />
	<cfargument name="domain" default="#listFirst(cgi.http_host,":")#">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.getCurrentURL(argumentCollection=arguments)>
</cffunction>

<cffunction name="dspUserTools" access="public" output="false" returntype="string">
	<cfset var theObject = "" />
	<cfset var theIncludePath = variables.event.getSite().getIncludePath() />

	<cfsavecontent variable="theObject">
		<cfinclude template="#theIncludePath#/includes/display_objects/dsp_user_tools.cfm">
	</cfsavecontent>

	<cfreturn theObject />

</cffunction>

<cffunction name="dspSection" access="public" output="false" returntype="string">
	<cfargument name="level" default="1" required="true">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.dspSection(argumentCollection=arguments)>
</cffunction>

<cffunction name="setDynamicContent" returntype="string" output="false">
	<cfargument name="str">

	<cfset var body=arguments.str>
	<cfset var errorStr="">
	<cfset var regex1="(\[sava\]|\[mura\]|\[m\]).+?(\[/sava\]|\[/mura\]|\[/m\])">
	<cfset var regex2="">
	<cfset var finder=reFindNoCase(regex1,body,1,"true")>
	<cfset var tempValue="">

	<cfparam name="this.enableMuraTag" default="true" />

	<!--- It the Mura tag is not enabled just return the submitted string --->
	<cfif not this.enableMuraTag>
		<cfreturn str />
	</cfif>

	<!---  still looks for the Sava tag for backward compatibility --->
	<cfloop condition="#finder.len[1]#">
		<cftry>
			<cfset tempValue=mid(body, finder.pos[1], finder.len[1])>

			<cfif left(tempValue,3) eq "[m]">
				<cfset tempValue=evaluate("##" & mid(tempValue, 4, len(tempValue)-7) & "##")>
			<cfelse>
				<cfset tempValue=evaluate("##" & mid(tempValue, 7, len(tempValue)-13) & "##")>
			</cfif>

			<cfif not isDefined("tempValue") or not isSimpleValue(tempValue)>
				<cfset tempValue="">
			</cfif>

			<cfset body=replaceNoCase(body,mid(body, finder.pos[1], finder.len[1]),'#trim(tempValue)#')>
			<cfcatch>
				<cfif application.configBean.getDebuggingEnabled()>
					<cfset request.muraDynamicContentError=true>
					<cfset errorStr=getBean('utility').formatError(cfcatch)>
					<cfset body=replaceNoCase(body,mid(body, finder.pos[1], finder.len[1]),errorStr)>
				<cfelse>
					<cfrethrow>
				</cfif>
			</cfcatch>
		</cftry>
		<cfset finder=reFindNoCase(regex1,body,1,"true")>
		<cfset request.cacheItem=false>
	</cfloop>

	<cfreturn body />
</cffunction>

<cffunction name="dspCaptcha" returntype="string" output="false">
	<cfset var theObject = "" />
	<cfset var theIncludePath = variables.event.getSite().getIncludePath() />

	<cfsavecontent variable="theObject">
		<cfinclude template="#theIncludePath#/includes/display_objects/dsp_captcha.cfm">
	</cfsavecontent>

	<cfreturn trim(theObject)>
</cffunction>

<cffunction name="dspInclude" returntype="string" access="public">
	<cfargument name="template" default="" required="true">
	<cfargument name="baseDir" default="#variables.event.getSite().getIncludePath()#/includes" required="true">
	<cfset var str='' />
	<cfset var tracePoint=0>
	<cfif arguments.template neq ''>
		<cfset tracePoint=initTracePoint("#arguments.baseDir#/#arguments.template#")>
		<cfsavecontent variable="str">
			<cfinclude template="#arguments.baseDir#/#arguments.template#">
		</cfsavecontent>
		<cfset commitTracePoint(tracePoint)>
	</cfif>

	<cfreturn trim(str) />
</cffunction>

<cffunction name="dspThemeInclude" returntype="string" access="public">
	<cfargument name="template" default="" required="true">
	<cfset var str='' />
	<cfset var tracePoint=0>
	<cfif arguments.template neq ''>
		<cfset tracePoint=initTracePoint("#variables.$.siteConfig('themeIncludePath')#/#arguments.template#")>
		<cfsavecontent variable="str">
			<cfinclude template="#variables.$.siteConfig('themeIncludePath')#/#arguments.template#">
		</cfsavecontent>
		<cfset commitTracePoint(tracePoint)>
	</cfif>

	<cfreturn trim(str) />
</cffunction>

<!--- DEPRECATED --->
<cffunction name="sendToFriendLink" output="false" returnType="String">
<cfreturn "javascript:sendtofriend=window.open('#variables.event.getSite().getAssetPath()#/utilities/sendtofriend.cfm?link=#urlEncodedFormat(getCurrentURL())#&siteID=#variables.event.getValue('siteID')#', 'sendtofriend', 'scrollbars=yes,resizable=yes,screenX=0,screenY=0,width=570,height=390');sendtofriend.focus();void(0);"/>
</cffunction>

<cffunction name="addToHTMLHeadQueue" output="false">
	<cfargument name="text">
	<cfargument name="action" default="append">
	<cfset arguments.renderer=this>
	<cfset variables.contentRendererUtility.addToHTMLHeadQueue(argumentCollection=arguments)>
</cffunction>

<cffunction name="addToHTMLFootQueue" output="false">
	<cfargument name="text">
	<cfargument name="action" default="append">
	<cfset arguments.renderer=this>
	<cfset variables.contentRendererUtility.addToHTMLFootQueue(argumentCollection=arguments)>
</cffunction>

<cffunction name="getShowModal" output="false">
<cfreturn getShowToolbar() or (this.showEditableObjects and this.hasEditableObjects and not request.muraExportHTML and this.enableFrontEndTools) />
</cffunction>

<cffunction name="getShowToolbar" output="false">
	<cfreturn this.enableFrontEndTools
		and (
			request.muraChangesetPreviewToolbar
			and (
				this.showMemberToolBar or this.showAdminToolBar
			) or (
				(
				 	StructKeyExists(session, 'mura')
				 	and (
						listFind(session.mura.memberships,'S2IsPrivate;#application.settingsManager.getSite(variables.event.getValue('siteID')).getPrivateUserPoolID()#')
						or listFind(session.mura.memberships,'S2')
					)
				) or (
					listFindNoCase("editor,author",variables.event.getValue('r').perm)
					and this.showMemberToolBar
				)
			) and getShowAdminToolBar()
		) and not request.muraExportHTML />
</cffunction>

<cffunction name="hasFETools" output="false">
<cfreturn getShowToolbar() and (not isDefined('cookie.fetdisplay') or cookie.fetdisplay eq '')/>
</cffunction>

<cffunction name="getShowInlineEditor" output="false">
<cfreturn  getShowToolbar() and this.showInlineEditor/>
</cffunction>

<cffunction name="renderHTMLQueue" output="false">
	<cfargument name="queueType">
	<cfset var headerStr="" />
	<cfset var itemStr="" />
	<cfset var HTMLQueue="" />
	<cfset var i = "" />
	<cfset var iLen = 0 />
	<cfset var headerFound=false />
	<cfset var pluginBasePath="" />
	<cfset var pluginPath="" />
	<cfset var pluginID=0 />
	<cfset var pluginConfig="" />
	<cfset var displayPoolID=application.settingsManager.getSite(variables.event.getValue('siteID')).getDisplayPoolID()>
	<cfset var theme=(len(request.altTheme) ? request.altTheme : application.settingsManager.getSite(variables.event.getValue('siteID')).getTheme())>
	<cfset var tracePoint=0>

	<cfif getRenderHTMLQueues()>

		<cfif arguments.queueType eq "HEAD" and variables.$.content('type') neq 'Variation'>

			<!--- Add global.js --->
			<cfset addToHTMLHEADQueue('global.cfm',"prepend")>

			<!--- ensure that the js lb is always there --->
			<cfif not this.jsLibLoaded>
				<cfset addToHTMLHeadQueue("jquery.cfm","prepend")>
			</cfif>

		<cfelseif arguments.queueType eq "FOOT">
			<cfif (getShowModal() or variables.event.getValue("muraChangesetPreviewToolbar")) and not request.muraExportHTML>
				<cfif getShowModal()>
					<cfsavecontent variable="headerStr"><cfinclude template="/#application.configBean.getWebRootMap()#/admin/core/utilities/modal/toolbar.cfm"></cfsavecontent>
					<cfset commitTracePoint(tracePoint)>
				</cfif>
				<!---
				<cfif variables.event.getValue("muraChangesetPreviewToolbar")>
					<cfset tracePoint=initTracePoint("/#application.configBean.getWebRootMap()#/admin/core/utilities/modal/dsp_modal_changeset.cfm")>
					<cfinclude template="/#application.configBean.getWebRootMap()#/admin/core/utilities/modal/dsp_modal_changeset.cfm">
					<cfset commitTracePoint(tracePoint)>
				</cfif>
				--->
			</cfif>
		</cfif>
		<!--- Loop through the HTML Head Que--->
		<cfset HTMLQueue=variables.event.getValue(property='HTML#arguments.queueType#Queue',defaultValue=[]) />

		<cfif arrayLen(HTMLQueue)>
			<cfloop from="1" to="#arrayLen(HTMLQueue)#" index="item">
				<cfset headerFound=false/>
				<cfset i=HTMLQueue[item]>

				<cfif refind('[<>]',i)>
						<cfset itemStr=i>
				<cfelse>
					<cfset itemStr=""/>
					<!--- look in default htmlHead directory --->
					<cfif not refind('[\\/]',i)>

						<cfset pluginBasePath="/#displayPoolID#/includes/themes/#theme#/display_objects/htmlhead/">
						<cfif fileExists(expandPath("/#application.configBean.getWebRootMap()##pluginbasePath##i#"))>
							<cfset pluginPath= application.configBean.getContext() & pluginBasePath >
							<cfset tracePoint=initTracePoint("/#application.configBean.getWebRootMap()##pluginbasePath##i#")>
							<cfsavecontent variable="itemStr"><cfinclude template="/#application.configBean.getWebRootMap()##pluginbasePath##i#"></cfsavecontent>
							<cfset commitTracePoint(tracePoint)>
							<cfset headerFound=true />
						</cfif>

						<cfif not headerFound>
							<cfset pluginBasePath="/#displayPoolID#/includes/display_objects/htmlhead/">
							<cfif fileExists(expandPath("/#application.configBean.getWebRootMap()##pluginbasePath##i#"))>
								<cfset pluginPath= application.configBean.getContext() & pluginBasePath >
								<cfset tracePoint=initTracePoint("/#application.configBean.getWebRootMap()##pluginbasePath##i#")>
								<cfsavecontent variable="itemStr"><cfinclude template="/#application.configBean.getWebRootMap()##pluginbasePath##i#"></cfsavecontent>
								<cfset commitTracePoint(tracePoint)>
								<cfset headerFound=true />
							</cfif>
						</cfif>

					<cfelse>
						<!--- If not found, look in look in your theme --->
						<cfset pluginBasePath="/#displayPoolID#/includes/themes/#theme#/display_objects/">
						<cfif fileExists(expandPath("/#application.configBean.getWebRootMap()##pluginbasePath##i#"))>
							<cfset pluginPath= application.configBean.getContext() & pluginBasePath >
							<cfset tracePoint=initTracePoint("/#application.configBean.getWebRootMap()##pluginbasePath##i#")>
							<cfsavecontent variable="itemStr"><cfinclude template="/#application.configBean.getWebRootMap()##pluginBasePath##i#"></cfsavecontent>
							<cfset commitTracePoint(tracePoint)>
							<cfset headerFound=true />
						</cfif>

						<!--- if not found, try the path that was passed --->
						<cfif not headerFound and fileExists(expandPath(i))>
							<cfsavecontent variable="itemStr"><cfinclude template="#i#" /></cfsavecontent>
							<cfset headerFound = true />
						</cfif>

						<!--- If not found, look in display_objects directory --->
						<cfif not headerFound>
							<cfset pluginBasePath="/#displayPoolID#/includes/display_objects/">
							<cfif fileExists(expandPath("/#application.configBean.getWebRootMap()##pluginbasePath##i#"))>
								<cfset pluginPath= application.configBean.getContext() & pluginBasePath >
								<cfset tracePoint=initTracePoint("/#application.configBean.getWebRootMap()##pluginbasePath##i#")>
								<cfsavecontent variable="itemStr"><cfinclude template="/#application.configBean.getWebRootMap()##pluginBasePath##i#"></cfsavecontent>
								<cfset commitTracePoint(tracePoint)>
								<cfset headerFound=true />
							</cfif>
						</cfif>

						<!--- If not found, look in top of theme directory
						<cfif not headerFound>
							<cfset pluginBasePath="/#displayPoolID#/includes/themes/#theme#/">
							<cfif fileExists(expandPath("/#application.configBean.getWebRootMap()##pluginbasePath#") & i)>
								<cfset pluginPath= application.configBean.getContext() & pluginBasePath >
								<cfinclude  template="/#application.configBean.getWebRootMap()##pluginBasePath##i#">
								<cfset headerFound=true />
							</cfif>
						</cfif>
						 --->

						<!--- If not found, look in includes directory --->
						<cfif not headerFound>
							<cfset pluginBasePath="/#displayPoolID#/includes/">
							<cfif fileExists(expandPath("/#application.configBean.getWebRootMap()##pluginbasePath##i#"))>
								<cfset pluginPath= application.configBean.getContext() & pluginBasePath >
								<cfset tracePoint=initTracePoint("/#application.configBean.getWebRootMap()##pluginbasePath##i#")>
								<cfsavecontent variable="itemStr"><cfinclude  template="/#application.configBean.getWebRootMap()##pluginBasePath##i#"></cfsavecontent>
								<cfset commitTracePoint(tracePoint)>
								<cfset headerFound=true />
							</cfif>
						</cfif>

						<!--- If not found, look in local plugins directory --->
						<cfif not headerFound>
							<cfset pluginBasePath="/#displayPoolID#/includes/plugins/">
							<cfif fileExists(expandPath("/#application.configBean.getWebRootMap()##pluginbasePath##i#"))>
								<cfset pluginID=listLast(listFirst(i,"/"),"_")>
								<cfset variables.event.setValue('pluginConfig',application.pluginManager.getConfig(pluginID))>
								<cfset pluginConfig=variables.event.getValue('pluginConfig')>
								<cfset pluginPath= application.configBean.getContext() & pluginBasePath & pluginConfig.getDirectory() & "/" >
								<cfset variables.event.setValue('pluginPath',pluginPath)>
								<cfset tracePoint=initTracePoint("/#application.configBean.getWebRootMap()##pluginbasePath##i#")>
								<cfsavecontent variable="itemStr"><cfinclude  template="/#application.configBean.getWebRootMap()##pluginBasePath##i#"></cfsavecontent>
								<cfset commitTracePoint(tracePoint)>
								<cfset headerFound=true />
								<cfset variables.event.removeValue("pluginPath")>
								<cfset variables.event.removeValue("pluginConfig")>
							</cfif>
						</cfif>

						<!--- If not found, look in global plugins directory --->
						<cfif not headerFound>
							<cfset pluginBasePath="/plugins/">
							<cfif fileExists(expandPath("#pluginbasePath##i#"))>
								<cfset pluginID=listLast(listFirst(i,"/"),"_")>
								<cfset variables.event.setValue('pluginConfig',application.pluginManager.getConfig(pluginID))>
								<cfset pluginConfig=variables.event.getValue('pluginConfig')>
								<cfset pluginPath= application.configBean.getContext() & pluginBasePath & pluginConfig.getDirectory() & "/" >
								<cfset variables.event.setValue('pluginPath',pluginPath)>
								<cfset tracePoint=initTracePoint("#pluginbasePath##i#")>
								<cfsavecontent variable="itemStr"><cfinclude  template="#pluginBasePath##i#"></cfsavecontent>
								<cfset commitTracePoint(tracePoint)>
								<cfset headerFound=true />
								<cfset variables.event.removeValue("pluginPath")>
								<cfset variables.event.removeValue("pluginConfig")>
							</cfif>
						</cfif>
					</cfif>
					<cfif not headerFound>
						<cfoutput><!-- missing header include- #i# --></cfoutput>
					</cfif>
				</cfif>
				<cfset headerStr=headerStr & chr(13) & chr(10) & trim(itemStr)>
			</cfloop>
		</cfif>
	</cfif>
	<cfreturn headerStr>
</cffunction>

<cffunction name="renderHTMLHeadQueue" output="false" hint="deprecated">
	<cfreturn renderHTMLQueue("Head")>
</cffunction>

<cffunction name="redirect" output="false" returntype="void">
	<cfargument name="location">
	<cfargument name="addToken" required="true" default="false">
	<cfargument name="statusCode" required="true" default="301">
	<cflocation url="#arguments.location#" addtoken="#arguments.addToken#" statusCode="#arguments.statusCode#">
</cffunction>

<cffunction name="getPagesQuery" returntype="query" output="false">
	<cfargument name="str">
	<cfreturn variables.contentRendererUtility.getPagesQuery(argumentCollection=arguments)>
</cffunction>

<cffunction name="dspMultiPageContent" returntype="any" output="false">
	<cfargument name="body">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.dspMultiPageContent(argumentCollection=arguments)>
</cffunction>

<cffunction name="generateEditableHook" output="false">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.generateEditableHook(argumentCollection=arguments)>
</cffunction>

<cffunction name="generateEditableObjectControl" access="public" output="no" returntype="string">
	<cfargument name="editLink" required="yes" default="">
	<cfargument name="isConfigurator" default="false">
	<cfset arguments.renderer=this>
	<cfset arguments.showEditableObjects=this.showEditableObjects>
	<cfset arguments.enableFrontEndTools=this.enableFrontEndTools>
	<cfreturn variables.contentRendererUtility.generateEditableObjectControl(argumentCollection=arguments)>
</cffunction>

<cffunction name="renderEditableObjectHeader" access="public" output="no" returntype="string">
	<cfargument name="class" required="yes" default="">
	<cfargument name="customWrapperString" required="yes" default="">
	<cfset arguments.renderer=this>
		<cfset arguments.showEditableObjects=this.showEditableObjects>
	<cfset arguments.enableFrontEndTools=this.enableFrontEndTools>
	<cfreturn variables.contentRendererUtility.renderEditableObjectHeader(argumentCollection=arguments)>
</cffunction>

<cffunction name="renderEditableObjectfooter" access="public" output="no" returntype="string">
	<cfargument name="control" required="yes" default="">
	<cfset arguments.renderer=this>
	<cfset arguments.showEditableObjects=this.showEditableObjects>
	<cfset arguments.enableFrontEndTools=this.enableFrontEndTools>
	<cfreturn variables.contentRendererUtility.renderEditableObjectfooter(argumentCollection=arguments)>
</cffunction>

<cffunction name="generateListImageSyles" output="false" hint="for backward compatibility">
	<cfreturn generateListImageStyles(argumentCollection=arguments)>
</cffunction>

<cffunction name="generateListImageStyles" output="false">
	<cfargument name="size" default="small">
	<cfargument name="height" default="auto">
	<cfargument name="width" default="auto">
	<cfargument name="padding" default="#this.contentListImagePadding#">
	<cfargument name="setHeight" default="true">
	<cfargument name="setWidth" default="true">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.generateListImageStyles(argumentCollection=arguments)>
</cffunction>

<cffunction name="getURLForFile" access="public" output="false" returntype="string">
	<cfargument name="fileid" required="false" default="" />
	<cfargument name="method" required="false" default="inline" />
	<cfscript>
		var rsFileData = getBean('fileManager').read(arguments.fileid);
		if ( not rsFileData.recordcount ) {
			return '';
		} else {
			return '#application.configBean.getContext()#/index.cfm/_api/render/file/?method=#arguments.method#&amp;fileID=#arguments.fileid#';
		}
	</cfscript>
</cffunction>

<cffunction name="getURLForImage" access="public" output="false" returntype="string">
	<cfargument name="fileid" required="false" default="" />
	<cfargument name="size" required="false" default="large" />
	<cfargument name="direct" required="false" default="#this.directImages#" />
	<cfargument name="complete" type="boolean" required="false" default="false" />
	<cfargument name="height" required="false" default="AUTO" />
	<cfargument name="width" required="false" default="AUTO" />
	<cfargument name="siteID" required="false" default="#variables.$.event('siteID')#" />
	<cfargument name="secure" default="false">
	<cfargument name="useProtocol" default="true">
	<cfscript>
		var imageURL = getBean('fileManager').createHREFForImage(argumentCollection=arguments);
		if ( IsSimpleValue(imageURL) ) {
			return imageURL;
		} else {
			return '';
		};
	</cfscript>
</cffunction>

<cffunction name="iconClassByContentType" output="false">
	<cfargument name="type">
	<cfargument name="subtype" default="Default">
	<cfargument name="siteid" default="">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.iconClassByContentType(argumentCollection=arguments)>
</cffunction>

<cffunction name="renderEditableAttribute" output="false">
	<cfargument name="attribute">
	<cfargument name="type" default="text">
	<cfargument name="required" default="false">
	<cfargument name="validation" default="">
	<cfargument name="message" default="">
	<cfargument name="label">
	<cfargument name="value">
	<cfargument name="enableMuraTag" default="true">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.renderEditableAttribute(argumentCollection=arguments)>
</cffunction>

<cffunction name="renderClassOption" output="false">
	<cfargument name="object">
	<cfargument name="objectid" default="">
	<cfargument name="objectname" default="">
	<cfargument name="objectlabel">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.renderObjectClassOption(argumentCollection=arguments)>
</cffunction>

<cffunction name="renderIntervalDesc" output="false">
	<cfargument name="content">
	<cfset arguments.renderer=this>
	<cfreturn variables.contentRendererUtility.renderIntervalDesc(argumentCollection=arguments)>
</cffunction>

<cfscript>
	public any function dspComponent(string componentid, boolean allowEditable=this.showEditableObjects) {
		return variables.$.dspObject(object='component',objectid=arguments.componentid,allowEditable=arguments.allowEditable);
	}

	public any function dspForm(string formid, boolean allowEditable=this.showEditableObjects) {
		return variables.$.dspObject(object='form',objectid=arguments.formid,allowEditable=arguments.allowEditable);
	}

	public any function dspFeed(string feedid,params={}, boolean allowEditable=this.showEditableObjects) {
		return variables.$.dspObject(object='feed',objectid=arguments.feedid,params=arguments.params,allowEditable=arguments.allowEditable);
	}

	public any function getCalendarUtility() {
		return variables.$.getBean('contentCalendarUtilityBean').setMuraScope(variables.$);
	}

	public any function noIndex(){
		addToHTMLHeadQueue('<meta name="robots" content="noindex, follow" />');
	}

	public string function dspReCAPTCHAContainer(string reCAPTCHATheme='light', string reCAPTCHAType='image',string reCAPTCHAClass='g-recaptcha-container') {
		return dspReCAPTCHA(argumentCollection=arguments);
	}

	public string function dspReCAPTCHA(string reCAPTCHATheme='light', string reCAPTCHAType='image',reCAPTCHAClass='g-recaptcha') {
		var str = '';

		if ( Len($.siteConfig('reCAPTCHASiteKey')) && Len($.siteConfig('reCAPTCHASecret')) ) {

			// scrub args
			arguments.reCAPTCHATheme = ListFindNoCase('light,dark', arguments.reCAPTCHATheme)
				? LCase(arguments.reCAPTCHATheme)
				: 'light';

			arguments.reCAPTCHAType = ListFindNoCase('audio,image', arguments.reCAPTCHAType)
				? LCase(arguments.reCAPTCHAType)
				: 'image';

			savecontent variable='str' {
				WriteOutput('<div id="m#createUUID()#" class="#arguments.reCAPTCHAClass#" data-sitekey="#$.siteConfig('reCAPTCHASiteKey')#" data-theme="#arguments.reCAPTCHATheme#" data-type="#arguments.reCAPTCHAType#"></div><noscript><div class="alert alert-info"><p>#$.rbKey('recaptcha.noscript')#</p><style>button[type="submit"],input[type="submit"]{display:none !important;}</style></noscript>');
			};

			// load Google ReCAPTCHA script
			//addToHTMLHeadQueue('<script type="text/javascript" src="https://www.google.com/recaptcha/api.js?hl=#$.siteConfig('reCAPTCHALanguage')#"></script>');
		} else {
			str = '<div class="alert alert-warning"><h4><i class="fa fa-warning"></i> #$.rbKey('recaptcha.warning')#</h4><p>#$.rbKey('recaptcha.nokeys')#</p></div>';
		}

		return str;
	}

	public string function setCamelback(required string theString) {
		return variables.$.getBean('utility').setCamelback(arguments.theString);
	}

	public string function setProperCase(required string theString) {
		return variables.$.getBean('utility').setProperCase(arguments.theString);
	}

	public string function renderFilesize(size) {
		return variables.$.getBean('utility').renderFilesize(arguments.size);
	}

 	public function getEvent(){
 		return variables.event;
 	}

 	public function getMuraScope(){
 		return variables.$;
 	}

 	public function hasEvent(){
 		return isDefined('variables.event');
 	}

 	public function hasMuraScope(){
 		return isDefined('variables.$');
 	}

 	public function useLayoutManager(){
 		return this.layoutmanager;
 	}

 	public function registerDisplayObject(
 			object,name='',
 			displaymethod='',
 			displayobjectFile='',
 			configuratorJS='',
 			configuratorInit='',
 			siteid='#variables.$.event('siteid')#'){
 		getBean('settingsManager').getSite(arguments.siteid).registerDisplayObject(argumentCollection=arguments);
 		return this;
	}

	public function hasDisplayObject(object,siteid='#variables.$.event('siteid')#'){
		return getBean('settingsManager').getSite(arguments.siteid).hasDisplayObject(argumentCollection=arguments);
	}

	public function getDisplayObject(object,siteid='#variables.$.event('siteid')#'){
		return getBean('settingsManager').getSite(arguments.siteid).hasDisplayObject(argumentCollection=arguments);
	}

	public function get(){
		if(isDefined('this.#arguments.property#')){
			return this[arguments.property];
		} else if (isDefined('variables.#argumentsproperty#')){
			return this[arguments.property];
		}

		return '';
	}

</cfscript>

</cfcomponent>
