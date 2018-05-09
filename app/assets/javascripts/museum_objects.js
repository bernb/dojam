var ready;
ready = function() {
  
  
  $("tr[data-link]").click(function() { // Used in search result table / index view
    window.location = $(this).data("link")
  })
};

$(document).ready(ready);
$(document).on('page:load', ready);
