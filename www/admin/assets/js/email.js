/* This file is part of Mura CMS. 

	Mura CMS is free software: you can redistribute it and/or modify 
	it under the terms of the GNU General Public License as published by 
	the Free Software Foundation, Version 2 of the License. 

	Mura CMS is distributed in the hope that it will be useful, 
	but WITHOUT ANY WARRANTY; without even the implied warranty of 
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the 
	GNU General Public License for more details. 

	You should have received a copy of the GNU General Public License 
	along with Mura CMS.  If not, see <http://www.gnu.org/licenses/>. 

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
	version 2 without this exception.  You may, if you choose, apply this exception to your own modified versions of Mura CMS. */

var emailManager = {

	openScheduler: function() {
		var s = $('#scheduler');
		var c = $('#controls');
		var i = $('.toggle');
		c.css('display', 'none');
		s.css('display', 'inline-block');
		i.css('opacity', '.30');
		i.attr('disabled','disabled');

		return false;

	},

	closeScheduler: function() {
		var s = $('#scheduler');
		var c = $('#controls');
		var i = $('.toggle');
		s.css('display', 'none');
		c.css('display', 'inline');
		i.css('opacity', '1');
		i.removeAttr('disabled');

		document.forms.form1.deliveryDate.value = '';

		$('.mura-datepickerdeliveryDate').val('');
		$('#mura-deliveryDateHour option')[7].selected = true;
		$('#mura-deliveryDateMinute option')[0].selected = true;
	
		if($('#mura-deliveryDateDayPart option').length){
			$('#mura-deliveryDateDayPart option')[0].selected = true;	
		}
		return false;

	},

	showMessageEditor: function() {
		var selObj = document.getElementById('messageFormat');
		var selIndex = selObj.selectedIndex;
		var h = $('#htmlMessage');
		var t = $('#textMessage');

		if(selObj.options[selIndex].value == "HTML") {
			h.css('display', 'inline');
			t.css('display', 'none');
		}
		if(selObj.options[selIndex].value == "Text") {
			h.css('display', 'none');
			t.css('display', 'inline');
		}
		if(selObj.options[selIndex].value == "HTML & Text") {
			h.css('display', 'inline');
			t.css('display', 'inline');
		}

	},

	validateEmailForm: function(formAction, errorMessage) {
		document.forms.form1.action.value = formAction;
		confirmDialog(errorMessage, function() {
			if(!emailManager.checkContentLength()) {
				return false;
			}

			submitForm(document.forms.form1);
		});


		return false;
	},

	validateScheduler: function(formAction, errorMessage, formField) {
		var f = $("#" + formField);
		document.forms.form1.action.value = formAction;
		if(f.val() == '') {
			alertDialog(errorMessage);
			f.focus();
		} else {
			submitForm(document.forms.form1);
		}

		return false;

	},

	checkContentLength: function() {
		/*
	var bodyHTML =FCKeditorAPI.GetInstance('bodyHTML').GetXHTML();
	var bodyHTMLLength = bodyHTML.length;
	var pageSize=32000;
			
			if(bodyHTMLLength > pageSize ){
		
			alert("The 'HTML' content length must be less than 32000 characters.");
			return false;
			}
			
			var bodyText =document.forms.form1.bodyText.value.length;
			var bodyTextLength = bodyText.length;
			
			if(bodyTextLength > pageSize ){
		
			alert("The 'Text' content length must be less than 32000 characters.");
			return false;
			}
			
		*/
		return true;
	}
}