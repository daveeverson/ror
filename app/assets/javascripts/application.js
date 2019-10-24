// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require ckeditor-jquery
//= require_tree .

$(function() {
    /* Convenience for forms or links that return HTML from a remote ajax call.
The returned markup will be inserted into the element id specified.
*/
    $('form[data-update-target]').on('ajax:success', function(evt, data) {
        var target = $(this).data('update-target');
        $('#' + target).html(data);
    });
    $('form[data-update-target]').on('ajax:error', function(evt, data) {
        var target = $(this).data('update-target');
        $('#' + target).html("<h3 class='nb' style='color:red'>Error in search field(s). Please ensure all search inputs do not contain invalid data before clicking on 'Search'.</p>");
    });
});

$(function(){
    $('#contact_contact_date').datepicker({ altFormat: "yy-mm-dd" });
    $('#contact_search_from_date').datepicker({ altFormat: "yy-mm-dd" });
    $('#contact_search_to_date').datepicker({ altFormat: "yy-mm-dd" });
});
