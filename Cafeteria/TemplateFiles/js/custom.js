﻿// to get current year
function getYear() {
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    document.querySelector("#displayYear").innerHTML = currentYear;
}







// isotope js
$(window).on('load', function () {
    $('.filters_menu li').click(function () {
        $('.filters_menu li').removeClass('active');
        $(this).addClass('active');

        var data = $(this).attr('data-filter');
        $grid.isotope({
            filter: data
        })
    });

    var $grid = $(".grid").isotope({
        itemSelector: ".all",
        percentPosition: false,
        masonry: {
            columnWidth: ".all"
        }
    })

    $(document).ready(function () {
        // Read a page's GET URL variables & return
        function getUrlVars() {
            var vars = [], hash;
            var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
            for (var i = 0; i < hashes.length; i++) {
                hash = hashes[i].split('=');
                vars.push(hash[0]);
                vars[hash[0]] = hash[1];
            }
            return vars;
        };

        var id = getUrlVars()["id"];
       
        if (id > 0) {
            $('.filters_menu li').removeClass('active');
        }

        $('.filters_menu li').each(function () {
            
            // Checks if it is the same on the address bar
            if (id == this.attributes["data-id"].value) {
                $(this).closest("li").addClass("active");

                var data = $(this).attr('data-filter');
                $grid.isotope({
                    filter: data
                })

                return;
            }
        });

    });


});

// nice select
$(document).ready(function() {
    $('select').niceSelect();
  });

/** google_map js **/
//function myMap() {
//    var mapProp = {
//        center: new google.maps.LatLng(40.712775, -74.005973),
//        zoom: 18,
//    };
//    var map = new google.maps.Map(document.getElementById("googleMap"), mapProp);
//};

// client section owl carousel
$(".client_owl-carousel").owlCarousel({
    loop: true,
    margin: 0,
    dots: false,
    nav: true,
    navText: [],
    autoplay: true,
    autoplayHoverPause: true,
    navText: [
        '<i class="fa fa-angle-left" aria-hidden="true"></i>',
        '<i class="fa fa-angle-right" aria-hidden="true"></i>'
    ],
    responsive: {
        0: {
            items: 1
        },
        768: {
            items: 2
        },
        1000: {
            items: 2
        }
    }
});

   //'use strict';
(function ($) {
    /*-------------------
        Quantity change
    --------------------- */
    var proQty = $('.pro-qty');
    proQty.prepend('<span class="dec qtybtn" >-</span>');
    proQty.append('<span class="inc qtybtn">+</span>');
    
    proQty.on('click', '.qtybtn', function () {
        var $button = $(this);
        var oldValue = $button.parent().find('input').val();
        
        if ($button.hasClass('inc')) {
            if (oldValue >= 10) {
                var newVal = parseFloat(oldValue);
            } else {
                newVal = parseFloat(oldValue) + 1;
            }
        } else {
            if (oldValue > 1) {
                var newVal = parseFloat(oldValue) - 1;
            } else {
                newVal = 1;
            }
        }
        
        $button.parent().find('input').val(newVal);

        // Logging the index of the row
        var rowIndex = $button.closest('tr').index();
        console.log(rowIndex);
    });

})(jQuery);


/*For Quantity Change*/

/*date and time*/

var months = ["იანვარი", "თებერვალი", "მარტი", "აპრილი", "მაისი", "ივნისი", "ივლისი", "აგვისტო", "სექტემბერი", "ოქტომბერი", "ნოემბერი", "დეკემბერი"];
var d = new Date();
var hr = d.getHours();
var min = d.getMinutes();
if (min < 10) {
    min = "0" + min;
}
if (hr > 24) {
    hr -= 24;
}
var date = d.getDate();
var month = months[d.getMonth()];
var year = d.getFullYear();
var x = document.getElementById("time");
x.innerHTML = date + " " + month + " | " + year + " | " + hr + ":" + min; 

/*date and time*/
