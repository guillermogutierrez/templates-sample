<style>
	span.score{
	    float: right;
	    padding: 0.1em .5em;
	    border: solid 1px green;
	    background-color: green;
	    color: white;
	    border-radius: 20px;
	}
	.timeline-center .timeline-item {
	    margin-left: 20%;
	    width: 80%;
	}
</style>
<div class="row">
	
	<div class="col-md-12 center">
		<h1 class="mb-none">
			${Select8nvz.getData()} <span class="score score-${Score.getData()}"> ${Score.getData()} </span>
		</h1>		
	</div>	
	<div class="col-md-12">
		<hr >
	</div>
</div>

<div class="row">
	<div class="col-md-3">
		<h1 class="mb-none">
			<#if Logo.getData()?? && Logo.getData() != ""> 
				<div class="img-rounded img-container">
					<img class="img-rounded" alt="${Logo.getAttribute("alt")}" src="${Logo.getData()}" />
				</div>
			 </#if>
		</h1>
	</div>
	<div class="col-md-9">
		<h5>${Summary.getData()}</h5>
	</div>
	<div class="col-md-12">
		<hr >
	</div>
</div>

<div class="row">
	<div class="col-md-12">	
		<#if Log.getSiblings()?has_content> 		
			<ul class="timeline timeline-center">
				<#list Log.getSiblings()?reverse as cur_Log> 				
					<li class="timeline-item">	
						<div aria-multiselectable="true" class="panel-group" id="accordion" role="tablist">
							<div class="panel panel-default">
								<div class="panel-heading" id="headingOne" role="tab">
									
									<div class="h3 panel-title">
										<a aria-controls="collapseOne" aria-expanded="false" class="collapsed" data-parent="#accordionTimelineCenter${cur_Log?index}" data-toggle="collapse" href="#panelCollapseTimelineCenter${cur_Log?index}" role="button">
											${cur_Log.getData()} 
										</a>
									</div>

									<div class="timeline-increment-icon">
										<span class="timeline-icon"></span>
									</div>

									<div class="timeline-increment-label">
										${cur_Log.getChild("LogDate").getData()}
									</div>
								</div>

								<div aria-expanded="false" aria-labelledby="headingTimelineCenter${cur_Log?index}" class="collapse panel-collapse" id="panelCollapseTimelineCenter${cur_Log?index}" role="tabpanel">
									<div class="panel-body">
										${cur_Log.getChild("LogSummary").getData()}	
									</div>
								</div>
							</div>
						</div>
					</li>
				</#list> 
			</ul>
		</#if>
	</div>
</div>