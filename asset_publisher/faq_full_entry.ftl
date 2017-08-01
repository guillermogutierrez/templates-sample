<#if !entries?has_content>
	<#if !themeDisplay.isSignedIn()>
		${renderRequest.setAttribute("PORTLET_CONFIGURATOR_VISIBILITY", true)}
	</#if>

	<div class="alert alert-info">
		<@liferay_ui["message"]
			key="there-are-no-results"
		/>
	</div>
</#if>

<style>
	.demo-edit-pencil{
		right: 0px;
		position: absolute;
		z-index: 100;
		background-color: white;				
	}
</style>

<div class="row row-spacing" style="margin:.5em;">
	<#list entries as entry>
		<#assign entry = entry />

		<#assign assetRenderer = entry.getAssetRenderer() />

		<#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContent()) />
		<#assign nameVal = docXml.valueOf("//dynamic-element[@name='Question']/dynamic-content[@language-id='en_US']/text()") />			
		<#assign answerVal = docXml.valueOf("//dynamic-element[@name='Answer']/dynamic-content/text()") />	
		
		<#assign entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale)) />

		<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />

		<#if assetLinkBehavior != "showFullContent">
			<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />
		</#if>

		<@getEditIcon />

		<div aria-multiselectable="true" class="panel-group" id="accordion00" role="tablist">
			<div class="panel panel-default">
        		<div class="panel-heading" id="heading00" role="tab">
            		<div class="panel-title">

						 <a aria-controls="collapseOne" aria-expanded="true" data-toggle="collapse" data-parent="#accordion${entry?index}" href="#panelCollapse${entry?index}" role="button">
		                  	<@liferay_ui["icon"] cssClass="icon-monospaced " icon="mark-as-question" markupView="lexicon"/>   ${nameVal}
		                </a>		     
	            	</div>
	        	</div>
	        	<div aria-labelledby="heading00" class="panel-collapse collapse" id="panelCollapse${entry?index}" role="tabpanel">
            		<div class="panel-body">
						${answerVal}					
					</div>
					<div class="panel-ratings">           
						<@getRatings />
					</div>
					<div class="panel-body panel-discussions">					
						<@getDiscussion entry?index/>
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
		${redirectURL.setWindowState("pop_up")}

		<#assign editPortletURL = assetRenderer.getURLEdit(renderRequest, renderResponse, windowStateFactory.getWindowState("pop_up"), redirectURL)!"" />

		<#if validator.isNotNull(editPortletURL)>
			<#assign title = languageUtil.format(locale, "edit-x", entryTitle, false) />

			<@liferay_ui["icon"]
				cssClass="icon-monospaced visible-interaction demo-edit-pencil"
				icon="pencil"
				markupView="lexicon"
				message=title
				url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "editAsset', title: '" + title + "', uri:'" + htmlUtil.escapeURL(editPortletURL.toString()) + "'});"
			/>
		</#if>
	</#if>
</#macro>

<#macro getMetadataField
	fieldName
>
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

<#macro getDiscussion index>
	<#if getterUtil.getBoolean(enableComments) && assetRenderer.isCommentable()>
		<br />

		<#assign discussionURL = renderResponse.createActionURL() />

		${discussionURL.setParameter("javax.portlet.action", "invokeTaglibDiscussion")}
		<div aria-multiselectable="true" class="panel-group" id="accordion00" role="tablist">
			<div class="panel panel-default">
				<div class="panel-heading" id="heading00" role="tab">
		    		<div class="panel-title">
						 <a aria-controls="collapseOne" aria-expanded="true" data-toggle="collapse" data-parent="#accordion${index}" href="#panelCollapse-dicussions${index}" role="button">
		                  	View Comments
		                </a>		     
		        	</div>
		    	</div>
				<div aria-labelledby="heading00" class="panel-collapse collapse" id="panelCollapse-dicussions${index}" role="tabpanel">
		        	<div class="panel-body">
						<@liferay_ui["discussion"]
							className=entry.getClassName()
							classPK=entry.getClassPK()
							formAction=discussionURL?string
							formName="fm" + entry.getClassPK()
							ratingsEnabled=getterUtil.getBoolean(enableCommentRatings)
							redirect=currentURL
							userId=assetRenderer.getUserId()
						/>
					</div>
				</div>
			</div>
		</div>
	</#if>
</#macro>

<#macro getRatings>
	<#if getterUtil.getBoolean(enableRatings) && assetRenderer.isRatable()>
		<div class="asset-ratings">
			<@liferay_ui["ratings"]
				className=entry.getClassName()
				classPK=entry.getClassPK()
			/>
		</div>
	</#if>
</#macro>