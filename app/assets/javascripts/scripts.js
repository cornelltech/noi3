$(document).ready(function () {

    // oauth controls display
    // #omniauth-login__form
    // #omniauth-login__button

    // #omniauth-signup__form
    // #omniauth-

    $('body').on("click", ".omniauth-login__button", function() {
        $("#omniauth-login__form").show();
        $("#omniauth-signup__form").hide();
        $(this).addClass("active");
        $(".omniauth-signup__button").removeClass("active")
    });

    $('body').on("click", ".omniauth-signup__button", function() {
        $("#omniauth-signup__form").show();
        $("#omniauth-login__form").hide();
        $(this).addClass("active");
        $(".omniauth-login__button").removeClass("active")
    });



    $('.reply-to-post').click(function(e) {
        e.preventDefault();
        var target = $(this).attr('data-target');
        $(target).toggleClass('js-active');
    });

    // Submit category filter
    $('body').on('change', '#category-form select', function (e) {
        $('#category-form').submit();
    });

    // Search top bar dropdown, default to posts
      $("#top-search-form-users").hide();

      $('body').on('change', '.select-search-options', function() {
          var activeSearch = $(this).val();
          if (activeSearch == "search-people") {
              $('#top-search-form-users').show();
              $('#top-search-form-posts').hide();
              $('.select-search-options option[value=search-people]').prop('selected', true);
          } else {
              $('#top-search-form-posts').show();
              $('#top-search-form-users').hide();
              $('.select-search-options option[value=search-posts]').prop('selected', true);
          }
      });

    $('body').on("click", ".questionnaire__check-all-control", function(e) {
        var skillAreaTarget = $(this).attr("data-skill-target");
        var checkboxes = $("." + skillAreaTarget);
        var checkedCheckboxes = $("." + skillAreaTarget + ":checked");
        if (checkboxes.length == checkedCheckboxes.length) {
            $(this).prop('checked', false);
        } else {
            $(this).prop('checked', true);
        }
    });

    $('body').on('change', '.questionnaire__check-all-control', function (e) {
        var skillAreaTarget = $(this).attr("data-skill-target");
        $("." + skillAreaTarget).prop('checked', $(this).prop("checked"));
    });


    $('body').on('click', '#survey-save', function (e) {
        $(window).scrollTop(0);
    });

    $('body').on('change', '.filter-section select', function (e) {
        $('#search-form').submit();
    });

    $('body').on('click', '.filter-section #reset-filters', function (e) {
        location = '/search';
    });

    $('body').on('click', '#more-filters', function (e) {
        $('.extra-filters').toggle('js-active');
        if ( $('.collapsed-que').text() == 'add' ) {
            $('.collapsed-que').text('remove');
        } else {
            $('.collapsed-que').text('add');
        }
    });

    $('body').on('click', '.toast__close', function (e) {
        $('.toast').removeClass('js-active');
    });

    $('body').on('click', '.js-open-panel', function (e) {
        $('.panel').not('.panel--1').removeClass('js-active');
        $('.panel--1').toggleClass('js-active');
    });

    $('body').on('click', '.js-open-panel-2', function(e) {
        $('.panel').not('.panel--2').removeClass('js-active');
        $('.panel--2').toggleClass('js-active');
    });

    $('body').on('click', '.js-open-panel-3', function(e) {
        $('.panel').not('.panel--3').removeClass('js-active');
        $('.panel--3').toggleClass('js-active');
    });

    $('body').on('click', '.js-open-panel-4', function(e) {
        $('.panel').not('.panel--4').removeClass('js-active');
        $('.panel--4').toggleClass('js-active');
    });

    $('body').on('click', '.js-close-panel', function(e) {
        $('.panel').removeClass('js-active');
    });

    $('body').on('click', '.js-open-action-panel', function(e) {
        $('.js-panel-action').toggleClass('js-active');
    });

    $('.js-open-this').hover(function () {
        $(this).toggleClass('js-active');
    });

    $('body').on('click','.expertise-panel__item', function(e) {
        $('.panel--4').removeClass('js-active');
    });

    $('body').on("click", '.category-tag__skills', function(e) {
        if (!$('.panel--4').hasClass('js-active'))  {
            $('.panel--4').addClass('js-active');
            $('.panel--3').removeClass('js-active');
            $('.panel--2').removeClass('js-active');
        }
    });

    $('.panel--1__handle').click(function () {
      var panel = $('.panel--1');
      var all_panels = $('.panel');
      var handle = $('.panel--1__handle');


      if ( all_panels.hasClass('js-active') ) {
        all_panels.removeClass('js-active');
        handle.removeClass('js-active');
      } else {
        panel.addClass('js-active');
        handle.addClass('js-active');
      }


    });


























    // Smooth Scrolling Function
    // $('a[href*=#]:not([href=#])').click(function () {
    //     var $targ = $(this.hash),
    //         host1 = this.hostname,
    //         host2 = location.hostname,
    //         path1 = this.pathname.replace(/^\//, ''),
    //         path2 = location.pathname.replace(/^\//, '');

    //     if (!$targ.length) {
    //         $targ = $('[name=' + this.hash.slice(1) + ']');
    //     }

    //     if ($targ.length && (host1 === host2 || path1 === path2)) {
    //         $('html, body').animate({ scrollTop: $targ.offset().top }, 1000);

    //         return false;
    //     }

    //     return true;
    // });

    // Modal Click Behavior
    $('.js-open-modal').click(function () {
        $('.js-target-modal').addClass('js-active');
        $('#overlay').addClass('js-active');
        $('body').addClass('js-body-modal-active');
    });

    $('.js-close-modal').click(function () {
        $('.js-target-modal').removeClass('js-active');
        $('#overlay').removeClass('js-active');
        $('body').removeClass('js-body-modal-active');
    });

    // Sticky Click Behavior
    $('.js-close-sticky').click(function () {
        $('.js-target-sticky').removeClass('js-active');
    });

    // Search Click Behavior
    $('.js-trigger-search').click(function (e) {
        e.preventDefault();
        $(this).parent().addClass('js-active');
        $('#overlay').addClass('js-active');
    });

    $('.js-close-modal').click(function () {
        $('.js-target-modal').removeClass('js-active');
        $('#overlay').removeClass('js-active');
        $('body').removeClass('js-body-modal-active');
    });

    // Main Menu Click Behavior
    $('.js-trigger-menu').click(function (e) {
        $(this).next().addClass('js-active-menu');
        $('.js-overlay').addClass('js-active');
    });

    // General Click Behavior for Overlay
    $('#overlay').click(function () {
        $('.js-active').removeClass('js-active');
        $('.js-active-menu').removeClass('js-active-menu');
    });

    // Slider
    // $('.slider').slick({
    //     arrows: true,
    //     draggable: false,
    //     swipeToSlide: true,
    //     autoplay: true,
    //     autoplaySpeed: 3000,
    //     responsive: [
    //         {
    //             breakpoint: 800,
    //             settings: {
    //                 draggable: true
    //             }
    //         }
    //     ]
    // });


    // // Fixed Table Header
    // $(window).scroll(function(){
    //     var yPosition = $( window ).scrollTop(),
    //         target = $('.table-sortable'),
    //         offset = target.offset().top;
    //     yPosition >= offset ? target.addClass("table-sortable--fixed") : target.removeClass("table-sortable--fixed");
    // });


    // // List.js Implementation
    // var options = {
    //     valueNames: [ 'company__name', 'company__category', 'company__type', 'company__founded', 'company__location', 'company__last-update' ]
    // };

    // var companyList = new List('company_data', options);

    // function searchReset() {
    //     $(".search").val("");
    //     companyList.search();
    // }

    // // Filter by name and location
    // $(".search").keyup(function() {
    //     console.log(this)
    //     if (this.id=="company__name--input") {
    //         var searchString = $(this).val();
    //         console.log(this)
    //         companyList.search(searchString, ["company__name"] );
    //     } else if (this.id=="company__location--input") {
    //         var searchString = $(this).val();
    //         companyList.search(searchString, ["company__location"]);
    //     }
    // });


    // $(".js-open-table-search").on("click", function(e) {
    //    $($(this).attr('data-target')).focus();
    // });

    // // Xs and ESC TO CLOSE OUT FORM
    // var searchButtons = $('.table-sortable__search').find("button[type='submit']");

    // searchButtons.on("click", function(e) {
    //     e.preventDefault();
    //     if ($(this).parent().hasClass("table-sortable__search--active")) {
    //         $(this).parent().removeClass("table-sortable__search--active")
    //         searchReset()
    //     }
    // });

    // $("body").keyup(function(event) {
    //     if ( event.keyCode == "27" ) {
    //         $(this).parent().find('.table-sortable__search').removeClass("table-sortable__search--active");
    //         searchReset();
    //     }
    // });

    // // SORT ICON
    // var sortClickButtons = $(".table-sortable__control > i:contains('keyboard_arrow_down')");

    // sortClickButtons.on("click", function() {
    //     $(this).text() == "keyboard_arrow_down" ? $(this).text("keyboard_arrow_up") : $(this).text("keyboard_arrow_down")

    // });

}); // doc.ready
