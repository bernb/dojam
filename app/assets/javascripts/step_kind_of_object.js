var ready;

function get_kind_of_object_list() {
	$.ajax({
		url: "/builds/kind_of_objects_for_spec_material",
		type: "GET",
		data: {
			selected_material_specified_id: $('input[name=museum_object\\[termlist_material_specified_id\\]]:checked').val(),
			museum_object_id: window.location.href.split('/')[4]
		}
	});
}

ready = function() {
  var site_name = ".step_kind_of_object"; 
  if($(document.body).is(site_name)){
    step_kind_of_object_js();
  }
};

function step_kind_of_object_js() {
	get_kind_of_object_list();
  $('input[name=museum_object\\[termlist_material_specified_id\\]]').change(get_kind_of_object_list());
}

$(document).on('turbolinks:load', ready);
