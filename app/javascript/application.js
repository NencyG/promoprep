// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "./main"
import "@nathanvda/cocoon"
//= require bootstrap.min

document.addEventListener("turbo:load", function () {
  setTimeout(function() {
    $('.alert').remove();
  }, 5000);
});
