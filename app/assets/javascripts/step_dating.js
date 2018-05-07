var ready;

ready = function() {
  var site_name = "step_dating";
  if($(document.body).hasClass(site_name)){
  step_dating_js();
  }
};

function step_dating_js() {
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
  var dating_period_selection = dating_period_checkbox.next().next().next();
  
  var dating_millennium_checkbox = $('#optional_termlist_dating_millennium_checkbox');
  var dating_millennium_selection = dating_millennium_checkbox.next().next().next();
  
  var dating_centuries_checkbox = $('#optional_termlist_dating_centuries_checkbox');
  var dating_centuries_selection = dating_centuries_checkbox.next().next().next();
  
  // Check initial state
  if(dating_period_checkbox.get(0).checked) {
    dating_period_selection.show();
  } else {
    dating_period_selection.hide();
    dating_period_selection.children().val("");
  }
  
  if(dating_millennium_checkbox.get(0).checked) {
    dating_millennium_selection.show();
  } else {
    dating_millennium_selection.hide();
    dating_millennium_selection.children().val("");
  }
  
  if(dating_centuries_checkbox.get(0).checked) {
    dating_centuries_selection.show();
  } else {
    dating_centuries_selection.hide();
    dating_centuries_selection.children().val("");
  }
  
  
  dating_period_checkbox.change(function() {
    if(this.checked) {
      dating_period_selection.show();
    } else {
      dating_period_selection.children().val("");
      dating_period_selection.hide();
    }
  });
  
  
  dating_millennium_checkbox.change(function() {
    if(this.checked) {
      dating_millennium_selection.show();
    } else {
      dating_millennium_selection.hide();
      dating_millennium_selection.children().val("");
    }
  });
  
  dating_centuries_checkbox.change(function() {
    if(this.checked) {
      dating_centuries_selection.show();
    } else {
      dating_centuries_selection.hide();
      dating_centuries_selection.children().val("");
    }
  });
  
  
} // end of site specific js function


$(document).ready(ready);
$(document).on('page:load', ready);