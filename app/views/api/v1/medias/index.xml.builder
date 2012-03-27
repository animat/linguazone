xml.instruct! :xml, :encoding => "UTF-8"
xml.xml do
  @medias.each do |m|
    xml.item("", :name => m.name, :path => m.path, :type => m.media_type.ext, :descrip => m.descrip, :id => m.id)
  end
end