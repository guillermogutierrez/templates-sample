<div class="row">
    <div class="knowledge-entry">
        <div class="col-md-12">
            <div class="row header">
                <div class="col-md-12">
                    <h1>
                        ${Title.getData()}
                    </h1>
                    <p class="small">
                        <em> ${Abstract.getData()} </em>
                    </p>
                </div>
            </div>
            <div class="row body">
                <div class="col-md-12" >
                    ${Body.getData()}
                </div>

                <div class="sections">
                    <#if Sections.getSiblings()?has_content>
                        <#list Sections.getSiblings() as cur_Sections>
                            <#assign article = cur_Sections.getData()?eval /> 
                            <div class="section">
                                <@liferay_ui["asset-display"] className=article.className classPK=getterUtil.getLong( article.classPK, 0) template="full_content"/>
                            </div>
                        </#list>
                    </#if>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    var navMenu = $('#entry-nav-menu');
    $('a.section-title').each(function(){
        navMenu.append('<li><a aria-expanded="false"  href="#'+$(this).attr('data-anchor')+'">'+ $(this).text() +'</a>');
    });
</script>