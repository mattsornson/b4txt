// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
	 
	$(document).ready(function() {
	    $('#mycarousel').jcarousel({
	        visible: 7,
			buttonNextHTML: null,
			buttonPrevHTML: null
	    });
	
	    $('#beerselector li').click(function() {
			$('#beerselector li').children().removeClass("selected");
			$(this).children().addClass("selected");
			setBeerName($(this).attr('id'), $(this).attr('name'));
		});
		
		$('#beerselector li').hover(
			function() {
				$(this).children().addClass('hover');
			},
			function() {
				$(this).children().removeClass('hover');
			});
			
		$('.coming_soon[title]').tooltip(
			{
				position: "bottom center",
				effect: 'fade'
			}
		);
	});
	
	function setBeerName(id, name) {
		$('#beer_name').html(name);
		$('#brand').val(id);
	}
	 

