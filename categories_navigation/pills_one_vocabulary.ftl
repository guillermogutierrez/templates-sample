<style>
	.nav-pills > li {
	    float: left;
	    padding-bottom: 1em;
	}
</style>
<#if entries?has_content>
	<#assign currentCategoryId = "0" />
	<#if request.getParameter("p_r_p___categoryId")??>
		<#assign currentCategoryId = request.getParameter("p_r_p___categoryId") />
	</#if>
	<div class="row row-spacing"> 		
		<div class="col-md-12 col-xs-12"> 
			<ul class="nav-pills nav"> 
				<#assign categoryURL = renderResponse.createRenderURL() />    
				${categoryURL.setParameter("resetCur", "true")}      
				${categoryURL.setParameter("categoryId", "0")}    
				
				<#if currentCategoryId == "0">
					<#assign linkClass="active"/>
				<#else>
					<#assign linkClass=""/>				
				</#if>  				
						
				<li class="${linkClass}">
					<a href="${categoryURL}" class="list-group-item ${linkClass}"> All </a> 
				</li>		 
				<#assign categories = entry.getCategories() />   
				<@displayCategories categories=categories /> 
			</ul>
		</div>
	</div>
	<div class="row row-spacing divider">&nbsp;</div>
</#if>  

<#macro displayCategories  categories >  
	<#if categories?has_content>   
		<#list categories as category>    	
			<#assign categoryURL = renderResponse.createRenderURL() />       
			${categoryURL.setParameter("resetCur", "true")}      
			${categoryURL.setParameter("categoryId", category.getCategoryId()?string)} 
			
			<#assign linkClass=""/>
			
			<#if currentCategoryId  == category.getCategoryId()?string>
				<#assign linkClass="active"/>
			<#else>
				<#assign linkClass=""/>				
			</#if>  				
			
			<li class="${linkClass}">
				<a href="${categoryURL}" class="list-group-item ${linkClass}">${category.getName()}</a> 
			</li>			
		</#list>   
	</#if> 
</#macro>