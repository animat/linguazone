Given /^I have (\d+) posts$/ do |num|
  count = num.to_i
  if count == 0
    # TODO: delete other posts in the database
  else
    count.times do |count|
      @post = Factory.create(:post)
      @post.save
    end
  end
end