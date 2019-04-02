var ready;

function get_kind_of_object_list() {
	$.ajax({
		url: "/builds/kind_of_objects_for_spec_material_path",
		type: "GET",
		data: {
			selected_material_specified_path_id: $('input[name=main_material_specified_path_dummy\\[main_material_specified_path_dummy\\]]:checked').val(),
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
 $('input[name=main_material_specified_path_dummy\\[main_material_specified_path_dummy\\]]').change(get_kind_of_object_list);
}

$(document).on('turbolinks:load', ready);
