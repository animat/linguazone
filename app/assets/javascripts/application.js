// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require swf_fu
//= require autocomplete-rails
//= require flash_messages
//= require underscore
//= require select2.min
//= require backbone-min
//= require backbone.marionette.min
//= require fineuploader.jquery
//= require select2
//= require jquery.mixitup

// get querystring as an array split on "&"
var QueryString = function() {
  var querystring = location.search.replace( '?', '' ).split( '&' );

  var queryObj = {};

  for ( var i=0; i<querystring.length; i++ ) {
        // get name and value
        var name = querystring[i].split('=')[0];
        var value = querystring[i].split('=')[1];
        // populate object
        queryObj[name] = value;
  }

  return queryObj;
}();

$.fn.wizardify = function(el) {
  var $el = $(this);
  var step = 1;
  var previousStep;

  if ($el.data("step")) {
    step = step.data("step");
  }

  $el.find(".step").hide();

  var showCurrentStep = function() {
    if(previousStep) $el.find(".step-" + previousStep).hide();
    $el.find(".step-" + step).fadeIn();
  }

  $el.find(".previous").click(function() {
    previousStep = step--;
    showCurrentStep();
  });

  $el.find(".next").click(function() {
    previousStep = step++;
    showCurrentStep();
  });

  showCurrentStep();
};
