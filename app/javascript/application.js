// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
// import "custom/table"
//= require bootstrap.min

document.addEventListener("turbo:load", function () {
  setTimeout(function() {
    $('.alert').remove();
  }, 5000);
});

$("#promo_company_id").on("change", function () {
  var compyid = $(this).val();
  console.log($(this).val())
  let frame = document.querySelector("turbo-frame#promo-list");
  frame.src = '/promos?company_id=1&format=turbo_stream'
});