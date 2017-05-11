<#if Name.getSiblings()?has_content>
	<form name="registrationForm">
		<#list Name.getSiblings() as cur_Name>
		    <div class="row">
	    		<div class="form-group">
	    			<div class="col-md-12">	
						<label>${cur_Name.getData()}</label>
					</div>
					<#if cur_Name.getChild("Icon").getData()?? && cur_Name.getChild("Icon").getData() != ""> 
						<div class="col-md-2">
							<img class="img-rounded" alt="${cur_Name.getChild("Icon").getAttribute("alt")}" src="${cur_Name.getChild("Icon").getData()}" />
						</div>
						<div class="col-md-10">
					<#else>
						<div class="col-md-12">	
					</#if>	

				    <#if cur_Name.getChild("Type").getData() == "Text">
				    	<input class="form-control input-sm" type="text">							
				    </#if>

				    <#if cur_Name.getChild("Type").getData() == "Slider">
				    	<input type="range"  class="form-control input-sm" min="0" max="100" id="${cur_Name.getChild("Id").getData()}" value="0"/>
						<output name="ageOutputName" id='${cur_Name.getChild("Id").getData()}out'>0</output>
				    	<script>
				    		document.registrationForm.${cur_Name.getChild("Id").getData()}.oninput = function(){
						    	document.registrationForm.${cur_Name.getChild("Id").getData()}out.value = document.registrationForm.${cur_Name.getChild("Id").getData()}.value;
						 	}
				    	</script>				    	
				    </#if>

				    <#if cur_Name.getChild("Type").getData() == "Switch">
						<div class="btn-group btn-group-justified">
					    	<#list cur_Name.getChild("Values").getData()?string?split(";") as x>
								<div class="btn-group">
									<button class="btn btn-default" type="button">${x}</button>
								</div>
							</#list>
						</div>
				    </#if>
				    </div>
				</div>
			</div>
		</#list>
	</form>
</#if>