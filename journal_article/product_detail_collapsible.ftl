<div class="row">
	<div class="col-md-12 center">
		<h1 class="mb-none">${Name.getData()}</h1>
		<hr class="tall">
	</div>
</div>

<div class="row">
	<div class="col-md-3">
		<#if SmallImage.getData()?? && SmallImage.getData() != ""> 
			<div class="img-rounded img-container">
				<img class="img-rounded" alt="${SmallImage.getAttribute("alt")}" src="${SmallImage.getData()}" />
			</div>
		 </#if>
	</div>

	<div class="col-md-9">
		<h5>${ShortDescription.getData()}</h5>
		<p>${Description.getData()}</p>
	</div>
	<div class="col-md-12">
		<hr >
	</div>
</div>

<div class="row">
	<div class="col-md-12">
		<#if Section.getSiblings()?has_content> 
			<div aria-multiselectable="true" class="panel-group" id="accordion" role="tablist">
				<#list Section.getSiblings() as cur_Section> 
					<div class="panel panel-default">
						<div class="panel-heading" id="headingOne" role="tab">
							<div class="panel-title">
								<a aria-controls="collapseOne" aria-expanded="false" data-toggle="collapse" data-parent="#accordion" href="#collapse${cur_Section?index}" role="button" class="collapsed">
									${cur_Section.getData()} 
								</a>
							</div>
						</div>
						<div aria-labelledby="headingOne" class="panel-collapse collapse" id="collapse${cur_Section?index}" role="tabpanel" aria-expanded="false" style="height: 0px;">
							<div class="panel-body">
								${cur_Section.getChild("SectionBody").getData()}								
							</div>
						</div>
					</div>
				</#list> 
			</div>
		</#if>
	</div>
</div>