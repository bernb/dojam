// shows how to apply a controller-action combination
var ready;

ready = function() {
  var site_name = ".step_dating"; 
  if($(document.body).is(site_name)){
    step_dating_js();
  }
};

function set_dating_date_properties(disable) {
		$('#museum_object_dating_year').prop('disabled', disable);
		$('#museum_object_dating_month').prop('disabled', disable);
		$('#museum_object_dating_day').prop('disabled', disable);
	if(disable) {
		$('#museum_object_dating_year').val("");
		$('#museum_object_dating_month').val("");
		$('#museum_object_dating_day').val("");
	}
}

function dating_period_checkbox_logic() {
	period_checkbox = $('#museum_object_is_dating_period_unknown');
	period_checkbox_state = period_checkbox.is(':checked');
	$('#museum_object_dating_period_id').prop('disabled', period_checkbox_state);
	period_checkbox.change(function() {
		period_dropdown = $('#museum_object_dating_period_id');
		period_dropdown.val("");
		period_dropdown.prop('disabled', $(this).is(':checked'));
	});
}

function dating_century_checkbox_logic() {
	century_checkbox = $('#museum_object_is_dating_century_unknown');
	century_checkbox_state = century_checkbox.is(':checked');
	$('#museum_object_dating_century_begin_id').prop('disabled', century_checkbox_state);
	$('#museum_object_dating_century_end_id').prop('disabled', century_checkbox_state);
	century_checkbox.change(function() {
		century_dropdown_begin = $('#museum_object_dating_century_begin_id');
		century_dropdown_begin.val("");
		century_dropdown_begin.prop('disabled', $(this).is(':checked'));

		century_dropdown_end = $('#museum_object_dating_century_end_id');
		century_dropdown_end.val("");
		century_dropdown_end.prop('disabled', $(this).is(':checked'));
	});
}

function dating_millennium_checkbox_logic() {
	millennium_checkbox = $('#museum_object_is_dating_millennium_unknown');
	millennium_checkbox_state = millennium_checkbox.is(':checked');
	$('#museum_object_dating_millennium_begin_id').prop('disabled', millennium_checkbox_state);
	$('#museum_object_dating_millennium_end_id').prop('disabled', millennium_checkbox_state);
	millennium_checkbox.change(function() {
		millennium_dropdown_begin = $('#museum_object_dating_millennium_begin_id');
		millennium_dropdown_begin.val("");
		millennium_dropdown_begin.prop('disabled', $(this).is(':checked'));

		millennium_dropdown_end = $('#museum_object_dating_millennium_end_id');
		millennium_dropdown_end.val("");
		millennium_dropdown_end.prop('disabled', $(this).is(':checked'));
	});
}

function dating_timespan_checkbox_logic() {
	timespan_checkbox = $('#museum_object_is_dating_timespan_unknown');
	timespan_checkbox_state = timespan_checkbox.is(':checked');

	$('#museum_object_dating_timespan_begin').prop('disabled', timespan_checkbox_state);
	$('#museum_object_dating_timespan_end').prop('disabled', timespan_checkbox_state);
	$('#museum_object_is_dating_timespan_begin_BC').prop('disabled', timespan_checkbox_state);
	$('#museum_object_is_dating_timespan_end_BC').prop('disabled', timespan_checkbox_state);

	timespan_checkbox.change(function() {
		timespan_dropdown_begin = $('#museum_object_dating_timespan_begin');
		timespan_dropdown_begin.val("");
		timespan_dropdown_begin.prop('disabled', $(this).is(':checked'));

		timespan_dropdown_end = $('#museum_object_dating_timespan_end');
		timespan_dropdown_end.val("");
		timespan_dropdown_end.prop('disabled', $(this).is(':checked'));

		timespan_end_BC = $('#museum_object_is_dating_timespan_end_BC');
		timespan_end_BC.val("");
		timespan_end_BC.prop('disabled', $(this).is(':checked'));

		timespan_begin_BC = $('#museum_object_is_dating_timespan_begin_BC');
		timespan_begin_BC.val("");
		timespan_begin_BC.prop('disabled', $(this).is(':checked'));
	});
}

function step_dating_js() {
	dating_period_checkbox_logic();
	dating_millennium_checkbox_logic();
	dating_century_checkbox_logic();
	dating_timespan_checkbox_logic();
}

$(document).on('turbolinks:load', ready);
