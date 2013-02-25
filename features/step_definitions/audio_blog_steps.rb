Given /^([^"]*) has left a comment on ([^"]*)'s (\d+)(st|nd|rd|th) post$/ do |student_name, teacher_name, num, suffix|
  @stu = User.find_by_first_name(student_name)
  @tea = User.find_by_first_name(teacher_name)
  @post = Post.find(num)
  @ap = AvailablePost.where(["user_id = ? and post_id = ? and course_id != 0", @tea.id, @post.id]).first
  puts "I found the post! See? #{@post.title}."
  # TODO: At this point I'm just scared of using FactoryGirl. Halp!
  @comment = Comment.create!(:user_id => @stu.id, :available_post_id => @ap.id, :content => "Sample comment post")
  puts "And look! There goes the comment! #{@comment.content}."
end

Then /^the (\d+)st comment should have a rating of (\d+)$/ do |arg1, arg2|
  pending # express the regexp above with the code you wish you had
end

Then /^the (\d+)(st|nd|rd|th) comment should have a note that says "([^"]*)"$/ do |num, suffix, msg|
  #@c = Comment.find(num.to_i)
  #puts "See? I found the comment. It is #{@c} and the teacher note is #{@c.teacher_note}."
  #@c.teacher_note.should_not == nil
  find(:xpath, "//p[@id='comment_#{num}_teacher_note_content']").should have_content(msg)
end

When /^I hover over the comment teacher controls$/ do
  page.execute_script "$(function() {	$('.hide_controls').toggleClass('controls'); $('.new_comment_teacher_note').show(); })"
end