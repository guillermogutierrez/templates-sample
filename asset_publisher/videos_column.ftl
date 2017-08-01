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
	   	<#assign videoName = docXml.valueOf("//dynamic-element[@name='VideoName']/dynamic-content/text()") />
	    <#assign videoSource = docXml.valueOf("//dynamic-element[@name='Source']/dynamic-content/text()") />
	    <#assign description = docXml.valueOf("//dynamic-element[@name='Description']/dynamic-content/text()") />
	    <#assign liferayVideoURL = docXml.valueOf("//dynamic-element[@name='LiferayVideo']/dynamic-content/text()") />
	    <#assign externalSourceVideoURL = docXml.valueOf("//dynamic-element[@name='ExternalSourceVideoURL']/dynamic-content/text()") />
	    
		<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />

		<#if assetLinkBehavior != "showFullContent">
			<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />
		</#if>

	    <div class="col-md-12">
	    	<div class="card card-nobox video">
	            <@getEditIcon />
		        <div class="card-row">
		            <div id="video-container-${assetRenderer.getClassPK()}">
		       			<@getVideoPlayer videoSource assetRenderer />
		      		</div>
		      		<div class="figcaption figcaption-middle figcaption-small"> 
		      			<h6>
		       				<a href="${viewURL}"> ${videoName} </a>
		       			</h6>
		      		</div>
		     	</div>
		    </div>
		</div>
	</#list>
</div>

<#macro getVideoPlayer  videoSource assetRenderer >
	<#if videoSource == "Liferay">
		<@liferay_aui.script use="aui-base,aui-video">
	  		new A.Video(     {      contentBox: '#video-container-${assetRenderer.getClassPK()}',      fixedAttributes: {       allowfullscreen: 'true',       bgColor: '#000000',       wmode: 'opaque'      },      url: '${liferayVideoURL}'     }    ).render();   </@liferay_aui.script>
	</#if>
	
	<#if videoSource == "Youtube">
		<iframe width="100%" height="100%" src="${externalSourceVideoURL}" frameborder="0"></iframe>
	</#if>

	<#if videoSource == "Vimeo">
		<iframe src="${externalSourceVideoURL}" width="100%" height="100%" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
	</#if>
</#macro>

<#macro getEditIcon> 
	<#if assetRenderer.hasEditPermission(themeDisplay.getPermissionChecker())>  
		<#assign redirectURL = renderResponse.createRenderURL() />  
		${redirectURL.setParameter("mvcPath", "/add_asset_redirect.jsp")}   
		${redirectURL.setWindowState("pop_up")}    <#assign editPortletURL = assetRenderer.getURLEdit(renderRequest, renderResponse, windowStateFactory.getWindowState("pop_up"), redirectURL)!"" />  
		<#if validator.isNotNull(editPortletURL)>    
			<#assign title = languageUtil.format(locale, "edit-x", entryTitle, false) />     
			<@liferay_ui["icon"] cssClass="icon-monospaced visible-interaction demo-edit-pencil" icon="pencil" markupView="lexicon" message=title     url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "editAsset', title: '" + title + "', uri:'" + htmlUtil.escapeURL(editPortletURL.toString()) + "'});"    />   
		</#if> 
 	</#if> 
</#macro>  

<#macro getFlagsIcon>  
	<#if getterUtil.getBoolean(enableFlags)>  
		<@liferay_flags["flags"] className=entry.getClassName() classPK=entry.getClassPK() contentTitle=entry.getTitle(locale) label=false reportedUserId=entry.getUserId()/> 
	</#if> 
</#macro> 

<#macro getMetadataField  fieldName > 
	<#if stringUtil.split(metadataFields)?seq_contains(fieldName)>   
		<span class="metadata-entry metadata-${fieldName}">  
			<#assign dateFormat = "dd MMM yyyy - HH:mm:ss" /> 
			<#if fieldName == "author">   
				<@liferay.language key="by" /> ${portalUtil.getUserName(assetRenderer.getUserId(), assetRenderer.getUserName())}   
			<#elseif fieldName == "categories">     
				<@liferay_ui["asset-categories-summary"] className=entry.getClassName() classPK=entry.getClassPK() portletURL=renderResponse.createRenderURL()/>  
			<#elseif fieldName == "create-date">   
				${dateUtil.getDate(entry.getCreateDate(), dateFormat, locale)}    
			<#elseif fieldName == "expiration-date">    
				${dateUtil.getDate(entry.getExpirationDate(), dateFormat, locale)}  
			<#elseif fieldName == "modified-date">   
				${dateUtil.getDate(entry.getModifiedDate(), dateFormat, locale)}   
		 	<#elseif fieldName == "priority"> 
		    	${entry.getPriority()}  
		   	<#elseif fieldName == "publish-date">   
		    	${dateUtil.getDate(entry.getPublishDate(), dateFormat, locale)} 
		    <#elseif fieldName == "tags">
		    	<@liferay_ui["asset-tags-summary"] className=entry.getClassName() classPK=entry.getClassPK() portletURL=renderResponse.createRenderURL() />  
		    <#elseif fieldName == "view-count">   
		    	${entry.getViewCount()} 
		        <@liferay.language key="views" />   
		    </#if>
	    </span> 
	</#if>
</#macro>  

<#macro getPrintIcon> 
	<#if getterUtil.getBoolean(enablePrint)>   
		<#assign printURL = renderResponse.createRenderURL() />   
	    ${printURL.setParameter("mvcPath", "/view_content.jsp")}   
	    ${printURL.setParameter("assetEntryId", entry.getEntryId()?string)}  
	    ${printURL.setParameter("viewMode", "print")}   
	    ${printURL.setParameter("type", entry.getAssetRendererFactory().getType())}    
	    <#if assetRenderer.getUrlTitle()?? && validator.isNotNull(assetRenderer.getUrlTitle())>  
			<#if assetRenderer.getGroupId() != themeDisplay.getScopeGroupId()>     
				${printURL.setParameter("groupId", assetRenderer.getGroupId()?string)}   
			</#if>   
			${printURL.setParameter("urlTitle", assetRenderer.getUrlTitle())}   
		</#if>   
		
		${printURL.setWindowState("pop_up")}  
		<@liferay_ui["icon"] iconCssClass="icon-print" message="print" url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "printAsset', title: '" + languageUtil.format(locale, "print-x-x", ["hide-accessible", entryTitle], false) + "', uri: '" + htmlUtil.escapeURL(printURL.toString()) + "'});" /> 
	</#if> 
</#macro> 

<#macro getRatings>  
	<#if getterUtil.getBoolean(enableRatings) && assetRenderer.isRatable()>  
		<div class="asset-ratings">   
			<@liferay_ui["ratings"]     className=entry.getClassName()     classPK=entry.getClassPK()    />  
		</div>  
	</#if> 
</#macro>  

<#macro getRelatedAssets> 
	<#if getterUtil.getBoolean(enableRelatedAssets)>   
		<@liferay_ui["asset-links"]    assetEntryId=entry.getEntryId()   />  
	</#if> 
</#macro> 

<#macro getSocialBookmarks>  
	<#if getterUtil.getBoolean(enableSocialBookmarks)>   
		<@liferay_ui["social-bookmarks"]    displayStyle="${socialBookmarksDisplayStyle}"    target="_blank"    title=entry.getTitle(locale)    url=viewURL   /> 
	</#if>
</#macro>