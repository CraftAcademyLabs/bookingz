
(function ($) {
    $.fn.longClick = function (callback, timeout) {
        var timer;
        timeout = timeout || 500;
        $(this).mousedown(function () {
            timer = setTimeout(function () {
                callback();
            }, timeout);
            return false;
        });
        $(document).mouseup(function () {
            clearTimeout(timer);
            return false;
        });
    };

})(jQuery);


function queryApi(date) {
    $.ajax({
        dataType: "json",
        url: '/api/resources.json?date=' + date,
        success: function (response) {
            loadCurrentBookings(response);
            addEvents();
        }
    });
}

function updateApi(date) {
    $.ajax({
        dataType: "json",
        url: '/api/resources.json?date=' + date,
        success: function (response) {
            updateCurrentBookings(response);
            addEvents();
        }
    });
}


function loadCurrentBookings(response) {
    var res = response;
    res.items.forEach(function (item) {
        var card = ['#card', item.id].join('-');
        $(card + " .content").append('<div class="with-scroll"></div>')
        item.slots.forEach(function (slot) {
            $(card + " .content .with-scroll").append('<div class="action" id="action_' + slot.info.id + '" style="background-color: ' + getBackgroundColor(slot) + '">' + getInfo(slot) + '</div>');
        });
    });
}

function updateCurrentBookings(response) {
    var res = response;
    res.items.forEach(function (item) {
        var card = ['#card', item.id].join('-');
        $(card + " .content .with-scroll").empty();
        item.slots.forEach(function (slot) {
            $(card + " .content .with-scroll").append('<div class="action" id="action_' + slot.info.id + '" style="background-color: ' + getBackgroundColor(slot) + '">' + getInfo(slot) + '</div>');
        });
    });

}

function getBackgroundColor(obj) {
    var color = (obj.state == 'booked') ? 'red' : 'green';
    return color;
}

function getInfo(obj) {
    var message = (obj.info.client != null) ? setSlotMessage(obj) : obj.info.time;
    return message;
}

function setSlotMessage(obj) {
    var booking_times = obj.info.booking_time.split(' - ')
    var message = [obj.info.time, 'Grupp: ' + obj.info.client, 'Start: ' + booking_times[0], 'Slut: ' + booking_times[1]].join(' ');
    return message;
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
    var obj, resource, slot, card, date, id, modal, booking_times;
    obj = object;
    card = $(obj).parent().parent().parent();
    resource = card.find('.accordion-title').text();
    slot = $(obj).text();
    date = getDispalyedDate();
    id = card[0].id.split("-").pop();
    $('#booking_resource_id').val(id);
    card.find('#' + obj.id).css({'color': 'red', 'background-color': 'orange'});
    modal = new Foundation.Reveal($('#slot-modal'));
    booking_times = object.textContent.split(' - ');
    $('#model-content #slot').html([resource, date, slot].join(' - '));
    $('#booking_booking_date').val(date);
    $('#booking_time_start').val(booking_times[0]);
    $('#booking_time_end').val(booking_times[1]);
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

function addEvents() {
    $('#previous').off("click").click(function () {
        $('#date').html(navigateDate(-1));
        updateApi(getDispalyedDate());
    });
    $('#next').off("click").click(function () {
        $('#date').html(navigateDate(1));
        updateApi(getDispalyedDate());
    });

    $('#previous').off("longClick").longClick(function () {
        //place date time picker code here
        console.log('Looong press!');
    });

    $('[id^=action_]').off("click").click(function () {
        populateAndShowModal(this);
    });

}