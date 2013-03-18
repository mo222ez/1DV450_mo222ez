$(function () {
	var date_select_fields = $(".date_select_field");
	var project_start_date = $("#id_start_date")[0];
	var project_end_date = $("#id_end_date")[0];

	if (date_select_fields.length != 0) {
		for (var i = 0; i < date_select_fields.length; i++) {
			$(date_select_fields[i]).datepicker({
				format: "yyyy-mm-dd"
			});
		};
	};
})