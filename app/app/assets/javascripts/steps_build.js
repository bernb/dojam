// shows how to apply a controller-action combination
var ready;
var site_name = ".builds"; 

function step_show_build_steps_js() {
	if($('.dojam-multi-select').length) {
		set_multi_select_event_handler();
	}
}
function set_multi_select_event_handler() {
	// Note that if more than one multi select is present,
	// event handler will use the correct selection group
    wrapper = $('.dojam-multi-select');
	undet_checkbox = get_undetermined_checkbox(wrapper);
	other_checkboxes = get_other_checkboxes(wrapper);
	other_checkboxes.on('change', set_correct_undet_state);
	undet_checkbox.on('change', keep_checked_if_last);
}

function keep_checked_if_last() {
	wrapper = $(this).closest('.dojam-multi-select');
	other_checkboxes = get_other_checkboxes(wrapper);
	if(!other_checkboxes.is(':checked')) {
		$(this).prop('checked', true);
	}
}

function set_correct_undet_state() {
	wrapper = $(this).closest('.dojam-multi-select');
	undet_checkbox = get_undetermined_checkbox(wrapper);
	other_checkboxes = get_other_checkboxes(wrapper);
	if(this.checked) {
		undet_checkbox.prop('checked', false);
	} else {
		if (!other_checkboxes.is(':checked')) {
			undet_checkbox.prop('checked', true);
		}
	}
}

function get_other_checkboxes(parent) {
    return parent.find('.checkbox').find('input').not(':last');
}

function get_undetermined_checkbox(parent) {
    return parent.find('.checkbox').last().find('input');
}


ready = function() {
  if($(document.body).is(site_name)){
  step_show_build_steps_js();
  }
};

$( document ).ajaxComplete(function() {
	});

$(document).on('turbolinks:load', ready);
