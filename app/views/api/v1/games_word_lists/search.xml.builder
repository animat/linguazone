xml.instruct! :xml, :encoding => "UTF-8"
xml.games do
  @all_convertible_games.each do |acg|
    if @linked_activity_ids.include?(acg.id)
      xml.game("", :gamename => acg.name, :gameinfoid => acg.id, :activate => 1)
    else
      xml.game("", :gamename => acg.name, :gameinfoid => acg.id, :activate => "")      
    end
  end
end