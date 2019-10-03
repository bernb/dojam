var ready;
ready = function() {
  
  
  $("tr[data-link]").click(function() { // Used in search result table / index view
    window.location = $(this).data("link")
  });

	$(".form-search-add").click(function(event) {
		event.preventDefault();
		$.ajax({
			url: 'add_search_field',
			type: 'GET',
			dataType: 'script'
		});
	});

};

$(document).on('turbolinks:load', ready);
