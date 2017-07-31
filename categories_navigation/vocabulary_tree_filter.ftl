<#assign currentCategoryId = "0" />
<#if request.getParameter("p_r_p_categoryId")??>
    <#assign currentCategoryId = request.getParameter("p_r_p_categoryId") />
</#if>

<#assign
    assetCategoryService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryService")
    currentCategory = assetCategoryService.getChildCategories(currentCategoryId?number)
    path = ""
/>

<@buildPath categoryId=currentCategoryId path=path/>

<#if entries?has_content>
	<@liferay_aui.row>
		<#list entries as entry>
			<@liferay_aui.col width=100>
				<div class="results-header">
					<h3>
						Your question is about?
					</h3>
				</div>

				<#assign categories = entry.getCategories() />

				<#list categories as category>
                    <#if category.isRootCategory()>
                        <#assign childCategories = assetCategoryService.getChildCategories(category.getCategoryId())/>                        
                        <#assign classCss = ""/>
                        
                        <#if currentCategoryId != "0">
                            <#assign classCss = "disabled"/>
                        </#if>  
                        
                        <#if path?contains(category.getCategoryId()?string)>
                                <#assign classCss = "active"/>
                        </#if>                       
                        
                        <a class="badge badge-primary category-navigation ${classCss}" data-question="${category.getCategoryId()?string}">
                            ${category.getName()}
                        </a>  

                    </#if>
                </#list>
                
                <#list categories as category>
                    <#if category.isRootCategory()>
                        <#assign
							assetCategoryService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryService")
							childCategories = assetCategoryService.getChildCategories(category.getCategoryId())
						/>
						<@displayCategories categories=childCategories parentId=category.getCategoryId() />
                    </#if>
                </#list>
			</@liferay_aui.col>
		</#list>
	</@liferay_aui.row>
</#if>

<#macro displayCategoryProperty	categoryId property>
    <#attempt>
        <#assign
            assetCategoryPropertyService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryPropertyLocalService")
            categoryProperties = assetCategoryPropertyService.getCategoryProperty(categoryId, property)
        />

        <h4> ${categoryProperties.value} </h4>     
        <#recover>
    </#attempt>
</#macro>

<#macro displayCategories categories parentId>

    <#assign classCss = "hidden"/>
    
    <#if path?contains(parentId?string)>
        <#assign classCss = "open"/>
    </#if>
    
	<#if categories?has_content>
		<div class="categories  ${classCss}" id="questions-${parentId}" >
        
            <@displayCategoryProperty categoryId=parentId property="en" />
			
            <#list categories as category>
				
                <#assign 
                    categoryURL = renderResponse.createRenderURL() 
                    assetCategoryService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryService")
                    childCategories = assetCategoryService.getChildCategories(category.getCategoryId())
                    classCss = ""
                />

                ${categoryURL.setParameter("resetCur", "true")}
                ${categoryURL.setParameter("categoryId", category.getCategoryId()?string)}
                        
                <#if currentCategoryId != "0">
                    <#assign classCss = "disabled"/>
                </#if> 
                
                <#if path?contains(category.getCategoryId()?string)>
                    <#assign classCss = "active"/>
                </#if>
                
                <#if childCategories?has_content>
                   <a class="badge badge-primary category-navigation ${classCss}"   data-question="${category.getCategoryId()?string}"> ${category.getName()} </a>
                <#else>
                    <a class="badge badge-primary category-navigation-end ${classCss}" href="${categoryURL}" data-question="${category.getCategoryId()?string}"> ${category.getName()} </a>
                </#if>
                
			</#list>
		</div>
        
        <#if serviceLocator??>
            <#list categories as category>
                <#assign
                    assetCategoryService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryService")
                    childCategories = assetCategoryService.getChildCategories(category.getCategoryId())
                />

                <@displayCategories categories=childCategories parentId=category.getCategoryId() />
            </#list>
        </#if>
	</#if>
</#macro>

<#macro buildPath categoryId path>
    <#if categoryId?number != 0>    
        <#assign
            assetCategoryService = serviceLocator.findService("com.liferay.asset.kernel.service.AssetCategoryService")                          
            path += "@" + categoryId + "@"        
            cat = assetCategoryService.getCategory(categoryId?number)
        />
        <@buildPath cat.getParentCategoryId() path/>
    </#if>
</#macro>

<script>

    $(document).ready(function(){

        $('a.category-navigation').each(function(){
            $(this).on('click', function(){
                $('#questions-' + $(this).data('question')).removeClass('hidden').slideDown(500);
                $(this).siblings().toggleClass('disabled').removeClass('active').each(function(){
                    $('#questions-' + $(this).data('question')).slideUp(500);
                });
                $(this).addClass('active').removeClass('disabled');
            })
        })
    });

</script>