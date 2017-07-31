<#if entries?has_content>
	<@liferay_util["html-top"]>
		<style>
			.breadcrumb-container{
				background-color: white !important;
			}
			.breadcrumb{							
				padding: 0;
				position: relative;
				max-width: 1280px;
				margin: 0 auto;
				background-color: white;
			}
			.breadcrumb-arrows a {
				background: white;
				display: inline-block;
				margin-right: 5px;
				padding: 10px;
				position: relative;
			}

			.breadcrumb-arrows a:after {
				content: "/";
                height: 0;
                position: absolute;
                top: .25em;
                width: 0;
                z-index: 2;
                font-weight: bold;
                font-size: 1.5em;
                margin-left: .25em;
			}

			.breadcrumb-arrows a:first-child {
				-moz-border-radius: 4px 0 0 4px;
				-webkit-border-radius: 4px 0 0 4px;
				border-radius: 4px 0 0 4px;
			}

			.breadcrumb-arrows a:last-child {
				-moz-border-radius: 0 4px 4px 0;
				-webkit-border-radius: 0 4px 4px 0;
				background: white;
			    border-radius: 0 4px 4px 0;
			    color: #666;
			    font-weight: bold;
			}
			
			.breadcrumb-arrows a:first-child:before, a:last-child:after {
			    border: none;
			    content: "";
			}
		</style>
	</@>
	<div class="breadcrumb-container">
		<div class="breadcrumb breadcrumb-arrows">
			<#list entries as entry>
				<a

				<#if entry.isBrowsable()>
					href="${entry.getURL()!""}"
				</#if>

				>${htmlUtil.escape(entry.getTitle())}</a>
			</#list>
		</div>
	</div>
</#if>