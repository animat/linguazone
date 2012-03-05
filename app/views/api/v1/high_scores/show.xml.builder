xml.instruct! :xml, :encoding => "UTF-8"
xml.scores(:gameid => @game.id) do
  @high_scores.each do |hs|
    xml.score("", :name => hs.user_id, :value => hs.score)
  end
end