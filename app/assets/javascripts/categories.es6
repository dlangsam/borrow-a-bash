// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var map; 

$(document).on("turbolinks:load", function(){
	$('.js-search').on('click', function(){
		var options = {timeout: 10000000};
		if($('.js-use-loc').prop("checked")){
			navigator.geolocation.getCurrentPosition( 
				function(location){
					setGeoCookie(location);
					searchWithCurrentLocation(location);
				},function(error){
					"Location unavailable"
				},options)
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
					updateSearchItems(response)		
				},
				failure: function(error){
					console.log(error);
				}
			});		
		}
		
	})


	



})
function searchWithCurrentLocation(position){
		
		var searchTerm = $('.js-search-term').val();
		var miles = $('.js-distance').val();
		var catId = $('.js-cat-id').data("id");
		var maxPrice = $('.js-rent').val();
		var maxDeposit = $('.js-deposit').val();
		var lat = encodeURI(position.coords.latitude.toString());
		var lng = encodeURI(position.coords.longitude.toString());
		var apiUrl ="/api/categories"  + "?category=" + catId + "&miles=" + encodeURI(miles) + "&lat="
			 + lat + "&lng=" + lng + "&search=" + encodeURI(searchTerm) + "&deposit=" + encodeURI(maxDeposit)
			+ "&price=" + encodeURI(maxPrice);
		console.log(apiUrl);
		$.ajax({
			method: "get",
			url: apiUrl,
			success: function(response){
				updateSearchItems(response, position)		
			}
			,
			failure: function(error){
				console.log(error);
			}
		});

}

function updateSearchItems(response){
		console.log(response);
		initMapByCoords(response.location);
		$('.js-header-search').hide();
		$('.js-cat-items').empty();
		response.items.forEach(function(item){
			var item_html = `<div class = "white user-item" >

						<a href = "/items/${item.id}" class = "item-link">
						<div class = "item-box">
					
						
						<img src = "${item.avatar_url}" 

						 class = "item-image"alt = "${item.name}">
						<div class = "item-desc">
						<h5>${item.name}</h5>
						Deposit: ${item.deposit.toFixed(2)}        
						Rental fee: ${item.price.toFixed(2)}
						</div>
			
						</div>	
						</a>
						</div>`;
						
			if (item_html.description != null){
				item_html += `<p>item.description</p>`;
			}
			item_html += `</div></a></div>`;
			$('.js-cat-items').append(item_html);

			//set markers
			 var marker = new google.maps.Marker({
   				 position: {lat: item.user.latitude, lng: item.user.longitude},
   				 map: map,
   				 
    			
  			});
			 marker.set(map);
		});
		if( response.items.length == 0){
			var no_items_found = `<div><h1>No items were found. Please try another search.
			</h1></div>`;
			$('.js-cat-items').append(no_items_found);

		}
}

function initMapByCoords(coords){
	map = new google.maps.Map(document.getElementById('map'), {
          center: coords,
          zoom: 8
        });


}
function initMap(position) {
		var coords = { lat:  position.coords.latitude , lng: position.coords.longitude};
		initMapByCoords(coords)
        
 }


