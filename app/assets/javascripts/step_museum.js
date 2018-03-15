// shows how to apply a controller-action combination
var ready;
var site_name = ".step_museum"; 


ready = function() {
  if($(document.body).is(site_name)){
    step_museum_js();
  }
};

function step_museum_js() {
  alert('works');
}

$(document).ready(ready);
$(document).on('page:load', ready);
