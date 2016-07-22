if (window.BorrowABashApp === undefined){
	window.BorrowABashApp = {};
}
BorrowABashApp.init = function(){
	console.log("BorrowABashApp ONLINE");
};

$(document).on("ready", function(){
	BorrowABashApp.init();
});