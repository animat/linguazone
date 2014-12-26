$(function() {
	if ($(".flash_msg")) {
		
		$(".flash_msg").css('cursor', 'pointer');
		$(".flash_msg").click(function() {
			$(".flash_msg").fadeOut(750);
		})
	}
})
