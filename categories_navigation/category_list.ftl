<#if entries?has_content>
	<#assign currentCategoryId = "0" />
	<#if request.getParameter("p_r_p___categoryId")??>
		<#assign currentCategoryId = request.getParameter("p_r_p___categoryId") />
	</#if>
	<div class="col">     
		<div class="list-group">      
			<div class="list-group-heading">Filter by category </div>     
		      
			<#assign categories = entry.getCategories() />      
			<@displayCategories categories=categories /> 
		</div>
	</div>
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
			
			<a href="${categoryURL}" class="list-group-item ${linkClass}">${category.getName()}</a> 
			
			<#if serviceLocator??>       
				<#assign assetCategoryService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryService") childCategories = assetCategoryService.getChildCategories(category.getCategoryId())       />        
				<@displayCategories categories=childCategories />      
			</#if>     
		</#list>   
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