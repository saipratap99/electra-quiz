// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

// require("@rails/ujs").start();
// require("turbolinks").start();
// require("@rails/activestorage").start();
// require("channels");

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)

$(document).ready(function () {
  console.log("ready!");

  // setting localStorage
  let duration;
  if (localStorage.length === 0){
    duration = 60;
    localStorage.setItem("duration","60");
  }else{
    duration = localStorage.getItem("duration");
  }

  ///

  let countdown;
  let submit = document.querySelector('.submit');
  let skip = document.querySelector('.skip');

  let hide_mesages = ()=>{
    let msgs = document.querySelector(".all-messages");
    msgs.style.visibility = 'hidden';
  }

  // ajax request for submiting and fetching next question
  let sendResponse = (duration,params)=>{
    $.ajax({
      type: "POST",
      url: "/user_questions/send_response",
      data: params,
      success: function(repsonse){
          document.querySelector('.submit').addEventListener('click',submitEvent);
          document.querySelector('.skip').addEventListener('click',skipEvent);
          startTimer(duration);
          document.querySelector(".all-messages").style.visibility = 'visible';
          setTimeout(hide_mesages,3000);
        },
      error: function(repsonse){
        console.log("error");
        localStorage.duration = "60";
      }
    });
  };

  // function for submit event click

  let submitEvent = ()=>{
    let val = $("input[type='radio'][name='option']:checked").val();
    if(val){
      let params = $("form").serialize() + '&commit=submit';
      clearInterval(countdown);
      // localStorage
      localStorage.duration = "60"
      sendResponse(1*60,params);
    }
  }

  let skipEvent = ()=>{
    let params = 'commit=skip';
    removeRequired();
    clearInterval(countdown);
    // localStorage
    localStorage.duration = "60"
    sendResponse(1*60,params);
  }

  let removeRequired = ()=>{
    // un-require required fields for skip button
    let items = [...document.getElementsByClassName('options')];
    items.forEach((item)=>{
      item.required = false;
    });
  };

  // countdown timer for question
  let startTimer = function(duration) {

    let display = document.querySelector('#time');
    var timer = duration;
    countdown = setInterval(function () {
        if(document.querySelector("#time") == null){
          localStorage.clear();
        }
        minutes = parseInt(timer / 60, 10);
        seconds = parseInt(timer % 60, 10);

        minutes = minutes < 10 ? "0" + minutes : minutes;
        seconds = seconds < 10 ? "0" + seconds : seconds;

        // localStorage
        if(localStorage.length != 0){
          localStorage.duration = seconds;
        }
        if(seconds == 10){
          display.style.color = '#ea5151';
        }
        display.innerHTML = "Time Left: " + minutes + ":" + seconds;
        if (--timer < 0) {
            let params = $("form").serialize();
            clearInterval(countdown);
            sendResponse(60,params);
        }
    }, 1000);
  }

  // on click event for submit and skip buttons
  submit.addEventListener('click',submitEvent);
  skip.addEventListener('click',skipEvent);

  startTimer(duration);

});
