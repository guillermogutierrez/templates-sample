<style>	
	.entry-layout{
		width: 100%;
	    height: 75%;
	    background-color: rgba(0,0,0,.35);
    	display: inline-block;
    	margin-top: 10em;
	}
	.entry-container{
	    margin: 0 auto;
	    max-width: 1280px;

	}
	.entry-title{
	    bottom: 0;
	    width: 100%;
	    height: 75%;
	}
	.entry-title h1{
		color: white;
	    font-size: 2.5em;
    	padding: .75em 0;	
	}
	.entry-title h1 a {
		color: white;
	}
	.entry-author{	 
	    color: white;
	    padding: 1em 0;
	    width: 30%;
	    border-bottom: solid 1px;
	    font-weight: bold;
	}
	.entry-description{	    
	    color: white;
	    padding: 1em 0 3em 0;
	    width: 30%;
	}
	.entry-categories{
	    bottom: 0;
	    height: 10%;
	    color: white;
	    padding: 1em 0;	
	}

	.entry-categories .taglib-asset-categories-summary{
		color: transparent;
	}

	.entry-categories .asset-category{
		border: solid 1px white;
    	padding: 0 .5em;
	}

	.entry-content a{
		color: white !important;
	}

</style>

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
		
		
		<div class="entry-content col-md-12 col-sm-12 col-xs-12" style="background-image: url(${entry.getAssetRenderer().getAssetObject().getCoverImageURL(themeDisplay)}); background-size: cover; margin-bottom: 5em; background-position-x: center;">
			<div class="entry-layout">
				<div class="entry-container">
					<div class="entry-title">
						<h1><a href="/c/blogs/find_entry?entryId=${entry.getAssetRenderer().getAssetObject().getEntryId()}">${htmlUtil.escape(entry.getTitle())}</a></h1>
					</div>

					<div class="entry-author ">
						<@liferay.language key="written-by" /> ${htmlUtil.escape(portalUtil.getUserName(entry.getUserId(), entry.getUserName()))} - Date
					</div>
					
					<div class="entry-description ">
						<#assign summary = entry.getDescription() />

						<#if validator.isNull(summary)>
							<#assign summary = entry.getAssetRenderer().getAssetObject().getContent() />
						</#if>

						${stringUtil.shorten(htmlUtil.stripHtml(summary), 250)}
					</div>

					<div class="entry-categories">
						<@getMetadataField fieldName="categories" />	
					</div>
				</div>
			</div>
		</div>
	</#list> 
</div>

<#macro getMetadataField fieldName >
	<#if stringUtil.split(metadataFields)?seq_contains(fieldName)>
		<span class="metadata-entry metadata-${fieldName}">
			<#assign dateFormat = "dd MMM yyyy - HH:mm:ss" />

			<#if fieldName == "author">
				<@liferay.language key="by" /> ${portalUtil.getUserName(assetRenderer.getUserId(), assetRenderer.getUserName())}
			<#elseif fieldName == "categories">
				<@liferay_ui["asset-categories-summary"]
					className=entry.getClassName()
					classPK=entry.getClassPK()
					portletURL=renderResponse.createRenderURL()
				/>
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
				<@liferay_ui["asset-tags-summary"]
					className=entry.getClassName()
					classPK=entry.getClassPK()
					portletURL=renderResponse.createRenderURL()
				/>
			<#elseif fieldName == "view-count">
				${entry.getViewCount()} <@liferay.language key="views" />
			</#if>
		</span>
	</#if>
</#macro>