// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).on("turbolinks:load", function(){
	$('.js-add-item').on('click', function(event){
		event.preventDefault();
		console.log("add new item clicked");
		$('.js-new-item-modal').modal("show");
	});

	$('.js-add-new-item').on('click', function(event){
		event.preventDefault();
		console.log("Adding new item")
		var id = $('.js-user-id').val();
		console.log(id);
		var name = $('.js-item-name').val();
		var desc = $('.js-item-desc').val();
		var select =  $('#item_category_ids'); //$('#item-category-ids');
		var cat_id = select.val();
		var image = document.getElementById('item_avatar').value;
		/*var file =  $('#item_avatar'); //$('#item-category-ids');
		var image = file.text();*/
		console.log("Cat id: " + cat_id);
		console.log(name);
		console.log(desc);
		console.log(image);
		$.ajax({
		 	method: "post",  
		 	url: "/api/users/" + id + "/items",
		 	data: {item: {name: name, description: desc, user_id: id}, category_id: cat_id },
		 	success: updateItems,
		 	failure: function(error){
		 		console.log(error);
		 	}
		 })
	});
	$('.js-item-toggle-activation').on('click', function(event){
		event.preventDefault();
		var id = $(this).data("id");
		console.log(id)	
		$.ajax({
			method: "patch",
			url: "/api/items/" + id + "/change_activation",
			success: updateItemPublishedView,
			failure: function(error){
				console.log(error);
			}
		});
	})
	$('.js-remove-image').on('click', function(event){
		event.preventDefault();
		var id = $(this).data("id");
		console.log(id)	
		$.ajax({
			method: "patch",
			url: "/api/items/" + id + "/remove_image",
			success: updateImageRemove,
			failure: function(error){
				console.log(error);
			}
		});
	});

	function updateItems(response){
		console.log(response);
		//make the div for the new item
		var html = `<div class = "user-item" >
		<a href = "/user/${response.user_id}/items/${response.id}">
		<div class = "item-box">
		
		<h5>${response.name}</h5>
		<hr>`;
		
		if(response.description){
			html += `<p>${response.description}</p>`;
		}
		html += '</div></a></div>';
		$('.user-items').append(html);
		$('.js-new-item-modal').modal("hide");
		$('.js-new-item-image-modal').modal("show");
		/*$('.js-new-item-modal').modal("hide");*/		
	}

	function updateItemPublishedView(response){
		console.log(response)
		if(response.is_published) $('.js-item-toggle-activation').text("Deactivate");
		else $('.js-item-toggle-activation').text("Activate");
		$('.js-user-item').toggleClass('deactivated');
	}
	function updateImageRemove(response){
		console.log(response)
		$('.js-remove-image').toggle("hidden");
	}
})