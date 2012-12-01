xml.instruct! :xml, :encoding => "UTF-8"
xml.gameInfo(:gameName => @game.activity.name, :gameSWF => @game.activity.swf) do
  xml.description(@game.description)
  xml.<< @game.activity.hints_xml
  unless @game.language.nil?
    xml.<< @game.language.special_characters
  end
end