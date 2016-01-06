xml.instruct! :xml, :encoding => "UTF-8"
xml.xml do
  @media_categories.each do |mc|
    xml.category("", :name => mc.name, :id => mc.id)
  end
end