const setPlanner = () => {
  console.log("hello")
  let element = document.getElementById("day")
  console.log(element)
  element.addEventListener('change', (event) => {
    console.log(element.value)
    let url = `/planner?day=${element.value}`

    console.log(url)
  //   $.ajax({
  //     url: url,
  //     method: "get",
  //     data: {
  //       day: element.value
  //     } ,
  //     success: function(data) {},
  //     error: function(data) {}
  //   })
  });
}

export { setPlanner };

