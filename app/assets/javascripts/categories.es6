 // Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var map; 

$(document).on("turbolinks:load", function(){
	$('.js-search').on('click', function(){
		
		if($('.js-use-loc').prop("checked")){
			getLocationQuickly();		
		}else{ 
			var searchTerm = $('.js-search').val();
			var zip = $('.js-zip').val();
			var miles = $('.js-distance').val();
			var catId = $('.js-cat-id').data("id");
			var maxPrice = $('.js-rent').val();
			var maxDeposit = $('.js-deposit').val();
			var apiUrl ="/api/categories"  + "?category=" + catId + "&miles=" + encodeURI(miles) + "&zip="
			 +zip + "&search=" + encodeURI(searchTerm) + "&deposit=" + encodeURI(maxDeposit) 		
			 + "&price=" + encodeURI(maxPrice);
			console.log(apiUrl);
			$.ajax({
				method: "get",
				url: apiUrl,
				success: function(response){
					updateSearchItems(response);
					updateMap(response, miles);		
				},
				failure: function(error){
					console.log(error);
				}
			});		
		}
		
	})


	



})
function searchWithCurrentLocation(position){
		$('.js-header-search').hide();
		var searchTerm = $('.js-search').val();
		var miles = $('.js-distance').val();
		var catId = $('.js-cat-id').data("id");
		var maxPrice = $('.js-rent').val();
		var maxDeposit = $('.js-deposit').val();
		var lat = encodeURI(position.lat.toString());
		var lng = encodeURI(position.lng.toString());
		var apiUrl ="/api/categories"  + "?category=" + catId + "&miles=" + encodeURI(miles) + "&lat="
			 + lat + "&lng=" + lng + "&search=" + encodeURI(searchTerm) + "&deposit=" + encodeURI(maxDeposit)
			+ "&price=" + encodeURI(maxPrice);
		console.log(apiUrl);
		$.ajax({
			method: "get",
			url: apiUrl,
			success: function(response){
				updateSearchItems(response);
				updateMap(response);	
			}
			,
			failure: function(error){
				console.log(error);
			}
		});

}

function updateSearchItems(response){
		console.log(response);
		
		
		$('.js-cat-items').empty();
		var item_html = ""
		response.items.forEach(function(item){
			item_html += `<div class = "white user-item" >

						<a href = "/items/${item.id}" class = "item-link">
						<div class = "item-box">
					
						
						<img src = "${item.avatar_url}" 

						 class = "item-image"alt = "${item.name}">
						<div class = "item-desc">
						<h5>${item.name}</h5>
						Deposit: ${item.deposit.toFixed(2)} 
						<br>       
						Rental fee: ${item.price.toFixed(2)}
						</div>
			
						</div>	
						</a>
						</div>`;
						
			if (item_html.description != null){
				item_html += `<p>item.description</p>`;
			}
			item_html += `</div></a></div>`;
		});
		if( response.items.length == 0){
			item_html += `<div><h1>No items were found. Please try another search.
			</h1></div>`;
		}
		$('.js-cat-items').append(item_html);
}
function updateMap(response, distance){
	initMapByCoords(response.location);
	response.items.forEach(function(item){
		var marker = new google.maps.Marker({
   		position: {lat: item.user.latitude, lng: item.user.longitude},
   		map: map,		
  	});
	marker.set(map);
	});
	var zoom = 8;
	if (distance < 1)zoom = 16;
	else if (distance < 3)zoom = 15;
	else if (distance < 5)zoom = 14;
	else if (distance < 10)zoom = 13;
	else if (distance < 20)zoom = 12;
	else if (distance < 50)zoom = 10;
	else zoom = 8;

	map.setZoom(zoom);
}
function initMapByCoords(coords){
	map = new google.maps.Map(document.getElementById('map'), {
          center: coords,
          zoom: 8
        });


}
function positionToCoords(position){
	return { lat:  position.coords.latitude , lng: position.coords.longitude};
}
function initMap(position) {
		var coords = positionToCoords(position);
		initMapByCoords(coords)
        
 }
function getCookie(cname) {
    var name = cname + "=";
    var ca = document.cookie.split(';');
    for(var i = 0; i <ca.length; i++) {
        var c = ca[i];
        while (c.charAt(0)==' ') {
            c = c.substring(1);
        }
        if (c.indexOf(name) == 0) {
            return c.substring(name.length,c.length);
        }
    }
    return "";
}
function getLocationQuickly(){
	var options = {timeout: 10000000};
	var lat = getCookie("lat");
	var lng = getCookie("lng");
	if(lat && lng){
		var coords = {lat: lat, lng: lng};
		initMapByCoords(coords);
		searchWithCurrentLocation(coords)

	}else{
 		navigator.geolocation.getCurrentPosition( 
				function(location){
					setGeoCookie(location);
					searchWithCurrentLocation(positionToCoords(location));
				},function(error){
					"Location unavailable"
				},options)
 	}
}


