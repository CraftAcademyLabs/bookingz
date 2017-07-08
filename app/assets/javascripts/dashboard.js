//= require cable
//= require date_extensions


function queryApi(date) {
    $.ajax({
        dataType: "json",
        url: '/api/resources?date=' + date,
        success: function (response) {
            loadCurrentBookings(response);
            addEvents();
        }
    });
}

function updateApi(date) {
    $.ajax({
        dataType: "json",
        url: '/api/resources?date=' + date,
        success: function (response) {
            updateCurrentBookings(response);
            addEvents();
        }
    });
}

function currentDate() {
    var date = setDate().toJSON().slice(0, 10);
    return date;
}

function setDate() {
    return new Date();
}

function getDisplayedDate() {
    var date = $('#date').text();
    return date;
}

function weekOf(date) {
    return ['Week of',
        date.getThisWeeksMonday().sv_format(), '-',
        date.getThisWeeksSunday().sv_format()
    ].join(' ');
}

function today() {
    return new Date(new Date().toJSON().slice(0, 10) + " 00:00");
}

function getInfo(obj) {
    var message = (obj.info.client != null) ? setSlotMessage(obj) : obj.info.time;
    return message;
}

function populateAndShowModal(object) {
    var modal, errorModal, date, newDate;
    modal = $('#slot-modal').modal();
    errorModal = $('#error-modal').modal();
    date = getDisplayedDate();
    newDate = new Date(date + " 00:00");
    if (newDate < today()) {
        errorModal.open();

    } else {
        populateModal(object);
        modal.modal('open', {
            ready: function (modal, trigger) {
                // Callback for Modal open. Modal and trigger parameters available.
                console.log(trigger);
                Materialize.updateTextFields();
            },
            complete: function () {
                // Callback for Modal close,
                console.log('Closed');
            }
        });
    }
}

function cableSubscribe() {
    var facility = document.querySelector('.facility_code');
    if (typeof(facility) != 'undefined' && facility != null) {
        var facilityCode = facilitSetting.id;
        App.cable.subscriptions.create({channel: 'NoteChannel', data: {facility_code: facilityCode}}, {
            collection: function () {
                // return $("#message");
            },

            connected: function (data) {
                // Called when the subscription is ready for use on the server
                console.log(data);

            },

            disconnected: function () {
                // Called when the subscription has been terminated by the server
            },

            received: function (data) {
                // Called when there's incoming data on the websocket for this channel
                $('.note_flash').html("Your message '" + data.note + "' was sent at " + data.time);
            }
        });
    }

}

function countChar(val, allowedLength, displayElement) {
    var len = val.value.length;
    if (len > allowedLength) {
        val.value = val.value.substring(0, allowedLength);
    } else {
        $(displayElement).text(allowedLength - len + ' characters left');
    }
}
// Usage: onkeyup="countChar(this, 160, '#char-display')"

$(document).ready(cableSubscribe);
