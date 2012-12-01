xml.instruct! :xml, :encoding => "UTF-8"
xml.xml do
  xml.format("", :gamename => "Word list", :wordlist => "true")
  xml.description do
    xml.text(@word_list.description)
  end
  xml.<< @word_list.xml
  xml.<< "<templatedata></templatedata>"
  if @word_list.language.nil?
    xml.language("English")
  else
    xml.language(@word_list.language.name)
  end
end