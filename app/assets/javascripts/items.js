// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on("ready", function(){
	$('.js-add-item').on('click', function(event){
		event.preventDefault();
		console.log("add new item clicked");
		$('.js-new-item-modal').modal("show");
	});
})