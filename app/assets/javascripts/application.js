// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
// These are provided by gems:
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//
// These are located in vendor/assets/javascripts:
//
//= require jquery.tweet
//= require jquery.flexslider
//= require jquery.metadata
//= require jquery.tablesorter
//= require jquery.tablesorter.widgets
//
// These are our scripts:
//
//= require_tree .
//
// These are <IE9 only
//= stub html5

$(function() {
  $('.toggle-menu').on('tap click', function() {
    $('.header-nav').slideToggle();
  });

  $("#main").on("click", ".talk", function() {
    $(this).find(".description").slideToggle('fast');
  });

  $('.flexslider').flexslider({
    pauseOnHover: true,
    directionNav: false
  });

  $.extend($.tablesorter.themes.bootstrap, {
    // these classes are added to the table. To see other table classes available,
    // look here: http://twitter.github.com/bootstrap/base-css.html#tables
    table      : 'table table-bordered',
    header     : 'bootstrap-header', // give the header a gradient background
    footerRow  : '',
    footerCells: '',
    icons      : '', // add "icon-white" to make them white; this icon class is added to the <i> in the header
    sortNone   : 'bootstrap-icon-unsorted',
    sortAsc    : 'icon-chevron-up',
    sortDesc   : 'icon-chevron-down',
    active     : '', // applied when column is sorted
    hover      : '', // use custom css here - bootstrap class may not override it
    filterRow  : '', // filter row class
    even       : '', // odd row zebra striping
    odd        : ''  // even row zebra striping
  });

  // add parser through the tablesorter addParser method
  $.tablesorter.addParser({
    // set a unique id
    id: 'sortOnDataAttrib',
    is: function(s, table, cell) {
      // return false so this parser is not auto detected
      return false;
    },
    format: function(s, table, cell, cellIndex) {
      // format your data for normalization
      return $(cell).attr("data-sort-value");
    },
    // set type, either numeric or text
    type: 'text'
  });

  // call the tablesorter plugin and apply the uitheme widget
  $(".tablesorter").bind("tablesorter-initialized filterEnd", function(){
    var $this = $(this);
    $(".row-count").each(function() {
      $(this).html($this.find("tbody tr").not(".filtered").length);
    });
  }).tablesorter({
    // this will apply the bootstrap theme if "uitheme" widget is included
    // the widgetOptions.uitheme is no longer required to be set
    theme : "bootstrap",
    headerTemplate : '{content} {icon}', // new in v2.7. Needed to add the bootstrap icon!
    // widget code contained in the jquery.tablesorter.widgets.js file
    // use the zebra stripe widget if you plan on hiding any rows (filter widget)
    widgets : [ "uitheme", "filter" ],

    widgetOptions : {
      // using the default zebra striping class name, so it actually isn't included in the theme variable above
      // this is ONLY needed for bootstrap theming if you are using the filter widget, because rows are hidden
      zebra : ["even", "odd"],
      
      // reset filters button
      filter_reset : ".reset",
      filter_columnFilters : true,
      filter_useParsedData : true
    }
  }).delegate('.expand', 'click' ,function(){
    $(this).toggleClass('btn-success').find('i').toggleClass('icon-plus').toggleClass('icon-minus').closest('tr').nextUntil('tr:not(.tablesorter-childRow)').find('td').toggle();
    return false;
  }).delegate('.bs-tooltip', 'mouseenter', function() {
    $(this).tooltip('show');
  }).delegate('.bs-tooltip', 'mouseleave', function() {
    $(this).tooltip('hide');
  });

});
