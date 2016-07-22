$(document).on("turbolinks:load", function(){
	$('.js-register').on('click', function(){
		console.log("Register clicked");
		$('.js-register-modal').modal("show");
	});
	$('.js-login').on('click', function(){
		console.log("Login clicked");
		$('.js-login-modal').modal("show");
	});
})