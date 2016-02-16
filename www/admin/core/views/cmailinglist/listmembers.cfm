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
<cfoutput>
<h1>#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager')#</h1>

<cfinclude template="dsp_secondary_menu.cfm">

<form class="fieldset-wrap" novalidate="novalidate" action="./?muraAction=cMailingList.updatemember" name="form1" method="post" onsubmit="return validate(this);">
<div class="fieldset">
<div class="control-group">
	<label class="control-label">
		#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.email')#
	</label>
	<div class="controls">
		<input type=text name="email" class="text" required="true" message="#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.emailrequired')#">
	</div>
</div>
<div class="control-group">
	<label class="control-label">
		#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.firstname')#
	</label>
	<div class="controls">
		<input type=text name="fname" class="text" />
	</div>
</div>

<div class="control-group">
	<label class="control-label">
		#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.lastname')#
	</label>
	<div class="controls">
		<input type=text name="lname" class="text" />
	</div>
</div>

<div class="control-group">
	<label class="control-label">
		#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.company')#
	</label>
	<div class="controls">
		<input type=text name="company" class="text" />
	</div>
</div>

<div class="control-group">
	<div class="controls">
		<label for="a" class="radio">
			<input type="radio" name="action" id="a" value="add" checked> 
			#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.subscribe')#
		</label> 
		<label id="d" class="radio">
			<input type="radio" id="d" name="action" value="delete"> 
			 #application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.unsubscribe')#
		</label>
	</div>
</div>
</div>
<div class="form-actions">
<input type="button" class="btn" onclick="submitForm(document.forms.form1);" value="#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.submit')#" />
</div>
<input type=hidden name="mlid" value="#esapiEncode('html_attr',rc.mlid)#">
<input type=hidden name="siteid" value="#esapiEncode('html_attr',rc.siteid)#">
<input type=hidden name="isVerified" value="1">
</form>
<h2>#rc.listBean.getname()#</h2>

<table id="metadata" class="mura-table-grid">
<tr>
	<th class="var-width">#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.emails')# (#rc.rslist.recordcount#)</th>
	<th>#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.name')#</th>
	<th>#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.company')#</th>
	<th>#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.verified')#</th>
	<th>#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.created')#</th>
	<th>&nbsp;</th>
</tr></cfoutput>
<cfif rc.rslist.recordcount>
<cfoutput query="rc.rslist" startrow="#rc.startrow#" maxrows="#rc.nextN.RecordsPerPage#">
	<tr>
		<td class="var-width"><a href="mailto:#esapiEncode('html',rc.rslist.email)#">#esapiEncode('html',rc.rslist.email)#</a></td>
		<td>#esapiEncode('html',rc.rslist.fname)#&nbsp;#esapiEncode('html',rc.rslist.lname)#</td>
		<td>#esapiEncode('html',rc.rslist.company)#</td>
		<td><cfif rc.rslist.isVerified eq 1>#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.yes')#<cfelse>#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.no')#</cfif></td>
		<td>#LSDateFormat(rc.rslist.created,session.dateKeyFormat)#</td>
		<td class="actions"><ul class="mailingListMembers"><li class="delete"><a title="#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.delete')#" href="./?muraAction=cMailingList.updatemember&action=delete&mlid=#rc.rslist.mlid#&email=#esapiEncode('url',rc.rslist.email)#&siteid=#esapiEncode('url',rc.siteid)#" onclick="return confirmDialog('#esapiEncode('javascript',application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.deletememberconfirm'))#',this.href);"><i class="icon-remove-sign"></i></a></li></ul></td></tr>
</cfoutput>
<cfelse>
<tr>
<td class="noResults" colspan="5"><cfoutput>#application.rbFactory.getKeyValue(session.rb,'mailinglistmanager.nomembers')#</cfoutput></td>
</tr>
</cfif>
</table>
<cfinclude template="dsp_list_members_next_n.cfm">