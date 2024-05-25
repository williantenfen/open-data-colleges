// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails";
import "controllers";

function initMap(lat, lng) {
  if (!lat || !lng) {
    new google.maps.Map(document.getElementById("map"), {
      zoom: 10,
      center: { lat: -34.397, lng: 150.644 },
    });
  } else {
    const latidute = parseFloat(lat);
    const longitude = parseFloat(lng);

    const map = new google.maps.Map(document.getElementById("map"), {
      zoom: 10,
      center: { lat: latidute, lng: longitude },
    });

    const marker = new google.maps.Marker({
      position: { lat: latidute, lng: longitude },
      map: map,
    });

    const infowindow = new google.maps.InfoWindow({
      content: "<p>Marker Location:" + marker.getPosition() + "</p>",
    });

    google.maps.event.addListener(marker, "click", () => {
      infowindow.open(map, marker);
    });
  }
}

window.initMap = initMap;

window.nextPage = function () {
  const form = document.querySelector("form");
  const pageInput = form.querySelector('input[name="page"]');
  pageInput.value = parseInt(pageInput.value) + 1;
  form.requestSubmit();
};
