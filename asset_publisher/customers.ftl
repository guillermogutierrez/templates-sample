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
		<#assign nameVal = docXml.valueOf("//dynamic-element[@name='Company']/dynamic-content[@language-id='en_US']/text()") />   
		<#assign shortDescVal = docXml.valueOf("//dynamic-element[@name='Sector']/dynamic-content/text()") />   
        <#assign scoreVal = docXml.valueOf("//dynamic-element[@name='Score']/dynamic-content/text()") />   
		<#assign imageVal = docXml.valueOf("//dynamic-element[@name='Logo']/dynamic-content/text()") />    
		<#assign entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale)) />   
		<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />   
		
		<#if assetLinkBehavior != "showFullContent">    
			<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />   
		</#if>   
		<div class="col-md-3 col-sm-6 col-xs-12">     
			<div class="product-card card card-rounded">    
				<@liferay_ui["icon"] cssClass="icon-monospaced preview-icon" icon="link" markupView="lexicon"  message=nameVal  url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "view detail', title: '${nameVal}', uri:'" + htmlUtil.escapeURL(viewURL+"&p_p_state=pop_up") + "'});"    />    
				<@getEditIcon />          
				<div class="aspect-ratio aspect-ratio-16-to-9">  
					<img alt="thumbnail" src="${imageVal}"> 
					<div class="figcaption figcaption-middle">   
						<h3>      
							<a href="${viewURL}">${nameVal}</a>    
						</h3> 
                        
                        <span class="tag"> <span class="metadata-entry metadata-tags"> <span class="taglib-asset-tags-summary"> <a class="badge badge-default badge-sm">${scoreVal}</a> </span> </span> </span>
					</div>   
				</div>    
			</div>  
		</div> 
	</#list> 
</div>

<#macro getEditIcon> 
	<#if assetRenderer.hasEditPermission(themeDisplay.getPermissionChecker())>  
	<#assign redirectURL = renderResponse.createRenderURL() />  
	${redirectURL.setParameter("mvcPath", "/add_asset_redirect.jsp")}   
	${redirectURL.setWindowState("pop_up")}    <#assign editPortletURL = assetRenderer.getURLEdit(renderRequest, renderResponse, windowStateFactory.getWindowState("pop_up"), redirectURL)!"" />  
	<#if validator.isNotNull(editPortletURL)>    
	<#assign title = languageUtil.format(locale, "edit-x", entryTitle, false) />     
	<@liferay_ui["icon"]     cssClass="icon-monospaced visible-interaction demo-edit-pencil"     icon="pencil"     markupView="lexicon"     message=title     url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "editAsset', title: '" + title + "', uri:'" + htmlUtil.escapeURL(editPortletURL.toString()) + "'});"    />   
	</#if> 
	 </#if> 
</#macro>  