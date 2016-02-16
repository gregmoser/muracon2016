﻿CKEDITOR.plugins.add( 'muratag',
{
	requires : [ 'dialog' ],
	init : function( editor )
	{
		var pluginName = 'muratag';
		
		// Create the toolbar button		
		editor.ui.addButton( pluginName,
			{
				label : 'Insert Mura Tag',
				command : pluginName,
				icon: this.path + 'btn_muratag.png'
			});
				
		
		// Create the dialog
		CKEDITOR.dialog.add( pluginName, function()
		{
						
			return {
				title : 'Insert Mura Tag',
				minWidth : 400,
				minHeight : 300,
				buttons : [ CKEDITOR.dialog.cancelButton, CKEDITOR.dialog.okButton ],
				contents :
				[
					{
						id : 'include',
						label : 'dspInclude',
						elements :
						[
							{
								type: 'html',
								html: '<h2 style="font-weight:bold;font-size:1.2em;">dspInclude</h2><p style="white-space:normal;width:390px;margin:1em 0 1.5em;">Allows you to include any .CFM file. Path is relative to your <strong>/{SiteID}/includes/</strong> directory.</p>'
							},
							{
								id: 'includePath',
								type: 'text',
								label: 'Relative path to file to be included'
							}							
						]
					},
					{
						id : 'themeInclude',
						label : 'dspThemeInclude',
						elements :
						[
							{
								type: 'html',
								html: '<h2 style="font-weight:bold;font-size:1.2em;">dspThemeInclude</h2><p style="white-space:normal;width:390px;margin:1em 0 1.5em;">Allows you to include any .CFM file. Path is relative to your <strong>/{SiteID}/includes/themes/{ThemeName}/</strong> directory.</p>'
							},
							{
								id: 'themeIncludePath',
								type: 'text',
								label: 'Relative path to file to be included'
							}							
						]
					},
					{
						id : 'object',
						label : 'dspObject',
						elements :
						[
							{
								type: 'html',
								html: '<h2 style="font-weight:bold;font-size:1.2em;">dspObject</h2><p style="white-space:normal;width:390px;margin:1em 0 1.5em;">Include a content object in your page by specifying the content type (e.g. feed, component) and Title or ID (ID can be found on the Advanced tab). By also specifying the SiteID, you can include content from another site.</p>'
							},
							{
								id: 'objectType',
								type: 'text',
								label: 'Type of object'
							},
							{
								id: 'objectId',
								type: 'text',
								label: 'Content ID of the object'
							},
							{
								id: 'objectSite',
								type: 'text',
								label: 'SiteID (optional - only required if not the current site)'
							}							
						]
					},
					{
						id : 'manual',
						label : 'Custom',
						elements :
						[
							{
								type: 'html',
								html: '<h2 style="font-weight:bold;font-size:1.2em;">Custom Function or Variable</h2><p style="white-space:normal;width:390px;margin:1em 0 1.5em;">Allows you to specify a custom function or variable for the Mura tag. For example, the CFML function <strong>Now()</strong> would output a current datetimestamp. Also use it to call custom methods from your contentRenderer.cfc such as <strong>$.yourMethod()</strong>.</p>'
							},
							{
								id: 'manualTagContent',
								type: 'text',
								label: 'Enter the content of the Mura tag'
							}
						]
					}
				],
				
				onOk : function()
				{
					var editor = this.getParentEditor(),
						selection = editor.getSelection(),
						ranges = selection.getRanges( true ),
						tagContent;
						
					if (this.getContentElement('include', 'includePath').isVisible())
					{
						var includePath = this.getValueOf( 'include', 'includePath' );
						
						if (!includePath.length)
						{
							alert('File path is required!');
							return false;
						}
						
						tagContent = "$.dspInclude('" + includePath + "')";
					}
					else if (this.getContentElement('themeInclude', 'themeIncludePath').isVisible())
					{
						var themeIncludePath = this.getValueOf( 'themeInclude', 'themeIncludePath' );
						
						if (!themeIncludePath.length)
						{
							alert('File path is required!');
							return false;
						}
						
						tagContent = "$.dspThemeInclude('" + themeIncludePath + "')";
					}
					else if (this.getContentElement('object', 'objectType').isVisible())
					{
						var objectType = this.getValueOf( 'object', 'objectType' ),
							contentId = this.getValueOf( 'object', 'objectId' ),
							siteId = this.getValueOf( 'object', 'objectSite' );
						
						if (!(objectType.length && contentId.length))
						{
							alert('Object type and content ID are both required!');
							return false;
						}
						
						tagContent = "$.dspObject('" + objectType + "', '" + contentId;
						if (siteId.length) tagContent += "', '" + siteId;
						tagContent += "')";
					}
					else
					{
						var manualTagContent = this.getValueOf( 'manual', 'manualTagContent' );
						
						if (!manualTagContent.length)
						{
							alert('Mura tag content is required!');
							return false;
						}
						
						tagContent = manualTagContent;
					}
					
					
					// Insert Mura Tag into editor
					if ( ranges.length == 1 && ranges[0].collapsed )
					{
						var textNode = new CKEDITOR.dom.text( '[m]'+tagContent+'[/m]', editor.document );
						ranges[0].deleteContents();
						ranges[0].insertNode( textNode );
						selection.selectRanges( ranges );
					}
				}
			};
			
		} );
		
		
		// Register the command
		editor.addCommand( pluginName, new CKEDITOR.dialogCommand( pluginName ) );
	
	}
} );
