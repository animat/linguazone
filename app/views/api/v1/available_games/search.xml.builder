xml.instruct! :xml, :encoding => "UTF-8"
xml.classes do
  @all_courses.each do |c|
      xml.class("", :classname => c.name, :classid => c.id, :classactive => @available_courses.include?(c))
  end
end