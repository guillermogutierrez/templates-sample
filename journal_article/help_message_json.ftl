<#if Key.getSiblings()?has_content>
    {
    	<#list Key.getSiblings() as cur_Key>
    		"${cur_Key.getData()}": { 
                "message" : "${cur_Key.Value.data}" , 
                "contents" : [
                    <#list cur_Key.RelatedContent.getSiblings() as cur_content> 
                        <#if cur_content.getData()?has_content>
                            "${cur_content.getData()?eval.classPK?number - 2}"
        
                            <#if cur_content?has_next> 
                                ,
                            </#if>
                        </#if>
                    </#list>
                ]
            }
    		<#if cur_Key?has_next> 
    		    ,
    	    </#if>
    	</#list>
    }
</#if>