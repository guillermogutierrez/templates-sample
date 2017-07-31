<div class="col-md-12">
    <div class="col-md-2">
    	<div class="aspect-ratio">
    		<#if Icon.getData()?? && Icon.getData() != "">
    	        <img alt="${Icon.getAttribute("alt")}" src="${Icon.getData()}" />
            </#if>
    	</div>
    </div>
    <div class="col-md-10">
		<h3>${Topic.getData()}</h3>
		<hr/>
		<p><em>${Description.getData()}</em></p>
	</div>
</div>