<style>
	span.score{
	    padding: 0.1em .5em;
	    border: solid 1px green;
	    background-color: green;
	    color: white;
	    border-radius: 20px;
    	margin: 0 2em 0 .25em;
	}
	.timeline-center .timeline-item {
	    margin-left: 20%;
	    width: 80%;
	}
	.right{
		text-align: right;
	}
</style>

<div class="row">
	<div class="col-md-12 right">
		<div class="col-md-4">
			<#if Logo.getData()?? && Logo.getData() != ""> 
				<div class="img-rounded img-container" style="float:left;">
					<img class="img-rounded" alt="${Logo.getAttribute("alt")}" src="${Logo.getData()}" style="height: 6em;" />
				</div>
			</#if>
		</div>
		<div class="col-md-8">
			<h4 class="mb-none" style="padding: .5em 0;">
				<span> Partnership status </span> <span class="score score-${Level.getData()}"> ${Status.getData()} </span> 
			</h4>			
			<h4 class="mb-none" style="padding: .5em 0;">
				<span> Partnership level </span> <span class="score score-${Level.getData()}"> ${Level.getData()} </span>
			</h4>
		</div>		
	</div>	
	<div class="col-md-12">
		<hr >
	</div>
</div>
<div class="row">
	<div class="col-md-12">
		<h5>${Description.getData()}</h5>
	</div>
	<div class="col-md-12">
		<hr >
	</div>
</div>