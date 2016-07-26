if (window.BorrowABashApp === undefined){
	window.BorrowABashApp = {};
}
BorrowABashApp.init = function(){
	console.log("BorrowABashApp ONLINE");
};

$(document).on("ready", function(){
	if("geolocation" in navigator){
		console.log("Broswer has geolocation");
		var options = {timeout: 10000000};
		navigator.geolocation.getCurrentPosition(showPosition, handleError, options);
	}else{
		var html = `
		<h2>Update your browser. </h2>
		`;
		$("body").append(html);
		console.log("Browser doesn't have geolation");
	}
	BorrowABashApp.init();


		function showPosition(position){
		console.log("User consented to give location");
		console.log(position);

		var lat = position.coords.latitude;
		var lng = position.coords.longitude;
		var html = 
		`<h2> Your position </h2>
		<ul>
		<li> Latitude: ${lat} </li>
		<li> Longitude: ${lng} </li>
		</ul>`;

		/*mapURL = `https://maps.googleapis.com/maps/api/staticmap?center=${lat},${lng}&size=640x400&zoom=15`
		img = `<img src = ${mapURL}>`*/

		$("body").append(html);
		/*$("body").append(img);*/

	}
	function handleError(error){
		console.log("There is an error.");
		console.log(error);
		if(error.code == 1){
			var html = `<h2>Come on! Give me your location. </h2>`;
			$("body").append(html);
		}

	}
});