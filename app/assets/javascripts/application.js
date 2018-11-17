// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap/dist/js/bootstrap
//= require datatables.net/js/jquery.dataTables
//= require datatables.net-bs4/js/dataTables.bootstrap4
//= require datatables.net-responsive/js/dataTables.responsive
//= require datatables.net-responsive-bs4/js/responsive.bootstrap4
//= require flatpickr/dist/flatpickr
//= require flatpickr/dist/l10n/pt
//= require jquery-mask-plugin/dist/jquery.mask
//= require select2/dist/js/select2
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery_nested_form
//= require_tree .

var ready = function() {
    confirm_modal();
    fields_masks();
    $(".add_nested_fields").on('click', function () {
        setTimeout(function(){
            fields_masks();
        }, 200);
    });
};

function confirm_modal() {
    $('a[data-confirm]').click(function (ev) {
        var href = $(this).attr('href');
        var method = $(this).data('method');
        if (!$('#dataConfirmModal').length) {
            $('body').append('<div id="dataConfirmModal" class="modal fade bs-example-modal-sm" tabindex="-1" role="dialog" aria-labelledby="dataConfirmLabel"><div class="modal-dialog modal-sm"><div class="modal-content"><div class="modal-body"><b></b></div><div class="modal-footer"><button class="btn" data-dismiss="modal" aria-hidden="true">Não</button><a class="btn btn-primary" id="dataConfirmOK">Sim</a></div></div></div></div>');
        }
        $('#dataConfirmModal').find('.modal-body > b').text($(this).attr('data-confirm'));
        $('#dataConfirmOK').attr('href', href).attr('data-method', method).removeClass('btn-primary').addClass('btn-success');
        $('#dataConfirmModal').modal({ show: true });
        return false;
    });
}

function fields_masks() {
    $('.date').flatpickr({
        dateFormat: "d/m/Y",
        locale: "pt"
    });

    $('.select2').select2({
        theme: "bootstrap4"
    });

    $(".cnpj").mask("00.000.000/0000-00");
}

if (typeof Turbolinks == "undefined") {
    $(document).ready(ready);
} else {
    $(document).on("turbolinks:load", ready);
}