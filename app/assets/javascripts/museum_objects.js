var ready;
ready = function() {
  $('.museum_object_page_button').click(function(event) {
    var id = event.target.id;
    $('.museum_object_page').not('.'+id).addClass('hidden');
    $('.'+id).removeClass('hidden');
  }); 
};

$(document).ready(ready);
$(document).on('page:load', ready);
