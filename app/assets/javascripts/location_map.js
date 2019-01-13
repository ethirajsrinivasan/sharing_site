$(document).ready(function() { 
	if($("#map").length == 1) {

    var latitude = $("#map").data("latitude")
    var longitude = $("#map").data("longitude")
    var marker_path = $("#map").data("markerpath")
		var map = new ol.Map({
	    target: 'map',
	    layers: [
	      new ol.layer.Tile({
	        source: new ol.source.OSM()
	      })
	    ],
	    view: new ol.View({
	      center: ol.proj.fromLonLat([longitude, latitude]),
	      zoom: 4
	    })
	  });
	      
	  var iconFeatures=[]; 
	  var iconFeature = new ol.Feature({
		geometry: new ol.geom.Point(ol.proj.transform([longitude, latitude], 'EPSG:4326', 'EPSG:3857'))});

	  iconFeatures.push(iconFeature);

	  var vectorSource = new ol.source.Vector({features: iconFeatures });

	  var iconStyle = new ol.style.Style({
		  image: new ol.style.Icon(/** @type {olx.style.IconOptions} */ ({
		    anchor: [0.5, 46],
		    anchorXUnits: 'fraction',
		    anchorYUnits: 'pixels',
		    opacity: 0.75,
		    src: marker_path
		  }))
		});
	      
	  var vectorLayer = new ol.layer.Vector({
		  source: vectorSource,
		  style: iconStyle
		});

	  map.addLayer(vectorLayer);
	}
});