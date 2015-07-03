xml.instruct! :xml, :encoding => "UTF-8"
xml.xml do
  # Monkey-patch for the customizer until cmzr3.0 arrives
  if @game.activity.name == "Bathtub Bubbles"
    xml.format("", :gamename => "Bath Tub Bubbles", :gameSWF => @game.activity.swf)
  else
    xml.format("", :gamename => @game.activity.name, :gameSWF => @game.activity.swf)
  end
  xml.description do
    xml.text(@game.description)
  end
  xml.<< @nodes
  xml.<< @game.template.xml
  xml.language do
    xml.name(@game.language.name)
    xml.<< @game.language.special_characters
  end
  xml.<< @game.activity.hints_xml
end