// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

var map; 

$(document).on("turbolinks:load", function(){
	$('.js-change-distance').on('click', function(){
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
			var zip = $('.js-zip').val();
			var miles = $('.js-distance').val();
			var cat_id = $('.js-cat-id').data("id");
			var api_url ="/api/categories/" + cat_id + "?miles=" + encodeURI(miles) + "&zip="
			 +zip;
			console.log(api_url);
			$.ajax({
				method: "get",
				url: api_url,
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
		var miles = $('.js-distance').val();
		var cat_id = $('.js-cat-id').data("id");
		var lat = encodeURI(position.coords.latitude.toString());
		var lng = encodeURI(position.coords.longitude.toString());
		var api_url ="/api/categories/" + cat_id + "?miles=" + encodeURI(miles) + "&lat="
			 + lat + "&lng=" + lng;
		console.log(api_url);
		$.ajax({
			method: "get",
			url: api_url,
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
		$('.js-cat-items').empty();
		response.items.forEach(function(item){
			var item_html = `<div class = "user-item" >
						<a href = "/items/${item.id}">
						<div class = "item-box">
						<h5>${item.name}</h5>
						<hr>`;
						
			if (item_html.description != null){
				item_html += `<p>item.description</p>`;
			}
			item_html += `</div></a></div>`;
			$('.js-cat-items').append(item_html);

			//set markers
			 var marker = new google.maps.Marker({
   				 position: {lat: item.user.latitude, lng: item.user.longitude},
   				 map: map,
   				 label: item.name
    			
  			});
			 marker.set(map);
		})
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


