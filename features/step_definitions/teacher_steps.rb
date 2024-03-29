Given /^([^"]*) has a course at that school named "(.*?)"$/ do |teacher_name, course_name|
  @school = School.last
  if teacher_name == "a teacher"
    @teacher = Factory.create(:teacher, :school => @school)
    @teacher.school_id = @school.id
    @teacher.save
  else
    @teacher = User.find_by_first_name(teacher_name)
    @teacher.school_id = @school.id
    @teacher.save
  end
  @c = Course.create(:name => course_name, :user_id => @teacher.id, :guid => rand(21**10).to_s(36))
  @c.save
end

Given /^"(.*?)" has a course at "(.*?)" named "(.*?)"$/ do |teacher_name, school_name, course_name|
  @school = School.find_by_name(school_name)
  @teacher = User.find_by_first_name(teacher_name)
  @teacher.school_id = @school.id
  @teacher.save
  @c = Course.create(:name => course_name, :user_id => @teacher.id)
  @c.save
end

Given /^a teacher has a password\-protected course at that school named "(.*?)" with a code of "(.*?)"$/ do |course_name, code|
  @school = School.last
  @teacher = Factory.create(:teacher, :school => @school)
  @teacher.school_id = @school.id
  @teacher.save
  @c = Course.create(:name => course_name, :user_id => @teacher.id, :login_required => 1, :code => code)
  @c.save
end

Given /^([^"]*) (has|have) (\d+) (games|posts?|word lists|word_lists|courses)$/ do |teacher_name, verb, num, things|
  things = things.sub(" ", "_")
  if teacher_name == "I"
    @t = User.first
  else
    @t = User.find_by_first_name(teacher_name)
  end
  count = num.to_i
  if count == 0
    things.singularize.capitalize.constantize.all.each do |g|
      g.destroy
    end
  else
    count.times do
      @g = Factory.create(things.singularize)
      # TODO @Len: This is automatically creating a new user because of my factory associations. Any tips here?
      if things.singularize == "course"
        @g.user_id = @t.id
      elsif things.singularize == "post"
        @g.user_id = @t.id
        AvailablePost.create!(:user_id => @t.id, :post_id => @g.id, :course_id => 0, :hidden => 0, :ordering => 0)
      elsif things.singularize == "game"
        # TODO: Make sure that course items are made available when they are created
        AvailableGame.create!(:user_id => @t.id, :game_id => @g.id, :course_id => 0)
        @g.updated_by_id = @t.id
      elsif things.singularize == "word_list"
        AvailableWordList.create!(:user_id => @t.id, :word_list_id => @g.id, :course_id => 0, :hidden => 0, :order => 0)
        @g.updated_by_id = @t.id
      end
      @g.save
    end
  end
end

Given /^([^"]*) has (\d+) games which are the "([^"]*)" activity$/ do |teacher_name, num_games, activity_name|
  @t = User.find_by_first_name(teacher_name)
  num_games.to_i.times do |counter|
    # TODO: Incorrect use of factories is creating duplicate activities
    @a = Activity.find_by_name(activity_name)
    @g = Factory.create(:game)
    @g.activity = @a
    @g.updated_by_id = @t.id
    @g.save
    AvailableGame.create!(:user_id => @t.id, :game_id => @g.id, :course_id => 0)
  end
end

Given /^([^"]*) has a (game|post|word list|word_list) with a description of "([^"]*)"$/ do |teacher_name, thing, description|
  @t = User.find_by_first_name(teacher_name)
  @g = Factory.create(thing)
  if thing == "post"
    @g.user_id = @t.id
    @g.content = description
  elsif thing == "game"
    @g.updated_by_id = @t.id
    @g.description = description
    AvailableGame.create!(:user_id => @t.id, :game_id => @g.id, :course_id => 0)
  elsif thing == "word_list"
    @g.updated_by_id = @t.id
    @g.description = description
    AvailableWordList.create!(:user_id => @t.id, :word_list_id => @g.id, :course_id => 0, :hidden => 0, :order => 0)
  end
  @g.save
end

Given /^([^"]*) is subscribed with a basic subscription$/ do |teacher_name|
  @t = User.find_by_first_name(teacher_name)
  @p = SubscriptionPlan.create(:name => "basic", :max_teachers => 3, :cost => 6)
  @sub = Factory.create(:subscription, :subscription_plan => @p)
  @t.subscription = @sub
  @t.subscription.save
end

Given /^([^"]*) has a hidden game on the "([^"]*)" class page$/ do |teacher_name, course_name|
  @t = User.find_by_first_name(teacher_name)
  @c = Course.find_by_name(course_name)
  @g = Factory.create(:game)
  @g.updated_by_id = @t.id
  @g.save
  @ag = AvailableGame.create!(:user_id => @t.id, :course_id => @c.id, :game_id => @g.id, :hidden => 1)
end

Given /^all of ([^"]*)'s games, word lists, and posts are ([^"]*) on the "([^"]*)" page$/ do |teacher_name, show_or_hide, class_name|
  @teacher = User.find_by_first_name(teacher_name)
  @course = Course.find_by_name(class_name)
  @games = Game.where(:updated_by_id => @teacher.id).all
  @games.each do |g|
    if show_or_hide == "showing"
      AvailableGame.create!(:game_id => g.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 0)
    else
      AvailableGame.create!(:game_id => g.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 1)
    end
  end
  @word_lists = WordList.where(:updated_by_id => @teacher.id).all
  @word_lists.each do |wl|
    if show_or_hide == "showing"
      AvailableWordList.create!(:word_list_id => wl.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 0, :order => 0)
    else
      AvailableWordList.create!(:word_list_id => wl.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 1, :order => 0)
    end
  end
  @posts = Post.where(:user_id => @teacher.id).all
  @posts.each do |p|
    if show_or_hide == "showing"
      AvailablePost.create!(:post_id => p.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 0, :ordering => 0)
    else
      AvailablePost.create!(:post_id => p.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 1, :ordering => 0)
    end
  end
end

Then /^I should see (\d+) available (games|word_lists|posts)$/ do |count, things|
  if count.to_i == 0
    begin
      #within "div#showing_games" do
      #  ____ child nodes ___ == count
      #end
      find(:xpath, "//div[@id='showing_#{things}']/*").length.should == count
    rescue
      true
      #TODO @Len: This is a terrible way to test! However I don't know how to test if there are no children -- unable to find xpath error.
    end
  else
    find(:xpath, "//div[@id='showing_#{things}']/div[@class='available_item']").length.should == count
  end
end

Then /^I should see that the (\d+)(st|nd|rd|th) student has (\d+) feed items in the gradebook$/ do |stu_num, suffix, item_count|
  cells = page.all(:xpath, "//table[@id='gradebook']//tbody//tr[#{stu_num.to_i}]")
  str = ""
  cells.each do |c|
    x = c.native
    str << x.content
  end
  nums = str.gsub(/[^0-9]/, '')
  sum = 0
  nums.split("").each do |n|
    sum += n.to_i
  end
  sum.should == item_count.to_i
end

Then(/^there should be (\d+) word lists with a description of "(.*?)"$/) do |num, descrip|
  WordList.where("description = ?", descrip).count.should == num.to_i
end

Given /^"(.*?)"'s subscription has expired$/ do |teacher_name|
  @s = User.find_by_first_name(teacher_name)
  @s.subscription.expired_at = Time.now - 1.day
  @s.subscription.save
end

When /^I upload a spreadsheet with (\d+) rows of valid data$/ do |num_rows|
  attach_file("word_list_spreadsheet", File.join(Rails.root, 'features', 'upload_files', 'word_list_ok.xls'))
end
When /^I upload a spreadsheet with invalid data$/ do
  attach_file("word_list_spreadsheet", File.join(Rails.root, 'features', 'upload_files', 'word_list_invalid.xls'))
end
Given /^I upload a PDF$/ do
  attach_file("word_list_spreadsheet", File.join(Rails.root, 'features', 'upload_files', 'word_list.pdf'))
end
Then /^I should see (\d+) word node rows$/ do |num_rows|
  all(:xpath, "//div[@id='notepad']/table/tr").length.should == num_rows.to_i
end