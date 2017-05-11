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

<div class="row row-spacing">
	<#list entries as entry>
		<#assign entry = entry />

		<#assign assetRenderer = entry.getAssetRenderer() />
		<div class="col-md-6">
			<div class="card card-horizontal">
				<div class="card-row">
					<div class="card-col-field">
					<#assign hasPreview = assetRenderer.getThumbnailPath(renderRequest)?? />
						<#if hasPreview>
							<img alt="thumbnail" src="${assetRenderer.getThumbnailPath(renderRequest)}" style="width: 115px;">
						<#else>
							<svg class="lexicon-icon" style="width: 150px;height: 150px;padding: 1em;color: grey;margin-bottom: 2em;">
								<use xlink:href="/o/classic-theme/images/lexicon/icons.svg#documents-and-media" />
							</svg>
						</#if>
						<div class="sticker sticker-bottom" style="background-color:#303030;opacity:.75;">
							${stringUtil.shorten(stringUtil.upperCase(assetRenderer.getAssetObject().getExtension()), 3, "")}
						</div>
					</div>

					<div class="card-col-content card-col-gutters">
						<h4>${assetRenderer.getTitle(locale)}</h4>
						<p>${assetRenderer.getSummary(renderRequest, renderResponse)}</p>
						<div class="button-area" style="position: absolute;right: 1em;bottom: 1em;">
							<#if hasPreview>
								<button class="btn btn-info" data-target="#lexFullScreenModalIframe-${assetRenderer.getClassPK()}" data-toggle="modal">
									<svg class="lexicon-icon">
										<use xlink:href="/o/classic-theme/images/lexicon/icons.svg#documents-and-media" />
									</svg>							
									View Document
								</button>		
							<#else>
								<a class="btn btn-info" target="_blank" href="${assetRenderer.getURLDownload(themeDisplay)}" style="color: white;">
									<svg class="lexicon-icon">
										<use xlink:href="/o/classic-theme/images/lexicon/icons.svg#download" />
									</svg>
									Download Document
								</a>
							</#if>
						</div>
					</div>
				</div>
			</div>
		</div>
		
		<div aria-labelledby="lexFullScreenModalIframeLabel" class="fade modal" id="lexFullScreenModalIframe-${assetRenderer.getClassPK()}" role="dialog" tabindex="-1" style="display: none;">
			<div class="modal-dialog modal-full-screen modal-inverse">
				<div class="modal-content">
					<div class="modal-header">
						<button aria-labelledby="Close" class="btn btn-default close" data-dismiss="modal" role="button" type="button">
							<svg aria-hidden="true" class="lexicon-icon lexicon-icon-times" viewBox="0 0 512 512">								
								<use xlink:href="/o/classic-theme/images/lexicon/icons.svg#times" />
							</svg>
						</button>

						<button class="btn btn-default modal-primary-action-button visible-xs" type="button">
							<svg aria-hidden="true" class="lexicon-icon lexicon-icon-check" viewBox="0 0 512 512">
								<use xlink:href="/o/classic-theme/images/lexicon/icons.svg#check" />
							</svg>
						</button>

						<h4 class="modal-title" id="lexFullScreenModalIframeLabel">${assetRenderer.getTitle(locale)}</h4>
					</div>

					<div class="modal-body modal-body-iframe">
						<iframe src="${assetRenderer.getURLView(renderResponse,windowStateFactory.getWindowState("pop_up"))}"></iframe>
					</div>

					<div class="modal-footer">					
						<a class="btn btn-link" target="_blank" href="${assetRenderer.getURLDownload(themeDisplay)}" >
							<svg class="lexicon-icon">
								<use xlink:href="/o/classic-theme/images/lexicon/icons.svg#download" />
							</svg>
							Download Document
						</a>
						<a class="btn btn-link close-modal" data-dismiss="modal" href="#1" type="button">Close</a>
					</div>
				</div>
			</div>
		</div>
	</#list>
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