// shows how to apply a controller-action combination
var ready;

ready = function() {
  var site_name = ".step_acquisition"; 
  if($(document.body).is(site_name)){
    step_acquisition_js();
  }
};

function set_acquisition_date_properties(disable) {
		$('#museum_object_acquisition_year').prop('disabled', disable);
		$('#museum_object_acquisition_month').prop('disabled', disable);
		$('#museum_object_acquisition_day').prop('disabled', disable);
	if(disable) {
		$('#museum_object_acquisition_year').val("");
		$('#museum_object_acquisition_month').val("");
		$('#museum_object_acquisition_day').val("");
	}
}


function step_acquisition_js() {
	checkbox = $('#museum_object_acquisition_date_unknown');
	checkbox_state = checkbox.is(':checked');
	$('#museum_object_acquisition_year').prop('disabled', checkbox_state);
	$('#museum_object_acquisition_month').prop('disabled', checkbox_state);
	$('#museum_object_acquisition_day').prop('disabled', checkbox_state);
	checkbox.change(function() {
		set_acquisition_date_properties($(this).is(':checked'));
	});
}

$(document).on('turbolinks:load', ready);
