$(function () {
	$("div[class*='termlist_select']").click(function() {
		if($(this).data("selected") == false) {
			$(this).data("selected", true);
			$(this).removeClass("btn-light");
			$(this).addClass("btn-success");
			if($(this).data("level") == "material") {
				values = $("#selected_materials").val();
				if(values.indexOf("1") == -1) {
					values.push("1");
					$("#selected_materials").val(values);
				}
			}
		} else {
			$(this).data("selected", false);
			$(this).removeClass("btn-success");
			$(this).addClass("btn-light");
		}
	});
});
