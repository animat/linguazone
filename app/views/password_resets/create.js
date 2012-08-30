<% if @success %>
	var msg = "An email has been sent to <%= @user.email %> with password reset instructions.";
	$(".wrapper").prepend("<p class='flash_notice flash_msg'>"+msg+"</p>");
	$(".flash_notice").delay(8000).fadeOut(1500);
<% else %>
	var msg = "Sorry! There was a problem sending the password reset instructions to <%= @user.email %>.";
	$(".wrapper").prepend("<p class='flash_error flash_msg'>"+msg+"</p>");
	$(".flash_error").delay(8000).fadeOut(1500);
<% end %>