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
  let hide_mesages = ()=>{
    let msgs = document.querySelector(".all-messages");
    msgs.style.visibility = 'hidden';
  }
  setTimeout(hide_mesages,3000);

  let show_password = document.querySelector("#show");
  let pass = document.querySelector("#password");
  show_password.checked = false;
  show_password.addEventListener('click',()=>{
    if(show_password.checked)
      pass.type = "text";
    else
      pass.type = "password";
  });

  let cleanUp = ()=>{
    console.log("cleared");
    localStorage.clear();
  }

});
