Given /^([^"]*) has left a comment on ([^"]*)'s (\d+)(st|nd|rd|th) post$/ do |student_name, teacher_name, num, suffix|
  #@stu = User.find_by_first_name(student_name)
  #@tea = User.find_by_first_name(teacher_name)
  #@post = Post.find(num)
  #@ap = AvailablePost.where(["user_id = ? and post_id = ? and course_id != 0", @tea.id, @post.id]).first
  ## TODO: At this point I'm just scared of using FactoryGirl. Halp!
  #@comment = Comment.create!(:user_id => @stu.id, :available_post_id => @ap.id, :content => "Sample comment post")
  steps %Q{
    Given I am logged in as the student "Bob"
		And I am on the "Sample class" class page
		And I follow the 1st link within the 1st post area
		And I fill in "Your comment:" with "Sample comment goes here"
		And I press "Submit"
		And I have logged out
  }
end

When /^I follow the (\d+)(st|nd|rd|th) star rating link$/ do |num, suffix|
  find(:xpath, "//a[@class[contains(., 'rate_comment_star')]][#{num}]").click
end

Then /^there should be a rating of (\d+)$/ do |num|
  find(:xpath, "(//*[@class[contains(., 'numerical_rating')]])[last()]").should have_text(num.to_s)
end

Then /^the (\d+)(st|nd|rd|th) comment should have a note that says "([^"]*)"$/ do |num, suffix, msg|
  #@c = Comment.find(num.to_i)
  #puts "See? I found the comment. It is #{@c} and the teacher note is #{@c.teacher_note}."
  #@c.teacher_note.should_not == nil
  find(:xpath, "//p[@id='comment_#{num}_teacher_note_content']").should have_content(msg)
end

When /^I hover over the comment teacher controls$/ do
  page.execute_script "$(function() {	$('.hide_controls').removeClass('hide_controls').addClass('controls'); $('.new_comment_teacher_note').show(); })"
end