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
        <#assign entryTitle = docXml.valueOf("//dynamic-element[@name='Topic']/dynamic-content/text()") /> 
        <#assign abstract = docXml.valueOf("//dynamic-element[@name='Summary']/dynamic-content/text()") />
        <#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />
        
        <#if assetLinkBehavior != "showFullContent">    
			<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />   
		</#if>   
        
        <div class="col-md-6">
            <div class="card card-horizontal" >    
                <div class="card-row card-row-padded">
                    <div class="card-col-field">
                        <img alt="thumbnail" src="${imageVal}" style="width:50px;">
                    </div>
                    <div class="card-col-content card-col-gutters">
					   <h4>
                            <a href="${viewURL}" > 
                                <@getFieldValue docXml "Topic" locale /> 
                            </a>  
                        </h4>
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