$(function () {
	$("div[class*='termlist_select']").click(function() {
		if($(this).data("selected") == false) {
			$(this).data("selected", true);
			$(this).removeClass("btn-light");
			$(this).addClass("btn-success");
		} else {
			$(this).data("selected", false);
			$(this).removeClass("btn-success");
			$(this).addClass("btn-light");
		}
	});
});
