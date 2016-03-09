<!DOCTYPE html>
<html lang="en">
<head>
	
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	
	<title>::APP_TITLE::</title>
	
	<meta id="viewport" name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta name="apple-mobile-web-app-capable" content="yes">
	
	::if linkedLibraries::::foreach (linkedLibraries)::
	<script type="text/javascript" src="::__current__::"></script>::end::::end::
	<script type="text/javascript" src="./::APP_FILE::.js"></script>
	
	<script>
		window.addEventListener ("touchmove", function (event) { event.preventDefault (); }, false);
		if (typeof window.devicePixelRatio != 'undefined' && window.devicePixelRatio > 2) {
			var meta = document.getElementById ("viewport");
			meta.setAttribute ('content', 'width=device-width, initial-scale=' + (2 / window.devicePixelRatio) + ', user-scalable=no');
		}
	</script>
	
	<style>
		html,body { margin: 0; padding: 0; height: 100%; overflow: hidden; }
		#openfl-content { background: #000000; width: ::if (WIN_RESIZABLE)::100%::elseif (WIN_WIDTH > 0)::::WIN_WIDTH::px::else::100%::end::; height: ::if (WIN_RESIZABLE)::100%::elseif (WIN_WIDTH > 0)::::WIN_HEIGHT::px::else::100%::end::; }
		::foreach assets::::if (type == "font")::
		@font-face {
			font-family: '::fontName::';
			src: url('::targetPath::.eot');
			src: url('::targetPath::.eot?#iefix') format('embedded-opentype'),
			url('::targetPath::.svg#my-font-family') format('svg'),
			url('::targetPath::.woff') format('woff'),
			url('::targetPath::.ttf') format('truetype');
			font-weight: normal;
			font-style: normal;
		}::end::::end::
	</style>
	
</head>
<body>
	php
	<div id="openfl-content"></div>
	
	<script type="text/javascript">
		lime.embed ("openfl-content", ::WIN_WIDTH::, ::WIN_HEIGHT::, "::WIN_FLASHBACKGROUND::", "http://squirrel.editor.dev:3457/");
	</script>
	
</body>
</html>