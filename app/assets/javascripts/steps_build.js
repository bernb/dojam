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
	undet_checkbox = $('.dojam-multi-select').find('label:contains(undetermined)').find('input');
	other_checkboxes = $('.dojam-multi-select').find('label').not('label:contains(undetermined)').find('input');
	other_checkboxes.on('change', set_correct_undet_state);
	undet_checkbox.on('change', keep_checked_if_last);
}

function keep_checked_if_last() {
	wrapper = $(this).closest('.dojam-multi-select');
	other_checkboxes = wrapper.find('label').not('label:contains(undetermined)').find('input');
	if(!other_checkboxes.is(':checked')) {
		$(this).prop('checked', true);
	}
}

function set_correct_undet_state() {
	wrapper = $(this).closest('.dojam-multi-select');
	undet_checkbox = wrapper.find('label:contains(undetermined)').find('input');
	other_checkboxes = wrapper.find('label').not('label:contains(undetermined)').find('input');
	if(this.checked) {
		undet_checkbox.prop('checked', false);
	} else {
		if (!other_checkboxes.is(':checked')) {
			undet_checkbox.prop('checked', true);
		}
	}
}


ready = function() {
  if($(document.body).is(site_name)){
  step_show_build_steps_js();
  }
};

$( document ).ajaxComplete(function() {
	});

$(document).on('turbolinks:load', ready);
