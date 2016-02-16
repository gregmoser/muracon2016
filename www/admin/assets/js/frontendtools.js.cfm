<cfif not isdefined('$')>
<cfcontent reset="yes" type="application/javascript">
<cfscript>
	if(server.coldfusion.productname != 'ColdFusion Server'){
		backportdir='';
		include "/mura/backport/backport.cfm";
	} else {
		backportdir='/mura/backport/';
		include "#backportdir#backport.cfm";
	}
</cfscript>
<cfif isDefined("url.siteID")>
<cfset isIeSix=FindNoCase('MSIE 6','#CGI.HTTP_USER_AGENT#') GREATER THAN 0>
<cfset $=application.serviceFactory.getBean("MuraScope").init(url.siteID)>
<cfparam name="session.siteid" default="#url.siteid#">
<cfif not structKeyExists(session,"rb")>
	<cfset application.rbFactory.resetSessionLocale()>
</cfif>
<cfcontent reset="true"><cfparam name="Cookie.fetDisplay" default="">
</cfif>
<cfoutput>(function(window){

	window.mura.layoutmanager=#$.getContentRenderer().useLayoutManager()#;

	var utility=(typeof jQuery != 'undefined')?jQuery:mura;

	var adminProxy;
	var adminDomain=<cfif len($.globalConfig('admindomain'))>"#$.globalConfig('admindomain')#"<cfelse>location.hostname</cfif>;
	var adminProtocal=<cfif application.configBean.getAdminSSL() or application.utility.isHTTPS()>"https://";<cfelse>"http://"</cfif>;
	var adminProxyLoc=adminProtocal + adminDomain + "#$.globalConfig('serverPort')##$.globalConfig('context')#/admin/assets/js/porthole/proxy.html";
	var adminLoc=adminProtocal + adminDomain + "#$.globalConfig('serverPort')##$.globalConfig('context')#/admin/";
	var frontEndProxyLoc= location.protocol + "//" + location.hostname + "#$.globalConfig('serverPort')#";

	var onAdminMessage=function(messageEvent){

		if (messageEvent.origin == 'http://' + adminDomain + "#$.globalConfig('serverPort')#"
			|| messageEvent.origin == 'https://' + adminDomain + "#$.globalConfig('serverPort')#") {
			
			var parameters=messageEvent.data;
			
			if (parameters["cmd"] == "setWidth") {			
				if(parameters["width"]=='configurator'){
					frontEndModalWidth=frontEndModalWidthConfigurator;
				} else if(!isNaN(parameters["width"])){
					frontEndModalWidth=parameters["width"];
				} else {
					frontEndModalWidth=frontEndModalWidthStandard;
				}
				
				if(parameters["targetFrame"]=='sidebar'){
					resizeFrontEndToolsSidebar(decodeURIComponent(parameters["height"]));
				} else {
					resizeFrontEndToolsModal(decodeURIComponent(parameters["height"]));
				}
			} else if(parameters["cmd"] == "close"){
				closeFrontEndToolsModal();
			} else if(parameters["cmd"] == "setLocation"){
				window.location=decodeURIComponent(parameters["location"]);
			} else if(parameters["cmd"] == "setHeight"){
				if(parameters["targetFrame"]=='sidebar'){
					resizeFrontEndToolsSidebar(decodeURIComponent(parameters["height"]));
				} else {
					resizeFrontEndToolsModal(decodeURIComponent(parameters["height"]));
				}		
			} else if(parameters["cmd"] == "scrollToTop"){
				window.scrollTo(0, 0);	
			} else if(parameters["cmd"] == "autoScroll"){
				autoScroll(parameters["y"]);
			} else if(parameters["cmd"] == "requestObjectParams"){
				var data=mura('[data-instanceid="' + parameters["instanceid"] + '"]').data();
				
				if(parameters["targetFrame"]=='sidebar' && document.getElementById('mura-sidebar-editor').style.display=='none'){
					mura('##mura-sidebar-configurator').show();
				}
				
				if(parameters["targetFrame"]=='sidebar'){
					sidebarProxy.post({cmd:'setObjectParams',params:data});
				} else {
					modalProxy.post({cmd:'setObjectParams',params:data});
				}
			} else if(parameters["cmd"] == "deleteObject"){
				mura('[data-instanceid="' + parameters["instanceid"] + '"]').remove();
				closeFrontEndToolsModal();
				muraInlineEditor.sidebarAction('showobjects');
				muraInlineEditor.isDirty=true;
			} else if(parameters["cmd"] == "showobjects"){
				muraInlineEditor.sidebarAction('showobjects');
			} else if (parameters["cmd"]=="setObjectParams"){
				var item=mura('[data-instanceid="' + parameters.instanceid + '"]');
				if(typeof parameters.params == 'object'){

					delete parameters.params.params;

					if(item.data('class')){
						var classes=item.data('class');

						if(typeof classes != 'array'){
							classes=classes.split(' ');
						}

						for(var c in classes){
							if(item.hasClass(classes[c])){
								item.removeClass(classes[c]);
							}
						}
					}

					for(var p in parameters.params){
						item.data(p,parameters.params[p]);
					}

					muraInlineEditor.isDirty=true;
				}


				mura.resetAsyncObject(item.node);
				item.addClass('active');
				mura.processAsyncObject(item.node).then(function(){
					closeFrontEndToolsModal();
					if(parameters.reinit){
						openFrontEndToolsModal(item.node);
					}	
				});
				
			} else if (parameters["cmd"]=='reloadObjectAndClose') {
				if(parameters.instanceid){
					var item=mura('[data-instanceid="' + parameters.instanceid + '"]');
				} else {
					var item=mura('[data-objectid="' + parameters.objectid + '"]');
				}
				
				mura.resetAsyncObject(item.node);
				item.addClass('active');
				mura.processAsyncObject(item.node);
				closeFrontEndToolsModal();
				muraInlineEditor.isDirty=true;
			} else if(parameters["cmd"] == "setImageSrc"){
				utility('img[data-instanceid="' + parameters.instanceid + '"]')
					.attr('src',parameters.src)
					.each(muraInlineEditor.checkForImageCroppers);
			} else if (parameters["cmd"] == "openModal"){
				initFrontendUI({href:adminLoc + parameters["src"]});
			}
		}			
	}

	initModalProxy=function(){
			modalProxy = new Porthole.WindowProxy(adminProxyLoc, 'frontEndToolsModaliframe');
			modalProxy.addEventListener(onAdminMessage);
	}

	initSidebarProxy=function(){
			sidebarProxy = new Porthole.WindowProxy(adminProxyLoc, 'frontEndToolsSidebariframe');
			sidebarProxy.addEventListener(onAdminMessage);
	}

	var frontEndModalWidthStandard=990;
	var frontEndModalWidthConfigurator=600;
	var frontEndModalHeight=0;
	var frontEndModalWidth=0;
	var frontEndModalIE8=document.all && document.querySelector && !document.addEventListener;

	var autoScroll=function(y){

		var st = utility(window).scrollTop();
	    var o = utility('##frontEndToolsModalBody').offset().top;
	    var t = utility(window).scrollTop() + 80;
	    var b = utility(window).height() - 50 + utility(window).scrollTop();
	    var adjY = y + o;

		if (adjY > b) {
	        //Down
	        scrollTop(adjY, st + 35);
		} else if (adjY < t) {
	        //Up
	        scrollTop(adjY, st - 35);
	    }
	}

	var scrollTop=function(y, top){
		utility('html, body').each(function(el){
			el.scrolltop=top;
		});
	}

	var openFrontEndToolsModal=function(a){
		return initFrontendUI(a);
	};

	var initFrontendUI=function(a){
		var src=a.href;
		var editableObj=utility(a);
		var targetFrame='modal';

		if(!src){
			if(utility(a).hasClass("mura-object")){
			var editableObj=utility(a);
			} else {
				var editableObj=utility(a).closest(".mura-object,.mura-async-object");
			}
				/*
			This reloads the element in the dom to ensure that all the latest
			values are present
			*/

			editableObj=mura('[data-instanceid="' + editableObj.data('instanceid') + '"]');
			editableObj.hide().show();

			var legacyMap={
				feed:true,
				feed_slideshow:true,
				feed_no_summary:true,
				feed_slideshow_no_summary:true,
				related_content:true,
				related_section_content:true,
				plugin:true
			}
			
			if(!legacyMap[editableObj.data('object')]){
				targetFrame='sidebar'; 
				if(muraInlineEditor.commitEdit && mura.currentId){
					muraInlineEditor.commitEdit(mura('##' + mura.currentId));
				}
			} 
				
			var src= adminLoc + '?muraAction=cArch.frontEndConfigurator&compactDisplay=true&siteid=' + mura.siteid + '&instanceid=' +  editableObj.data('instanceid') + '&contenthistid=' + mura.contenthistid + '&contentid=' + mura.contentid + '&parentid=' + mura.parentid + '&object=' +  editableObj.data('object') + '&objectid=' +  editableObj.data('objectid') + '&layoutmanager=' +  mura.layoutmanager + '&objectname=' + editableObj.data('objectname') + '&contenttype=' + mura.type + '&contentsubtype=' + mura.subtype + '&sourceFrame=' + targetFrame;

		}

		if(targetFrame=='modal'){
			var isModal=editableObj.attr("data-configurator");

			//These are for the preview iframes
			var width=editableObj.attr("data-modal-width");
			var ispreview=editableObj.attr("data-modal-preview");

			frontEndModalHeight=0;
			frontEndModalWidth=0;
			
			if(!isNaN(width)){
				frontEndModalWidth = width;
			}

			closeFrontEndToolsModal();
			
			if(ispreview){
				if(src.indexOf("?") == -1) {
					src = src + '?muraadminpreview';
				} else {
					src = src + '&muraadminpreview';
				}

				frontEndModalHeight=600;
				frontEndModalWidth=1075;

				var $tools='<div id="mura-preview-device-selector">';
					$tools=$tools+'<p>Preview Mode</p>';
					$tools=$tools+'<a class="mura-device-standard active" title="Desktop" data-height="600" data-width="1075" data-mobileformat="false"><i class="icon-desktop"></i></a>';
					$tools=$tools+'<a class="mura-device-tablet" title="Tablet" data-height="600" data-width="768" data-mobileformat="false"><i class="icon-tablet"></i></a>';
					$tools=$tools+'<a class="mura-device-tablet-landscape" title="Tablet Landscape" data-height="480" data-width="1024" data-mobileformat="false"><i class="icon-tablet icon-rotate-270"></i></a>';
					$tools=$tools+'<a class="mura-device-phone" title="Phone" data-height="480" data-width="320" data-mobileformat="true"><i class="icon-mobile-phone"></i></a>';
					$tools=$tools+'<a class="mura-device-phone-landscape" title="Phone Landscape" data-height="250" data-width="520" data-mobileformat="true"><i class="icon-mobile-phone icon-rotate-270"></i></a>';
					$tools=$tools+'<a id="preview-close" title="Close" href="##" onclick="closeFrontEndToolsModal();"><i class="icon-remove-sign"></i></a>';
					$tools=$tools+'</div>';

			} else {
				if(!frontEndModalHeight){
					if (isModal == undefined) {
						frontEndModalWidth = frontEndModalWidthStandard;
					} else if (isModal == "true") {
						frontEndModalWidth=frontEndModalWidthConfigurator;
					} else {
						frontEndModalWidth = frontEndModalWidthStandard;
					}
				}

				src=src + "&frontEndProxyLoc=" + frontEndProxyLoc;
				var $tools='';
			}


			utility("##frontEndToolsModalTarget").html('<div id="frontEndToolsModalContainer">' +
			'<div id="frontEndToolsModalBody">' + $tools +
			'<iframe src="' + src + '" id="frontEndToolsModaliframe" scrolling="false" frameborder="0" style="overflow:hidden" name="frontEndToolsModaliframe"></iframe>' +
			'</div>' +
			'</div>');
			
			if(ispreview){
				utility('##mura-preview-device-selector a').on('click', function () {
					var data=utility(this).data();

					frontEndModalWidth=data.width;
				   	frontEndModalHeight=data.height;

				   	utility('##frontEndToolsModaliframe').attr('src',src + '&mobileFormat=' + data.mobileformat);
				    utility('##mura-preview-device-selector a').removeClass('active');
				    utility(this).addClass('active');

				    resizeFrontEndToolsModal(data.height);
				    return false;
				});

				utility("##frontEndToolsModalBody").css("top",(utility(document).scrollTop()+80) + "px")
				resizeFrontEndToolsModal(frontEndModalHeight);
			} else{
				frontEndModalHeight=0;
				utility("##frontEndToolsModalBody").css("top",(utility(document).scrollTop()+50) + "px")
				resizeFrontEndToolsModal(0);
			}
		} else {

			mura('.mura-object-selected').removeClass('mura-object-selected');

			editableObj.addClass('mura-object-selected');
			console.log(src)
			utility('##frontEndToolsSidebariframe').attr('src',src);
			muraInlineEditor.sidebarAction('showconfigurator');
		}
	}

	var resizeFrontEndToolsSidebar=function(frameHeight){
		var iframe=document.getElementById("frontEndToolsSidebariframe");
		if (iframe){
			iframe.style.height=frameHeight + "px";
		}

	}

	var resizeFrontEndToolsModal=function(frameHeight){

		if (document.getElementById("frontEndToolsModaliframe")) {

			var frame = document.getElementById("frontEndToolsModaliframe");
			var frameContainer = document.getElementById("frontEndToolsModalContainer");
			
			//if (frameDoc.body != null) {
				var windowHeight = Math.max(frameHeight, utility(window).height());
		
				/*
				if (frontEndModalWidth==frontEndModalWidthStandard 
					&& frameHeight < utility(window).height()
					) {
					frameHeight= Math.max(utility(window).height() * .80,frameHeight);
				}
				*/

				utility('##frontEndToolsModalContainer ##frontEndToolsModalBody,##frontEndToolsModalContainer ##frontEndToolsModaliframe').width(frontEndModalWidth);
				
				frame.style.height = frameHeight + "px";
				frameContainer.style.position = "absolute";
				document.overflow = "auto"
				
				if(windowHeight > frontEndModalHeight){	
					frontEndModalHeight=windowHeight;
					if(frontEndModalIE8){
						frameContainer.style.height=Math.max(frameHeight,utility(document).height()) + "px";
					} else {
						frameContainer.style.height=utility(document).height() + "px";
					}
					setTimeout(function(){
						utility("##frontEndToolsModalClose").fadeIn("fast")
					},1000);			
				}
				
				
			//}
			//setTimeout(resizeFrontEndToolsModal, 250);
		}
		
	}

	var closeFrontEndToolsModal=function(){
		utility('##frontEndToolsModalContainer').remove();
	}	

	var checkToolbarDisplay=function() {
	<cfif Cookie.fetDisplay eq "none">
		utility('HTML').removeClass('mura-edit-mode');
		utility(".editableObject").addClass('editableObjectHide');
	<cfelse>
		utility('HTML').addClass('mura-edit-mode');
	</cfif>
	}

	var toggleAdminToolbar=function(){
		var tools=utility("##frontEndTools");

		if(utility('HTML').hasClass('mura-edit-mode')){
			if(typeof tools.fadeOut == 'function'){
				utility("##frontEndTools").fadeOut();
			} else {
				utility("##frontEndTools").hide();
			}

			utility('HTML').removeClass('mura-edit-mode');
			utility(".editableObject").addClass('editableObjectHide');

			if(typeof muraInlineEditor != 'undefined' && muraInlineEditor.inited){
				utility(".mura-editable").addClass('inactive');
			}

		} else {
			if(typeof tools.fadeOut == 'function'){
				utility("##frontEndTools").fadeIn();
			} else {
				utility("##frontEndTools").show();
			}

			utility('HTML').addClass('mura-edit-mode');
			utility(".editableObject").removeClass('editableObjectHide');

			if(typeof muraInlineEditor != 'undefined' && muraInlineEditor.inited){
				utility(".mura-editable").removeClass('inactive');
			}
		}
		
	}

	var resizeEditableObject=function(target){
		
		var display="inline";	
		var width=0;
		var float;

		utility(target).find(".editableObjectContents").each(
			function(){
				utility(this).find(".frontEndToolsModal").each(
					function(){
						utility(this).click(function(event){
							event.preventDefault();
							openFrontEndToolsModal(this);
						}
					);
				});
					
				utility(this).children().each(
					function(el){			
						if (utility(this).css("display") == "block") {
							display = "block";
							float=utility(this).css("float");
							width=utility(this).outerWidth();
						}											
					}	
				);
					
				utility(this).css("display",display).parent().css("display",display);
					
				if(width){
					utility(this).width(width).parent().width(width);
					utility(this).css("float",float).parent().css("float",float);
				}

		});

		if(utility('HTML').hasClass('mura-edit-mode')){
			utility(target).removeClass('editableObjectHide');
		} else {
			utility(target).addClass('editableObjectHide');
		}
		
	}

	var initToolbar=function(){

		checkToolbarDisplay();

		utility(".frontEndToolsModal").each(
			function(el){
				
				utility(this).on('click',function(event){
					event.preventDefault();
					openFrontEndToolsModal(this);
				}
			);
		});

		utility(".editableObject").each(function(){
			resizeEditableObject(this);
		});
		
		initModalProxy();
		<cfif $.getContentRenderer().useLayoutManager()>
		initSidebarProxy();
		</cfif>
		
		if(frontEndModalIE8){
			utility("##adminQuickEdit").remove();
		}
	};

	initToolbar();
	</cfoutput>
	</cfif>
	<cfparam name="url.contenttype" default="">
	<cfif isDefined('url.siteID') and isDefined('url.contenthistid') and isDefined('url.showInlineEditor') and url.showInlineEditor>

	<cfset node=application.serviceFactory.getBean('contentManager').read(contentHistID=url.contentHistID,siteid=url.siteid)>

	<cfif url.contenttype eq 'Variation'>
		<cfset node.setIsNew(0)>
		<cfset node.setType('Variation')>
	</cfif>

	<cfif not node.getIsNew()>
	<cfoutput>
	var muraInlineEditor={
		inited: false,
		init: function(){

			<cfif $.siteConfig('hasLockableNodes')>
				<cfset stats=node.getStats()>
				<cfif stats.getLockType() eq 'node' and stats.getLockID() neq session.mura.userid>
					alert('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,"sitemanager.draftprompt.contentislockedbyanotheruser"))#');
					return false;
				</cfif>
			</cfif>
			if(muraInlineEditor.inited){
				return false;
			}

			CKEDITOR.disableAutoInline=true;
			muraInlineEditor.inited=true;
			utility('##adminSave').show();
			utility('##adminStatus').hide();		
			utility('.mura-editable').removeClass('inactive');
			window.mura.editing=true;

			utility('##mura-deactivate-editors').click(function(){
				muraInlineEditor.sidebarAction('showobjects');
			});
			
			<cfif node.getType() eq 'Variation'>
				mura.finalVariations=[]

				mura('.mxp-editable').each(function(){
					var item=mura(this);
					mura.finalVariations.push({
						original:item.html(),
						selector:item.selector()
					});

					item.addClass('active');

				});

				var displayVariations=function(){
					
					//console.log(mura.variations);

					if(mura.variations.length){
						mura(".mura-var-undo").show();
						//mura(".mura-var-save").show();
						mura(".mura-var-cancel").show();
					} else {
						mura(".mura-var-undo").hide();
						//mura(".mura-var-save").hide();
						mura(".mura-var-cancel").hide();
					}
					mura(".mura-var-undo").hide();
					mura("##mura-var-details").html("");	
				} 
				
				var undoVariations=function(){
					if(mura.variations.length){
						var last=mura.variations.length-1;
						mura(mura.variations[last].selector).html(mura.variations[last].original);
						mura.variations.pop();
					}
					displayVariations();
				}

				var reset=function(){
					while(mura.variations.length){
						undoVariations();
					}
					activeEdit=false;
					mura.variations=mura.origvariations;
					applyVariations();
					displayVariations();
				}

				var trimAttrs=function(e){
					if(!e.attr('class')){
						e.removeAttr('class');
					}
					if(!e.attr('style')){
						e.removeAttr('style');
					}
					if(!e.attr('id')){
						e.removeAttr('id');
					}

					e.removeAttr('contenteditable');
				}

				var compressVariations=function(){
					var vs=[];

					variations.reverse();

					for(var i=0;i<mura.variations.length;i++){
						var item=mura.variations[i], added=false;
						
						for(var v=0;v<vs.length;v++){
						
							if(vs[v].selector==item.selector){
							
								added=true;
								break;
							}
						}

						if(!added){
							vs.push(item);
						}
					}

					mura.variations=vs.slice();

					editingVariations=false;
					
				}

				var activeEditorIndex=0;
				var activeEditorId='mura-var-editor0';
				var variation;
				var style;

				var commitEdit=function(currentEl){

					if(mura.currentId && mura.currentId==currentEl.attr('id')){
						
						currentEl.removeClass('mura-var-current');

						if(!currentEl.attr('class')){
							currentEl.removeAttr('class');
						}
						
						var instance=CKEDITOR.instances[currentEl.attr('id')];
						
						if(instance){
							instance.updateElement();
							variation.adjusted=instance.getData();
							instance.destroy();
							CKEDITOR.remove(instance);
						} else {
							variation.adjusted=currentEl.html();
						}

						currentEl.attr('contenteditable','false');

						mura.processMarkup(currentEl)

						mura.currentId='';

						currentEl.find('.mura-region-local .mura-object').each(function(){
							mura.initDraggableObject(this);
						});

						currentEl.find('h1, h2, h3, h4, p, div, img, table, form').each(function(){
							mura.initLooseDropTarget(this);
						});

						
						if(style){
							currentEl.attr('style',style);
						} else {
							currentEl.removeAttr('style');
						}

						if(variation.adjusted){
							
							if(variation.original != variation.adjusted){
								mura.variations.push(variation);
								displayVariations();
							}
						}
					}
				}

				muraInlineEditor.commitEdit=commitEdit;

				var editAction=function(){
				
					var currentEl=mura('.mura-var-target');
			
					if(!currentEl.length){
						return;
					}


					mura('.mura-var-target').each(function(){
						mura(this).removeClass('mura-var-target');
						trimAttrs(mura(this));
					});

				
					var style=currentEl.attr('style');
					var hasTempId=true;

					if(mura.currentId && mura.currentId==currentEl.attr('id')){
						return;
					}

					if(mura.currentId!=''){
						commitEdit(mura('##' + mura.currentId));
					}

					mura.currentId='';

					if(currentEl.attr('id')){
						mura.currentId=currentEl.attr('id');
						hasTempId=false;
					}

					if(activeEditorId){
						mura('##' + activeEditorId).attr('contenteditable',false);
					}

					if(hasTempId){
						activeEditorIndex++;
						mura.currentId='mura-var-editor' + activeEditorIndex;
						currentEl.attr('id',mura.currentId);
						currentEl.data('hastempid',true);
					}

					activeEditorId=mura.currentId;
			
					var instance=CKEDITOR.instances[mura.currentId];
					var editiorEnabled=true;

					muraInlineEditor.sidebarAction('showeditor');

					mura('##' + mura.currentId)
						.find('.mura-object')
						.each(function(){
							mura.resetAsyncObject(this);
						});

					variation={
						selector:currentEl.selector(),
						original:currentEl.html()
					};

					try{
						currentEl.attr('contenteditable',true);

						var instance=CKEDITOR.instances[mura.currentId];

						if(!instance){

							mura('##' + mura.currentId).find('.mura-object').each(function(){
								mura.resetAsyncObject(this);
							});

							CKEDITOR.disableAutoInline = true;
							var editor=CKEDITOR.inline( 
								document.getElementById( mura.currentId ),
								{
									toolbar: 'htmlEditor',
									width: "75%",
									customConfig: 'config.js.cfm',
									on: {
											'instanceReady':function(e){
												e.editor.updateElement();
												variation.original=e.editor.getData();	
											},
											'blur': function(){ /*onBlur()*/}
										}	
								}
							);

						}

					} catch(err){
						
					}

					console.log('current Selector:' + variation.selector);

					
						
					/*
					currentEl.on('blur',function(){
						onBlur();
						currentEl.unbind('blur');
						
					});
					*/

					muraInlineEditor.isDirty=true;

					currentEl.addClass('mura-var-current');
					return false;
				}

				var editVariations=function(){
					editingVariations=true;
					mura('##adminStatus').hide();
					mura('##adminSave').show();
					displayVariations();

					mura(mura.editableSelector).hover(function(){
						if(editingVariations){	
							if(mura.currentId != mura(this).attr('id')){
								var prev=mura('.mura-var-target');
								prev.removeClass('mura-var-target');

								if(!prev.attr('class')){
									prev.removeAttr('class');
								}

								mura(this).addClass('mura-var-target');
							}
						}
					},
					function(){
						if(editingVariations){		
							if(mura.currentId != mura(this).attr('id')){
								mura(this).removeClass('mura-var-target');
								if(!mura(this).attr('class')){
									mura(this).removeAttr('class');
								}
							}
						}
					});

					mura(mura.editableSelector).on('dblclick',
						function(event){
							event.stopPropagation();
							if(editingVariations){
								editAction();
							}
					});

					/*
					mura('body').find('a:not(.mura),button:not(.mura)').on('click',function(event){
						if(editingVariations){
							event.preventDefault();
						}
					});
					*/
				}

				var exitVariations=function(){
					reset();
					mura('##adminStatus').show();
					mura('##adminSave').hide();
					
					var prev=mura('.mura-var-target');
					prev.removeClass('mura-var-target');

					if(!prev.attr('class')){
						prev.removeAttr('class');
					}

					editingVariations=false;
				}	
				

				mura('.mura-inline-undo').on('click',function(){
					undoVariations();
					editVariations();
				});

				editVariations();
				displayVariations();

				var styles='<style type="text/css">.mura-var-current {';
					styles+='	outline-width: 1px;';
					styles+='	outline-style: dotted;';
					styles+='   outline-color: red;';
					styles+='}';
					styles+='.mura-var-target {';
					styles+='    outline-width: 1px;';
					styles+='    outline-style: dotted;';
					styles+='    outline-color: blue;';
					styles+='}</style>';

				document.head.innerHTML += styles;
			</cfif>

			<cfif $.getContentRenderer().useLayoutManager()>
			if(window.mura.layoutmanager){

				mura("img").each(function(){muraInlineEditor.checkforImageCroppers(this);});

				muraInlineEditor.setAnchorSaveChecks(document);

				function initObject(){
					var item=mura(this);
					
					var objectParams;

					item.addClass("active");
					
					if(mura.type =='Variation'){
						objectParams=item.data();
						if(window.muraInlineEditor.objectHasConfigurator(objectParams) || window.muraInlineEditor.objectHasEditor(objectParams)){
							item.html(window.mura.layoutmanagertoolbar + item.html());

							item.find(".frontEndToolsModal").on(
								'click',
								function(event){
									event.preventDefault();
									openFrontEndToolsModal(this);
								}
							);


							item.find("img").each(function(){muraInlineEditor.checkforImageCroppers(this);});

							item.find('.mura-object').each(initObject);
						}
					} else {
						var region=item.closest(".mura-region-local");
						
						if(region && region.length ){
							if(region.data('perm')){
								objectParams=item.data();
								if(window.muraInlineEditor.objectHasConfigurator(objectParams) || window.muraInlineEditor.objectHasEditor(objectParams)){
									item.html(window.mura.layoutmanagertoolbar + item.html());

									item.find(".frontEndToolsModal").on(
										'click',
										function(event){
											event.preventDefault();
											openFrontEndToolsModal(this);
										}
									);


									item.find("img").each(function(){muraInlineEditor.checkforImageCroppers(this);});

									item.find('.mura-object').each(initObject);
								}
							}
						}

					}
				}

				mura(".mura-object").each(initObject);

				mura('.mura-object[data-object="folder"], .mura-object[data-object="calendar"], .mura-object[data-object="gallery"]').each(function(){
					var item=mura(this);
					item.addClass("active");
					item.prepend(window.mura.layoutmanagertoolbar);
					item.find(".frontEndToolsModal").on(
						'click',
						function(event){
							event.preventDefault();
							openFrontEndToolsModal(this);
						}
					);
				});

				mura.initLayoutManager();
			}
			</cfif>


			utility('.mura-editable-attribute').each(
				function(){
				var attribute=utility(this);
				
				if(attribute.data('attribute')){

					<cfif $.getContentRenderer().useLayoutManager()>	
					if(attribute.attr('data-attribute')){
						muraInlineEditor.initEditableObjectData.call(this);

						utility(this)
						.off('dblclick')
						.on('dblclick',
							function(){
								muraInlineEditor.initEditableAttribute.call(this);
							}
						);	
					}												
									
					<cfelse>
					
					var attributename=attribute.attr('data-attribute').toLowerCase();

					attribute.attr('contenteditable','true');
					attribute.attr('title','');
					
					utility(this)
					.unbind('click')
					.click(
						function(){
							muraInlineEditor.initEditableObjectData.call(this);
						}
					);													
									
					if(!(attributename in muraInlineEditor.attributes)){

						if(attribute.attr('data-type').toLowerCase()=='htmleditor' && 
							typeof(CKEDITOR.instances[attribute.attr('id')]) == 'undefined' 	
						){
							var editor=CKEDITOR.inline( 
							document.getElementById( attribute.attr('id') ),
							{
								toolbar: 'QuickEdit',
								width: "75%",
								customConfig: 'config.js.cfm'
							});

							editor.on('change', function(){
								if(utility('##adminSave').css('display') == 'none'){
									utility('##adminSave').fadeIn();	
								}
							});
						}
									
					}	
					</cfif>
				}
				
			});

			utility('.mura-inline-save').click(function(){
				var changesetid=utility(this).attr('data-changesetid');

				if(changesetid == ''){
					//alert(1 + " " + utility(this).attr('data-approved'))
					muraInlineEditor.data.approved=utility(this).attr('data-approved');
					muraInlineEditor.data.changesetid='';
				} else {
					if(muraInlineEditor.data.changesetid != '' && muraInlineEditor.data.changesetid != changesetid){
						if(confirm('#esapiEncode('javascript',application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,"sitemanager.content.removechangeset"),application.changesetManager.read(node.getChangesetID()).getName()))#')){
							muraInlineEditor.data._removePreviousChangeset=true;
						}
					}
					//alert(changesetid)
					muraInlineEditor.data.changesetid=changesetid;
					muraInlineEditor.data.approved=0;
				}

				muraInlineEditor.save();
			});

			utility('.mura-inline-cancel').click(function(){
				location.reload();
			});

			//clean instances
			for (var instance in CKEDITOR.instances) {
				if(!utility('##' + instance).length){
					CKEDITOR.instances[instance].destroy(true);
				}
			}

			return false;				 
		},
		resetEditableAttributes:function(){
			if(mura.currentId && muraInlineEditor.commitEdit){
				muraInlineEditor.commitEdit(mura('##' + mura.currentId));
			}

			
			utility('.mura-editable-attribute').each(
				function(){
					var attribute=utility(this);

					if(attribute.attr('contenteditable') == 'true'){

						if(CKEDITOR.instances[attribute.attr('id')]){
							var instance =CKEDITOR.instances[attribute.attr('id')];
							instance.updateElement();
							instance.destroy(true)
						}
						
						attribute.attr('contenteditable','false');
						attribute.addClass('active');
						attribute.data('manualedit',false);
						mura.processMarkup(this);

						attribute.find('.mura-object').each(function(){
							mura.initDraggableObject(this);
							mura(this).addClass('active')
						});

						attribute.find('h1, h2, h3, h4, p, div, img, table, form, article').each(function(){
							mura.initLooseDropTarget(this);
						});

						attribute
						.off('dblclick')
						.on('dblclick',
							function(){
								muraInlineEditor.initEditableAttribute.call(this);
							}
						);

					}
			});
		},
		initEditableObjectData:function(){
			var self=this;
			var attributename=this.getAttribute('data-attribute').toLowerCase();
			
			var attribute=document.getElementById('mura-editable-attribute-' + attributename);
			
			if(!(attributename in muraInlineEditor.attributes)){
				if(attributename in muraInlineEditor.preprocessed){
					
					attribute.innerHTML=muraInlineEditor.preprocessed[attributename];
					
					if(mura.processMarkup){
						mura.processMarkup(this);
					}
				}
				

				muraInlineEditor.attributes[attributename]=attribute;
			}
		},
		initEditableAttribute:function(){
			var attribute=utility(this);
			var attributename=attribute.attr('data-attribute').toLowerCase();
			
			muraInlineEditor.sidebarAction('showeditor');
			attribute.attr('contenteditable','true');
			attribute.attr('title','');
			attribute.unbind('dblclick');
			attribute.find('.mura-object').each(function(){
				var self=utility(this);

				self.removeAttr('data-perm')
				.removeAttr('data-instanceid')
				.removeAttr('draggable');

				if(typeof mura !='undefined' && typeof mura.resetAsyncObject=='function'){
					mura.resetAsyncObject(this);
				} else {
					self.html('');
				}

			});	

			if(!attribute.data('manualedit')){
				if(attribute.attr('data-type').toLowerCase()=='htmleditor' && 
					typeof(CKEDITOR.instances[attribute.attr('id')]) == 'undefined' 	
				){
					var editor=CKEDITOR.inline( 
					document.getElementById( attribute.attr('id') ),
					{
						toolbar: 'QuickEdit',
						width: "75%",
						customConfig: 'config.js.cfm'
					});

					editor.on('change', function(){
						if(utility('##adminSave').css('display') == 'none'){
							utility('##adminSave').fadeIn();	
						}
					});
				}
				
				attribute.data('manualedit',true);		
			}
					
			muraInlineEditor.isDirty=true;

		},
		getAttributeValue: function(attribute){
			var attributeid='mura-editable-attribute-' + attribute;
			if(typeof(CKEDITOR.instances[attributeid]) != 'undefined') {
				CKEDITOR.instances[attributeid].updateElement();
				return CKEDITOR.instances[attributeid].getData();
			} else if(muraInlineEditor.attributes[attribute].getAttribute('data-type').toLowerCase() == 'htmleditor') {
				return muraInlineEditor.attributes[attribute].innerHTML;
			} else{
				return muraInlineEditor.stripHTML(muraInlineEditor.attributes[attribute].innerHTML.trim());
			}
		},
		save:function(){
			try{

				utility('.mura-object-selected').removeClass('mura-object-selected');

				muraInlineEditor.validate(
					function(){
						var count=0;

						for (var prop in muraInlineEditor.attributes) {
							var attribute=muraInlineEditor.attributes[prop].getAttribute('data-attribute');
							
							utility(attribute)
								.find('.mura-object')
								.removeAttr('data-perm')
								.removeAttr('data-instanceid')
								.removeAttr('draggable');
							
							if(mura && mura.resetAsyncObject){
								mura(attribute)
									.find('.mura-object')
									.each(function()
									{
										mura.resetAsyncObject(this)
									});
							} else {
								utility(attribute)
								.find('.mura-object')
								.html('');	
							}
							
							muraInlineEditor.data[attribute]=muraInlineEditor.getAttributeValue(attribute);
							count++;
						}

						utility('.mxp-editable').each(function(){
							if(mura && mura.resetAsyncObject){
								mura(this)
									.find('.mura-object')
									.each(function()
									{
										mura.resetAsyncObject(this)
									});
							}

						});
									
						utility('.mura-region-local[data-inited="true"]:not([data-loose="true"])').each(
							function(){
								var objectlist=[];

								utility(this).children('.mura-object').each(function(){
									
									if(mura && mura.resetAsyncObject){
										mura.resetAsyncObject(this);
										var item=mura(this);
									} else {
										var item=utility(this);
										item.html('');	
									}

									var params=item.data();
									
									delete params['instanceid'];
									delete params['objectname'];
									delete params['objectid'];
									delete params['isconfigurator'];
									delete params['perm'];
									delete params['async'];

									if(!item.data('objectname')){
										item.data('objectname',item.data('object'));
									}			

									objectlist.push(item.data('object') + '~' + item.data('objectname') + '~' + item.data('objectid') + '~' + JSON.stringify(params))

								});

								muraInlineEditor.data['objectlist' + this.getAttribute('data-regionid')]=objectlist.join('^');
								count++;
							}
						);

						utility('.mura-object[data-object="folder"], .mura-object[data-object="gallery"], .mura-object[data-object="calendar"]').each(function(){
							var item=utility(this);

							if(item.data('displaylist')){
								muraInlineEditor.data['displaylist']=item.data('displaylist');
							}
							if(item.data('imagesize')){
								muraInlineEditor.data['imagesize']=item.data('imagesize');
							}
							if(item.data('imagewidth')){
								muraInlineEditor.data['imagewidth']=item.data('imagewidth');
							}
							if(item.data('imageheight')){
								muraInlineEditor.data['imageheight']=item.data('imageheight');
							}
							if(item.data('nextn')){
								muraInlineEditor.data['nextn']=item.data('nextn');
							}
							if(item.data('sortby')){
								muraInlineEditor.data['sortby']=item.data('sortby');
							}
							if(item.data('sortdirection')){
								muraInlineEditor.data['sortdirection']=item.data('sortdirection');
							}

							muraInlineEditor.data['objectparams']=JSON.stringify(item.data());
							
						});

						//objectlistarguments.regionID=rs.object~rs.name~rs.objectID~rs.params^

						//alert(muraInlineEditor.data.objectlist3);
						//return;

						<cfif node.getType() eq 'Variation'>

							count=1;

							if(muraInlineEditor.commitEdit){
								muraInlineEditor.commitEdit(mura('##' + mura.currentId));
							}
						
							mura('.mxp-editable').each(function(){
								var item=mura(this);
								var selector=item.selector();
								var instance=CKEDITOR.instances[item.attr('id')];

								for(var i=0;i<mura.finalVariations.length;i++){
									if(mura.finalVariations[i].selector==selector){
										if(instance){
											instance.updateElement();
											
											mura(mura.finalVariations[i].selector)
												.find('.mura-object').each(function(){
													mura.resetAsyncObject(this);
												});

											mura.finalVariations[i].adjusted=instance.getData();
										} else {
											
											mura(mura.finalVariations[i].selector)
												.find('.mura-object').each(function(){
													mura.resetAsyncObject(this);
												});

											mura.finalVariations[i].adjusted=item.html();
										}
										
									}
								}

							});

							muraInlineEditor.data=mura.extend(
								muraInlineEditor.data,
								{
									moduleid:mura.content.moduleid,
									remoteid:mura.content.remoteid,
									remoteurl:mura.content.remoteurl,
									type:mura.content.type,
									subtype:mura.content.subtype,
									parentid:mura.content.parentid,
									title:mura.content.title,
									body:escape(JSON.stringify(mura.finalVariations))
								}
							);
						</cfif>
						
						if(count){
							if(muraInlineEditor.data.approvalstatus=='Pending'){
								if(confirm('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,"approvalchains.cancelPendingApproval"))#')){
									muraInlineEditor.data.cancelpendingapproval=true;
								} else {
									muraInlineEditor.data.cancelpendingapproval=false;
								}

							}

							//console.log(muraInlineEditor.data)
							//return;

							if(typeof $ != 'undefined' && $.support){
								$.support.cors = true;
							}
							
							utility.ajax({ 
					        type: "POST",
					        xhrFields: { withCredentials: true },
					        crossDomain:true,
					        url: adminLoc,
					        data: muraInlineEditor.data,
					        success: function(data){
					        	<cfif node.getType() eq 'Variation'>
					        		if(muraInlineEditor.requestedURL){
										location.href=muraInlineEditor.requestedURL
									} else {
					        			location.reload();
									}
					        	<cfelse>
					        		var resp = eval('(' + data + ')');

					        		if(muraInlineEditor.requestedURL){
										location.href=muraInlineEditor.requestedURL
									} else {
										location.href=resp.location;
									}
						        	
					        	</cfif>
						     
					        },
					         error: function(data){
					        	console.log(JSON.stringify(data));
						     
					        }
					       });
						} else {
							if(muraInlineEditor.requestedURL){
								location.href=muraInlineEditor.requestedURL
							} else {
								location.reload();
							}
						 	
						}
					}
				);
			} catch(err){
				alert("An error has occurred, please check your browser console for more information."); 
				console.log(err);
			}

			return false;		
		},
		stripHTML: function(html){
			var tmp = document.createElement("DIV");
			tmp.innerHTML = html;
			return tmp.textContent||tmp.innerText;
		},
		validate: function(callback){

			if(!mura.apiEndpoint){
				mura.apiEndpoint=mura.context + '/index.cfm/_api/json/v1/';
			}

			var getValidationFieldName=function(theField){
				if(theField.getAttribute('data-label')!=undefined){
					return theField.getAttribute('data-label');
				}else if(theField.getAttribute('label')!=undefined){
					return theField.getAttribute('label');
				}else{
					return theField.getAttribute('name');
				}
			}

			var getValidationIsRequired=function(theField){
				if(theField.getAttribute('data-required')!=undefined){
					return (theField.getAttribute('data-required').toLowerCase() =='true');
				}else if(theField.getAttribute('required')!=undefined){
					return (theField.getAttribute('required').toLowerCase() =='true');
				}else{
					return false;
				}
			}

			var getValidationMessage=function(theField, defaultMessage){
				if(theField.getAttribute('data-message') != undefined){
					return theField.getAttribute('data-message');
				} else if(theField.getAttribute('message') != undefined){
					return theField.getAttribute('message') ;
				} else {
					return getValidationFieldName(theField).toUpperCase() + defaultMessage;
				}	
			}

			var getValidationType=function(theField){
				if(theField.getAttribute('data-validate')!=undefined){
					return theField.getAttribute('data-validate').toUpperCase();
				}else if(theField.getAttribute('validate')!=undefined){
					return theField.getAttribute('validate').toUpperCase();
				}else{
					return '';
				}
			}

			var hasValidationMatchField=function(theField){
				if(theField.getAttribute('data-matchfield')!=undefined && theField.getAttribute('data-matchfield') != ''){
					return true;
				}else if(theField.getAttribute('matchfield')!=undefined && theField.getAttribute('matchfield') != ''){
					return true;
				}else{
					return false;
				}
			}

			var getValidationMatchField=function (theField){
				if(theField.getAttribute('data-matchfield')!=undefined){
					return theField.getAttribute('data-matchfield');
				}else if(theField.getAttribute('matchfield')!=undefined){
					return theField.getAttribute('matchfield');
				}else{
					return '';
				}
			}

			var hasValidationRegex=function(theField){
				if(theField.value != undefined){
					if(theField.getAttribute('data-regex')!=undefined && theField.getAttribute('data-regex') != ''){
						return true;
					}else if(theField.getAttribute('regex')!=undefined && theField.getAttribute('regex') != ''){
						return true;
					}
				}else{
					return false;
				}
			}

			var getValidationRegex=function(theField){
				if(theField.getAttribute('data-regex')!=undefined){
					return theField.getAttribute('data-regex');
				}else if(theField.getAttribute('regex')!=undefined){
					return theField.getAttribute('regex');
				}else{
					return '';
				}
			}

			var data={};
			var $callback=callback;

			for (var prop in muraInlineEditor.attributes) {
				data[prop]=muraInlineEditor.getAttributeValue(prop);
			}

			var errors="";
			var setFocus=0;
			var started=false;
			var startAt;
			var firstErrorNode;
			var validationType='';
			var validations={properties:{}};
			var rules=new Array();

			for (var prop in muraInlineEditor.attributes) {
				theField=muraInlineEditor.attributes[prop];
			    validationType=getValidationType(theField).toUpperCase();;
			    theValue=muraInlineEditor.getAttributeValue(prop);

				rules=new Array();
				
				if(getValidationIsRequired(theField))
					{	
						rules.push({
							required: true,
							message: getValidationMessage(theField,' is required.')
						});
						
						 			
					}
				if(validationType != ''){
						
					if(validationType=='EMAIL' && theValue != '')
					{	
							rules.push({
								dataType: 'EMAIL',
								message: getValidationMessage(theField,' must be a valid email address.')
							});
							
									
					}

					else if(validationType=='NUMERIC')
					{	
							rules.push({
								dataType: 'NUMERIC',
								message: getValidationMessage(theField,' must be numeric.')
							});
										
					}
					
					else if(validationType=='REGEX' && theValue !='' && hasValidationRegex(theField))
					{	
							rules.push({
								regex: hasValidationRegex(theField),
								message: getValidationMessage(theField,' is not valid.')
							});
											
					}
					
					else if(validationType=='MATCH' 
							&& hasValidationMatchField(theField) && theValue != theForm[getValidationMatchField(theField)].value)
					{	
						rules.push({
							eq: theForm[getValidationMatchField(theField)].value,
							message: getValidationMessage(theField, ' must match' + getValidationMatchField(theField) + '.' )
						});
									
					}
					
					else if(validationType=='DATE' && theValue != '')
					{
						rules.push({
							dataType: 'DATE',
							message: getValidationMessage(theField, ' must be a valid date [MM/DD/YYYY].' )
						});
						 
					}
				}
				
				if(rules.length){
					validations.properties[prop]=rules;
				}
			}

			try{
				//alert(JSON.stringify(validations))
				utility.ajax(
					{
						type: 'post',
						url: mura.apiEndpoint + 'validate/',
						data: {
								data: JSON.stringify(utility.extend(muraInlineEditor.data,data)),
								validations: JSON.stringify(validations)
							},
						success: function(resp) {
							if(typeof resp != 'object'){
								resp=data=eval('(' + resp + ')');
							}
						 		data=resp.data;

						 		if(utility.isEmptyObject(data)){
						 			$callback();
						 		} else {
							 		var msg='';
							 		for(var e in data){
							 			msg=msg + data[e] + '\n';
							 		}

							 		alert(msg);

							 		return false;
						 		}
						},
						error: function(resp) {
						 		
						 		alert(JSON.stringify(resp));
						}

					}		 
				);
			} 
			catch(err){ 
				console.log(err);

			}

			return false;

		},
		htmlEditorOnComplete: function(editorInstance) {
			var instance = utility(editorInstance).ckeditorGet();
			instance.resetDirty();
			var totalInstances = CKEDITOR.instances;
			CKFinder.setupCKEditor(
			instance, {
				basePath: '#application.configBean.getContext()#/requirements/ckfinder/',
				rememberLastFolder: true
			});
		},
		<cfset csrfTokens=$.generateCSRFTokens(context=node.getContentHistID() & 'add')>
		data:{
			muraaction: 'carch.update',
			action: 'add',
			ajaxrequest: true,
			siteid: '#esapiEncode('javascript',node.getSiteID())#',
			contenthistid: '#esapiEncode('javascript',node.getContentHistID())#',
			contentid: '#esapiEncode('javascript',node.getContentID())#',
			parentid: '#esapiEncode('javascript',node.getParentID())#',
			moduleid: '#esapiEncode('javascript',node.getModuleID())#',
			approved: 0,
			changesetid: '',
			bean: 'content',
			loadby: 'contenthistid',
			approvalstatus: '#esapiEncode('javascript',node.getApprovalStatus())#',
			csrf_token: '#csrfTokens.token#',
			csrf_token_expires: '#csrfTokens.expires#'
			},
		attributes: {},
		preprocessed: {
		</cfoutput>
		<cfscript>
		started=false;
		nodeCollection=node.getAllValues();
		for(attribute in nodeCollection)
			if(isSimpleValue(nodeCollection[attribute]) and reFindNoCase("(\{{|\[sava\]|\[mura\]|\[m\]).+?(\[/sava\]|\[/mura\]|}}|\[/m\])",nodeCollection[attribute])){
				if(started){writeOutput(",");}
				writeOutput("'#esapiEncode('javascript',lcase(attribute))#':'#esapiEncode('javascript',trim(nodeCollection[attribute]))#'");
				started=true;
			}
		</cfscript>

		},
		pluginConfigurators:[],
		getPluginConfigurator: function(objectid) {
			for(var i = 0; i < window.muraInlineEditor.pluginConfigurators.length; i++) {
				if(window.muraInlineEditor.pluginConfigurators[i].objectid == objectid || window.muraInlineEditor.pluginConfigurators[i].object == objectid) {
					return window.muraInlineEditor.pluginConfigurators[i].init;
				}
			}

			return "";
		},
		<cfoutput>customtaggroups:#serializeJSON(listToArray($.siteConfig('customTagGroups')))#,
		allowopenfeeds:#application.configBean.getValue(property='allowopenfeeds',defaultValue=false)#,</cfoutput>
		objectHasEditor:function(displayObject){
			if(displayObject.object == 'form') {
				return true;
			} else if(displayObject.object == 'form_responses') {
				return true;
			} else if(displayObject.object == 'component') {
				return true;
			}
			return false;
		},'form':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
		configuratorMap:{
			'container':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'collection':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'text':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'embed':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'feed':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initFeedConfigurator(data);}},
			'form':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'component':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'folder':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'gallery':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'calendar':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'form_responses':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'plugin':{
				'condition':function(){
					return true;
				},
				'initConfigurator':function(data){
					if(data.objectid && data.objectid.toLowerCase() != 'none' && siteManager.getPluginConfigurator(data.objectid)){
						var configurator = siteManager.getPluginConfigurator(data.objectid);
						window[configurator](data)
					} else {
						siteManager.initGenericConfigurator(data);
					}
				}
			},
			'feed_slideshow':{condition:function(){return true;},'initConfigurator':function(data){muraInlineEditor.initSlideShowConfigurator(data);}},
			'tag_cloud':{condition:function(){return muraInlineEditor.customtaggroups.length;},'initConfigurator':function(data){siteManager.initTagCloudConfigurator(data);}},
			'category_summary':{condition:function(){return true;},'initConfigurator':function(data){if(siteManager.allowopenfeeds){siteManager.initCategorySummaryConfigurator(data);} else {siteManager.initGenericConfigurator(data);}}},
			'archive_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'calendar_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'category_summary_rss':{condition:function(){return muraInlineEditor.allowopenfeeds;},'initConfigurator':function(data){siteManager.initCategorySummaryConfigurator(data);}},
			'site_map':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initSiteMapConfigurator(data);}},
			'related_content':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initRelatedContentConfigurator(data);}},
			'related_section_content':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initRelatedContentConfigurator(data);}},
			'system':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'comments':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'favorites':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'forward_email':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'event_reminder_form':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'rater':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'user_tools':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'goToFirstChild':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'navigation':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'sub_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'peer_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'standard_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'portal_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'folder_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'multilevel_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'seq_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'top_nav':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'mailing_list':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}},
			'mailing_list_master':{condition:function(){return true;},'initConfigurator':function(data){siteManager.initGenericConfigurator(data);}}
		},
		objectHasConfigurator:function(displayObject){
			return (displayObject.object in this.configuratorMap) && this.configuratorMap[displayObject.object].condition() || !(displayObject.object in this.configuratorMap);
		},
		checkforImageCroppers:function(el){

			if(window.mura && window.mura.editing){
				var img=mura(el);
				var instanceid=mura.createUUID();
					img.data('instanceid',instanceid);
				var path=img.attr('src').split( '?' )[0].split('/');
				var fileParts=path[path.length-1].split('.');
				var filename=fileParts[0];
				
				if(fileParts.length > 1){
					var fileext=fileParts[1].toLowerCase();
				}
				
				var fileInfo=filename.split('_');
				var fileid=fileInfo[0];
				
				if(fileid.length==35 && (fileext=='jpg' || fileext=='jpeg' || fileext=='png')){
					fileInfo.shift()
					
				
					img.css({display:'inline-block;'});

					var size=fileInfo.join('_');

					if(!size){
						size='large';
					}
					
					var actionhref=adminLoc + '?muraAction=cArch.imagedetails&siteid=' + mura.siteid + '&fileid=' + fileid + '&imagesize=' + size + '&instanceid=' + img.data('instanceid') + '&compactDisplay=true';

					function initCropper(){
						openFrontEndToolsModal({
								href:actionhref
						});
					}

					
					var a=img.closest('a');


					if(a.length){
						a.click(function(e){e.preventDefault();});
						a.attr('onclick',"openFrontEndToolsModal({href:'" + actionhref + "'}); return false;");
						a.off();
					}
					
					img=mura('img[data-instanceid="' + instanceid + '"]' );
					img.on('click',function(e){e.preventDefault();});
					
					mura('img[data-instanceid="' + instanceid + '"]' ).on('click',function(){
						initCropper();
					});
				}
				
			}
		},
		reloadImg:function(img) {

		   var src = img.src;
		 
		   var pos = img.indexOf('?');
		   if (pos >= 0) {
		      src = src.substr(0, pos);
		   }
			
		   img.src = src + '?v=' + Math.random();

		   return false;
		},
		sidebarAction:function(action){
			if(action=='showobjects'){
				muraInlineEditor.resetEditableAttributes();
				mura('.mura-object-selected').removeClass('mura-object-selected');
				mura('#mura-sidebar-configurator').hide();
				mura('#mura-sidebar-objects-legacy').hide();
				mura('#mura-sidebar-objects').show();
				mura('#mura-sidebar-editor').hide();
			} else if(action=='showlegacyobjects'){
				muraInlineEditor.resetEditableAttributes();
				mura('.mura-object-selected').removeClass('mura-object-selected');
				mura('#mura-sidebar-configurator').hide();
				mura('#mura-sidebar-objects-legacy').show();
				mura('#mura-sidebar-objects').hide();
				mura('#mura-sidebar-editor').hide();
			} else if(action=='showconfigurator'){
				muraInlineEditor.resetEditableAttributes();
				mura('#mura-sidebar-configurator').hide();
				mura('#mura-sidebar-objects-legacy').hide();
				mura('#mura-sidebar-objects').hide();
				mura('#mura-sidebar-editor').hide();
			} else if(action=='showeditor'){
				mura('.mura-object-selected').removeClass('mura-object-selected');
				mura('#mura-sidebar-configurator').hide();
				mura('#mura-sidebar-objects-legacy').hide();
				mura('#mura-sidebar-objects').hide();
				mura('#mura-sidebar-editor').show();
			}
		},
		setAnchorSaveChecks:function(el){
			function handleEditCheck(){
				if(muraInlineEditor.isDirty && confirm("Save as draft?")){
					muraInlineEditor.requestedURL=this.href;
					muraInlineEditor.save();
					return false;
				} else {
					return true;
				}
			}

			var anchors=el.querySelectorAll('a');

			for(var i=0;i<anchors.length;i++){	
				try{
					if (typeof(anchors[i].onclick) != 'function' 
						&& typeof(anchors[i].getAttribute('href')) == 'string' 
						&& anchors[i].getAttribute('href').indexOf('#') == -1
						&& anchors[i].getAttribute('href').indexOf('mailto') == -1) {
			   			anchors[i].onclick = handleEditCheck;
					}
				} catch(err){}
			}
		},
		isDirty:false
	}

	<cfoutput>
	<cfset rsPluginDisplayObjects=application.pluginManager.getDisplayObjectsBySiteID(siteID=session.siteID,configuratorsOnly=true)>
	<cfset nonPluginDisplayObjects=$.siteConfig().getDisplayObjectLookup()>
	<cfloop query="rsPluginDisplayObjects">
	muraInlineEditor.pluginConfigurators.push({'objectid':'#rsPluginDisplayObjects.objectid#','init':'#rsPluginDisplayObjects.configuratorInit#'});
	</cfloop>
	<cfloop item="i" collection="#nonPluginDisplayObjects#">
	<cfif len(nonPluginDisplayObjects[i].configuratorInit)>
		muraInlineEditor.pluginConfigurators.push({'objectid':'#nonPluginDisplayObjects[i].objectid#','init':'#nonPluginDisplayObjects[i].configuratorInit#'});
	</cfif>
	</cfloop>
	</cfoutput>
	window.muraInlineEditor=muraInlineEditor;
	</cfif>
	</cfif>
	window.toggleAdminToolbar=toggleAdminToolbar;
	window.closeFrontEndToolsModal=closeFrontEndToolsModal;
	window.openFrontEndToolsModal=openFrontEndToolsModal;
})(window);