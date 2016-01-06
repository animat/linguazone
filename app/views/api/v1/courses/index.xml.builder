xml.instruct! :xml, :encoding => "UTF-8"
xml.xml do
  @courses.each do |c|
    xml.course("", :name => c.name, :id => c.id, :teacher_id => c.user.id) unless c.user.nil?
  end
end