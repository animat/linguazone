Given /^([^"]*) (has|have) (\d+) (games|posts|word lists|word_lists|courses)$/ do |teacher_name, verb, num, things|
  things = "word_lists" if things == "word lists" # TODO: Is there a Ruby command that will do this for me?
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
      if things.singularize == "post" || things.singularize == "course"
        @g.user_id = @t.id
      elsif things.singularize == "game"
        # TODO: Make sure that course items are made available when they are created
        AvailableGame.create!(:user_id => @t.id, :game_id => @g.id, :course_id => 0)
        @g.updated_by_id = @t.id
      elsif things.singularize == "WordList"
        AvailableWordList.create!(:user_id => @t.id, :word_list_id => @g.id, :course_id => 0)
        @g.updated_by_id = @t.id
      end
      @g.save
    end
  end
end

Given /^([^"]*) has (\d+) games which are the "([^"]*)" activity$/ do |teacher_name, num_games, activity_name|
  @t = User.find_by_first_name(teacher_name)
  num_games.to_i.times do |counter|
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
  else
    @g.updated_by_id = @t.id
    @g.description = description
    AvailableGame.create!(:user_id => @t.id, :game_id => @g.id, :course_id => 0)
  end
  @g.save
end

Given /^([^"]*) is subscribed with a basic subscription$/ do |teacher_name|
  @t = User.find_by_first_name(teacher_name)
  @p = SubscriptionPlan.create(:name => "basic", :max_teachers => 3, :cost => 6)
  @t.subscription.subscription_plan = @p
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

Given /^all of ([^"]*)'s games, word lists, and posts are showing on the "([^"]*)" page$/ do |teacher_name, class_name|
  @teacher = User.find_by_first_name(teacher_name)
  @course = Course.find_by_name(class_name)
  @games = Game.where(:updated_by_id => @teacher.id).all
  @games.each do |g|
    AvailableGame.create!(:game_id => g.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 0)
  end
  @word_lists = WordList.where(:updated_by_id => @teacher.id).all
  @word_lists.each do |wl|
    AvailableWordList.create!(:word_list_id => wl.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 0)
  end
  @posts = Post.where(:user_id => @teacher.id).all
  @posts.each do |p|
    AvailablePost.create!(:post_id => p.id, :user_id => @teacher.id, :course_id => @course.id, :hidden => 0, :ordering => 0)
  end
end

Then /^I should only see one game$/ do
  find(:xpath, "//div[@class='showing_games']/available_item").should == 1
end