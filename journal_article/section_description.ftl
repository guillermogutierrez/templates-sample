<div class="row">
	<div class="col-md-12">
		<h1>
			<#list Name.getData()?split(" ") as sValue>
				<#if sValue?has_next> 
			  		${sValue}
			  	<#else>
			  		<strong>${sValue}</strong>
			  	</#if>
			</#list>	
			<#if getterUtil.getBoolean(Help.getData())>
			
				<a class="help-icon help-icon-default icon-question" href="#1" data-help-key="${Help.HelpKey.data}" data-toggle="popover" data-original-title="" title=""></a>
			</#if>		
		</h1>
		${Description.getData()}
	</div>
</div>