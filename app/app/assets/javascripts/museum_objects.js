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

	$(".search_form_fields").on("click", ".search_form_remove_field", function(event) {
		event.preventDefault();
		$(this).parent().remove();
	});

};

$(document).on('turbolinks:load', ready);
