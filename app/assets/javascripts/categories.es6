// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on("turbolinks:load", function(){
	$('.js-change-distance').on('click', function(){
		var miles = $('.js-distance').val();
		var cat_id = $('.js-cat-id').data("id");
		$.ajax({
			method: "get",
			url: "/api/categories/" + cat_id + "/" + miles,
			success: updateSearchItems,
			failure: function(error){
				console.log(error);
			}
		});
	})
	function updateSearchItems(response){
		console.log(response);
		//TODO: Write code to show the items that are found!
	}
})