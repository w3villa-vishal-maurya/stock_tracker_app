// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
import $ from 'jquery' // Import jQuery
import 'bootstrap'

$(document).on('turbolinks:load', function() {
  // Add a click event handler to the toggle button
  $('.navbar-toggler').on('click', function() {
    // Toggle the collapse element to open or close the menu
    $('#navbarSupportedContent').toggleClass('show');
  });

  // Close the menu when clicking outside of it
  $(document).on('click', function(e) {
    if (!$(e.target).closest('.navbar').length) {
      $('#navbarSupportedContent').removeClass('show');
    }
  });
});
