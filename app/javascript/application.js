// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("DOMContentLoaded", function() {
  const btn = document.getElementById("back-to-top");

  if (btn) {
    window.addEventListener("scroll", function() {
      const pageHeight = document.body.scrollHeight;
      const windowHeight = window.innerHeight;

      // Show only if page is taller than viewport AND scrolled past one screen
      if (pageHeight > windowHeight && window.scrollY > windowHeight) {
        btn.style.display = "block";
      } else {
        btn.style.display = "none";
      }
    });

    btn.addEventListener("click", function(e) {
      e.preventDefault();
      window.scrollTo({ top: 0, behavior: "smooth" });
    });
  }
});
