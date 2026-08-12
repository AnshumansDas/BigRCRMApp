(function ($) {
    "use strict";

    /*---------------------
     tooltip
    --------------------- */
    $('[data-toggle="tooltip"]').tooltip({
        animated: 'fade',
        placement: 'top',
        container: 'body'
    });
    /*----------------------------
     scrollUp
    ------------------------------ */
    $.scrollUp({
        scrollText: '<i class="fa fa-angle-up"></i>',
        easingType: 'linear',
        scrollSpeed: 900,
        animation: 'fade'
    });
    /*----------------------------
     mixItUp
    ------------------------------ */
    $('#mix-fil').mixItUp();
    /*----------------------------
     counterUp
    ------------------------------ */
    $('.counter2').counterUp({
        delay: 10,
        time: 1000
    });
    /*----------------------------
	price-slider active
   ---------------------------- */
    $("#slider-range").slider({
        range: true,
        min: 40,
        max: 600,
        values: [100, 540],
        slide: function (event, ui) {
            $("#amount").val("RM" + ui.values[0] + " - RM" + ui.values[1]);
        }
    });
    $("#amount").val("RM" + $("#slider-range").slider("values", 0) +
        " - RM" + $("#slider-range").slider("values", 1));
    /*----------------------------
     wow js active
    ------------------------------ */
    new WOW().init();
    /*-------------------------------------------
    option chosen
    -------------------------------------------- */
    $(".orderby").chosen();

    $(".menu-carousel").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 5,
        itemsCustom: [
            [0, 1],
            [450, 1],
            [480, 2],
            [600, 2],
            [700, 2],
            [768, 3],
            [992, 4],
            [1199, 5]
        ],
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
    });

    $(".feature-carousel").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 4,
        itemsCustom: [
            [0, 1],
            [450, 1],
            [480, 2],
            [600, 2],
            [700, 2],
            [768, 2],
            [992, 3],
            [1199, 4]
        ],
        pagination: true,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
    });

    $(".feature-carousel-np").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 4,
        itemsCustom: [
            [0, 1],
            [450, 1],
            [480, 2],
            [600, 2],
            [700, 2],
            [768, 2],
            [992, 3],
            [1199, 4]
        ],
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
    });
    $(".feature-carousel-np3").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 3,
        itemsCustom: [
            [0, 1],
            [450, 1],
            [480, 2],
            [600, 2],
            [700, 2],
            [768, 2],
            [992, 2],
            [1199, 3]
        ],
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
    });

    $(".feature-carousel-np6").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 6,
        itemsCustom: [
            [0, 1],
            [450, 1],
            [480, 2],
            [600, 2],
            [700, 2],
            [768, 4],
            [992, 4],
            [1199, 5]
        ],
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
    });
    $(".new-arri-total").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 1,
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        itemsDesktop: [1199, 1],
        itemsDesktopSmall: [979, 1],
        itemsTablet: [768, 1]
    });
    $("#client-carousel").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 1,
        pagination: false,
        navigation: true,
        navigationText: ["<i class='fa fa-angle-left'></i>", "<i class='fa fa-angle-right'></i>"],
        itemsDesktop: [1199, 1],
        itemsDesktopSmall: [979, 1],
        itemsTablet: [767, 1]
    });
    $(".total-usefull-product").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 1,
        itemsCustom: [
            [0, 1],
            [450, 1],
            [480, 2],
            [600, 2],
            [700, 2],
            [768, 1],
            [992, 1],
            [1199, 1]
        ],
        pagination: true,
        navigation: false,
    });
    $("#gallery_01").owlCarousel({
        autoPlay: false,
        slideSpeed: 2000,
        items: 4,
        pagination: true,
        navigation: false,
        itemsDesktop: [1199, 4],
        itemsDesktopSmall: [979, 3],
        itemsTablet: [768, 2],
        itemsMobile: [480, 3]
    });

    /*----------------------------
     jQuery MeanMenu
    ------------------------------ */
    jQuery('nav#dropdown').meanmenu();
    /*----------------------------

    /*----------------------------
     fancybox active
    ------------------------------ */
    $(document).ready(function () {
        $('.fancybox').fancybox();
    });
    /*----------------------------
         Elevate Zoom active
    ------------------------------ */
    $("#zoom_03").elevateZoom({
        constrainType: "height",
        zoomType: "lens",
        containLensZoom: true,
        gallery: 'gallery_01',
        cursor: 'pointer',
        galleryActiveClass: "active"
    });

    //pass the images to Fancybox
    $("#zoom_03").bind("click", function (e) {
        var ez = $('#zoom_03').data('elevateZoom');
        $.fancybox(ez.getGalleryList());
        return false;
    });

    $('#infogate-menu').superfish({
        //add options here if required
    });

    $(".active-part").focus(function () {
        $(this).addClass("active");
        $(".overlay").addClass("active");

    }).blur(function () {
        $(this).removeClass("active");
        $(".overlay").removeClass("active");
    })


    /** BEGIN DATEPICKER **/
    if ($('.datepicker').length > 0) {
        $('.datepicker').datepicker({ dateFormat: 'yy-mm-dd' });
    }

    //    if($('.datepicker3').length > 0){
    //        $(".datepicker3").datepicker({
    //            todayBtn:  1,
    //            autoclose: true,
    //        }).on('changeDate', function (selected) {
    //            var minDate = new Date(selected.date.valueOf());
    //            $('.datepicker4').datepicker('setStartDate', minDate);
    //        });
    //
    //        $(".datepicker4").datepicker()
    //            .on('changeDate', function (selected) {
    //                var minDate = new Date(selected.date.valueOf());
    //                $('.datepicker3').datepicker('setEndDate', minDate);
    //            });
    //    }

    if ($('.datepicker1').length > 0) {
        var nowTemp = new Date();
        var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

        var checkin = $('.datepicker1').datepicker({
            dateFormat: 'dd-mm-yy',
            onRender: function (date) {
                return date.valueOf() < now.valueOf() ? 'disabled' : '';
            }
        }).on('changeDate', function (ev) {
            //		  if (ev.date.valueOf() > checkout.date.valueOf()) {
            //			var newDate = new Date(ev.date)
            //			newDate.setDate(newDate.getDate() + 0);
            //			checkout.setValue(newDate);
            //		  }
            //		  checkin.hide();
            if (ev.date) {
                if (ev.date.valueOf() > checkout.date.valueOf()) {
                    var newDate = new Date(ev.date)
                    newDate.setDate(newDate.getDate() + 1);
                    checkout.update(newDate);

                }
                checkin.hide();
            }
            $('.datepicker2')[0].focus();
        }).data('datepicker');
        var checkout = $('.datepicker2').datepicker({
            onRender: function (date) {
                return date.valueOf() <= checkin.date.valueOf() ? 'disabled' : '';
            }
        }).on('changeDate', function (ev) {
            checkout.hide();
        }).data('datepicker');
    }

    if ($('.startdate').length > 0) {
        $('.startdate').daterangepicker({
            locale: {
                format: 'DD/MM/YYYY'
            }
        });
    }

    var start = moment().subtract(29, 'days');
    var end = moment();

    function cb(start, end) {
        $('#reportrange span').html(start.format('D MMMM, YYYY') + ' - ' + end.format('D MMMM, YYYY'));
    }

    $('#reportrange').daterangepicker({
        startDate: start,
        endDate: end,
        ranges: {
            'Today': [moment(), moment()],
            'This Month': [moment().startOf('month'), moment().endOf('month')],
            'This Year': [moment().startOf('year'), moment().endOf('year')]
        }
    }, cb);

    cb(start, end);


    /** END DATEPICKER **/

    $('#check1').click(function () {
        $('.text1').attr('disabled', !this.checked);
        $('.text1').attr('required', this.checked);
    });

    $(".checkAll").click(function () {
        $('.item-s').not(this).prop('checked', this.checked);
    });

    $('.agred').click(function () {
        //$('.radio-payment').attr('disabled', !$(this).is(':checked'));
        if ($(this).is(':checked')) {
            $('.radio-payment').addClass('active');
            $('.radio-payment').attr('disabled', false);
        }
        else {
            $('.radio-payment').removeClass('active');
            $('.radio-payment').attr('disabled', true);
            $('.radio-payment').removeAttr('checked');
        }

    });

    $('.btn-cart-add').click(function (event) {
        event.preventDefault();
        $('.cart-add').toggleClass('active');
        $(".overlay").toggleClass('active');
    });

    $('.chan-bill').click(function () {
        //$('.radio-payment').attr('disabled', !$(this).is(':checked'));
        if ($(this).is(':checked')) {
            $('.bill-new').addClass('active');
            $('.bill-curent').addClass('hide');
        }
        else {
            $('.bill-new').removeClass('active');
            $('.bill-curent').removeClass('hide');
        }

    });

    //jquery increase decrease input value

    $('.btn-number').click(function (e) {
        e.preventDefault();

        var fieldName = $(this).attr('data-field');
        var type = $(this).attr('data-type');
        var input = $("input[name='" + fieldName + "']");
        var currentVal = parseInt(input.val());
        if (!isNaN(currentVal)) {
            if (type == 'minus') {

                if (currentVal > input.attr('min')) {
                    input.val(currentVal - 1).change();
                }
                if (parseInt(input.val()) == input.attr('min')) {
                    $(this).attr('disabled', true);
                }

            } else if (type == 'plus') {

                if (currentVal < input.attr('max')) {
                    input.val(currentVal + 1).change();
                }
                if (parseInt(input.val()) == input.attr('max')) {
                    $(this).attr('disabled', true);
                }

            }
        } else {
            input.val(0);
        }
    });
    $('.input-number').focusin(function () {
        $(this).data('oldValue', $(this).val());
    });
    $('.input-number').change(function () {

        var minValue = parseInt($(this).attr('min'));
        var maxValue = parseInt($(this).attr('max'));
        var valueCurrent = parseInt($(this).val());

        var name = $(this).attr('name');
        if (valueCurrent >= minValue) {
            $(".btn-number[data-type='minus'][data-field='" + name + "']").removeAttr('disabled')
        } else {
            alert('Sorry, the minimum value was reached');
            $(this).val($(this).data('oldValue'));
        }
        if (valueCurrent <= maxValue) {
            $(".btn-number[data-type='plus'][data-field='" + name + "']").removeAttr('disabled')
        } else {
            alert('Sorry, the maximum value was reached');
            $(this).val($(this).data('oldValue'));
        }


    });
    $(".input-number").keydown(function (e) {
        // Allow: backspace, delete, tab, escape, enter and .
        if ($.inArray(e.keyCode, [46, 8, 9, 27, 13, 190]) !== -1 ||
            // Allow: Ctrl+A
            (e.keyCode == 65 && e.ctrlKey === true) ||
            // Allow: home, end, left, right
            (e.keyCode >= 35 && e.keyCode <= 39)) {
            // let it happen, don't do anything
            return;
        }
        // Ensure that it is a number and stop the keypress
        if ((e.shiftKey || (e.keyCode < 48 || e.keyCode > 57)) && (e.keyCode < 96 || e.keyCode > 105)) {
            e.preventDefault();
        }
    });


})(jQuery);