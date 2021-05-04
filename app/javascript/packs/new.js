$(document).ready(function () {
  console.log("ready!");
  let count = 2

  let addOption = ()=>{
    let opts = document.querySelector("table");
    let row = opts.insertRow(count);
    let cell1 = row.insertCell(0);
    let cell2 = row.insertCell(1);
    let cell3 = row.insertCell(2);


    let cbox = document.createElement("input");
    let cbox_hidden = document.createElement("input");
    let tbox = document.createElement("input");
    let radio = document.createElement("input");
    let br = document.createElement("br");

    cbox.type = "checkbox";
    cbox_hidden.type = "hidden";
    cbox.name = "opt" + count + "_image";
    cbox_hidden.name = "opt" + count + "_image";
    cbox.value = "1";

    tbox.type = "text";
    tbox.name = "opt" + count;
    tbox.placeholder = "Option or Image Url"
    tbox.required = true

    radio.type = "radio";
    radio.value = "opt" + count;
    radio.name = "option";


    cell1.appendChild(radio);
    cell2.appendChild(cbox_hidden);
    cell2.appendChild(cbox);
    cell3.appendChild(tbox);

    document.querySelector(".addOption").value = count;
    count++;
  };

  document.querySelector(".addOption").addEventListener("click",addOption);
});
