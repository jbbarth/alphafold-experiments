// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  // Focus on the input when the page loads
  document.addEventListener('htmx:load', function (event) {
    const firstInput = event.target.querySelector('*[autofocus] input[type="text"]:first-of-type')
    if (firstInput) {
      firstInput.focus()
    }
  })

  // HTMX error handling
  document.body.addEventListener("htmx:responseError", function(evt) {
    let error = "Unknown error"
    try {
      error = JSON.parse(evt.detail.xhr.response).error
    } catch {
      // nothing
    }
    $("#notice").html(error).show().delay(3000).hide(200);
  });

  // Submit form on Cmd+Enter
  document.body.addEventListener('keydown', function (e) {
    if (!(e.keyCode === 13 && e.metaKey)) return
    var target = e.target
    if (target.form) {
      target.form.submit()
    }
  })

  // keyboard shortcuts
  $(document).keyup(function(evt) {
    if (!$(evt.target).is(":input")) {
      if (evt.key === "p") {
        // ....
      }
    }
  })

  // copy to clipboard
  new ClipboardJS("[data-clipboard-text]");

  tippy.delegate("body", {
    target: "[data-clipboard-text]",
    interactive: true,
    animateFill: false,
    animation: "fade",
    arrow: true,
    trigger: "click",
    placement: "top",
    content: "Copied!"
  });
})
