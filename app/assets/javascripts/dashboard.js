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
    modal = new Foundation.Reveal($('#slot-modal'));
    errorModal = new Foundation.Reveal($('#error-modal'));
    date = getDisplayedDate();
    newDate = new Date(date + " 00:00");
    if (newDate < today()) {
        errorModal.open();
    } else {
        populateModal(object);
        modal.open();
    }
}

function cableSubscribe() {
    var facility_id = document.querySelector('.facility_id').id;
    App.cable.subscriptions.create({channel: 'NoteChannel', facility_id: parseInt(facility_id, 'as needed')}, {
        collection: function () {
            // return $("#message");
        },

        connected: function (data) {
            // Called when the subscription is ready for use on the server

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

$(document).ready(cableSubscribe);

