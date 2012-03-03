xml.instruct! :xml, :encoding => "UTF-8"
xml.xml do
  xml.format("", :gamename => @game.activity.name)
  xml.description do
    xml.text(@game.description)
  end
  xml.<< @game.xml
  xml.<< @game.template.xml
  xml.language(@game.language.name)
end