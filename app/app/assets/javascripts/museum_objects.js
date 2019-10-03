var ready;
ready = function() {
  
  
  $("tr[data-link]").click(function() { // Used in search result table / index view
    window.location = $(this).data("link")
  });

	$(".form-search-add").click(function(event) {
		event.preventDefault();
		var selected_term = $('#selected_term').val();
		$.ajax({
			url: 'add_search_field',
			type: 'GET',
			data: {selected_term: selected_term},
			dataType: 'script'
		});
	});

};

$(document).on('turbolinks:load', ready);
