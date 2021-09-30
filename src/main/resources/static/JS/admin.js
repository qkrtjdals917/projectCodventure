$(document).ready(function() {

	$("#admNotice").click(function() {
		var 
	});

	$(".content").click(function(e) {
		var content = $(".content_sample")
		if (content.has(e.target).length === 0) {
			$(this).hide();
		}
	});

});

function show(mode) {
	if (mode == "notice") {
		$("#adm_content.contentNotice").show();
		$("#adm_content.contentBoard").hide();
	}
}
