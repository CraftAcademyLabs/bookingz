Date.prototype.getNextWeeksMonday = function () {
    return this.next().week().monday()
};

Date.prototype.getNextWeeksSunday = function () {
    this.next().week().sunday()
};

Date.prototype.getThisWeeksMonday = function() {
    var d = new Date(this.getTime());
    var day = d.getDay(),
        diff = d.getDate() - day + (day == 0 ? -6:1); // adjust when day is sunday
    return new Date(d.setDate(diff));
};

Date.prototype.getThisWeeksSunday = function () {
    var d = this.getThisWeeksMonday();
    return new Date(d.setDate(d.getDate() + 6));
};

Date.prototype.sv_format = function() {
    return this.toString('yyyy-MM-dd')
};