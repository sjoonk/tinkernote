// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults


// Unescape HTML entities
String.prototype.unescapeHtmlEntities = function () {
	try{
		var temp = document.createElement('textarea');
    temp.innerHTML = this;
    return temp.value;
	}catch(e){
		return this;
	}
}

$(document).ready(function() {
	// $.ajaxSetup({ data: { authenticity_token: encodeURIComponent(AUTH_TOKEN) }});
	$('.rounded').parent().css('background-color', '#fff').end().corner(); // http://www.methvin.com/jquery/jq-corner.html
});

$(function () {
	$("body#application").FBBorderLayout({
		spacing: 5,
		north_resizable: false,
		north_max_height: 57,
		east_resizable: false,
		east_width: 200,
		east_min_width:200,
		east_max_width:400,
		south_resizable: true,
		south_max_height: 100,
		west_resizable: false,
		west_width: 200,
		west_min_width:200,
		west_max_width:400
	});
});
