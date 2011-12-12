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
      @post = Factory.create(:course)
      @post.save
    end
  end
end