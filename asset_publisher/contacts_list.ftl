<#if !entries?has_content>  
	<#if !themeDisplay.isSignedIn()>   
		${renderRequest.setAttribute("PORTLET_CONFIGURATOR_VISIBILITY", true)} 
	</#if>  
	<div class="alert alert-info">   
		<@liferay_ui["message"]    key="there-are-no-results"   /> 
	</div>
</#if>  

<div class="row row-spacing">  
	<#list entries as entry>  
		<#assign entry = entry /> 
		<#assign assetRenderer = entry.getAssetRenderer() /> 
		<#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContent()) />   
		<#assign nameVal = docXml.valueOf("//dynamic-element[@name='FirstName']/dynamic-content/text()") />   
		<#assign lastNameVal = docXml.valueOf("//dynamic-element[@name='LastName']/dynamic-content/text()") />  
		<#assign emailVal = docXml.valueOf("//dynamic-element[@name='EmailAddress']/dynamic-content/text()") />    
		<#assign phoneVal = docXml.valueOf("//dynamic-element[@name='Phone']/dynamic-content/text()") />   
		<#assign entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale)) />  
		<#assign viewURL = docXml.valueOf("//dynamic-element[@name='URL']/dynamic-content/text()") />  
		
		<div class="col-md-12"> 
			<@getEditIcon /> 
			<div class="link-icon col-md-3" >
				<@liferay_ui["icon"] cssClass="icon-monospaced" icon="user" markupView="lexicon"/>
			</div>
			<div class="col-md-9" >
				<blockquote>
					<span>
						${nameVal} ${lastNameVal}
					</span>
					<span>
						<a href="mailto:${emailVal}">${emailVal}</a>
					</span>
					<span>
						<@liferay_ui["icon"] cssClass="icon-monospaced" icon="phone" markupView="lexicon"/>
						${phoneVal}
					</span>
				</blockquote>
			</div>
		</div> 
	</#list> 
</div>

<#macro getEditIcon> 
	<#if assetRenderer.hasEditPermission(themeDisplay.getPermissionChecker())>  
		<#assign redirectURL = renderResponse.createRenderURL() />  
		${redirectURL.setParameter("mvcPath", "/add_asset_redirect.jsp")}   
		${redirectURL.setWindowState("pop_up")}    
		<#assign editPortletURL = assetRenderer.getURLEdit(renderRequest, renderResponse, windowStateFactory.getWindowState("pop_up"), redirectURL)!"" />  
		<#if validator.isNotNull(editPortletURL)>    
			<#assign title = languageUtil.format(locale, "edit-x", entryTitle, false) />  
			<@liferay_ui["icon"] cssClass="icon-monospaced visible-interaction demo-edit-pencil" icon="pencil" markupView="lexicon"     message=title url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "editAsset', title: '" + title + "', uri:'" + htmlUtil.escapeURL(editPortletURL.toString()) + "'});"/>   
		</#if> 
	</#if> 
</#macro>