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
//= require foundation
//= require foundation-datetimepicker
//= require turbolinks
//= require_tree .

var res = {
    date: '2016-08-31',
    items: [
        {
            id: 28,
            slots: [
                {info: {time: '08.00 - 08.30'}, state: 'free'},
                {info: {time: '08.30 - 09.00'}, state: 'free'},
                {info: {time: '09.00 - 09.30', client: 'Volvo'}, state: 'booked'}]
        },
        {
            id: 29,
            slots: [
                {info: {time: '08.00 - 08.30'}, state: 'free'},
                {info: {time: '08.30 - 09.00', client: 'CraftAcademy'}, state: 'booked'},
                {info: {time: '09.00 - 09.30'}, state: 'free'}]
        },
        {
            id: 30,
            slots: [
                {info: {time: '08.00 - 08.30'}, state: 'free'},
                {info: {time: '08.30 - 09.00',client: 'CraftAcademy'}, state: 'booked'},
                {info: {time: '09.00 - 09.30'}, state: 'free'}]
        }]

};

function loadCurrentBookings() {
    res.items.forEach(function (item) {
        item.slots.forEach(function (slot) {
            var card = ['#card', item.id].join('-');
            $(card + " .content").append('<div class="action" id="action_' + item.id + '" style="background-color: '+ getBackgroundColor(slot) +'">' + getInfo(slot) + '</div>');
        });
    });
}

function getBackgroundColor (obj) {
    var color = (obj.state == 'booked') ? 'red' : 'green';
    return color;
}

function getInfo(obj){
    var client = (obj.info.client != null) ? [obj.info.time, obj.info.client].join(' ') : obj.info.time;
    return client
}

function currentDate() {
    var date = setDate().toJSON().slice(0, 10);
    return date;
}

function setDate() {
    return new Date();
}

function getDispalyedDate() {
    var date = $('#date').text();
    return date;
}

function populateAndShowModal(object) {
    var obj, resource, slot, card, date;
    obj = object;
    card = $(obj).parent().parent();
    resource = card.find('.accordion-title').text();
    slot = $(obj).text();
    date = getDispalyedDate();
    var id = card[0].id.split("-").pop();
    $('#booking_resource_id').val(id);
    card.find('#' + obj.id).css({'color': 'red', 'background-color': 'orange'});
    var modal = new Foundation.Reveal($('#slot-modal'));
    $('#model-content #slot').html([resource, date, slot].join(' - '));
    $('#booking_booking_date').val(date);
    modal.open();
}

function navigateDate(val) {
    var displayedDate = getDispalyedDate();
    var newDate = new Date(displayedDate);
    newDate.setDate(newDate.getDate() + val);
    console.log(newDate);
    return newDate.toJSON().slice(0, 10);

}

function dateOnPageLoad(passed_date) {
    if (typeof passed_date !== 'undefined') {
        MockDate.set(passed_date);
    }
    var date = currentDate();
    $('#date').html(date);

}

$(document).ready(function () {
    dateOnPageLoad();
    loadCurrentBookings();
    $('.picker').fdatetimepicker({
        language: 'en',
        pickTime: true,
        closeButton: true,
        startView: 0,
        format: 'hh:ii'
    });
    $(".action").click(function () {
        populateAndShowModal(this);
    });

    $('#previous').click(function () {
        $('#date').html(navigateDate(-1));
    });
    $('#next').click(function () {
        $('#date').html(navigateDate(1));
    });
});
