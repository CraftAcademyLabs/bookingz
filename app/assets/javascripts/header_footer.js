$(window).resize(function() {
    fixedFooter(); //at page resize
    var more = document.getElementById("js-navigation-more");
    if ($(more).length > 0) {
        var windowWidth = $(window).width();
        var moreLeftSideToPageLeftSide = $(more).offset().left;
        var moreLeftSideToPageRightSide = windowWidth - moreLeftSideToPageLeftSide;

        if (moreLeftSideToPageRightSide < 330) {
            $("#js-navigation-more .submenu .submenu").removeClass("fly-out-right");
            $("#js-navigation-more .submenu .submenu").addClass("fly-out-left");
        }

        if (moreLeftSideToPageRightSide > 330) {
            $("#js-navigation-more .submenu .submenu").removeClass("fly-out-left");
            $("#js-navigation-more .submenu .submenu").addClass("fly-out-right");
        }
    }
});

$(document).ready(function() {
    var menuToggle = $("#js-mobile-menu").unbind();
    $("#js-navigation-menu").removeClass("show");

    menuToggle.on("click", function(e) {
        e.preventDefault();
        $("#js-navigation-menu").slideToggle(function(){
            if($("#js-navigation-menu").is(":hidden")) {
                $("#js-navigation-menu").removeAttr("style");
            }
        });
    });

    fixedFooter(); //at page load

    $('.js-accordion-trigger').bind('click', function(e){
        jQuery(this).parent().find('.submenu').slideToggle('fast');  // apply the toggle to the ul
        jQuery(this).parent().toggleClass('is-expanded');
        e.preventDefault();
    });
});


function fixedFooter() {
    var footer = $(".footer-2"); //or your footer class
    height = footer.height();
    paddingTop = parseInt(footer.css('padding-top'), 10);//zero if is undefined
    paddingBottom = parseInt(footer.css('padding-bottom'), 10);//zero if is undefined
    totalHeight = (height + paddingTop + paddingBottom);
    footerPosition = footer.position();
    windowHeight = $(window).height();
    height = (windowHeight - footerPosition.top) - totalHeight;
    if (height > 0) {
        footer.css({
            'margin-top': (height) + 'px'
        });
    }
}

