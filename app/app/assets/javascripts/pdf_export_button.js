var ready;

ready = function() {
    let pdf_export_button_exists = $('#pdf-export-button').length;
    if (pdf_export_button_exists) {
        setInterval(wait_for_new_pdf, 1500);
    }
};

function wait_for_new_pdf() {
    if ($('#pdf-export-button').hasClass('running')) {
        check_for_new_pdf();
    }
    if ($('#pdf-export-button').hasClass('completed')) {
        $('#pdf-export-button').hide();
        $('#pdf-export-button').removeClass('running');
        $('#pdf-export-download-button').show();
    }
}

function check_for_new_pdf() {
    $.ajax({
        type: 'GET',
        url: '/museum_objects/check_for_new_pdf',
        success: function (pdf_ready) {
            if (pdf_ready  == "true") {
                $('#pdf-export-button').removeClass('running');
                $('#pdf-export-button').addClass('completed');
            }
        }
    });
}

$(document).ready(ready);
$(document).on('page:load', ready);