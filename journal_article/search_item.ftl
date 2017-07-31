<div class="row" style="padding-top: 3em;padding-bottom: 3em;"> 
	<div class="col-md-12"> 
		<h1 class="center monospace" style="font-size:4em;"> 
			${Name.getData()} 
		</h1> 
	</div>
</div> 

<div class="row" style="padding-top: 0em;padding-bottom: 3em;"> 
	<div class="col-md-12"> 
		<div aria-expanded="false" class="collapse navbar-collapse" id="navigationCollapse"> 
			<form action="http://localhost:8380/web/knowledge-dxp/home?p_p_id=com_liferay_portal_search_web_portlet_SearchPortlet&amp;p_p_lifecycle=0&amp;p_p_state=maximized&amp;p_p_mode=view&amp;_com_liferay_portal_search_web_portlet_SearchPortlet_mvcPath=%2Fsearch.jsp&amp;_com_liferay_portal_search_web_portlet_SearchPortlet_redirect=http%3A%2F%2Flocalhost%3A8380%2Fweb%2Fknowledge-dxp%2Fhome%3Fp_p_id%3Dcom_liferay_portal_search_web_portlet_SearchPortlet%26p_p_lifecycle%3D0%26p_p_state%3Dnormal%26p_p_mode%3Dview" class="form " data-fm-namespace="_com_liferay_portal_search_web_portlet_SearchPortlet_" id="_com_liferay_portal_search_web_portlet_SearchPortlet_fm" method="get" name="_com_liferay_portal_search_web_portlet_SearchPortlet_fm"> 
				<fieldset class="input-container"> 
					<input class="field form-control" id="_com_liferay_portal_search_web_portlet_SearchPortlet_formDate" name="_com_liferay_portal_search_web_portlet_SearchPortlet_formDate" type="hidden" value="1498204183511"> 
					<input name="p_p_id" type="hidden" value="com_liferay_portal_search_web_portlet_SearchPortlet"> 
					<input name="p_p_lifecycle" type="hidden" value="0">
					<input name="p_p_state" type="hidden" value="maximized"> 
					<input name="p_p_mode" type="hidden" value="view"> 
					<input name="_com_liferay_portal_search_web_portlet_SearchPortlet_mvcPath" type="hidden" value="/search.jsp"> 
					<input name="_com_liferay_portal_search_web_portlet_SearchPortlet_redirect" type="hidden" value="http://localhost:8380/web/knowledge-dxp/home?p_p_id=com_liferay_portal_search_web_portlet_SearchPortlet&amp;p_p_lifecycle=0&amp;p_p_state=normal&amp;p_p_mode=view"> 
					<fieldset class="fieldset "> 
						<div class=""> 
							<div class="form-group form-group-inline input-text-wrapper" style="width:100%;">
								<input style="padding-right: 3em;box-sizing: border-box;float: left;height: 2em;font-size: 2em;" class="field search-input form-control" id="_com_liferay_portal_search_web_portlet_SearchPortlet_keywords" name="_com_liferay_portal_search_web_portlet_SearchPortlet_keywords" placeholder="Search the knowledge base..." title="Search" type="text" value="" size="30"> 
								<span class="icon-monospaced" style="float: left;position: absolute;right: 2em;top: .5em;"> 
									<a href="javascript:;" target="_self" class=" lfr-icon-item taglib-icon" id="_com_liferay_portal_search_web_portlet_SearchPortlet_bhfa__null__null" onclick="_com_liferay_portal_search_web_portlet_SearchPortlet_search();"> 
										<span class="" id=""> 
											<svg class="lexicon-icon lexicon-icon-search" role="img" title="" viewBox="0 0 512 512" style="height: 3em;width: 3em;"> 
												<path class="lexicon-icon-outline" d="M503.254 467.861l-133.645-133.645c27.671-35.13 44.344-79.327 44.344-127.415 0-113.784-92.578-206.362-206.362-206.362s-206.362 92.578-206.362 206.362 92.578 206.362 206.362 206.362c47.268 0 90.735-16.146 125.572-42.969l133.851 133.851c5.002 5.002 11.554 7.488 18.106 7.488s13.104-2.486 18.106-7.488c10.004-10.003 10.004-26.209 0.029-36.183zM52.446 206.801c0-85.558 69.616-155.173 155.173-155.173s155.174 69.616 155.174 155.173-69.616 155.173-155.173 155.173-155.173-69.616-155.173-155.173z">
												</path>
											</svg> 
										</span> 
										<span class="taglib-text hide-accessible"></span> 
									</a> 
								</span> 
							</div> 
							<input class="field form-control" id="_com_liferay_portal_search_web_portlet_SearchPortlet_scope" name="_com_liferay_portal_search_web_portlet_SearchPortlet_scope" type="hidden" value="this-site"> 
						</div> 
					</fieldset> 
				</fieldset> 
			</form> 
		</div> 
	</div> 
</div>

<script>
	function _com_liferay_portal_search_web_portlet_SearchPortlet_search() {
		var keywords = document._com_liferay_portal_search_web_portlet_SearchPortlet_fm._com_liferay_portal_search_web_portlet_SearchPortlet_keywords.value;

		keywords = keywords.replace(/^\s+|\s+$/, '');

		if (keywords != '') {
			submitForm(document._com_liferay_portal_search_web_portlet_SearchPortlet_fm);
		}
	}
</script>