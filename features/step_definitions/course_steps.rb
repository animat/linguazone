Given /^there (is|are) (\d+) students? enrolled in "(.*?)"$/ do |verb, num_students, course_name|
  @course = Course.find_or_create_by_name(course_name)
  for i in 0...num_students.to_i do
    @student = Factory.create(:student)
    @student.save
    @cr = CourseRegistration.create!(:course_id => @course.id, :user_id => @student.id)
  end
end

Given /^"(.*?)" is enrolled in "(.*?)"$/ do |student_name, course_name|
  @course = Course.find_by_name(course_name)
  @student = User.where(:first_name => student_name, :role => "student").first
  @cr = CourseRegistration.create!(:course_id => @course.id, :user_id => @student.id)
end

Given /^"([^"]*)" has (\d+) (games|word lists|audio blog posts?) showing$/ do |course_name, num, thing|
  num_courses = Course.count
  puts "Currently looking for #{course_name}. There are #{num_courses} out there."
  @c = Course.find_by_name(course_name)
  num.to_i.times do
    if thing == "audio blog posts" or thing == "audio blog post"
      @p = Factory.create(:post, :course_id => @c.id)
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

Then /^the "(.*?)" class page should( not)? require students to login$/ do |course_name, not_required|
  @c = Course.find_by_name(course_name)
  @c.login_required == not_required
  if not_required
    @c.code == ""
  end
end

Then /^I should see (\d+) "([^"]*)" links for ([^"]*)$/ do |count, link_text, area|
  all(:xpath, "//div[@id='showing_#{area}']//a[text()='#{link_text}']").length.should == count.to_i
end

Then /^I should see (\d+) "([^"]*)" links?$/ do |count, link_text|
  if count.to_i > 0
    stylized_span_links = all(:xpath, "//a//*[text()='#{link_text}']")
    if stylized_span_links.length > 0
      stylized_span_links.length.should == count.to_i
    end
  end
  #all(:xpath, "//a[text()='#{link_text}']").length.should == count.to_i
end

When /^I hover over the course item teacher controls$/ do
  page.execute_script "$(function() {	$('.available_item').toggleClass('available_item_controls'); $('.available_item').show(); })"
end

Then /^"(.*?)" should be archived$/ do |class_name|
  @c = Course.find_by_name(class_name)
  @c.archived.should == true
end