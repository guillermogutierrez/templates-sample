<div class="news-detail">
	<div class="row">
	    <div class="col-md-12 center"> 
	        <h1 class="mb-none"> ${NewsTitle.getData()}</h1> 
	        <hr class="tall"> 
	    </div>
	</div>
	<div class="row">
		<div class="news-title serif col-md-12" >
	    	<em> Title ${Summary.getData()}</em>
		</div>
	</div>
	<div class="row">
	    <div class="news-image col-md-3">
	    	<img src="${RelatedImage.getData()}" class="img-rounded aspect-ratio-vertical img-responsive">
		</div>
	    <div class="news-body col-md-9">    
	    	${Body.getData()}     
	    </div>    
	</div>
 </div>