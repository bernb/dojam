// shows how to apply a controller-action combination
var ready;
var site_name = ".builds"; 

function termlist_undetermined_handler() {
	var length = $(".termlist_select_input").children('option').length;
	var undetermined_option = $(".termlist_select_input option[value=nil]");
	if (length > 1 && undetermined_option.length == 0) { // i.e. not only blank entry present and undetermined option missing
	  $(".termlist_select_input").append(new Option("undetermined","nil"));
	}
}
function step_show_build_steps_js() {
	termlist_undetermined_handler();
}


ready = function() {
  if($(document.body).is(site_name)){
  step_show_build_steps_js();
  }
};

$( document ).ajaxComplete(function() {
	termlist_undetermined_handler();
	});

$(document).on('turbolinks:load', ready);
