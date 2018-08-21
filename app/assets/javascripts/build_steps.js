// shows how to apply a controller-action combination
var ready;
var site_name = ".builds"; 

function step_show_build_steps_js() {
}


ready = function() {
  if($(document.body).is(site_name)){
  step_show_build_steps_js();
  }
};

$( document ).ajaxComplete(function() {
	});

$(document).on('turbolinks:load', ready);
