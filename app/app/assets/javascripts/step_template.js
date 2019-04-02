// shows how to apply a controller-action combination
var ready;

ready = function() {
  var site_name = ".step_X"; 
  if($(document.body).is(site_name)){
    step_X_js();
  }
};

function step_X_js() {
}

$(document).on('turbolinks:load', ready);
