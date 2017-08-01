// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
// require foundation
// require foundation-datetimepicker
// require turbolinks
//= require imagesloaded.pkgd.min
//= require masonry.pkgd.min
//= require materialize
//= require color-thief.min
//= require galleryExpand
//= require init
//= require mockdate
//= require date
//= require date/sv-SE
//= require flash_messages


$(document).ready(function() {
    $('.timepicker').pickatime({
        default: 'now', // Set default time
        fromnow: 0,       // set default time to * milliseconds from now (using with default = 'now')
        twelvehour: false, // Use AM/PM or 24-hour format
        donetext: 'OK', // text for done-button
        cleartext: 'Clear', // text for clear-button
        canceltext: 'Cancel', // Text for cancel-button
        autoclose: false, // automatic close timepicker
        ampmclickable: true, // make AM PM clickable
        aftershow: function(){} //Function for after opening timepicker
    });
    $('select').material_select();
    $('.parallax').parallax();
    $(".button-collapse").sideNav();
    $(".dropdown-button").dropdown({
        belowOrigin: true
    });
});
