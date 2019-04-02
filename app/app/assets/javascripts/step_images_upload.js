var ready;

ready = function() {
  var site_name = "step_images_upload";
  if($(document.body).hasClass(site_name)){
  step_images_upload_js();
  }
};


function step_images_upload_js() {
  $('.custom-file-input').on('change', function() {
    let fileName = $(this).val().split('\\').pop();
    $(this).siblings('.custom-file-label').addClass("selected").html(fileName);
});


} // end of site specific js function


$(document).ready(ready);
$(document).on('page:load', ready);
