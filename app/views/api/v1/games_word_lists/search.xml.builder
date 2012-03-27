xml.instruct! :xml, :encoding => "UTF-8"
xml.games do
  @games.each do |g|
    # TODO: activate should be flagged as a 1 if the word list has been converted to this kind of a game
    xml.game("", :gamename => g.game.activity.name, :gameinfoid => g.game.activity.id, :gameid => g.id, :activate => "") unless g.game.nil?
  end
end