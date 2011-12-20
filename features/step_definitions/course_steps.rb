# TODO @Len: Posts, word lists, and games need to be standardized in some key ways. Any tips on how to approach this? Inheritance?
Given /^"([^"]*)" has (\d+) (games|word lists|audio blog posts) showing$/ do |course_name, num, thing|
  @c = Course.find_by_name(course_name)
  num.to_i.times do
    if thing == "posts"
      @p = Factory.create(:post)
      @p.course_id = @c.id
    elsif thing == "word lists"
      @wl = Factory.create(:word_list)
      @awl = AvailableWordList.create!(:course_id => @c.id, :word_list_id => @wl.id, :hidden => 0, :order => 0)
    elsif thing == "games"
      @g = Factory.create(:game)
      @ag = AvailableGame.create!(:course_id => @c.id, :game_id => @g.id, :hidden => 0, :ordering => 0)
    end
  end
end