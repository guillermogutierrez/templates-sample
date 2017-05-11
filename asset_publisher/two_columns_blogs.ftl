
<style>

	.entry-content-col{
		background-size: cover; 
		display: inline-block;
		text-align: center;
		width: 100%;
	}

	.blog-content:after {
	    content: '';
	    display: block;
	    width: 0;
	    height: 0;
	    border-style: solid;
	    border-width: 15px 0 15px 15px;
	    border-color: transparent transparent transparent rgba(230,0,0,.8);
	    position: absolute;
	    top: 50%;
	    transform: translateY(-50%);
	    right: -.85em;
	    background-position: 50%;
	    z-index: 10;
	}

	.blog-content{
	    background-color: rgba(230,0,0,.8);	
	    padding: 1em .25em;
	}

	.entry-content-col a{
		color:white !important;
	}

	.entry-description-col, .entry-categories-col, .entry-author-col{
		font-size: .9em;
		color: white;
		padding-top: 1em;
	}

	.entry-categories-col{
		padding-top: 3em;
	}

	.entry-content-col .taglib-asset-categories-summary{
		color:transparent;    
		position: absolute;
	    left: -4em;
	    width: 100%;
	    overflow: hidden;
	    height: 1.35em;
	}

	.entry-content-col .taglib-asset-categories-summary a{
	    border: solid 1px white;
    	padding: 0em 1em;
	}

	.entry-author-col{
		padding-top: 2em;
	    font-weight: bold;
	    text-align: center;
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
		<#assign blogClass = "col-md-5 col-sm-5 col-xs-5" />
		<#assign oddCol = (entry?index % 2 == 0) />
		<#if oddCol>
			<#assign blogClass = "col-md-7 col-sm-7 col-xs-7" />
		</#if>
		
		<div class="${blogClass}">
			<div class="entry-content-col" style="background-image: url(${entry.getAssetRenderer().getAssetObject().getCoverImageURL(themeDisplay)}); ">
				<div class="col-md-4 col-sm-6 col-xs-8 blog-content">
					<div class="entry-title-col">
						<h3><a href="/c/blogs/find_entry?entryId=${entry.getAssetRenderer().getAssetObject().getEntryId()}">${htmlUtil.escape(entry.getTitle())}</a></h3>
					</div>
					<#if oddCol>
						<div class="entry-description-col">
							<#assign summary = entry.getDescription() />

							<#if validator.isNull(summary)>
								<#assign summary = entry.getAssetRenderer().getAssetObject().getContent() />
							</#if>

							${stringUtil.shorten(htmlUtil.stripHtml(summary), 100)}
						</div>
					</#if>

					<div class="entry-categories-col">
						<@getMetadataField fieldName="categories" />	
					</div>

					<div class="entry-author-col">
						<@getMetadataField fieldName="publish-date" />
					</div>
				</div>
			</div>
		</div>
	</#list> 
</div>

<#macro getMetadataField fieldName >
	<#if stringUtil.split(metadataFields)?seq_contains(fieldName)>
		<span class="metadata-entry metadata-${fieldName}">
			<#assign dateFormat = "dd MMMM yyyy" />

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