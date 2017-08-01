<#if entries?has_content>
	<#assign currentCategoryId = "0" />
	<#if request.getParameter("p_r_p___categoryId")??>
		<#assign currentCategoryId = request.getParameter("p_r_p___categoryId") />
	</#if>
	<div class="row row-spacing" style="margin:.5em;padding: 0 1em 1em 1em;"> 
		<div class="col-md-12 col-xs-12" style="padding: 1em;">      
			Filter By Category
		</div>
		<div class="col-md-12 col-xs-12">     
			<#assign categories = entry.getCategories() />      
			<@displayCategories categories=categories /> 
		</div>
	</div>
</#if>  

<#macro displayCategories  categories >  
	<#if categories?has_content>   
		<#list categories as category>    	
			<div class="dropdown">
				<#assign categoryURL = renderResponse.createRenderURL() />       
				${categoryURL.setParameter("resetCur", "true")}      
				${categoryURL.setParameter("categoryId", category.getCategoryId()?string)} 
				
				<#assign linkClass=""/>
				
				<#if currentCategoryId  == category.getCategoryId()?string>
					<#assign linkClass="active"/>
				<#else>
					<#assign linkClass=""/>				
				</#if>  				
				
				<#if category.isRootCategory()>
					<button class="btn btn-default dropdown-toggle" data-toggle="dropdown" type="button">
						${category.getName()} <span class="icon-caret-down"></span>
					</button>
				</#if>
				
				<#if serviceLocator??>       
					<#assign assetCategoryService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryService") childCategories = assetCategoryService.getChildCategories(category.getCategoryId())       />        
					
					<@displayChildCategories categories=childCategories />      
				</#if>   
			</div>			
		</#list>   
	</#if> 
</#macro>

<#macro displayChildCategories  categories >  
	<#if categories?has_content>   	
		<ul class="dropdown-menu">
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
				<li>
					<a href="${categoryURL}" class="list-group-item ${linkClass}">${category.getName()}</a> 
				</li>				
			</#list>  
		</ul>		
	</#if> 
</#macro>


<style>
	a.list-group-item.active{
	    font-weight: bold;
	    background-color: #f7f7f7;
		cursor:normal;
	}
	.list-group-heading:after {
	    background-color: #777;
	}
</style>