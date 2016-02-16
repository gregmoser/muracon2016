<!--- 
	This file is part of Mura CMS.

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
---><cfsilent>
<cfparam name="request.action" default="core:cplugin.plugin">
<cfparam name="rc.originalfuseaction" default="#listLast(listLast(request.action,":"),".")#">
<cfparam name="rc.originalcircuit"  default="#listFirst(listLast(request.action,":"),".")#">
<cfparam name="rc.jsLib" default="jquery">
<cfparam name="rc.jsLibLoaded" default="false">
<cfparam name="rc.activetab" default="0">
<cfparam name="rc.activepanel" default="0">
<cfparam name="rc.siteid" default="#session.siteID#">
<cfparam name="rc.frontEndProxyLoc" default="">
<cfparam name="session.frontEndProxyLoc" default="#rc.frontEndProxyLoc#">
<cfparam name="rc.sourceFrame" default="modal">

<cfif len(rc.frontEndProxyLoc)>
	<cfset session.frontEndProxyLoc=rc.frontEndProxyLoc>
</cfif>
</cfsilent><cfoutput><cfprocessingdirective suppressWhitespace="true"><!DOCTYPE html>
<cfif cgi.http_user_agent contains 'msie'>
	<!--[if lt IE 7 ]><html class="mura ie ie6" lang="#esapiEncode('html_attr',session.locale)#"><![endif]-->
	<!--[if IE 7 ]><html class="mura ie ie7" lang="#esapiEncode('html_attr',session.locale)#"><![endif]-->
	<!--[if IE 8 ]><html class="mura ie ie8" lang="#esapiEncode('html_attr',session.locale)#"><![endif]-->
	<!--[if (gte IE 9)|!(IE)]><!--><html lang="#esapiEncode('html_attr',session.locale)#" class="mura ie"><!--<![endif]-->
<cfelse>
	<html lang="#esapiEncode('html_attr',session.locale)#" class="mura">
