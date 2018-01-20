var ready;
ready = function() {
  // ToDo: More robust selector instead of double next()
  var checkbox_selector = "[id^='optional_termlist'][id$='checkbox']";
  var optional_termlist_selector = $(checkbox_selector).next().next();
  $(optional_termlist_selector).hide();
  $(checkbox_selector).change(function() {
    if(this.checked) {
      $(optional_termlist_selector).show();
    } else {
      $(optional_termlist_selector).hide();
    }
});
  
};

$(document).ready(ready);
$(document).on('page:load', ready);
