if (navigator.geolocation) {
		navigator.geolocation.getCurrentPosition(showPosition);
	} 

	function showPosition(position){
		var url = 	"url(http://maps.googleapis.com/maps/api/staticmap?center="+
		position.coords.latitude+
		","+
		position.coords.longitude+
		"&scale=2&zoom=13&"+
		"format=png&sensor=false&size=640x480&"+
		"maptype=roadmap&style=feature:road.highway|visibility:off&"+
		"style=feature:road.arterial|visibility:off&"+
		"style=feature:transit.station|visibility:off&"+
		"style=saturation:-81|hue:0x08ff00|lightness:-40|gamma:0.2&"+
		"style=feature:administrative.neighborhood|visibility:off&"+
		"style=feature:poi|element:labels|visibility:off)";

		document.getElementById("welcome").style.backgroundImage=url;
	}
