import mapboxgl from 'mapbox-gl';

const initMapboxPlanner = () => {
  const mapElement = document.getElementById('planner-map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker =>
      bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };

  const addMarkersToMap = (map, markers) => {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.plannerInfoWindow);

      // const element = document.createElement('div');
      // element.className = 'marker';
      // element.style.width = '100px';
      // element.style.height = '100px';

      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
    });
  };

  if (mapElement) {
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'planner-map',
      style: 'mapbox://styles/mapbox/streets-v10'
    });

    const markers = JSON.parse(mapElement.dataset.markers);
    markers.forEach((marker) => {
      console.log("hello")

      const element = document.createElement('div');
      element.className = 'marker';
      element.style.width = '100px';
      element.style.height = '100px';

      new mapboxgl.Marker(element)
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(map);
    });

    addMarkersToMap(map, markers);
    fitMapToMarkers(map, markers);
  };
}

export { initMapboxPlanner };
