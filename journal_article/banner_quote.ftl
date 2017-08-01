<div class="section-header" style="height:10em; background-image:url('${BkgImage.getData()}');background-size: cover;">
	<div >	
		<div class="section-title monospace">
			<h1 style="padding: .5em 1em;background-color: rgba(205,205,205,.25);width: auto;display: inline-block;margin: .75em 0;border-top-right-radius: 10px;border: solid 2px rgba(205,205,205,.5);border-bottom-right-radius: 10px;border-left: none;color:white;">
				${SectionTitle.getData()}	
			</h1>
		</div>
		<#if Quote.getData()?has_content> 	
			<blockquote class="blockquote-reverse blockquote-section" style="    background-color: rgba(205,205,205,.15);float: right;width: auto;display: inline-block;position: relative;right: 1em;width: 35%;bottom: 2em;color: #333;
}">
				<p>${Quote.getData()}</p>
				<#if Quote.getChild("Who")?has_content> 
					<small>
						${Quote.getChild("Who").getData()}
					</small>		
				</#if>
			</blockquote>
		</#if>
		<#if Description.getData()?has_content> 	
			<blockquote class="blockquote-reverse blockquote-section" style="background-color: rgba(205,205,205,.5);margin-right: 2em;">
				${Description.getData()}
			</blockquote>
		</#if>
	</div>
</div>