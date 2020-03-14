// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/ujs").start()
require("@rails/activestorage").start()
require("channels")


// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)


// ----------------------------------------------------
// Note(lewagon): ABOVE IS RAILS DEFAULT CONFIGURATION
// WRITE YOUR OWN JS STARTING FROM HERE 👇
// ----------------------------------------------------
import "bootstrap";

import { initMapbox } from '../plugins/init_mapbox';
import { initMapboxPlanner } from '../plugins/init_mapbox_planner';
import { plannerDate } from '../components/plannerdate.js';

// Show page map
initMapbox();

// Sets active class on the navbar links
const navLinks = document.querySelectorAll(".big-nav-link")
navLinks.forEach(link => {
  const href = window.location.pathname;
  const strippedHref = link.href.split('/').slice(-1)[0];
  if (window.location.pathname === `/${strippedHref}`) {
    link.classList.add('active-nav');
  }
})

// Sets the active class on the planner page date links
const dateLinks = document.querySelectorAll(".cal-grid-date")
dateLinks.forEach(link => {
  const queryParam = window.location.search
  const data = link.dataset.day;
  if (queryParam.includes(data)) {
    link.classList.add('cal-date-active');
  }
})

// Planner page map
initMapboxPlanner();

// Select date in planner
plannerDate();




