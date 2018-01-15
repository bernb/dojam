var ready;
ready = function() {
  $('#museum_object_acquisition_date_2i').hide();
  $('#museum_object_acquisition_date_3i').hide();
  $("#museum_object_is_acquisition_date_exact").change(function() {
    if(this.checked) {
      $('#museum_object_acquisition_date_2i').show();
      $('#museum_object_acquisition_date_3i').show();
    } else {
      $('#museum_object_acquisition_date_2i').hide();
      $('#museum_object_acquisition_date_3i').hide();
    }
});
};

$(document).ready(ready);
$(document).on('page:load', ready);
