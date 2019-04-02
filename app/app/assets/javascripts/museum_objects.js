var ready;
ready = function() {
  
  
  $("tr[data-link]").click(function() { // Used in search result table / index view
    window.location = $(this).data("link")
  })
};

$(document).on('turbolinks:load', ready);
