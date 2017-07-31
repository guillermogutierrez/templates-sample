<#assign articleId=.vars['reserved-article-id'].data />

<div class="col-md-12">
    <div aria-multiselectable="true" class="panel-group" id="accordion" role="tablist">
        <div class="panel panel-default">
            <div class="panel-heading" id="headingOne" role="tab">
                <div class="panel-title">
                    <a  class="section-title" data-anchor="section-${articleId}" name="section-${articleId}" aria-controls="collapseOne" aria-expanded="false" data-toggle="collapse" data-parent="#accordion" href="#collapse${articleId}" role="button" class="collapsed">
                        ${SectionTitle.getData()}
                    </a>
                </div>
            </div>
            <div aria-labelledby="headingOne" class="panel-collapse collapse" id="collapse${articleId}" role="tabpanel" aria-expanded="false" style="height: 0px;">
                <div class="panel-body">
                    ${Section.getData()}	                    
                    <#if SectionDocuments.getSiblings()?has_content>
                        <#list SectionDocuments.getSiblings() as cur_SectionDocuments>

                            <div class="col-md-4">
                                <div class="card card-horizontal">
                                    <div class="card-row">
                                        <div class="card-col-field">                                    
                                            <svg class="lexicon-icon" style="width: 50px;height: 50px;padding: .5em;">
                                                <use xlink:href="/o/classic-theme/images/lexicon/icons.svg#documents-and-media" />
                                            </svg>
                                        </div>

                                        <div class="card-col-content card-col-gutters">
                                            <h4><a class="" target="_blank" href="${cur_SectionDocuments.getData()}" >
                                                    ${cur_SectionDocuments.name}
                                                    <svg class="lexicon-icon" style="float:right;">
                                                        <use xlink:href="/o/classic-theme/images/lexicon/icons.svg#download" />
                                                    </svg>
                                                </a>
                                            </h4>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </#list>
                    </#if>
                </div>                 
            </div>
        </div> 
    </div>
</div>