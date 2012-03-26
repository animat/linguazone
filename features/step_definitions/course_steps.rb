Given /^"([^"]*)" has (\d+) (games|word lists|audio blog posts) showing$/ do |course_name, num, thing|
  @c = Course.find_by_name(course_name)
  num.to_i.times do
    if thing == "audio blog posts"
      @p = Factory.create(:post)
      @p.course_id = @c.id
      @ap = AvailablePost.create!(:course_id => @c.id, :user_id => 0, :post_id => @p.id, :hidden => 0, :ordering => 0)
    elsif thing == "word lists"
      @wl = Factory.create(:word_list)
      @awl = AvailableWordList.create!(:course_id => @c.id, :word_list_id => @wl.id, :hidden => 0, :order => 0)
    elsif thing == "games"
      @g = Factory.create(:game)
      @ag = AvailableGame.create!(:course_id => @c.id, :game_id => @g.id, :hidden => 0, :ordering => 0)
    end
  end
end

Given /^the course "([^"]*)" has a code of "([^"]*)"$/ do |course_name, code|
  @c = Course.find_by_name(course_name)
  if code == ""
    @c.login_required = false
    @c.code = ""
  else
    @c.login_required = true
    @c.code = code
  end
  @c.save
end

Then /^I should see (\d+) "([^"]*)" links for ([^"]*)$/ do |count, link_text, area|
  all(:xpath, "//div[@id='showing_#{area}']//a[text()='#{link_text}']").length.should == count.to_i
end

Then /^I should see (\d+) "([^"]*)" links?$/ do |count, link_text|
  all(:xpath, "//a[text()='#{link_text}']").length.should == count.to_i
end

When /^I hover over the course item teacher controls$/ do
  page.execute_script "$(function() {	$('.available_item').toggleClass('available_item_controls'); })"
end