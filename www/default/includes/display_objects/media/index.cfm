<cfsilent>
	<cfparam name="objectparams.fileid" default="">
	<cfparam name="objectparams.size" default="medium">
	<cfparam name="objectparams.height" default="AUTO">
	<cfparam name="objectparams.width" default="AUTO">
</cfsilent>
<cfif len(objectparams.fileid)>
<cfoutput><img id="selectMedia" class="mura-center" src="#$.getURLForImage(argumentCollection=objectParams)#"/></cfoutput>
<cfelse>
<p>Select Image</p>
</cfif>
