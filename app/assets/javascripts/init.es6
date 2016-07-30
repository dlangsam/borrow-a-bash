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
		navigator.geolocation.getCurrentPosition(getGeoLocation, handleError, options);
	}else{
		var html = `
		<h2>Update your browser. </h2>
		`;
		$("body").append(html);
		console.log("Browser doesn't have geolation");
	}
	BorrowABashApp.init();


	function handleError(error){
		console.log("There is an error.");
		console.log(error);
		if(error.code == 1){
			var html = `<h2>Come on! Give me your location. </h2>`;
			$("body").append(html);
		}

	}
});

function getGeoLocation(position) {
  setGeoCookie(position);
}

function setGeoCookie(position) {
  document.cookie = `lat=${position.coords.latitude}`
  document.cookie = `lng=${position.coords.longitude}`
}




