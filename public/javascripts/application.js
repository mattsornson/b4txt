// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
	 
	$(document).ready(function() {
	    $('#mycarousel').jcarousel({
	        visible: 7,
			buttonNextHTML: null,
			buttonPrevHTML: null
	    });
	
	    $('#beerselector img').click(function() {
			$('#beerselector img').removeClass("selected");
			$(this).addClass("selected");
		});
	});
	 

