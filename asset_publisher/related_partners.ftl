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
        <#assign imageVal = docXml.valueOf("//dynamic-element[@name='Logo']/dynamic-content/text()") />
        <#assign entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale)) />
        <#assign viewURL = docXml.valueOf("//dynamic-element[@name='URL']/dynamic-content/text()") />
        <div class="col-md-12">
            <div class="link-icon col-md-12" >    
                <div class="img-rounded img-container">
                    <a href="${currentURL}/${viewURL}" > <img alt="thumbnail" src="${imageVal}">  </a>                       
                </div>                  
            </div>   
        </div>  
    </#list>  
</div>    