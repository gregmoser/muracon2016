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

<cfset isBlocked=false/>
<cfoutput>
<cfif rc.$.event('status') eq 'challenge' and isdefined('session.mfa')>
	<cfif rc.compactDisplay eq 'true'>
		<h1>#application.rbFactory.getKeyValue(session.rb,'login.authorizationcode')#</h1>
	</cfif>
	<div id="login" class="span12">
	<cfif rc.compactDisplay neq 'true'>
		<h1>#application.rbFactory.getKeyValue(session.rb,'login.authorizationcode')#</h1>
	</cfif>
<cfelse>
	<cfif rc.compactDisplay eq 'true'>
		<h1>#application.rbFactory.getKeyValue(session.rb,'login.pleaselogin')#</h1>
	</cfif>
	<div id="login" class="span12">
	<cfif rc.compactDisplay neq 'true'>
		<h1>#application.rbFactory.getKeyValue(session.rb,'login.pleaselogin')#</h1>
	</cfif>
	<cfif rc.status eq 'denied'>
		<p class="alert alert-error">#application.rbFactory.getKeyValue(session.rb,'login.denied')#</p>
	<cfelseif rc.status eq 'failed'>
		<cfset isBlocked=structKeyExists(session, "blockLoginUntil") and isDate(session.blockLoginUntil) and session.blockLoginUntil gt now() />
		<cfif isBLocked>
			<p class="alert alert-error">#application.rbFactory.getKeyValue(session.rb,'login.blocked')#</p>
		<cfelse>
			<p class="alert alert-error">#application.rbFactory.getKeyValue(session.rb,'login.failed')#</p>
		</cfif>
	</cfif>
</cfif>


<!--- Do not change the html comment below --->
<!-- mura-primary-login-token -->

