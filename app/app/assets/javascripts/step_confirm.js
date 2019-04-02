var ready;

ready = function() {
  var site_name = ".step_confirm"; 
  if($(document.body).is(site_name)){
    step_confirm_js();
  }
};


function step_confirm_js() {
  $('.museum_object_page_button').click(function(event) {
    var id = event.target.id;
    $('.museum_object_page').not('.'+id).parent().addClass('hidden');
    $('.'+id).parent().removeClass('hidden');
  }); 
}


$(document).ready(ready);
$(document).on('page:load', ready);
