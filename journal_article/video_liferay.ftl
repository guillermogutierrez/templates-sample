<div> ${VideoName.getData()} ${Description.getData()} <a href="${LiferayVideo.getData()}">  ${languageUtil.format(locale, "download-x", "Liferay Video", false)} </a> ${LiferayVideo.getClass()} <div id="videoDetaildemo"/> </div>  <@liferay_aui.script use="aui-base,aui-video">  new A.Video(   {    contentBox: '#videoDetaildemo',    fixedAttributes: {     allowfullscreen: 'true',     bgColor: '#000000',     wmode: 'opaque'    },    url: '${LiferayVideo.getData()}'   }  ).render(); </@liferay_aui.script>