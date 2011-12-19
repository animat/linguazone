Given /^I have (\d+) posts$/ do |num|
  count = num.to_i
  if count == 0
    Post.all.each do |p|
      p.destroy
    end
  else
    count.times do |count|
      @post = Factory.create(:post)
      @post.save
    end
  end
end

Given /^I have (\d+) games$/ do |num|
  count = num.to_i
  if count == 0
    Game.all.each do |g|
      g.destroy
    end
  else
    count.times do |count|
      @game = Factory.create(:game)
      @game.save
    end
  end
end

Given /^I have (\d+) courses$/ do |num|
  count = num.to_i
  if count == 0
    Course.all.each do |c|
      c.destroy
    end
  else
    count.times do |count|
      @course = Factory.create(:course)
      @course.save
    end
  end
end

# TODO: Is this an appropriate way to use factories? Create then update?
Given /^"([^"]*)" has (\d+) ([^"]*)$/ do |name, num, things|
  @t = User.find_by_first_name(name)
  count = num.to_i
  if count == 0
    things.singularize.constantize.all.each do |g|
      g.destroy
    end
  else
    count.times do |t|
      @g = Factory.create(things.singularize)
      @g.updated_by_id = @t.id
      @g.save
    end
  end
end

Given /^"([^"]*)" has (\d+) games which are the "([^"]*)" activity$/ do |teacher_name, num_games, activity_name|
  @t = User.find_by_first_name(teacher_name)
  num_games.to_i.times do |activity_name|
    @a = Activity.find_by_name(activity_name)
    @g = Factory.create(:game)
    @g.activity = @a
    @g.updated_by_id = @t.id
    @g.save
  end
end

Given /^"([^"]*)" has a ([^"]*) with a description of "([^"]*)"$/ do |teacher_name, thing, description|
  @t = User.find_by_first_name(teacher_name)
  @g = Factory.create(thing)
  @g.updated_by_id = @t.id
  @g.description = description
  @g.save
end