<cfif not isBlocked>
	<cfif rc.$.event('status') eq 'challenge' and isdefined('session.mfa')>
		<cfset output=rc.$.renderEvent('onAdminMFAChallengeRender')>
		<cfif len(output)>
			#output#
		<cfelse>
			<cfif rc.$.getBean('configBean').getValue(property='MFAPerDevice',defaultValue=false) and not len(rc.$.event('authcode'))>
				<p class="alert alert-error">#application.rbFactory.getKeyValue(session.rb,'login.newdevice')#</p>
			</cfif>

			<cfif len(rc.$.event('authcode'))>
				<p class="alert alert-error">#application.rbFactory.getKeyValue(session.rb,'login.authcodeerror')#</p>
			</cfif>
			
			<form novalidate="novalidate" id="loginForm" name="frmLogin" method="post" action="index.cfm" onsubmit="return submitForm(this);">

			<div class="control-group">
		      	<label class="control-label">
				#application.rbFactory.getKeyValue(session.rb,'login.enteremailedauthcode')#
				</label>
		      	<div class="controls">
					<div class="input-prepend">
					  	<span class="add-on"><i class="icon-envelope"></i></span><input id="authcode" name="authcode" type="text" class="span11" placeholder="#esapiEncode('html_attr',application.rbFactory.getKeyValue(session.rb,'login.authorizationcode'))#" />
					</div>
					<cfif rc.$.getBean('configBean').getValue(property='MFAPerDevice',defaultValue=false)>
						<input type="hidden" name="rememberdevice" value="1"/>
						<!---
						<div id="remember-device">
				      	<input type="checkbox" id="rememberdevice" name="rememberdevice" value="1" />
				     	<label for="rememberdevice">#application.rbFactory.getKeyValue(session.rb,'login.rememberdevice')#
				      	</label>
						</div>
						--->
					</cfif>
				</div>
			</div>
			<div class="form-actions">
				<input type="submit" class="btn" value="#application.rbFactory.getKeyValue(session.rb,'login.submit')#" />
			</div>
			<input type="hidden" name="muraAction" value="cLogin.login">
			<input type="hidden" name="status" value="challenge">
			<input type="hidden" name="attemptChallenge" value="true">
			#rc.$.renderCSRFTokens(format='form')#
			</form>
		</cfif>
	<cfelse>
		<form novalidate="novalidate" id="loginForm" name="frmLogin" method="post" action="index.cfm" onsubmit="return submitForm(this);">

			<!---<div class="control-group">
			    <label class="control-label">
			    	#application.rbFactory.getKeyValue(session.rb,'login.username')#
			    </label>--->
			    <div class="input-prepend">
			      <span class="add-on"><i class="icon-user"></i></span><input id="username" name="username" type="text" class="span11" placeholder="#application.rbFactory.getKeyValue(session.rb,'login.username')#">
			    </div>
			 <!---</div>--->

			<!---<div class="control-group">
			    <label class="control-label">
			      	#application.rbFactory.getKeyValue(session.rb,'login.password')#
			 	</label>--->
			    <div class="input-prepend">
			      	<span class="add-on"><i class="icon-key"></i></span><input id="password" type="password" name="password" class="span11" placeholder="#application.rbFactory.getKeyValue(session.rb,'login.password')#">
			  	</div>
			<!---</div>--->

			<cfif rc.$.getBean('configBean').getValue(property='MFA',defaultValue=false)>
				<div class="input-prepend">
			      	<select class="span11" name="rb">
						<option value="en">English</option>
						<option value="de"<cfif cookie.rb eq "de"> selected</cfif>>Deutsch</option>
						<option value="nl"<cfif cookie.rb eq "nl"> selected</cfif>>Dutch</option>
						<option value="fr"<cfif cookie.rb eq "fr"> selected</cfif>>Fran&ccedil;ais</option>
						<option value="hu"<cfif cookie.rb eq "hu"> selected</cfif>>Hungarian</option>
						<option value="it"<cfif cookie.rb eq "it"> selected</cfif>>Italian</option>
						<!---<option value="no"<cfif cookie.rb eq "no"> selected</cfif>>Norwegian</option>--->
						<option value="pt"<cfif cookie.rb eq "pt"> selected</cfif>>Portuguese</option>
						<option value="es"<cfif cookie.rb eq "es"> selected</cfif>>Spanish</option>
						<!---<option value="es">Spanish</option>--->
					</select>
			  	</div>
			<cfelse>
				<div class="control-group">
				    <!---<label class="control-label">Language</label>--->
				    <div class="controls">
				      	<select name="rb">
							<option value="en">English</option>
							<option value="de"<cfif cookie.rb eq "de"> selected</cfif>>Deutsch</option>
							<option value="nl"<cfif cookie.rb eq "nl"> selected</cfif>>Dutch</option>
							<option value="fr"<cfif cookie.rb eq "fr"> selected</cfif>>Fran&ccedil;ais</option>
							<option value="hu"<cfif cookie.rb eq "hu"> selected</cfif>>Hungarian</option>
							<option value="it"<cfif cookie.rb eq "it"> selected</cfif>>Italian</option>
							<!---<option value="no"<cfif cookie.rb eq "no"> selected</cfif>>Norwegian</option>--->
							<option value="pt"<cfif cookie.rb eq "pt"> selected</cfif>>Portuguese</option>
							<option value="es"<cfif cookie.rb eq "es"> selected</cfif>>Spanish</option>
							<!---<option value="es">Spanish</option>--->
						</select>

						
						<div id="remember-me">
						      	<input type="checkbox" id="rememberMe" name="rememberMe" value="1" />
						     	<label for="rememberMe">#application.rbFactory.getKeyValue(session.rb,'login.rememberme')#
						      	</label>
						</div>
					</div>
				</div>
			</cfif>

			<div class="form-actions">
				<input type="submit" class="btn" value="#application.rbFactory.getKeyValue(session.rb,'login.login')#" />
			</div>

			<input name="returnUrl" type="hidden" value="#esapiEncode('html_attr',rc.returnURL)#">
			<input type="hidden" name="muraAction" value="cLogin.login">
			<input type="hidden" name="isAdminLogin" value="true">
			<input type="hidden" name="compactDisplay" value="#esapiEncode('html_attr',rc.compactDisplay)#">
			#rc.$.renderCSRFTokens(format='form')#
		</form>
		</div>
		<cfif not isBoolean(application.configBean.getValue('showadminloginhelp')) or application.configBean.getValue('showadminloginhelp')>
			<form novalidate="novalidate" class="span12" id="sendLogin" name="sendLogin" method="post" action="./?muraAction=cLogin.main" onsubmit="return submitForm(this);">
			
			<div class="control-group">
		      	<label class="control-label">
				#application.rbFactory.getKeyValue(session.rb,'login.forgetpassword')#
				</label>
		      	<div class="controls">
				<p class="help-block">
					<cfif rc.status eq 'sendLogin'>
					  <cfset msg=application.userManager.sendLoginByEmail('#rc.email#','','#esapiEncode("url","#listFirst(cgi.http_host,":")##cgi.SCRIPT_NAME#")#')>
					<cfif left(msg,2) eq "No">

					#esapiEncode('html',application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,"login.noaccountexists"),rc.email))#		
					<cfelseif left(msg,4) eq "Your">
					#esapiEncode('html',application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,"login.messagesent"),rc.email))#
					<cfelse>	#esapiEncode('html',application.rbFactory.getResourceBundle(session.rb).messageFormat(application.rbFactory.getKeyValue(session.rb,"login.invalidemail"),rc.email))#
					</cfif>
					<cfelse>
					#application.rbFactory.getKeyValue(session.rb,'login.enteremail')#
					</cfif>
				</p>
					<div class="input-prepend">
					  	<span class="add-on"><i class="icon-envelope"></i></span><input id="email" name="email" type="text" class="span11" placeholder="Email Address" />
					</div>
				</div>
			</div>
			<div class="form-actions">
			 	<input type="submit" class="btn" value="#application.rbFactory.getKeyValue(session.rb,'login.submit')#" />
			 </div>
			<input type="hidden" name="status" value="sendlogin" />
			<input name="returnURL" type="hidden" value="#esapiEncode('html_attr',rc.returnURL)#">
			<input type="hidden" name="isAdminLogin" value="true">
			<input type="hidden" name="compactDisplay" value="#esapiEncode('html_attr',rc.compactDisplay)#">
		   </form>
		</cfif>
	</cfif>
</cfif>
</cfoutput>

<cfif rc.compactDisplay eq "true">
<script type="text/javascript">
jQuery(document).ready(function(){
	if (top.location != self.location) {
		if(jQuery("#ProxyIFrame").length){
			jQuery("#ProxyIFrame").load(
				function(){
					frontEndProxy.post({cmd:'setWidth',width:400});
				}
			);	
		} else {
			frontEndProxy.post({cmd:'setWidth',width:400});
		}
	}
});
</script>
</cfif>