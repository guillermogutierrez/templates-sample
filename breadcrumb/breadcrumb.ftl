<#if entries?has_content> 
	<#assign currentPage = "" /> 
	<div class="breadcrumb-container">
		<div class="container-fluid-1280">
			<div class="row">
				<ul class="breadcrumb breadcrumb-modern">   
					<#list entries as entry>    
						<li>     
							<a  <#if entry.isBrowsable()>      href="${entry.getURL()!""}"     </#if>  >
								${htmlUtil.escape(entry.getTitle())}
							</a>    
						</li>  
						<#if ! entry?has_next> 
							<#assign currentPage = htmlUtil.escape(entry.getTitle()) /> 
						</#if>
					</#list>  
				</ul> 
			</div>
			<div class="row">
				<div class="col-md-12">
					<h1>${currentPage}</h1>
				</div>
			</div>
		</div>
	</div>
</#if>