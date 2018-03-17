// shows how to apply a controller-action combination
var ready;

ready = function() {
  var site_name = ".step_museum"; 
  if($(document.body).is(site_name)){
    step_museum_js();
  }
};

function step_museum_js() {
  $('.storage_location_selection').prop('selectedIndex', 0);
  if($('.storage_selection').val() == "") {
    $('.storage_location_selection').prop('disabled', true);
  }
  $('.storage_selection').change(function() {
      if($('.storage_selection').val() == "") {
        $('.storage_location_selection').prop('disabled', true);
        $('.storage_location_selection').empty();
      } else {
        $('.storage_location_selection').prop('disabled', false);
      }
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);
