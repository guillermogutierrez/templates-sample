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
        <#assign imageVal = docXml.valueOf("//dynamic-element[@name='Icon']/dynamic-content/text()") />
        <#assign entryTitle = docXml.valueOf("//dynamic-element[@name='Title']/dynamic-content/text()") /> 
        <#assign abstract = docXml.valueOf("//dynamic-element[@name='Abstract']/dynamic-content/text()") />
        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />
        
        <#if assetLinkBehavior != "showFullContent">    
			<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />   
		</#if>   
        
        <div class="col-md-4">
            <div class="card card-horizontal" >    
                <div class="card-row card-row-padded">
                    <div class="card-col-field">
                        <img alt="thumbnail" src="${imageVal}" style="width:75px;">
                    </div>
                    <div class="card-col-content card-col-gutters">
					   <h4 class="truncate-text"><a href="${viewURL}" >${entryTitle} </a></h4>
					   <p class="truncate-text">${abstract}</p>
				    </div>                   
                </div>                  
            </div>   
        </div>
    </#list>  
</div>