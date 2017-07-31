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
        
        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />
        
        <#if assetLinkBehavior != "showFullContent">    
			<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />   
		</#if>   
        <div class="col-md-4 col-s-4 col-xs-6">
            <div class="" style="overflow: hidden;"> 
                <div class="" style="display: inline-block;width: 100%;text-align: center;margin: auto;float: left;">
                    <img alt="thumbnail" src="${imageVal}">
                </div>

                <div class="card-row card-row-padded card-row-valign-top">
                    <div class="card-col-content" style="height: 125px; text-align: center;">
                        <h3>
                            <a href="${viewURL}" > 
                                <@getFieldValue docXml "Topic" locale /> 
                            </a>  
                        </h3>
					    <p class="truncate-text">  
                            <@getFieldValue docXml "Summary" locale /> 
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </#list>  
</div>

<#macro getFieldValue docXml key language>
    <#assign param = docXml.valueOf("//dynamic-element[@name='${key}']/dynamic-content[@language-id='${language}']/text()") />    
    <#if !param?has_content >
        ${docXml.valueOf("//dynamic-element[@name='${key}']/dynamic-content/text()")}
    <#else>
         ${param}
    </#if>
</#macro>