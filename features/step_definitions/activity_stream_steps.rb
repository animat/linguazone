Given /^"(.*?)" has recorded (\d+) high scores in "(.*?)"$/ do |student_name, num_high_scores, course_name|
  @s = User.where(:first_name => student_name, :role => "student").first
  @c = Course.find_by_name(course_name)
  @g = AvailableGame.where(:course_id => @c.id).last
  for i in 0...num_high_scores.to_i do
    @params = {:score => "10", :available_game_id => @g.id, :user_id => @s.id, :submitted_at => Time.now, :user_ip_address => "127.0.0.1"}
    HighScore.create!(@params)
    FeedItem.create!(:user_id => @s.id, :course_id => @c.id, :controller => "HighScore", :action => "create", :params => @params.inspect,
                      :sourceable_type => "HighScore", :sourceable_id => HighScore.last.id)
  end
end

Given /^"(.*?)" has created (\d+) comment on a post in "(.*?)"$/ do |student_name, num_comments, course_name|
  @s = User.where(:first_name => student_name, :role => "student").first
  @c = Course.find_by_name(course_name)
  @p = AvailablePost.where(:course_id => @c.id).last
  for i in 0...num_comments.to_i do
    @params = {:audio_id => "10", :available_post_id => @p.id, :user_id => @s.id}
    Comment.create!(@params)
    FeedItem.create(:user_id => @s.id, :course_id => @c.id, :controller => "Comment", :action => "create", :params => @params.inspect,
                      :sourceable_type => "Comment", :sourceable_id => Comment.last.id)
  end
end

Given /^"(.*?)" has studied (\d+) word lists in "(.*?)"$/ do |student_name, num_study_histories, course_name|
  @s = User.where(:first_name => student_name, :role => "student").first
  @c = Course.find_by_name(course_name)
  @wl = AvailableWordList.where(:course_id => @c.id).last
  for i in 0...num_study_histories.to_i do
    @params = {:study_type => "browse", :available_word_list_id => @wl.id, :user_id => @s.id, :submitted_at => Time.now, :user_ip_address => "127.0.0.1"}
    StudyHistory.create!(@params)
    FeedItem.create(:user_id => @s.id, :course_id => @c.id, :controller => "StudyHistory", :action => "create", :params => @params.inspect,
                      :sourceable_type => "StudyHistory", :sourceable_id => StudyHistory.last.id)
  end
end

Given /^I should see (\d+) feed items listed$/ do |num_items|
  all(:xpath, "//li[@class='feed_item']").length.should == num_items.to_i
end