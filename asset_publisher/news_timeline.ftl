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
	@media (min-width: 768px){
		.timeline-center .timeline-item {
	    	margin-left: 25%;
	    	width: 75%;
		}
	}
</style>

<div class="row row-spacing">
	<div class="col-md-12">
		<ul class="timeline timeline-center">
			<#list entries as entry>
				<#assign entry = entry />

				<#assign assetRenderer = entry.getAssetRenderer() />

				<#assign docXml = saxReaderUtil.read(entry.getAssetRenderer().getArticle().getContent()) />
				<#assign titleVal = docXml.valueOf("//dynamic-element[@name='NewsTitle']/dynamic-content[@language-id='en_US']/text()") />			
				<#assign summaryVal = docXml.valueOf("//dynamic-element[@name='Summary']/dynamic-content[@language-id='en_US']/text()") />	
				<#assign imageVal = docXml.valueOf("//dynamic-element[@name='RelatedImage']/dynamic-content[@language-id='en_US']/text()") />	

				<#assign entryTitle = htmlUtil.escape(assetRenderer.getTitle(locale)) />

				<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry) />

				<#if assetLinkBehavior != "showFullContent">
					<#assign viewURL = assetPublisherHelper.getAssetViewURL(renderRequest, renderResponse, entry, true) />
				</#if>
				<li class="timeline-item">
					<div aria-multiselectable="true" class="panel-group" id="accordionTimelineCenter${entry?index}" role="tablist">
						<div class="panel panel-default">
							<div class="panel-heading" id="headingTimelineCenter${entry?index}" role="tab">
								<div class="h3 panel-title">
									<a aria-controls="collapseOne" aria-expanded="false" class="collapsed" data-parent="#accordionTimelineCenter${entry?index}" data-toggle="collapse" href="#panelCollapseTimelineCenter${entry?index}" role="button">
										${titleVal}
									</a>
								</div>

								<div class="timeline-increment-icon">
									<div class="user-icon user-icon-danger">
										<img alt="thumbnail" src="${imageVal}" style="border-radius: 4px 0 0 4px;width: 90px; float:left;">
									</div>
								</div>

								<div class="timeline-increment-label">${assetRenderer.getDisplayDate()?date?string.long}</div>

							</div>
							<div aria-expanded="false" aria-labelledby="headingTimelineCenter${entry?index}" class="collapse panel-collapse" id="panelCollapseTimelineCenter${entry?index}" role="tabpanel">
								<div class="panel-body">
									<div class="col-md-12">
										<img alt="thumbnail" src="${imageVal}" style="border-radius: 4px; width: 10em; float: left; margin: 0em 1em 0 0;">
										${summaryVal}									
									</div>
									<div class="col-md-12">
										<a href="${viewURL}"> Read more </a>
									</div>
								</div>
							</div>
						</div>
					</div>
				</li>
			</#list>
		</ul>
	</div>
</div>
<#macro getDiscussion>
	<#if getterUtil.getBoolean(enableComments) && assetRenderer.isCommentable()>
		<br />

		<#assign discussionURL = renderResponse.createActionURL() />

		${discussionURL.setParameter("javax.portlet.action", "invokeTaglibDiscussion")}

		<@liferay_ui["discussion"]
			className=entry.getClassName()
			classPK=entry.getClassPK()
			formAction=discussionURL?string
			formName="fm" + entry.getClassPK()
			ratingsEnabled=getterUtil.getBoolean(enableCommentRatings)
			redirect=currentURL
			userId=assetRenderer.getUserId()
		/>
	</#if>
</#macro>

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

<#macro getFlagsIcon>
	<#if getterUtil.getBoolean(enableFlags)>
		<@liferay_flags["flags"]
			className=entry.getClassName()
			classPK=entry.getClassPK()
			contentTitle=entry.getTitle(locale)
			label=false
			reportedUserId=entry.getUserId()
		/>
	</#if>
</#macro>

<#macro getMetadataField fieldName>
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

		<@liferay_ui["icon"]
			iconCssClass="icon-print"
			message="print"
			url="javascript:Liferay.Util.openWindow({id:'" + renderResponse.getNamespace() + "printAsset', title: '" + languageUtil.format(locale, "print-x-x", ["hide-accessible", entryTitle], false) + "', uri: '" + htmlUtil.escapeURL(printURL.toString()) + "'});"
		/>
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

<#macro getRelatedAssets>
	<#if getterUtil.getBoolean(enableRelatedAssets)>
		<@liferay_ui["asset-links"]
			assetEntryId=entry.getEntryId()
		/>
	</#if>
</#macro>

<#macro getSocialBookmarks>
	<#if getterUtil.getBoolean(enableSocialBookmarks)>
		<@liferay_ui["social-bookmarks"]
			displayStyle="${socialBookmarksDisplayStyle}"
			target="_blank"
			title=entry.getTitle(locale)
			url=viewURL
		/>
	</#if>
</#macro>