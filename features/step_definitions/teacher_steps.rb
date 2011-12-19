# TODO @Len: Is this an appropriate way to use factories? Create then update? Also not sure how to deal with word lists as two words.
Given /^([^"]*) (has|have) (\d+) (games|posts|word lists|word_lists|courses)$/ do |teacher_name, verb, num, things|
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
      else
        @g.updated_by_id = @t.id
      end
      @g.save
    end
  end
end

Given /^([^"]*) has (\d+) games which are the "([^"]*)" activity$/ do |teacher_name, num_games, activity_name|
  @t = User.find_by_first_name(teacher_name)
  num_games.to_i.times do |activity_name|
    @a = Activity.find_by_name(activity_name)
    @g = Factory.create(:game)
    @g.activity = @a
    @g.updated_by_id = @t.id
    @g.save
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
  end
  @g.save
end

Given /^([^"]*) is subscribed with a basic subscription$/ do |teacher_name|
  @t = User.find_by_first_name(teacher_name)
  @p = SubscriptionPlan.create(:name => "basic", :max_teachers => 3, :cost => 6)
  @t.subscription.subscription_plan = @p
end