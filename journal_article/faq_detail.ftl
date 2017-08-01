<div class="news-detail col-md-12"> 
	
	<div class="news-body">      
		${Answer.getData()}   
	</div>     
	<div class="management-bar management-bar-default management-bar-no-collapse">	
			<button class="btn btn-link" type="button">
				<a href="${MoreDetailsLink.getFriendlyUrl()}">
					Go to page...
				</a>
			</button>		
			<button class="btn btn-link" type="button">
				<a href="${RelatedDocument.getData()}"> 
					${languageUtil.format(locale, "download-x", "Related Document", false)}
					<svg class="lexicon-icon">
						<use xlink:href="/o/classic-theme/images/lexicon/icons.svg#documents-and-media" />
					</svg>	
				</a>						
			</button>
	</div>
</div>