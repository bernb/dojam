var ready;

ready = function() {
  var site_name = ".step_kind_of_object"; 
  if($(document.body).is(site_name)){
    step_kind_of_object_js();
  }
};

function step_kind_of_object_js() {
  $('input[name=museum_object\\[termlist_material_specified_id\\]]').change(function() {
    $.ajax({
      url: "/builds/kind_of_objects_for_spec_material",
      type: "GET",
      data: {selected_material_specified_id: $('input[name=museum_object\\[termlist_material_specified_id\\]]:checked').val()}
    });
  });
}

$(document).ready(ready);
$(document).on('page:load', ready);
