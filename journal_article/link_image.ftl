<div>
	<div class="card card-horizontal">
		<div class="card-row card-row-padded">
			<div class="card-col-field">
				<#if Icon.getData()?? && Icon.getData() != "">
					<img style="max-width: 3em;" class="icon-folder-close-alt sticker sticker-default sticker-static sticker-lg" alt="${Icon.getAttribute("alt")}" src="${Icon.getData()}" />
				<#else>
					<span class="icon-folder-close-alt sticker sticker-default sticker-static sticker-lg"></span>
				</#if>
			</div>
			<div class="card-col-content card-col-gutters">
				<a href="${URL.getData()}" target="${Select3n84.getData()}"><h4>${Name.getData()}</h4></a>
			</div>
		</div>
	</div>
</div>