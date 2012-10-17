xml.instruct! :xml, :encoding => "UTF-8"
xml.xml do
  # Monkey-patch for the customizer until cmzr3.0 arrives
  if @game.activity.name == "Bathtub Bubbles"
    xml.format("", :gamename => "Bath Tub Bubbles")
  else
    xml.format("", :gamename => @game.activity.name)
  end
  xml.description do
    xml.text(@game.description)
  end
  # TODO: This is not scrambling the order of the questions!
  xml.<< @nodes
  xml.<< @game.template.xml
  xml.language(@game.language.name)
end