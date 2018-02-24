// shows how to apply a controller-action combination
var ready;
var site_name = ".builds .show"; 

ready = function() {
  if($(document.body).is(site_name)){
  site_specific_js();
  }
};


$(document).ready(ready);
$(document).on('page:load', ready);
