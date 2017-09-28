var ready;
ready = function() {
  $('.checkbox.material').removeAttr('checked'); 
  $('.checkbox.material').change(function () {
    var value = $(this).val();
    $('#'+value).toggleClass('hidden');
 });
};

$(document).ready(ready);
$(document).on('page:load', ready);
