var ready;

ready = function() {
    if ($('#pdf-export-button').length) {
        window.setInterval(wait_for_new_pdf(), 500);
    }
};

function wait_for_new_pdf() {
    return function () {
        let is_finished;
        if ($('#pdf-export-button').hasClass('running')) {
            is_finished = check_for_new_pdf();
            if (is_finished) {

            }
        }
    };
}

function check_for_new_pdf() {
    $.ajax({
        type: 'GET',
        url: '/museum_objects/check_for_new_pdf',
        success: function (pdf_ready) {
            if (pdf_ready  == "true") {
                return true
            } else {
                return false
            }
        }
    });
}