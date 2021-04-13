// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start();
require("turbolinks").start();
require("@rails/activestorage").start();
require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).ready(function () {
  console.log("ready!");

  let countdown;
  let submit = document.querySelector('.submit');

  // ajax request for submiting and fetching next question
  let sendResponse = (duration)=>{
    console.log($('form').serialize());
    $.ajax({
      type: "POST",
      url: "/user_questions/send_response",
      data: $('form').serialize(),
      success: function(repsonse){
          document.querySelector('.submit').addEventListener('click',submitEvent);
          startTimer(duration);
        },
      error: function(repsonse){console.log("error")}
    });
  };

  // function for submit event click

  let submitEvent = ()=>{
    clearInterval(countdown);
    sendResponse(10)
  }


  // countdown timer for question
  let startTimer = function(duration) {

    display = document.querySelector('#time');
    if(display == null){
      return null;
    }
    var timer = duration;
    countdown = setInterval(function () {
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        display.innerHTML = "Time Left: " + minutes + ":" + seconds;

        if (--timer < 0) {
            clearInterval(countdown);
            let token = document.querySelector("form").querySelector('input').value;
            sendResponse(duration);
        }
    }, 1000);
  }

  // on click event for submit button
  submit.addEventListener('click',submitEvent);

  startTimer(10);

});
