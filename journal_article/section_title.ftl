<div class="row">
	<div class="col-md-12">
		<h1>
			<#list SectionTitle.getData()?split(" ") as sValue>
				<#if sValue?has_next> 
			  		${sValue}
			  	<#else>
			  		<strong>${sValue}</strong>
			  	</#if>
			</#list>			
		</h1>
		<p class="small">
			${SectionSummary.getData()}
		</p>
	</div>
</div>