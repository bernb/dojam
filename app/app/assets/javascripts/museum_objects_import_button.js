var ready;

ready = function() {
    let museum_objects_import_button_exists = $('#museum-objects-import-button').length;
    if (museum_objects_import_button_exists) {
        setInterval(wait_for_museum_objects_import_results, 500);
    }
};

function wait_for_museum_objects_import_results() {
    if ($('#museum-objects-import-button').hasClass('running')) {
        check_for_import_results();
    }
    if ($('#museum-objects-import-button').hasClass('completed')) {
        $('#museum-objects-import-button').hide();
        $('#museum-objects-import-button').removeClass('running');
        $('#museum-objects-show-import-button').show();
    }
}

function check_for_import_results() {
    $.ajax({
        type: 'GET',
        url: '/museum_objects/check_for_import_results',
        success: function (import_ready) {
            if (import_ready  == "true") {
                $('#museum-objects-import-button').removeClass('running');
                $('#museum-objects-import-button').addClass('completed');
            }
        }
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);