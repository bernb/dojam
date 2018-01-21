var ready;
ready = function() {
  // ToDo: More robust selector instead of double next()
  // ToDo: Generalize by using a general selector as shown below and then
  //       iterate all matching to get the wanted behaviour for all
  /*
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
  */
  var dating_period_checkbox = $('#optional_termlist_dating_period_checkbox');
  var dating_period_selection = dating_period_checkbox.next().next();
  dating_period_checkbox.change(function() {
    if(this.checked) {
      dating_period_selection.show();
    } else {
      dating_period_selection.hide();
    }
  });
  
  var dating_millennium_checkbox = $('#optional_termlist_dating_millennium_checkbox');
  var dating_millennium_selection = dating_millennium_checkbox.next().next();
  dating_millennium_checkbox.change(function() {
    if(this.checked) {
      dating_millennium_selection.show();
    } else {
      dating_millennium_selection.hide();
    }
  });
  
  
};


$(document).ready(ready);
$(document).on('page:load', ready);
