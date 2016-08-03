if (window.BorrowABashApp === undefined){
	window.BorrowABashApp = {};
}
BorrowABashApp.init = function(){
	console.log("BorrowABashApp ONLINE");
};

$(document).on("turbolinks:load", function(){

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
	//if (/^\/categories/.test(window.location.pathname) { // do stuff here }`
	//FIXME!!!!!!
	console.log("Get geolocation quickly")
	getLocationQuickly();  
	

	function handleError(error){
		console.log("There is an error.");
		console.log(error);
	}

	window.onresize = function() {
    if (window.innerHeight >= 820) { /* ... */ }
    if (window.innerWidth <= 1130) {  
    	// $('.navbar-collapse').removeClass("collapse");
    	// $('.navbar-collapse').addClass("collapsed");
    /* ... */ }
}
});

function getGeoLocation(position) {
  setGeoCookie(position);
}

function setGeoCookie(position) {
  document.cookie = `lat=${position.coords.latitude}`
  document.cookie = `lng=${position.coords.longitude}`
}