</cfif>
	<head>
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta charset="utf-8">
		<title>#esapiEncode('html', application.configBean.getTitle())#</title>
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="author" content="Blue River Interactive Group">
		<meta name="robots" content="noindex, nofollow, noarchive">
		<meta http-equiv="cache control" content="no-cache, no-store, must-revalidate">

		<cfif Len(application.configBean.getWindowDocumentDomain())>
			<script type="text/javascript">
				window.document.domain = '#application.configBean.getWindowDocumentDomain()#';
			</script>
		</cfif>

		<cfif cgi.http_user_agent contains 'msie'>
			<!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
			<!--[if lt IE 9]>
			   <script src="#application.configBean.getContext()#/admin/assets/js/html5.js"></script>
			<![endif]-->
		</cfif>

		<!--- <link href="#application.configBean.getContext()#/admin/assets/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="#application.configBean.getContext()#/admin/assets/bootstrap/css/bootstrap-responsive.min.css" rel="stylesheet"> --->

		<!-- Le fav and touch icons -->
		<link rel="shortcut icon" href="#application.configBean.getContext()#/admin/assets/ico/favicon.ico">
		<link rel="apple-touch-icon-precomposed" sizes="144x144" href="#application.configBean.getContext()#/admin/assets/ico/apple-touch-icon-144-precomposed.png">
		<link rel="apple-touch-icon-precomposed" sizes="114x114" href="#application.configBean.getContext()#/admin/assets/ico/apple-touch-icon-114-precomposed.png">
		<link rel="apple-touch-icon-precomposed" sizes="72x72" href="#application.configBean.getContext()#/admin/assets/ico/apple-touch-icon-72-precomposed.png">
		<link rel="apple-touch-icon-precomposed" href="#application.configBean.getContext()#/admin/assets/ico/apple-touch-icon-57-precomposed.png">

		 <!-- Spinner JS -->
		<script src="#application.configBean.getContext()#/admin/assets/js/spin.min.js" type="text/javascript"></script>

		 <!-- jQuery -->
		<script src="#application.configBean.getContext()#/admin/assets/js/jquery/jquery.js?coreversion=#application.coreversion#" type="text/javascript"></script>
		<script src="#application.configBean.getContext()#/admin/assets/js/jquery/jquery.spin.js" type="text/javascript"></script>
		<script src="#application.configBean.getContext()#/admin/assets/js/jquery/jquery.collapsibleCheckboxTree.js?coreversion=#application.coreversion#" type="text/javascript"></script>
		<script src="#application.configBean.getContext()#/admin/assets/js/jquery/jquery-ui.js?coreversion=#application.coreversion#" type="text/javascript"></script>
		<script src="#application.configBean.getContext()#/admin/assets/js/jquery/jquery-ui-i18n.min.js?coreversion=#application.coreversion#" type="text/javascript"></script>

		<!-- Mura Admin JS -->
		<script src="#application.configBean.getContext()#/admin/assets/js/admin.min.js" type="text/javascript"></script>

		<!-- CK Editor/Finder -->
		<script type="text/javascript" src="#application.configBean.getContext()#/requirements/ckeditor/ckeditor.js"></script>
		<script type="text/javascript" src="#application.configBean.getContext()#/requirements/ckeditor/adapters/jquery.js"></script>
		<cfif not rc.$.getContentRenderer().useLayoutManager()  and request.action neq 'core:carch.frontendconfigurator'>
			<script type="text/javascript" src="#application.configBean.getContext()#/requirements/ckfinder/ckfinder.js"></script>
		</cfif>
		<!-- Color Picker -->
		<script type="text/javascript" src="#application.configBean.getContext()#/requirements/colorpicker/js/bootstrap-colorpicker.js?coreversion=#application.coreversion#"></script>
		<link href="#application.configBean.getContext()#/requirements/colorpicker/css/colorpicker.css?coreversion=#application.coreversion#" rel="stylesheet" type="text/css" />

		<!-- JSON -->
		<script src="#application.configBean.getContext()#/admin/assets/js/json2.js" type="text/javascript"></script>

		<!-- Utilities to support iframe communication -->
		<script src="#application.configBean.getContext()#/admin/assets/js/jquery/jquery-resize.min.js?coreversion=#application.coreversion#" type="text/javascript"></script>
		<script src="#application.configBean.getContext()#/admin/assets/js/porthole/porthole.min.js?coreversion=#application.coreversion#" type="text/javascript"></script>
		<script src="#application.configBean.getContext()#/admin/assets/js/chart.min.js?coreversion=#application.coreversion#" type="text/javascript"></script>

		<script type="text/javascript">
		var htmlEditorType='#application.configBean.getValue("htmlEditorType")#';
		var context='#application.configBean.getContext()#';
		var themepath='#application.settingsManager.getSite(rc.siteID).getThemeAssetPath()#';
		var rb='#lcase(esapiEncode('javascript',session.rb))#';
		var siteid='#esapiEncode('javascript',session.siteid)#';
		var activepanel=#esapiEncode('javascript',rc.activepanel)#;
		var activetab=#esapiEncode('javascript',rc.activetab)#;
		var webroot='#esapiEncode('javascript',left($.globalConfig("webroot"),len($.globalConfig("webroot"))-len($.globalConfig("context"))))#';
		var fileDelim='#esapiEncode('javascript',$.globalConfig("fileDelim"))#';
		</script>
		
		<link href="#application.configBean.getContext()#/admin/assets/css/admin.min.css" rel="stylesheet" type="text/css" />
		#session.dateKey#
		<script type="text/javascript">
			var frontEndProxy;
			jQuery(document).ready(function(){

				if (top.location != self.location) {

					function getHeight(){
						if(document.all){
							return Math.max(document.body.scrollHeight, document.body.offsetHeight);
						} else {
							return Math.max(document.body.scrollHeight, document.body.offsetHeight, document.documentElement.scrollHeight, document.documentElement.offsetHeight);
						}
					}

					frontEndProxy = new Porthole.WindowProxy("#esapiEncode('javascript',session.frontEndProxyLoc)##application.configBean.getContext()#/admin/assets/js/porthole/proxy.html");
					frontEndProxy.post({cmd:
											'setHeight',
											height:getHeight(),
											'targetFrame': '#esapiEncode("javascript",rc.sourceFrame)#'
										});
					jQuery(this).resize(function(e){
						frontEndProxy.post({cmd:
											'setHeight',
											height:getHeight(),
											'targetFrame': '#esapiEncode("javascript",rc.sourceFrame)#'
										});
					});					
				};
			});
		</script>
		#rc.ajax#
		
		<cfif cgi.http_user_agent contains 'msie'>
			<!--[if lte IE 8]>
			<link href="#application.configBean.getContext()#/admin/assets/css/ie.min.css?coreversion=#application.coreversion#" rel="stylesheet" type="text/css" />
			<![endif]-->
			
			<!--[if lte IE 7]>
			<script src="#application.configBean.getContext()#/admin/assets/js/upgrade-notification.min.js" type="text/javascript"></script>
			<![endif]-->
		</cfif>
	</head>
	<body id="#esapiEncode('html_attr',rc.originalcircuit)#" class="compact">
		<cfif rc.sourceFrame eq 'modal'>
			<a id="frontEndToolsModalClose" href="javascript:frontEndProxy.post({cmd:'close'});"><i class="icon-remove-sign"></i></a>
			<cfinclude template="includes/dialog.cfm">
		</cfif>
		
		<div class="main row-fluid"></cfprocessingdirective>#body#<cfprocessingdirective suppressWhitespace="true"></div>
		
		<script src="#application.configBean.getContext()#/admin/assets/js/jquery/jquery-tagselector.js?coreversion=#application.coreversion#"></script>
		<script src="#application.configBean.getContext()#/admin/assets/bootstrap/js/bootstrap.min.js"></script>
	</body>
</html></cfprocessingdirective>
</cfoutput>