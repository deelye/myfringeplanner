const plannerDate = () => {
  let calDate = document.querySelector(".cal-date")
  const calBtns = document.querySelectorAll(".cal-grid-date")
  calBtns.forEach((btn) => {
    btn.addEventListener("click", (event) => {
      let date = (btn.innerText + " August 2020");
      calDate.value = date;
      document.getElementById("date-form").submit();
    });
  });
}

export { plannerDate };
